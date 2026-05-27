INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;

CREATE OR REPLACE VIEW overture_buildings_classified AS
WITH user_buildings AS (
    SELECT ST_SetCRS(geom, '4326') AS geom
    FROM my_buildings
    WHERE building IS NOT NULL
),
overture_buildings_normalized AS (
    SELECT
        id,
        ST_SetCRS(geom, '4326') AS geom,
        bbox,
        sources,
        subtype,
        class,
        height,
        num_floors,
        filename
    FROM overture_buildings
)
SELECT
    o.id,
    o.geom,
    o.bbox,
    o.sources,
    o.subtype,
    o.class,
    o.height,
    o.num_floors,
    o.filename,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM user_buildings AS m
            WHERE ST_Contains(m.geom, ST_Centroid(o.geom))
        ) THEN 'my'
        WHEN CAST(o.sources AS VARCHAR) ILIKE '%openstreetmap%'
          OR CAST(o.sources AS VARCHAR) ILIKE '%osm%'
        THEN 'osm'
        ELSE 'ml'
    END AS source_type
FROM overture_buildings_normalized AS o;
