INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;

CREATE OR REPLACE TABLE overture_geojson_features AS
SELECT
    id,
    source_type,
    subtype,
    class,
    height,
    num_floors,
    geom
FROM overture_buildings_classified;
