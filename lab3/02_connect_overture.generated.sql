INSTALL spatial;
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
('2026-05-20.0', 'buildings', 'building', '00444', 44.88904571533203, 52.329078674316406, 53.29610824584961, 55.5407829284668, 'https://overturemaps-us-west-2.s3.us-west-2.amazonaws.com/release/2026-05-20.0/theme=buildings/type=building/part-00444-c758194f-8660-57f6-b660-6d7341d5c7fe-c000.zstd.parquet');

DROP VIEW IF EXISTS overture_buildings;

CREATE VIEW overture_buildings AS
WITH local_bbox AS (
    SELECT
        50.3000249::DOUBLE AS minx,
        53.2556097::DOUBLE AS miny,
        50.3168786::DOUBLE AS maxx,
        53.2706443::DOUBLE AS maxy
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
    FROM read_parquet(['https://overturemaps-us-west-2.s3.us-west-2.amazonaws.com/release/2026-05-20.0/theme=buildings/type=building/part-00444-c758194f-8660-57f6-b660-6d7341d5c7fe-c000.zstd.parquet'], filename = true, hive_partitioning = true)
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
