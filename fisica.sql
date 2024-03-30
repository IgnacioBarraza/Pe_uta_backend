--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

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
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    rut character varying(255),
    tipo_id integer,
    password character varying(255),
    remember_token character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Users_id_seq" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: asignaturas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asignaturas (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.asignaturas OWNER TO postgres;

--
-- Name: asignaturas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asignaturas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asignaturas_id_seq OWNER TO postgres;

--
-- Name: asignaturas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asignaturas_id_seq OWNED BY public.asignaturas.id;


--
-- Name: criterios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.criterios (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    ponderacion numeric(3,2) NOT NULL
);


ALTER TABLE public.criterios OWNER TO postgres;

--
-- Name: criterios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.criterios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.criterios_id_seq OWNER TO postgres;

--
-- Name: criterios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.criterios_id_seq OWNED BY public.criterios.id;


--
-- Name: evaluaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluaciones (
    id integer NOT NULL,
    users_id integer NOT NULL,
    grupo_id integer NOT NULL,
    criterio_id integer NOT NULL,
    puntuacion numeric(5,2) NOT NULL
);


ALTER TABLE public.evaluaciones OWNER TO postgres;

--
-- Name: evaluaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evaluaciones_id_seq OWNER TO postgres;

--
-- Name: evaluaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluaciones_id_seq OWNED BY public.evaluaciones.id;


--
-- Name: grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    asignatura_id integer NOT NULL,
    imagen_url text NOT NULL,
    descripcion character varying(255) NOT NULL
);


ALTER TABLE public.grupos OWNER TO postgres;

--
-- Name: grupos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grupos_id_seq OWNER TO postgres;

--
-- Name: grupos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupos_id_seq OWNED BY public.grupos.id;


--
-- Name: integrantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integrantes (
    id integer NOT NULL,
    nombre character varying(255),
    apellidos character varying(255),
    grupo_id integer
);


ALTER TABLE public.integrantes OWNER TO postgres;

--
-- Name: integrantes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.integrantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.integrantes_id_seq OWNER TO postgres;

--
-- Name: integrantes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.integrantes_id_seq OWNED BY public.integrantes.id;


--
-- Name: nombre_de_tabla; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nombre_de_tabla (
    nombre text,
    apellidos text,
    grupo_id bigint
);


ALTER TABLE public.nombre_de_tabla OWNER TO postgres;

--
-- Name: tipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.tipos OWNER TO postgres;

--
-- Name: tipos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_id_seq OWNER TO postgres;

--
-- Name: tipos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_id_seq OWNED BY public.tipos.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    rut character varying(10) NOT NULL,
    password character varying(255) NOT NULL,
    tipo_id bigint
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Name: asignaturas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignaturas ALTER COLUMN id SET DEFAULT nextval('public.asignaturas_id_seq'::regclass);


--
-- Name: criterios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.criterios ALTER COLUMN id SET DEFAULT nextval('public.criterios_id_seq'::regclass);


--
-- Name: evaluaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones ALTER COLUMN id SET DEFAULT nextval('public.evaluaciones_id_seq'::regclass);


--
-- Name: grupos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos ALTER COLUMN id SET DEFAULT nextval('public.grupos_id_seq'::regclass);


--
-- Name: integrantes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrantes ALTER COLUMN id SET DEFAULT nextval('public.integrantes_id_seq'::regclass);


