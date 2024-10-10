--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Homebrew)
-- Dumped by pg_dump version 16.4 (Homebrew)

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
-- Name: actor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actor (
    person_id bigint NOT NULL,
    movie_id bigint NOT NULL,
    role_name character varying(255) NOT NULL
);


--
-- Name: director; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.director (
    person_id bigint NOT NULL,
    movie_id bigint NOT NULL
);


--
-- Name: movie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movie (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    primary_picture bigint,
    publish_year integer NOT NULL
);


--
-- Name: movie_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.movie ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.movie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person (
    id bigint NOT NULL,
    primary_picture bigint,
    person_name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    date_of_death date
);


--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.person ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person_picture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_picture (
    person_id bigint NOT NULL,
    picture_id bigint NOT NULL,
    order_id integer NOT NULL
);


--
-- Name: picture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.picture (
    id bigint NOT NULL,
    picture_description character varying(255) NOT NULL,
    picture_filename character varying(255) NOT NULL
);


--
-- Name: picture_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.picture ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.picture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: premiere; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.premiere (
    movie_id bigint NOT NULL,
    country_code character(2) NOT NULL,
    premiere_date date NOT NULL
);


--
-- Name: review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review (
    movie_id bigint NOT NULL,
    viewer_id bigint NOT NULL,
    score integer NOT NULL,
    CONSTRAINT review_score_check CHECK (((score >= 1) AND (score <= 10)))
);


--
-- Name: viewer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.viewer (
    id bigint NOT NULL,
    email character varying(255) NOT NULL
);


--
-- Name: viewer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.viewer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.viewer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.actor (person_id, movie_id, role_name) FROM stdin;
1	1	Neo
1	2	Neo
1	3	Neo
1	4	Neo
2	1	Trinity
2	2	Trinity
2	3	Trinity
2	4	Trinity
5	1	Morpheus
5	2	Morpheus
5	3	Morpheus
7	4	Morpheus
\.


--
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.director (person_id, movie_id) FROM stdin;
3	1
4	1
\.


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.movie (id, title, primary_picture, publish_year) FROM stdin;
1	The Matrix	2	1999
2	The Matrix Reloaded	3	2003
3	The Matrix Revolutions	4	2003
4	The Matrix Resurrections	5	2021
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person (id, primary_picture, person_name, date_of_birth, date_of_death) FROM stdin;
1	1	Keanu Reeves	1964-09-02	\N
2	\N	Carrie-Anne Moss	1967-08-21	\N
3	\N	Lana Wachowski	1965-06-21	\N
4	\N	Lilly Wachowski	1967-12-29	\N
5	\N	Laurence Fishburne	1961-07-30	\N
7	\N	Yahya Abdul-Mateen II	1986-07-15	\N
\.


--
-- Data for Name: person_picture; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_picture (person_id, picture_id, order_id) FROM stdin;
\.


--
-- Data for Name: picture; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.picture (id, picture_description, picture_filename) FROM stdin;
1	Keanu Reeves istuu puiston penkillä, mutustaen sämpylää	/1/1/1/1-keanu.jpg
2	Matrix poster	https://image.tmdb.org/t/p/original/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg
3	Matrix Reloaded poster	https://image.tmdb.org/t/p/original/9TGHDvWrqKBzwDxDodHYXEmOE6J.jpg
4	Matrix Revolutions poster	https://image.tmdb.org/t/p/original/tyXwreXv4pfo4T4aplTKIp7f9GI.jpg
5	Matrix Resurrections poster	https://image.tmdb.org/t/p/original/8c4a8kE7PizaGQQnditMmI1xbRp.jpg
\.


--
-- Data for Name: premiere; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.premiere (movie_id, country_code, premiere_date) FROM stdin;
1	FI	1999-06-11
1	SE	1999-06-11
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.review (movie_id, viewer_id, score) FROM stdin;
1	1	9
1	2	10
\.


--
-- Data for Name: viewer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.viewer (id, email) FROM stdin;
1	pekkisx@gmail.com
2	puhemies@diktaattoriporssi.com
\.


--
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.movie_id_seq', 4, true);


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_id_seq', 7, true);


--
-- Name: picture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.picture_id_seq', 5, true);


--
-- Name: viewer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.viewer_id_seq', 2, true);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (person_id, movie_id, role_name);


--
-- Name: director director_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (person_id, movie_id);


--
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- Name: person_picture person_picture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_picture
    ADD CONSTRAINT person_picture_pkey PRIMARY KEY (person_id, picture_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: picture picture_picture_filename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.picture
    ADD CONSTRAINT picture_picture_filename_key UNIQUE (picture_filename);


--
-- Name: picture picture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.picture
    ADD CONSTRAINT picture_pkey PRIMARY KEY (id);


--
-- Name: premiere premiere_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.premiere
    ADD CONSTRAINT premiere_pkey PRIMARY KEY (movie_id, country_code);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (movie_id, viewer_id);


--
-- Name: viewer viewer_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viewer
    ADD CONSTRAINT viewer_email_key UNIQUE (email);


--
-- Name: viewer viewer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viewer
    ADD CONSTRAINT viewer_pkey PRIMARY KEY (id);


--
-- Name: actor actor_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(id) ON DELETE CASCADE;


--
-- Name: actor actor_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id) ON DELETE CASCADE;


--
-- Name: director director_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(id) ON DELETE CASCADE;


--
-- Name: director director_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id) ON DELETE CASCADE;


--
-- Name: movie movie_primary_picture_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_primary_picture_fkey FOREIGN KEY (primary_picture) REFERENCES public.picture(id) ON DELETE SET NULL;


--
-- Name: person_picture person_picture_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_picture
    ADD CONSTRAINT person_picture_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id) ON DELETE CASCADE;


--
-- Name: person_picture person_picture_picture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_picture
    ADD CONSTRAINT person_picture_picture_id_fkey FOREIGN KEY (picture_id) REFERENCES public.picture(id) ON DELETE CASCADE;


--
-- Name: person person_primary_picture_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_primary_picture_fkey FOREIGN KEY (primary_picture) REFERENCES public.picture(id) ON DELETE SET NULL;


--
-- Name: premiere premiere_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.premiere
    ADD CONSTRAINT premiere_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(id) ON DELETE CASCADE;


--
-- Name: review review_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movie(id) ON DELETE CASCADE;


--
-- Name: review review_viewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_viewer_id_fkey FOREIGN KEY (viewer_id) REFERENCES public.viewer(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

