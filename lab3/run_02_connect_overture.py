import json
import ssl
import urllib.parse
import urllib.request
from pathlib import Path

import duckdb


ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "lab3" / "lab3.duckdb"
GENERATED_SQL_PATH = ROOT / "lab3" / "02_connect_overture.generated.sql"
STAC_ROOT = "https://stac.overturemaps.org/catalog.json"


def load_json(url):
    context = ssl._create_unverified_context()
    with urllib.request.urlopen(url, context=context, timeout=30) as response:
        return json.load(response)


def intersects(left, right):
    return (
        left[0] <= right[2]
        and left[2] >= right[0]
        and left[1] <= right[3]
        and left[3] >= right[1]
    )


def sql_string(value):
    return "'" + value.replace("'", "''") + "'"


def get_local_bbox(con):
    return con.execute(
        """
        SELECT
            ST_XMin(ST_Extent_Agg(geom)) AS minx,
            ST_YMin(ST_Extent_Agg(geom)) AS miny,
            ST_XMax(ST_Extent_Agg(geom)) AS maxx,
            ST_YMax(ST_Extent_Agg(geom)) AS maxy
        FROM my_buildings
        """
    ).fetchone()


def find_building_partitions(local_bbox):
    root = load_json(STAC_ROOT)
    latest_release = root["latest"]
    release_catalog_url = urllib.parse.urljoin(STAC_ROOT, f"{latest_release}/catalog.json")
    collection_url = urllib.parse.urljoin(
        release_catalog_url,
        "buildings/building/collection.json",
    )
    collection = load_json(collection_url)

    item_links = [
        link["href"]
        for link in collection["links"]
        if link.get("rel") == "item"
    ]
    partition_bboxes = collection["extent"]["spatial"]["bbox"]

    partitions = []
    for href, bbox in zip(item_links, partition_bboxes):
        if not intersects(bbox, local_bbox):
            continue

        item_url = urllib.parse.urljoin(collection_url, href)
        item = load_json(item_url)
        assets = item.get("assets", {})
        asset = assets.get("aws") or assets.get("azure")
        if not asset:
            continue

        partitions.append(
            {
                "release": latest_release,
                "theme": "buildings",
                "type": "building",
                "partition_id": item["id"],
                "bbox": item["bbox"],
                "parquet_url": asset["href"],
            }
        )

    return partitions


def build_sql(local_bbox, partitions):
    minx, miny, maxx, maxy = local_bbox
    parquet_urls = ", ".join(sql_string(item["parquet_url"]) for item in partitions)

    insert_rows = []
    for item in partitions:
        bbox = item["bbox"]
        insert_rows.append(
            "("
            + ", ".join(
                [
                    sql_string(item["release"]),
                    sql_string(item["theme"]),
                    sql_string(item["type"]),
                    sql_string(item["partition_id"]),
                    str(bbox[0]),
                    str(bbox[1]),
                    str(bbox[2]),
                    str(bbox[3]),
                    sql_string(item["parquet_url"]),
                ]
            )
            + ")"
        )
    partition_values = ",\n".join(insert_rows)

    return f"""INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;

DROP TABLE IF EXISTS overture_partitions;

CREATE TABLE overture_partitions (
    release VARCHAR,
    theme VARCHAR,
    type VARCHAR,
    partition_id VARCHAR,
    minx DOUBLE,
    miny DOUBLE,
    maxx DOUBLE,
    maxy DOUBLE,
    parquet_url VARCHAR
);

INSERT INTO overture_partitions VALUES
{partition_values};

DROP VIEW IF EXISTS overture_buildings;

CREATE VIEW overture_buildings AS
WITH local_bbox AS (
    SELECT
        {minx}::DOUBLE AS minx,
        {miny}::DOUBLE AS miny,
        {maxx}::DOUBLE AS maxx,
        {maxy}::DOUBLE AS maxy
),
remote_buildings AS (
    SELECT
        id,
        geometry AS geom,
        bbox,
        sources,
        subtype,
        class,
        height,
        num_floors,
        filename
    FROM read_parquet([{parquet_urls}], filename = true, hive_partitioning = true)
)
SELECT
    id,
    geom,
    bbox,
    sources,
    subtype,
    class,
    height,
    num_floors,
    filename
FROM remote_buildings, local_bbox
WHERE bbox.xmin <= local_bbox.maxx
  AND bbox.xmax >= local_bbox.minx
  AND bbox.ymin <= local_bbox.maxy
  AND bbox.ymax >= local_bbox.miny;
"""


def main():
    con = duckdb.connect(str(DB_PATH))
    try:
        con.execute("LOAD spatial;")
        local_bbox = get_local_bbox(con)
        partitions = find_building_partitions(local_bbox)
        if not partitions:
            raise RuntimeError("No Overture building partitions intersect the local bbox.")

        sql = build_sql(local_bbox, partitions)
        GENERATED_SQL_PATH.write_text(sql, encoding="utf-8")
        con.execute(sql)

        partition_count = con.execute(
            "SELECT count(*) FROM overture_partitions"
        ).fetchone()[0]
        geometry_type = con.execute(
            "SELECT column_type FROM (DESCRIBE SELECT * FROM overture_buildings) WHERE column_name = 'geom'"
        ).fetchone()[0]

        print(f"Local bbox: {local_bbox}")
        print(f"Generated SQL: {GENERATED_SQL_PATH}")
        print(f"Intersecting partitions: {partition_count}")
        for row in con.execute(
            "SELECT partition_id, parquet_url FROM overture_partitions ORDER BY partition_id"
        ).fetchall():
            print(f"  {row[0]} {row[1]}")
        print(f"Remote view: overture_buildings")
        print(f"Geometry column type: {geometry_type}")
    finally:
        con.close()


if __name__ == "__main__":
    main()
