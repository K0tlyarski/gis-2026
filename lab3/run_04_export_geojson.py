import json
from pathlib import Path

import duckdb


ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "lab3" / "lab3.duckdb"
SQL_PATH = ROOT / "lab3" / "04_export_geojson.sql"
OUTPUT_PATH = ROOT / "lab3" / "overture.geojson"


def main():
    con = duckdb.connect(str(DB_PATH))
    try:
        con.execute(SQL_PATH.read_text(encoding="utf-8"))

        rows = con.execute(
            """
            SELECT
                id,
                source_type,
                subtype,
                class,
                height,
                num_floors,
                ST_AsGeoJSON(geom) AS geometry
            FROM overture_geojson_features
            """
        ).fetchall()

        features = []
        for row in rows:
            feature_id, source_type, subtype, class_name, height, num_floors, geometry = row
            features.append(
                {
                    "type": "Feature",
                    "id": feature_id,
                    "properties": {
                        "id": feature_id,
                        "source_type": source_type,
                        "subtype": subtype,
                        "class": class_name,
                        "height": height,
                        "num_floors": num_floors,
                    },
                    "geometry": json.loads(geometry),
                }
            )

        collection = {
            "type": "FeatureCollection",
            "features": features,
        }
        OUTPUT_PATH.write_text(
            json.dumps(collection, ensure_ascii=False),
            encoding="utf-8",
        )

        print(f"GeoJSON: {OUTPUT_PATH}")
        print(f"Features: {len(features)}")
        for source_type, count in con.execute(
            """
            SELECT source_type, count(*)
            FROM overture_geojson_features
            GROUP BY source_type
            ORDER BY source_type
            """
        ).fetchall():
            print(f"{source_type}: {count}")
    finally:
        con.close()


if __name__ == "__main__":
    main()
