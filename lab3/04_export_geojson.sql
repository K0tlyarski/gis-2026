INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;

DROP TABLE IF EXISTS overture_geojson_features;

CREATE TABLE overture_geojson_features AS
SELECT
    id,
    'my' AS source_type,
    building AS subtype,
    amenity AS class,
    NULL::DOUBLE AS height,
    TRY_CAST("building:levels" AS INTEGER) AS num_floors,
    geom
FROM my_buildings
WHERE building IS NOT NULL;
