from pathlib import Path

import duckdb
import prepare_geojson


ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "lab3" / "lab3.duckdb"
SQL_PATH = ROOT / "lab3" / "01_load_geojson.sql"


def main():
    prepare_geojson.main()

    con = duckdb.connect(str(DB_PATH))
    try:
        con.execute(SQL_PATH.read_text(encoding="utf-8"))

        rows_count = con.execute(
            "SELECT count(*) FROM my_buildings"
        ).fetchone()[0]
        geom_type = con.execute(
            "SELECT typeof(geom) FROM my_buildings LIMIT 1"
        ).fetchone()[0]
        valid_count = con.execute(
            "SELECT count(*) FROM my_buildings WHERE ST_IsValid(geom)"
        ).fetchone()[0]

        print(f"DuckDB database: {DB_PATH}")
        print(f"Table: my_buildings")
        print(f"Rows: {rows_count}")
        print(f"Geometry column type: {geom_type}")
        print(f"Valid geometries: {valid_count}")
    finally:
        con.close()


if __name__ == "__main__":
    main()
