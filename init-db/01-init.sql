CREATE EXTENSION IF NOT EXISTS postgis;

DROP TABLE IF EXISTS public.samara_places;

CREATE TABLE public.samara_places (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    description TEXT NOT NULL,
    geom geometry(Point, 4326) NOT NULL
);

INSERT INTO public.samara_places (name, category, description, geom) VALUES
    ('Площадь Куйбышева', 'landmark', 'Одна из крупнейших городских площадей Европы.', ST_SetSRID(ST_MakePoint(50.1002, 53.1955), 4326)),
    ('Набережная Самары', 'recreation', 'Популярная прогулочная зона у Волги.', ST_SetSRID(ST_MakePoint(50.0945, 53.2096), 4326)),
    ('Железнодорожный вокзал', 'transport', 'Главный железнодорожный узел города.', ST_SetSRID(ST_MakePoint(50.1218, 53.1864), 4326)),
    ('Самарский университет', 'education', 'Крупный образовательный и исследовательский центр.', ST_SetSRID(ST_MakePoint(50.1771, 53.2127), 4326)),
    ('Парк Гагарина', 'recreation', 'Городской парк отдыха в северо-восточной части Самары.', ST_SetSRID(ST_MakePoint(50.1925, 53.2323), 4326));

CREATE INDEX samara_places_geom_idx
    ON public.samara_places
    USING GIST (geom);

ANALYZE public.samara_places;