--
-- Name: tipos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos ALTER COLUMN id SET DEFAULT nextval('public.tipos_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20231107033442-create-user.js
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, rut, tipo_id, password, remember_token, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: asignaturas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asignaturas (id, nombre) FROM stdin;
3	Electromagnetismo
1	Introducci¢n a la f¡sica
4	Kinesiologia
5	Física Contemporanea
2	Mecánica Clásica
\.


--
-- Data for Name: criterios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.criterios (id, nombre, ponderacion) FROM stdin;
1	Video	0.45
2	Claridad vocal, ritmo del discurso, orden y coherencia	0.05
3	Materiales utilizados	0.05
4	Experimento Demostración	0.40
5	Tiempo	0.05
\.


--
-- Data for Name: evaluaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluaciones (id, users_id, grupo_id, criterio_id, puntuacion) FROM stdin;
\.


--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupos (id, nombre, asignatura_id, imagen_url, descripcion) FROM stdin;
1	Compactador de latas	2	https://torresproject.com/prouta/img/proyecto-compactador-lata.jpeg	Una prensa que procura disminuir el volumen de latas para reciclar
2	Drone tipo avioneta	2	https://torresproject.com/prouta/img/proyecto-drone-tipo-avioneta.jpeg	Es una avioneta con cámara, para evidenciar lugar donde no llega el ojo humano fácilmente
3	Granja autosustentable	1	https://torresproject.com/prouta/img/proyecto-granja-autosustentable.jpeg	Granja sustentable capaz de generar electricidad gracias a sus dos turbinas eólicas.
4	Proyecto Valhalla	1	https://torresproject.com/prouta/img/proyecto-valhalla.jpeg	Proyecto de almacenamiento de energía con agua: desplazamiento diurno hacia elevación superior y generación nocturna mediante bomba. Eficiente aprovechamiento de variaciones de energía potencial para electricidad sostenible.
5	Electrobot	3	https://torresproject.com/prouta/img/proyecto-electrobot.jpg	Un vehículo autopropulsado, alimentado por medio de baterías cargadas limpiamente implementando energía fotovoltaica, cuya función es recolectar la basura de las calles de la ciudad.
6	LanguageTongue	3	https://torresproject.com/prouta/img/proyecto-languageTongue.jpg	Un dispositivo capaz de facilitar la comunicación entre personas sordas y no sordas, al presentar imágenes de lengua de señas mediante comandos de voz.
7	Espectroscopio	5	https://torresproject.com/prouta/img/proyecto-espectroscopio.png	Un espectroscopio es un instrumento que descompone la luz en sus componentes, revelando patrones únicos que proporcionan información sobre la composición química y propiedades de materiales.
\.


--
-- Data for Name: integrantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.integrantes (id, nombre, apellidos, grupo_id) FROM stdin;
1	Tomás	Ortiz	1
2	Sanca	Tapia	1
3	Yeremi	Mamani	1
4	Katia	Bohorquez	1
5	Miguel	Foemmel	1
6	Elvis	Vasquez	1
7	Yenny	Rodríguez	2
8	Mabel	Challapa	2
9	Carolina	Maraboli	3
10	Antonio	Aedo	3
11	Gabriel	Perez	3
12	Demi	La Torre	3
13	Francisco	Valdes	3
14	Alexis	Cayo	3
15	Jorge	Salinas	3
16	Andres	Arias	3
17	Cristian	Ortiz	3
18	Andres	Guzman	3
19	Felipe	Gonzalez	4
20	Sergio	Bernal	4
21	Agustin	Herrera	4
22	Giovani	Cantillanes	4
23	Joaquin	Torres	4
24	Alejandro	Mamani	4
25	Alejandro	Freites	4
26	Leonardo	Mamani	4
27	Benjamin	Naredo	4
28	Ruben	Reyes	4
29	Salvador	Campos	5
30	Sebastian	Fuentes	5
31	Marilyn	Limachi	5
32	Bastian	Ulloa	5
33	Matias	Araya	6
34	Brayan	Flores	6
35	Maximiliano	Vargas	6
36	Diego	Araya	7
37	Ignacio	Barraza	7
38	Carlos	Catalan	7
39	Joel	Faldín	7
40	Cristina	Devia	7
41	Samuel	Sotomayor	7
42	Brandon	Valdes	7
43	Joaquin	Lopez	7
\.


--
-- Data for Name: nombre_de_tabla; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nombre_de_tabla (nombre, apellidos, grupo_id) FROM stdin;
Tomás	Ortiz	1
Sanca	Tapia	1
Yeremi	Mamani	1
Katia	Bohorquez	1
Miguel	Foemmel	1
Elvis	Vasquez	1
Yenny	Rodríguez	2
Mabel	Challapa	2
Carolina	Maraboli	3
Antonio	Aedo	3
Gabriel	Perez	3
Demi	La Torre	3
Francisco	Valdes	3
Alexis	Cayo	3
Jorge	Salinas	3
Andres	Arias	3
Cristian	Ortiz	3
Andres	Guzman	3
Felipe	Gonzalez	4
Sergio	Bernal	4
Agustin	Herrera	4
Giovani	Cantillanes	4
Joaquin	Torres	4
Alejandro	Mamani	4
Alejandro	Freites	4
Leonardo	Mamani	4
Benjamin	Naredo	4
Ruben	Reyes	4
Salvador	Campos	5
Sebastian	Fuentes	5
Marilyn	Limachi	5
Bastian	Ulloa	5
Matias	Araya	6
Brayan	Flores	6
Maximiliano	Vargas	6
Diego	Araya	7
Ignacio	Barraza	7
Carlos	Catalan	7
Joel	Faldín	7
Cristina	Devia	7
Samuel	Sotomayor	7
Brandon	Valdes	7
Joaquin	Lopez	7
Tomás	Ortiz	1
Sanca	Tapia	1
Yeremi	Mamani	1
Katia	Bohorquez	1
Miguel	Foemmel	1
Elvis	Vasquez	1
Yenny	Rodríguez	2
Mabel	Challapa	2
Carolina	Maraboli	3
Antonio	Aedo	3
Gabriel	Perez	3
Demi	La Torre	3
Francisco	Valdes	3
Alexis	Cayo	3
Jorge	Salinas	3
Andres	Arias	3
Cristian	Ortiz	3
Andres	Guzman	3
Felipe	Gonzalez	4
Sergio	Bernal	4
Agustin	Herrera	4
Giovani	Cantillanes	4
Joaquin	Torres	4
Alejandro	Mamani	4
Alejandro	Freites	4
Leonardo	Mamani	4
Benjamin	Naredo	4
Ruben	Reyes	4
Salvador	Campos	5
Sebastian	Fuentes	5
Marilyn	Limachi	5
Bastian	Ulloa	5
Matias	Araya	6
Brayan	Flores	6
Maximiliano	Vargas	6
Diego	Araya	7
Ignacio	Barraza	7
Carlos	Catalan	7
Joel	Faldín	7
Cristina	Devia	7
Samuel	Sotomayor	7
Brandon	Valdes	7
Joaquin	Lopez	7
\.


--
-- Data for Name: tipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipos (id, nombre) FROM stdin;
1	Administrador
2	usuario
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, rut, password, tipo_id) FROM stdin;
1	21212751-5	$2b$10$oQhZ9KtIqZrl8FmheF5e8OQtvyeAh2CrJA4ztDOGK13Q46mpojs5S	1
\.


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 1, false);


