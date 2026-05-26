INSTALL spatial;
LOAD spatial;

DROP TABLE IF EXISTS my_buildings_raw;

CREATE TABLE my_buildings_raw AS
SELECT *
FROM ST_Read('lab3/lab1_prepared.geojson');

DROP TABLE IF EXISTS my_buildings;

CREATE TABLE my_buildings AS
SELECT
    *,
    ST_MakeValid(geom) AS geometry
FROM my_buildings_raw
WHERE geom IS NOT NULL;

ALTER TABLE my_buildings
DROP COLUMN geom;

ALTER TABLE my_buildings
RENAME COLUMN geometry TO geom;
