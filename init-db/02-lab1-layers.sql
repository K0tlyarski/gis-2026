--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg110+2)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buildings (
    ogc_fid integer NOT NULL,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    access character varying,
    "addr:city" character varying,
    "addr:street" character varying,
    amenity character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    landuse character varying,
    place character varying,
    surface character varying,
    type character varying,
    id character varying,
    "addr:housenumber" character varying,
    "addr:place" character varying,
    geom public.geometry(Geometry,4326)
);


--
-- Name: poi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.poi (
    ogc_fid integer NOT NULL,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    access character varying,
    "addr:city" character varying,
    "addr:street" character varying,
    amenity character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    landuse character varying,
    place character varying,
    surface character varying,
    type character varying,
    id character varying,
    "addr:housenumber" character varying,
    "addr:place" character varying,
    geom public.geometry(Geometry,4326)
);


--
-- Name: roads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roads (
    ogc_fid integer NOT NULL,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    access character varying,
    "addr:city" character varying,
    "addr:street" character varying,
    amenity character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    landuse character varying,
    place character varying,
    surface character varying,
    type character varying,
    id character varying,
    "addr:housenumber" character varying,
    "addr:place" character varying,
    geom public.geometry(Geometry,4326)
);


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (3, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774643', '110', 'СТ СМПО "Металлист"', '0106000020E610000001000000010300000001000000050000000E4867052B27494047938B31B0A14A4033FCA71B282749406C19BA23ADA14A4036D5496C2D2749405581FF52ABA14A4011210956302749409B3BFA5FAEA14A400E4867052B27494047938B31B0A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (4, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774644', '121', 'территория 18 км Московского шоссе', '0106000020E61000000100000001030000000100000005000000D8B5622420274940E4F32FEEABA14A402C30BF2E1E274940BB945FABA9A14A407D1C72D822274940578D6F39A8A14A4029A215CE242749407FEC3F7CAAA14A40D8B5622420274940E4F32FEEABA14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (5, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774645', '108', 'СТ СМПО "Металлист"', '0106000020E61000000100000001030000000100000005000000BDA36BCB25274940A4891CC7B4A14A40359886E123274940CECC823FB2A14A4074EB353D2827494082638511B1A14A40FCF61A272A27494057201F99B3A14A40BDA36BCB25274940A4891CC7B4A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (6, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774646', '114', 'СТ СМПО "Металлист"', '0106000020E610000001000000010300000001000000050000003AFF1B203D27494038CAB040AAA14A404785FB123B274940C8A4750AA8A14A40B79091FD3D27494045E0FE12A7A14A40AA0AB20A4027494020466348A9A14A403AFF1B203D27494038CAB040AAA14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (7, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774647', '118', 'СТ СМПО "Металлист"', '0106000020E6100000010000000103000000010000000500000095CF978345274940B10CBB39A6A14A4013C9A18F43274940A079EF5EA4A14A402442C81E46274940B2744F68A3A14A40A648BE1248274940C3071B43A5A14A4095CF978345274940B10CBB39A6A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (8, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11 линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774648', '129', 'массив 18 км Московского шоссе', '0106000020E61000000100000001030000000100000005000000749593F540274940D19332A9A1A14A40E6CC76853E274940B43E40529FA14A40B5E0455F41274940C1069F419EA14A4043A962CF43274940DD5B9198A0A14A40749593F540274940D19332A9A1A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (9, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '12-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774649', '99', 'СТ СМПО "Металлист"', '0106000020E61000000100000001030000000100000005000000EEDDD5613B274940D7D2ED36B9A14A40131C4DE4382749405B75C2F0B6A14A40E2D3F7753B2749404AF663EEB5A14A40BD9580F33D274940C5538F34B8A14A40EEDDD5613B274940D7D2ED36B9A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (10, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11 линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774650', '125', 'массив 18 км Московского шоссе', '0106000020E61000000100000001030000000100000005000000A78AF3812E274940692CABFAA6A14A40C048C3842C2749403BC8EBC1A4A14A40946181542F27494059FB3BDBA3A14A40E7E3DA5031274940875FFB13A6A14A40A78AF3812E274940692CABFAA6A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (11, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774651', '104', 'СТ СМПО "Металлист"', '0106000020E6100000010000000103000000010000000500000002A8983913274940084955C9B6A14A40EB6B02B1112749407461A417B5A14A400D501A6A142749400F12FD35B4A14A40248CB0F215274940A3F9ADE7B5A14A4002A8983913274940084955C9B6A14A40');
INSERT INTO public.buildings (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (12, '2026-05-22 18:09:19+00', '1', '183035933', 'vadimkotlyarskiy', '24150741', NULL, 'Самара', '11-я линия', NULL, 'yes', '1', NULL, NULL, NULL, NULL, NULL, 'way/1518774652', '120', 'СДТ СМПО "Металлист"', '0106000020E61000000100000001030000000100000005000000CED8E1F9562749404EF79562A2A14A40E0EDE64E552749401F1D0D96A0A14A405688A29B58274940F028DF7D9FA14A4043739D465A2749401F03684AA1A14A40CED8E1F9562749404EF79562A2A14A40');


--
-- Data for Name: poi; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: roads; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (13, '2024-10-01 07:30:05+00', '3', '157325016', 'Глеб', '346125', NULL, NULL, NULL, NULL, NULL, NULL, 'service', NULL, NULL, 'compacted', NULL, 'way/43532027', NULL, NULL, '0105000020E61000000100000001020000000200000005AD1B4A48274940786407F071A14A40F15BBE3FEF264940E0980A968FA14A40');
INSERT INTO public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (14, '2024-10-26 08:20:37+00', '4', '158365623', 'skysamum', '1517841', NULL, NULL, NULL, NULL, NULL, NULL, 'unclassified', NULL, NULL, 'compacted', NULL, 'way/43532043', NULL, NULL, '0105000020E6100000010000000102000000060000008BAFD1CD592749405DF92CCF83A14A405ED72FD80D274940B678C25C9CA14A408481E7DEC3264940FCFCF7E0B5A14A404B4453D1B326494029CB10C7BAA14A4032F3D36EAA264940228C9FC6BDA14A409C10DF2EA0264940D0A22D9DC5A14A40');
INSERT INTO public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (15, '2024-10-26 08:20:37+00', '5', '158365623', 'skysamum', '1517841', NULL, NULL, NULL, NULL, NULL, NULL, 'unclassified', NULL, NULL, 'compacted', NULL, 'way/43532044', NULL, NULL, '0105000020E610000001000000010200000007000000800AECD6D72649409785C0DBCDA14A40D4BBD3F8E026494096760F75C4A14A40E3B2C00DE7264940D9B9C4ECC0A14A40F0BA2308FC264940ADDD76A1B9A14A400C8A308F4627494066AF2DF2A1A14A40191989754F2749408B636E089FA14A40C314408C6B2749409C638A8395A14A40');
INSERT INTO public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (16, '2024-10-26 08:20:37+00', '5', '158365623', 'skysamum', '1517841', NULL, NULL, NULL, NULL, NULL, NULL, 'unclassified', NULL, NULL, 'compacted', NULL, 'way/43532045', NULL, NULL, '0105000020E610000001000000010200000006000000332CEBA3F8264940BD48B258D4A14A40CDE506431D2749400612143FC6A14A401233FB3C462749405ADF1B9EB9A14A40FDAAB7616F274940F61CA21BABA14A409DA5BFF27B274940286B2FFDA6A14A40F2DE628F9A274940B0CFF7AE9CA14A40');
INSERT INTO public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (17, '2025-07-30 21:44:18+00', '8', '169742849', 'Jekader', '48157', NULL, NULL, NULL, NULL, NULL, NULL, 'unclassified', NULL, NULL, 'compacted', NULL, 'way/43532046', NULL, NULL, '0105000020E6100000010000000102000000070000009477C4D78D27494007E7F80DB8A14A4075E44867602749404CD246BFC7A14A4023A9E04B3C274940238A24D5D2A14A402CA9C9422A27494042284A9DDBA14A407E8747872C27494005EA831BDFA14A407B1002F22527494063B0879BF8A14A40AE505A6E1F2749401EE3E54416A24A40');
INSERT INTO public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, access, "addr:city", "addr:street", amenity, building, "building:levels", highway, landuse, place, surface, type, id, "addr:housenumber", "addr:place", geom) VALUES (18, '2024-10-22 04:51:51+00', '5', '158194954', 'skysamum', '1517841', NULL, NULL, NULL, NULL, NULL, NULL, 'unclassified', NULL, NULL, 'compacted', NULL, 'way/704701556', NULL, NULL, '0105000020E6100000010000000102000000120000002E9FF6A5C82749400E5E0542FCA14A40E68A9CCFCA274940684DE262FBA14A40BAB7C777CE27494033CA8EE8F9A14A40EA0D524BCE274940BD715298F7A14A40573D0565BF274940A133C40CE8A14A4092DCABA0B3274940FA19283ADCA14A40080F89319F274940E6006663CAA14A409477C4D78D27494007E7F80DB8A14A40C4CA0D2B8127494003FFA556A9A14A409DA5BFF27B274940286B2FFDA6A14A40C314408C6B2749409C638A8395A14A408BAFD1CD592749405DF92CCF83A14A4005AD1B4A48274940786407F071A14A40EAA2D75537274940ED48F59D5FA14A406A526573302749402CF587C157A14A400492B06F2727494026FB8CB04DA14A40095ADCDA1D2749403D4E870442A14A403C10FEEA1627494058A2FD593DA14A40');


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (ogc_fid);


--
-- Name: poi poi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poi
    ADD CONSTRAINT poi_pkey PRIMARY KEY (ogc_fid);


--
-- Name: roads roads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roads
    ADD CONSTRAINT roads_pkey PRIMARY KEY (ogc_fid);


--
-- Name: idx_buildings_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_buildings_geom ON public.buildings USING gist (geom);


--
-- Name: idx_poi_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_poi_geom ON public.poi USING gist (geom);


--
-- Name: idx_roads_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_roads_geom ON public.roads USING gist (geom);


--
-- PostgreSQL database dump complete
--