--
-- Name: asignaturas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asignaturas_id_seq', 1, true);


--
-- Name: criterios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.criterios_id_seq', 5, true);


--
-- Name: evaluaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluaciones_id_seq', 10, true);


--
-- Name: grupos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupos_id_seq', 7, true);


--
-- Name: integrantes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.integrantes_id_seq', 43, true);


--
-- Name: tipos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: asignaturas asignaturas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignaturas
    ADD CONSTRAINT asignaturas_pkey PRIMARY KEY (id);


--
-- Name: criterios criterios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.criterios
    ADD CONSTRAINT criterios_pkey PRIMARY KEY (id);


--
-- Name: evaluaciones evaluaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_pkey PRIMARY KEY (id);


--
-- Name: grupos grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_pkey PRIMARY KEY (id);


--
-- Name: integrantes integrantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrantes
    ADD CONSTRAINT integrantes_pkey PRIMARY KEY (id);


--
-- Name: tipos tipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos
    ADD CONSTRAINT tipos_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: asignaturas_nombre_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX asignaturas_nombre_unique ON public.asignaturas USING btree (nombre);


--
-- Name: criterios_nombre_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX criterios_nombre_unique ON public.criterios USING btree (nombre);


--
-- Name: evaluaciones_criterio_id_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX evaluaciones_criterio_id_foreign ON public.evaluaciones USING btree (criterio_id);


--
-- Name: evaluaciones_grupo_id_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX evaluaciones_grupo_id_foreign ON public.evaluaciones USING btree (grupo_id);


--
-- Name: evaluaciones_users_id_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX evaluaciones_users_id_foreign ON public.evaluaciones USING btree (users_id);


--
-- Name: grupos_asignatura_id_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grupos_asignatura_id_foreign ON public.grupos USING btree (asignatura_id);


--
-- Name: grupos_nombre_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX grupos_nombre_unique ON public.grupos USING btree (nombre);


--
-- Name: evaluaciones evaluaciones_criterio_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_criterio_id_foreign FOREIGN KEY (criterio_id) REFERENCES public.criterios(id) ON DELETE CASCADE;


--
-- Name: evaluaciones evaluaciones_grupo_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_grupo_id_foreign FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON DELETE CASCADE;


--
-- Name: evaluaciones evaluaciones_users_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_users_id_foreign FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: grupos grupos_asignatura_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_asignatura_id_foreign FOREIGN KEY (asignatura_id) REFERENCES public.asignaturas(id) ON DELETE CASCADE;


--
-- Name: integrantes integrantes_grupo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrantes
    ADD CONSTRAINT integrantes_grupo_id_fkey FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

