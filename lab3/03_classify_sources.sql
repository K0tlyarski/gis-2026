INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;

DROP VIEW IF EXISTS overture_buildings_classified;

CREATE VIEW overture_buildings_classified AS
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
            FROM my_buildings AS m
            WHERE ST_Intersects(o.geom, m.geom)
        ) THEN 'my'
        WHEN CAST(o.sources AS VARCHAR) ILIKE '%openstreetmap%'
          OR CAST(o.sources AS VARCHAR) ILIKE '%osm%'
        THEN 'osm'
        ELSE 'ml'
    END AS source_type
FROM overture_buildings AS o;
