--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

-- Started on 2017-11-28 17:48:31 ART

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12435)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 208 (class 1259 OID 30174)
-- Name: cargo_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cargo_por_persona (
    idpersona integer NOT NULL,
    idfuncion integer NOT NULL,
    identidad integer NOT NULL,
    idtipo_cargo integer NOT NULL,
    idnivel_estudio integer NOT NULL,
    cantidad_horas double precision NOT NULL,
    fecha_inicio date,
    fecha_fin character varying,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE cargo_por_persona OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 30024)
-- Name: configuracion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE configuracion (
    cantidad_max_dias_viatico_mensual integer
);


ALTER TABLE configuracion OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 31345)
-- Name: detalle_dias_viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE detalle_dias_viatico (
    iddetalle_dias_viatico integer NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    cantidad_dias numeric,
    idlocalidad_origen integer,
    idlocalidad_destino integer,
    idviatico integer,
    medio_dia boolean DEFAULT false
);


ALTER TABLE detalle_dias_viatico OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 31348)
-- Name: detalle_dias_viatico_iddetalle_dias_viatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE detalle_dias_viatico_iddetalle_dias_viatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detalle_dias_viatico_iddetalle_dias_viatico_seq OWNER TO postgres;

--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 213
-- Name: detalle_dias_viatico_iddetalle_dias_viatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE detalle_dias_viatico_iddetalle_dias_viatico_seq OWNED BY detalle_dias_viatico.iddetalle_dias_viatico;


--
-- TOC entry 210 (class 1259 OID 30197)
-- Name: detalle_viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE detalle_viatico (
    iddetalle_viatico integer NOT NULL,
    monto double precision NOT NULL,
    descripcion character varying(50),
    idtipo_detalle_viatico integer NOT NULL,
    idviatico integer
);


ALTER TABLE detalle_viatico OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 30195)
-- Name: detalle_viatico_iddetalle_viatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE detalle_viatico_iddetalle_viatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detalle_viatico_iddetalle_viatico_seq OWNER TO postgres;

--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 209
-- Name: detalle_viatico_iddetalle_viatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE detalle_viatico_iddetalle_viatico_seq OWNED BY detalle_viatico.iddetalle_viatico;


--
-- TOC entry 197 (class 1259 OID 30082)
-- Name: entidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidad (
    identidad integer NOT NULL,
    sigla character varying(10),
    nombre character varying(100) NOT NULL,
    idlocalidad integer NOT NULL,
    calle character varying(50),
    altura integer,
    piso character varying(2),
    depto character varying(2)
);


ALTER TABLE entidad OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 30080)
-- Name: entidad_identidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE entidad_identidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidad_identidad_seq OWNER TO postgres;

--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 196
-- Name: entidad_identidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE entidad_identidad_seq OWNED BY entidad.identidad;


--
-- TOC entry 199 (class 1259 OID 30090)
-- Name: estado_civil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE estado_civil (
    idestado_civil integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE estado_civil OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 30088)
-- Name: estado_civil_idestado_civil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estado_civil_idestado_civil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estado_civil_idestado_civil_seq OWNER TO postgres;

--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 198
-- Name: estado_civil_idestado_civil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estado_civil_idestado_civil_seq OWNED BY estado_civil.idestado_civil;


--
-- TOC entry 214 (class 1259 OID 31371)
-- Name: estudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE estudio (
    titulo character(300),
    idestudio integer NOT NULL,
    sigla character(10)
);


ALTER TABLE estudio OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 31382)
-- Name: estudio_idestudio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estudio_idestudio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estudio_idestudio_seq OWNER TO postgres;

--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 215
-- Name: estudio_idestudio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estudio_idestudio_seq OWNED BY estudio.idestudio;


--
-- TOC entry 216 (class 1259 OID 31395)
-- Name: estudio_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE estudio_por_persona (
    idestudio integer NOT NULL,
    idnivel_estudio integer NOT NULL,
    idpersona integer NOT NULL,
    identidad integer NOT NULL,
    obervaciones text
);


ALTER TABLE estudio_por_persona OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 30037)
-- Name: funcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE funcion (
    idfuncion integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    maximo_horas numeric NOT NULL,
    cantidad_permitida integer NOT NULL
);


ALTER TABLE funcion OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 30035)
-- Name: funcion_idfuncion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE funcion_idfuncion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE funcion_idfuncion_seq OWNER TO postgres;

--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 186
-- Name: funcion_idfuncion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE funcion_idfuncion_seq OWNED BY funcion.idfuncion;


--
-- TOC entry 195 (class 1259 OID 30074)
-- Name: localidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE localidad (
    idlocalidad integer NOT NULL,
    idprovincia integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE localidad OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 30072)
-- Name: localidad_idlocalidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE localidad_idlocalidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE localidad_idlocalidad_seq OWNER TO postgres;

--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 194
-- Name: localidad_idlocalidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE localidad_idlocalidad_seq OWNED BY localidad.idlocalidad;


--
-- TOC entry 182 (class 1259 OID 30018)
-- Name: nivel_estudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nivel_estudio (
    idnivel_estudio integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    maximo_horas double precision NOT NULL,
    orden integer
);


ALTER TABLE nivel_estudio OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 30016)
-- Name: nivel_estudio_idnivel_estudio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE nivel_estudio_idnivel_estudio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nivel_estudio_idnivel_estudio_seq OWNER TO postgres;

--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 181
-- Name: nivel_estudio_idnivel_estudio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE nivel_estudio_idnivel_estudio_seq OWNED BY nivel_estudio.idnivel_estudio;


--
-- TOC entry 191 (class 1259 OID 30058)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pais (
    idpais integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE pais OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 30056)
-- Name: pais_idpais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pais_idpais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pais_idpais_seq OWNER TO postgres;

--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 190
-- Name: pais_idpais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pais_idpais_seq OWNED BY pais.idpais;


--
-- TOC entry 205 (class 1259 OID 30114)
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persona (
    idpersona integer NOT NULL,
    nombres character varying(100) NOT NULL,
    apellido character varying(50) NOT NULL,
    idtipo_documento integer NOT NULL,
    nro_documento integer NOT NULL,
    matricula character varying(20),
    idestado_civil integer,
    cuil character varying(11) NOT NULL,
    correo character varying(100),
    fecha_nacimiento date,
    sexo character varying(1) NOT NULL,
    idlocalidad integer NOT NULL,
    calle character varying(50) NOT NULL,
    altura character varying(5) NOT NULL,
    depto character varying(4),
    piso character varying(2),
    domicilio character varying(100),
    matricula_activa boolean DEFAULT true,
    fecha_baja_matricula date,
    baja boolean DEFAULT false
);


ALTER TABLE persona OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 30112)
-- Name: persona_idpersona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE persona_idpersona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE persona_idpersona_seq OWNER TO postgres;

--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 204
-- Name: persona_idpersona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE persona_idpersona_seq OWNED BY persona.idpersona;


--
-- TOC entry 193 (class 1259 OID 30066)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE provincia (
    idprovincia integer NOT NULL,
    idpais integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE provincia OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 30064)
-- Name: provincia_idprovincia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE provincia_idprovincia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE provincia_idprovincia_seq OWNER TO postgres;

--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 192
-- Name: provincia_idprovincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE provincia_idprovincia_seq OWNED BY provincia.idprovincia;


--
-- TOC entry 211 (class 1259 OID 30219)
-- Name: telefono_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE telefono_por_persona (
    idtipo_telefono integer NOT NULL,
    idpersona integer NOT NULL,
    numero character varying(15) NOT NULL
);


ALTER TABLE telefono_por_persona OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 30098)
-- Name: tipo_cargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_cargo (
    idtipo_cargo integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE tipo_cargo OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 30096)
-- Name: tipo_cargo_idtipo_cargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_cargo_idtipo_cargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_cargo_idtipo_cargo_seq OWNER TO postgres;

--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_cargo_idtipo_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_cargo_idtipo_cargo_seq OWNED BY tipo_cargo.idtipo_cargo;


--
-- TOC entry 185 (class 1259 OID 30029)
-- Name: tipo_detalle_viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_detalle_viatico (
    idtipo_detalle_viatico integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE tipo_detalle_viatico OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 30027)
-- Name: tipo_detalle_viatico_idtipo_detalle_viatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_detalle_viatico_idtipo_detalle_viatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_detalle_viatico_idtipo_detalle_viatico_seq OWNER TO postgres;

--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 184
-- Name: tipo_detalle_viatico_idtipo_detalle_viatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_detalle_viatico_idtipo_detalle_viatico_seq OWNED BY tipo_detalle_viatico.idtipo_detalle_viatico;


--
-- TOC entry 203 (class 1259 OID 30106)
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_documento (
    idtipo_documento integer NOT NULL,
    sigla character varying(10) NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE tipo_documento OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 30104)
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_documento_idtipo_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_documento_idtipo_documento_seq OWNER TO postgres;

--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 202
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_documento_idtipo_documento_seq OWNED BY tipo_documento.idtipo_documento;


--
-- TOC entry 189 (class 1259 OID 30050)
-- Name: tipo_telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_telefono (
    idtipo_telefono integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE tipo_telefono OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 30048)
-- Name: tipo_telefono_idtipo_telefono_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_telefono_idtipo_telefono_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_telefono_idtipo_telefono_seq OWNER TO postgres;

--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 188
-- Name: tipo_telefono_idtipo_telefono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_telefono_idtipo_telefono_seq OWNED BY tipo_telefono.idtipo_telefono;


--
-- TOC entry 207 (class 1259 OID 30125)
-- Name: viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE viatico (
    idviatico integer NOT NULL,
    fecha_desde date,
    nro_expediente character varying(10) NOT NULL,
    fecha_hasta date,
    idpersona integer NOT NULL,
    idlocalidad_origen integer,
    idlocalidad_destino integer,
    cantidad_total_dias numeric,
    mes integer,
    cantidad_dias_reintegro numeric,
    cantidad_dias_disponible numeric,
    cantidad_dias_ numeric
);


ALTER TABLE viatico OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 30123)
-- Name: viatico_idviatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE viatico_idviatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE viatico_idviatico_seq OWNER TO postgres;

--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 206
-- Name: viatico_idviatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE viatico_idviatico_seq OWNED BY viatico.idviatico;


--
-- TOC entry 2188 (class 2604 OID 31350)
-- Name: iddetalle_dias_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico ALTER COLUMN iddetalle_dias_viatico SET DEFAULT nextval('detalle_dias_viatico_iddetalle_dias_viatico_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 30200)
-- Name: iddetalle_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_viatico ALTER COLUMN iddetalle_viatico SET DEFAULT nextval('detalle_viatico_iddetalle_viatico_seq'::regclass);


--
-- TOC entry 2178 (class 2604 OID 30085)
-- Name: identidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidad ALTER COLUMN identidad SET DEFAULT nextval('entidad_identidad_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 30093)
-- Name: idestado_civil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_civil ALTER COLUMN idestado_civil SET DEFAULT nextval('estado_civil_idestado_civil_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 31384)
-- Name: idestudio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio ALTER COLUMN idestudio SET DEFAULT nextval('estudio_idestudio_seq'::regclass);


--
-- TOC entry 2173 (class 2604 OID 30040)
-- Name: idfuncion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funcion ALTER COLUMN idfuncion SET DEFAULT nextval('funcion_idfuncion_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 30077)
-- Name: idlocalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad ALTER COLUMN idlocalidad SET DEFAULT nextval('localidad_idlocalidad_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 30021)
-- Name: idnivel_estudio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nivel_estudio ALTER COLUMN idnivel_estudio SET DEFAULT nextval('nivel_estudio_idnivel_estudio_seq'::regclass);


--
-- TOC entry 2175 (class 2604 OID 30061)
-- Name: idpais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pais ALTER COLUMN idpais SET DEFAULT nextval('pais_idpais_seq'::regclass);


--
-- TOC entry 2182 (class 2604 OID 30117)
-- Name: idpersona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona ALTER COLUMN idpersona SET DEFAULT nextval('persona_idpersona_seq'::regclass);


--
-- TOC entry 2176 (class 2604 OID 30069)
-- Name: idprovincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia ALTER COLUMN idprovincia SET DEFAULT nextval('provincia_idprovincia_seq'::regclass);


--
-- TOC entry 2180 (class 2604 OID 30101)
-- Name: idtipo_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_cargo ALTER COLUMN idtipo_cargo SET DEFAULT nextval('tipo_cargo_idtipo_cargo_seq'::regclass);


--
-- TOC entry 2172 (class 2604 OID 30032)
-- Name: idtipo_detalle_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_detalle_viatico ALTER COLUMN idtipo_detalle_viatico SET DEFAULT nextval('tipo_detalle_viatico_idtipo_detalle_viatico_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 30109)
-- Name: idtipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento ALTER COLUMN idtipo_documento SET DEFAULT nextval('tipo_documento_idtipo_documento_seq'::regclass);


--
-- TOC entry 2174 (class 2604 OID 30053)
-- Name: idtipo_telefono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_telefono ALTER COLUMN idtipo_telefono SET DEFAULT nextval('tipo_telefono_idtipo_telefono_seq'::regclass);


--
-- TOC entry 2185 (class 2604 OID 30128)
-- Name: idviatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico ALTER COLUMN idviatico SET DEFAULT nextval('viatico_idviatico_seq'::regclass);


--
-- TOC entry 2404 (class 0 OID 30174)
-- Dependencies: 208
-- Data for Name: cargo_por_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cargo_por_persona (idpersona, idfuncion, identidad, idtipo_cargo, idnivel_estudio, cantidad_horas, fecha_inicio, fecha_fin, activo) FROM stdin;
\.


--
-- TOC entry 2379 (class 0 OID 30024)
-- Dependencies: 183
-- Data for Name: configuracion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY configuracion (cantidad_max_dias_viatico_mensual) FROM stdin;
\.


--
-- TOC entry 2408 (class 0 OID 31345)
-- Dependencies: 212
-- Data for Name: detalle_dias_viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY detalle_dias_viatico (iddetalle_dias_viatico, fecha_desde, fecha_hasta, cantidad_dias, idlocalidad_origen, idlocalidad_destino, idviatico, medio_dia) FROM stdin;
1	2017-11-11	2017-11-14	4	442	442	\N	\N
2	2017-11-22	2017-11-24	3	218	264	\N	\N
3	2017-11-01	2017-11-08	8	77	94	\N	\N
6	2017-12-01	2017-12-02	2	442	442	2	f
5	2017-11-11	2017-11-13	1.5	440	87	1	f
4	2017-11-11	2017-11-13	3	218	442	1	f
7	2017-11-11	2017-11-09	3	442	442	3	f
\.


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 213
-- Name: detalle_dias_viatico_iddetalle_dias_viatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('detalle_dias_viatico_iddetalle_dias_viatico_seq', 7, true);


--
-- TOC entry 2406 (class 0 OID 30197)
-- Dependencies: 210
-- Data for Name: detalle_viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY detalle_viatico (iddetalle_viatico, monto, descripcion, idtipo_detalle_viatico, idviatico) FROM stdin;
1	500	\N	2	1
\.


--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 209
-- Name: detalle_viatico_iddetalle_viatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('detalle_viatico_iddetalle_viatico_seq', 1, true);


--
-- TOC entry 2393 (class 0 OID 30082)
-- Dependencies: 197
-- Data for Name: entidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidad (identidad, sigla, nombre, idlocalidad, calle, altura, piso, depto) FROM stdin;
1	UNAM	UNIVERSIDAD NACIONAL DE MISIONES	218	\N	\N	\N	\N
2	UNCAUS	UNIVERSIDAD DEL CHACO AUSTRAL	80	\N	\N	\N	\N
\.


--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 196
-- Name: entidad_identidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('entidad_identidad_seq', 2, true);


--
-- TOC entry 2395 (class 0 OID 30090)
-- Dependencies: 199
-- Data for Name: estado_civil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estado_civil (idestado_civil, descripcion) FROM stdin;
2	CASADO
3	DIVORCIADO
4	SOLTERO
6	SEPARADO DE HECHO
7	SIN ESTADO CIVIL
\.


--
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 198
-- Name: estado_civil_idestado_civil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_civil_idestado_civil_seq', 9, true);


--
-- TOC entry 2410 (class 0 OID 31371)
-- Dependencies: 214
-- Data for Name: estudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estudio (titulo, idestudio, sigla) FROM stdin;
LICENCIATURA EN SISTEMAS DE INFORMACION                                                                                                                                                                                                                                                                     	2	LSI       
ANALISTA SISTEMAS DE COMPUTACION                                                                                                                                                                                                                                                                            	1	ASC       
\.


--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 215
-- Name: estudio_idestudio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estudio_idestudio_seq', 3, true);


--
-- TOC entry 2412 (class 0 OID 31395)
-- Dependencies: 216
-- Data for Name: estudio_por_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estudio_por_persona (idestudio, idnivel_estudio, idpersona, identidad, obervaciones) FROM stdin;
1	7	4	1	DFGDDG
1	7	1	2	\N
1	7	1	1	\N
2	7	4	2	\N
2	7	4	1	\N
\.


--
-- TOC entry 2383 (class 0 OID 30037)
-- Dependencies: 187
-- Data for Name: funcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY funcion (idfuncion, descripcion, maximo_horas, cantidad_permitida) FROM stdin;
\.


--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 186
-- Name: funcion_idfuncion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('funcion_idfuncion_seq', 1, false);


--
-- TOC entry 2391 (class 0 OID 30074)
-- Dependencies: 195
-- Data for Name: localidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localidad (idlocalidad, idprovincia, descripcion) FROM stdin;
1	1	SIN LOCALIDAD
2	2	VILLA DE MAYO
3	2	OLAVARRIA
4	2	VILLALONGA
5	2	FLORIDA
6	2	VICENTE LOPEZ
7	2	FLORENCIO VARELA
8	2	HAEDO
9	2	HURLINGHAM
10	2	JOSE C. PAZL
11	2	LUJAN
12	2	LOMAS DE ZAMORA
13	2	MORENO
14	2	MORÓN
15	2	NECOCHEA
16	2	QUILMES
17	2	LINCOLN
18	2	LA PLATA
19	2	PUAN
20	2	LOBERIAS
21	2	AVELLANEDA
22	2	TRISTAN SUAREZ
23	2	RAUCH
24	2	PIÑEYRO
25	2	SAN ISIDRO
26	2	WILDE
27	2	BANFIELD
28	2	ZÁRATE
29	2	GENERAL SARMIENTO
30	2	BAHIA BLANCA
31	2	GENERAL SAN MARTIN
32	2	CARLOS CASARES
33	2	AMEGHINO
34	2	SAN JUSTO
35	2	CARMEN DE PATAGONES
36	2	ROJAS
37	2	BERNAL OESTE
38	2	SAN MIGUEL DEL MONTE
39	2	CHIVILCOY
40	2	TANDIL
41	2	DOLORES
42	2	TIGRE
43	2	AZUL
44	2	VERONICA
45	2	TRES ARROYOS
46	2	CAMPO DE MAYO
47	2	CIUDADELA
48	2	MARTIN CORONADO
49	2	LOMA HERMOSA
50	2	MERLO
51	2	LANUS
52	2	JOSE LEON SUAREZ
53	2	CASEROS
54	2	TRENQUE LAUQUEN
55	2	SAN FERNANDO
56	2	MONTE
57	2	VILLA BALLESTER
58	2	ALMIRANTE BROWN
59	2	MANUEL B. GONNET
60	2	CAPITAL FEDERAL
61	2	BELLA VISTA
62	2	RAMOS MEJIA
63	2	CIUDAD AUTONOMA DE BUENOS AIRES
64	2	PERGAMINO
65	2	CHACABUCO
66	2	NO ESPECIFICADA
67	2	MAR DEL PLATA
68	2	SAN MIGUEL
69	2	SAN NICOLAS DE LOS ARROYOS
70	3	SAN FERNANDO DEL VALLE DE CATAMARCA
71	3	NO ESPECIFICADA
72	4	COLONIA ELISA
73	4	PAMPA DEL INFIERNO
74	4	AVIA TERAI
75	4	LAS BREÑAS
76	4	MARGARITA BELEN
77	4	VILLA ANGELA
78	4	TACO POZO
79	4	ROQUE SAENZ PEÑA
80	4	RESISTENCIA
81	4	PRESIDENCIA DE LA PLAZA
82	4	LAS PALMAS
83	4	JUAN JOSE.CASTELLI
84	4	GANCEDO
85	4	GRAL. JOSE DE SAN MARTIN
86	4	CHARATA
87	4	BARRANQUERAS
88	4	QUITILIPI
89	4	NO ESPECIFICADA
90	5	TRELEW
91	5	ESQUEL
92	5	RAWSON
93	5	PUERTO MADRYN
94	5	NO ESPECIFICADA
95	5	COMODORO RIVADAVIA
96	6	LA PLAYOSA
97	6	CORDOBA
98	6	VILLA CARLOS PAZ
99	6	CRUZ ALTA
100	6	LABOULAYE
101	6	LA CARLOTA
102	6	RIO CUARTO
103	6	RIO SEGUNDO
104	6	RIO TERCERO
105	6	NO ESPECIFICADA
106	6	SAN FRANCISCO
107	6	UNQUILLO
108	6	VILLA DOLORES
109	6	BALLESTEROS
110	6	ALEJO LEDEZMA
111	6	VILLA María
112	6	CONDORES
113	6	VILLA BUSTOS
114	6	COLONIA BISMARCK
115	6	JESUS MARIA
116	6	EL QUEBRACHO
117	7	VIRASORO
118	7	PASO DE LA PATRIA
119	7	PASO DE LOS LIBRES
120	7	SAN MIGUEL
121	7	CAABY POY
122	7	EMPEDRADO
123	7	ITATI
124	7	NO ESPECIFICADA
125	7	COLONIA URIBURU
126	7	CORRIENTES
127	7	LORETO
128	7	MERCEDES
129	7	MOCORETA
130	7	SAN CARLOS
131	7	BELLA VISTA
132	7	CONCEPCION
133	7	CURUZU CUATIA
134	7	ESQUINA
135	7	GOYA
136	7	LA CRUZ
137	7	MONTE CASEROS
138	7	SAN LUIS DEL PALMAR
139	7	SALADAS
140	7	SAN ROQUE
141	7	GDOR. ING. VALENTIN VIRASORO
142	7	GARRUCHOS
143	7	COLONIA LIEBIG
144	7	ITUZAINGO
145	7	SANTO TOME
146	7	SANTA LUCIA
147	7	ALVEAR
148	8	VICTORIA
149	8	VILLA ELISA
150	8	VILLAGUAY
151	8	VILLA LIBERTADOR SAN MARTIN
152	8	VILLA SAN MARCIAL
153	8	ROSARIO DEL TALA
154	8	NOGOYA
155	8	PARANA
156	8	FEDERACION
157	8	GUALEGUAY
158	8	GUALEGUAYCHU
159	8	CONCORDIA
160	8	CONCEPCION DEL URUGUAY
161	8	COLON
162	8	BASAVILBASO
163	8	BOVRIL
164	8	DIAMANTE
165	8	SANTA ANITA
166	8	PEHUAJO NORTE
167	8	LA PAZ
168	8	CHAJARI
169	8	NO ESPECIFICADA
170	9	COLONIA JUANITA
171	9	PIRANE
172	9	CLORINDA
173	9	NO ESPECIFICADA
174	9	EL COLORADO
175	9	FORMOSA
176	10	NO ESPECIFICADA
177	10	SAN SALVADOR DE JUJUY
178	11	COLONIA BARÓN
179	11	NO ESPECIFICADA
180	11	SANTA ROSA
181	12	MILAGRO
182	12	VILLA BUSTOS
183	12	NO ESPECIFICADA
184	12	LOS PALACIOS
185	12	LA RIOJA
186	13	NO ESPECIFICADA
187	13	MENDOZA
188	13	SAN RAFAEL
189	13	SAN MARTIN
190	13	VILLA SECA
191	13	GENERAL ALVEAR
192	13	GODOY CRUZ
193	14	SAN JOSE
194	14	TRES ESQUINAS
195	14	SAN JAVIER
196	14	SAN IGNACIO
197	14	SAN ANTONIO
198	14	COLONIA CAAGUAZU
199	14	RUIZ DE MONTOYA
200	14	PUERTO RICO
201	14	PUERTO PIRAY
202	14	PUERTO LIBERTAD
203	14	PUERTO LEONI
204	14	PUERTO IGUAZU
205	14	PUERTO ESPERANZA
206	14	PIÑALITO SUR
207	14	PROFUNDIDAD
208	14	PANAMBI
209	14	PUERTO GISELA
210	14	PUERTO ESPAÑA
211	14	COLONIA YABEBIRI
212	14	SIERRA DE SAN JOSE
213	14	PICADA SARGENTO CABRAL
214	14	25 DE MAYO
215	14	GUAYABERA
216	14	CUÑA PIRU
217	14	ARISTOBULO DEL VALLE
218	14	POSADAS
219	14	PIÑALITO NORTE
220	14	EL SOBERBIO
221	14	GARUHAPE
222	14	PICADA FINLANDESA
223	14	FACHINAL
224	14	ELDORADO
225	14	FNO. AMEGHINO
226	14	GENERAL URQUIZA
227	14	COLONIA AURORA
228	14	9 DE JULIO
229	14	COLONIA GUARANI
230	14	BONPLAND
231	14	EL ALCAZAR
232	14	SALTO ENCANTADO
233	14	MONTEAGUDO
234	14	TRES CAPONES
235	14	SANTO PIPO
236	14	SANTIAGO DE LINIERS
237	14	SANTA MARIA
238	14	SANTA ANA
239	14	SAN VICENTE
240	14	SAN PEDRO
241	14	SAN MARTIN
242	14	COLONIA OASIS
243	14	MACHADIÑO
244	14	COLONIA DELICIA
245	14	LAS VERTIENTES
246	14	ITACARUARE
247	14	COLONIA POLANA
248	14	HIPOLITO IRIGOYEN
249	14	GUARANI
250	14	GOBENADOR ROCA
251	14	GOBERNADOR LOPEZ
252	14	COLONIA VICTORIA
253	14	PUERTO BEMBERG
254	14	GARUPA
255	14	COLONIA WANDA
256	14	CONCEPCION DE LA SIERRA
257	14	CORPUS
258	14	DOS ARROYOS
259	14	COLONIA GISELA
260	14	DOS DE MAYO
261	14	SAN JUAN DE LA SIERRA
262	14	ALBA POSSE
263	14	ALMAFUERTE
264	14	APOSTOLES
265	14	ARROYO DEL MEDIO
266	14	AZARA
267	14	BERNARDO DE IRIGOYEN
268	14	NO ESPECIFICADA
269	14	CAA - YARI
270	14	POZO AZUL
271	14	CAMPO GRANDE
272	14	LIBERTADOR GENERAL SAN MARTIN
273	14	SAN FRANCISCO DE ASIS
274	14	CAMPO RAMON
275	14	JARDIN AMERICA
276	14	CAMPO VIERA
277	14	SANTA RITA
278	14	OBERA
279	14	OLEGARIO VICTOR ANDRADE
280	14	MONTECARLO
281	14	MOJON GRANDE
282	14	MARTIRES
283	14	INVERNADA GRANDE
284	14	CANDELARIA
285	14	CAPIOVI
286	14	DOS HERMANAS
287	14	PICADA YAPEYU
288	14	LOS HELECHOS
289	14	LORETO
290	14	LEANDRO N. ALEM
291	14	CARAGUATAY
292	14	CERRO AZUL
293	14	CERRO CORA
294	14	COMANDANTE ANDRESITO
295	14	GENERAL ALVEAR
296	14	COLONIA ALBERDI
297	14	GOBERNADOR LANUSSE
298	14	PARADA LEIS
299	14	SAN ALBERTO
300	14	PUERTO NARANJITO
301	14	PUERTO LONDERO
302	14	SAN ISIDRO
303	15	NO ESPECIFICADA
304	15	SAN CARLOS DE BARILOCHE
305	15	INGENIERO HUERGO
306	15	ALLEN
307	15	SIERRA GRANDE
308	15	VILLA REGINA
309	16	GENERAL J DE SAN MARTIN
310	16	CACHI
311	16	SALTA
312	16	NO ESPECIFICADA
313	16	TARTAGAL
314	17	JACHAL
315	17	SAN JUAN
316	17	RIVADAVIA
317	17	NO ESPECIFICADA
318	18	NO ESPECIFICADA
319	18	VILLA MERCEDES
320	19	RIO GALLEGOS
321	19	PUERTO SAN JULIAN
322	19	NO ESPECIFICADA
323	20	SAN JUSTO
324	20	RECONQUISTA
325	20	RAFAELA
326	20	SAN CARLOS CENTRO
327	20	MONJE
328	20	EL TREBOL
329	20	ARRUFO
330	20	ARROYO SECO
331	20	SAN JERONIMO
332	20	MACIEL
333	20	RUFINO
334	20	CORONDA
335	20	VILLA ANA
336	20	ROSARIO
337	20	SAN LORENZO
338	20	VERA
339	20	VENADO TUERTO
340	20	SUNCHALES
341	20	SANTA FE
342	20	SAN CRISTOBAL
343	21	AÑATUYA
344	21	LA BANDA
345	21	SANTIAGO DEL ESTERO
346	21	PAMPA DE LOS GUANACOS
347	22	RIO GRANDE
348	22	USHUAIA
349	23	JUAN B.ALBERDI
350	23	EL BRACHO
351	23	SAN MIGUEL DE TUCUMAN
352	24	SAN MARTIN DE LOS ANDES
353	24	VILLA LANGOSTURA
354	24	JUNIN DE LOS ANDES
355	24	CUTRAL CO
356	24	NO ESPECIFICADA
357	25	SAN MAURICIO
358	25	GENERAL ARTIGAS
359	25	BELLA VISTA
360	25	HOHENAU
361	25	GENERAL DELGADO
362	25	CARMEN DEL PARANA
363	25	CORONEL BOGADO
364	25	ENCARNACION
365	25	PIRAPO
366	25	JESÚS
367	25	SAN COSME Y DAMIAN
368	25	SAN PEDRO DEL PARANA
369	25	SANTO DOMINGO
370	25	CAMBYRETA
371	25	SALITRE-CUE
372	25	MAYOR OTAÑO
373	25	PUERTO CANTERA
374	26	QUYQUYHO
375	26	SAPUCAI
376	26	YBYTYMÍ
377	26	CAAPUCU
378	26	TEBICUARY-MI
379	26	YBYCUÍ
380	26	MBUYAPEY
381	27	FULGENCIO YEGROS
382	27	SAN JUAN NEPOMUCENO
383	27	YUTY
384	27	GENERAL HIGINIO MORINIGO
385	27	ABAI
386	28	COLONIA INDEPENDENCIA
387	28	ITURBE
388	28	BORJA
389	28	CHARARA
390	28	VILLARICA
391	29	ASUNCION
392	30	SOLTAU
393	32	PIA
394	33	SIN LOCALIDAD
395	34	SABADELL
396	36	SAN JUAN BAUTISTA
397	36	SAN MIGUEL
398	36	SANTA MARIA
399	36	SAN PATRICIO
400	37	CORONEL OVIEDO
401	37	SAN JOSE DE LOS ARROYOS
402	38	AREGUÁ
403	38	GUARAMBARE
404	38	YPACARAI
405	38	VILLA ELISA
406	39	PORTO LUCENA
407	39	SANTO CRISTO
408	39	SAO LUIZ GONZAGA
409	39	SANTA MARIA
410	39	PASSO FUNDO
411	39	SANTO ANGELO
412	39	CARASINHO
413	39	CRISSIUMAL
414	39	IJUI
415	39	SAN NICOLAS
416	39	NONOAI
417	39	HORIZONTINA
418	39	SANTA ROSA
419	40	MANAGUA
420	41	ZACATECAS
421	42	PITTSBURGH
422	43	SAN ANTONIO
423	43	MEDIANEIRA
424	44	BOGOTA
425	45	SIN LOCALIDAD
426	46	WILNO
427	47	RESENDE
428	48	SAN PABLO
429	49	PONTE SERRADA
430	49	PORTO XAVIER
431	49	DIONISÍO CERQUEIRA
432	49	ROMELANDIA
433	49	CHAPECO
434	50	DOLORES
435	51	LOS ANGELES
436	52	HERNANDARIAS
437	53	SIN LOCALIDAD
438	54	SIN LOCALIDAD
439	55	LARANJEIRAS
440	56	PONTA PORA
441	57	GRABOCIN
442	58	SANTIAGO
443	60	DURAZNO
444	61	FERMO
445	62	KASSEL
446	63	PILAR
\.


--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 194
-- Name: localidad_idlocalidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localidad_idlocalidad_seq', 446, true);


--
-- TOC entry 2378 (class 0 OID 30018)
-- Dependencies: 182
-- Data for Name: nivel_estudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY nivel_estudio (idnivel_estudio, descripcion, maximo_horas, orden) FROM stdin;
6	SECUNDARIO	20	2
7	UNIVERSITARIO	20	1
5	PRIMARIO	10	3
\.


--
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 181
-- Name: nivel_estudio_idnivel_estudio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('nivel_estudio_idnivel_estudio_seq', 7, true);


--
-- TOC entry 2387 (class 0 OID 30058)
-- Dependencies: 191
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pais (idpais, descripcion) FROM stdin;
1	Sin Pais
2	ARGENTINA
3	BRASIL
4	PARAGUAY
5	URUGUAY
6	CHILE
7	BOLIVIA
8	PERU
9	COLOMBIA
10	VENEZUELA
11	FRANCIA
12	ALEMANIA
13	LITUANIA
14	ESPAÑA
15	NICARAGUA
16	MEXICO
17	ESTADOS UNIDOS
18	ITALIA
19	RUSIA
20	POLONIA
\.


--
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 190
-- Name: pais_idpais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pais_idpais_seq', 20, true);


--
-- TOC entry 2401 (class 0 OID 30114)
-- Dependencies: 205
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY persona (idpersona, nombres, apellido, idtipo_documento, nro_documento, matricula, idestado_civil, cuil, correo, fecha_nacimiento, sexo, idlocalidad, calle, altura, depto, piso, domicilio, matricula_activa, fecha_baja_matricula, baja) FROM stdin;
4	FACUNDO	PIOTROSKI	7	30475293	\N	\N	20304752190	\N	1984-10-01	m	218	CALLE	1	\N	\N	\N	t	\N	f
5	BMB	MH	1	30047529	\N	\N	20304752190	\N	\N	m	46	CALLE	5454	\N	\N	\N	t	\N	t
1	GUSTAVO	ESCALANTE	7	30047529	644	6	20304752190	escalantegc@gmail.com	1983-09-13	m	218	CALLEA	1538	22	1	QA	f	\N	f
\.


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 204
-- Name: persona_idpersona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('persona_idpersona_seq', 5, true);


--
-- TOC entry 2389 (class 0 OID 30066)
-- Dependencies: 193
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincia (idprovincia, idpais, descripcion) FROM stdin;
1	1	Sin Provincia
2	2	ENTRE RIOS
3	2	BUENOS AIRES
4	2	CATAMARCA
5	2	CHACO
6	2	CHUBUT
7	2	CORDOBA
8	2	CORRIENTES
9	2	FORMOSA
10	2	JUJUY
11	2	LA PAMPA
12	2	LA RIOJA
13	2	MENDOZA
14	2	MISIONES
15	2	NEUQUEN
16	2	RIO NEGRO
17	2	SALTA
18	2	SAN JUAN
19	2	SAN LUIS
20	2	SANTA CRUZ
21	2	SANTA FE
22	2	SANTIAGO DEL ESTERO
23	2	TIERRA DEL FUEGO
24	2	TUCUMAN
25	3	SANTA CATARINA
26	3	MATO GROSSO DEL SUR
27	3	SERGIPE
28	3	PARANA
29	3	SAN PABLO
30	3	RIO DE JANEIRO
31	3	RIO GRANDE DO SUL
32	4	ALTO PARANA
33	4	ASUNCIÓN
34	4	CAAZAPÁ
35	4	CAAGUAZU
36	4	CENTRAL
37	4	PARAGUARÍ
38	4	GUAIRÁ
39	4	ITAPUA
40	4	ÑEEMBUCÚ
41	4	VILLARRICA
42	4	MISIONES
43	5	SORIANO
44	5	DURAZNO
45	6	REGION METROPOLITANA DE SANTIAGO
46	9	DISTRITO CAPITAL
47	11	ISLA DE FRANCIA
48	11	PIRINEOS ORIENTALES
49	12	HESSE
50	12	BAJA SAJONIA
51	12	ALTA SILESIA
52	12	BAVIERA
53	13	PROVINCIA DE VILNA
54	14	CATALUÑA
55	14	BARCELONA
56	15	DEPARTAMENTO DE MANAGUA
57	15	ZACATECAS
58	18	ALLEGHENY
59	17	CALIFORNIA
60	18	ROMA
61	18	ASCOLI PICENO
62	19	SIN PROVINCIA
63	20	WILNO
\.


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 192
-- Name: provincia_idprovincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('provincia_idprovincia_seq', 63, true);


--
-- TOC entry 2407 (class 0 OID 30219)
-- Dependencies: 211
-- Data for Name: telefono_por_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY telefono_por_persona (idtipo_telefono, idpersona, numero) FROM stdin;
2	1	367689846
2	4	37648945
\.


--
-- TOC entry 2397 (class 0 OID 30098)
-- Dependencies: 201
-- Data for Name: tipo_cargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_cargo (idtipo_cargo, descripcion) FROM stdin;
\.


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_cargo_idtipo_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_cargo_idtipo_cargo_seq', 1, false);


--
-- TOC entry 2381 (class 0 OID 30029)
-- Dependencies: 185
-- Data for Name: tipo_detalle_viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_detalle_viatico (idtipo_detalle_viatico, descripcion) FROM stdin;
1	Sin Motivo
2	COMBUSTIBLE
3	HOSPEDAJE
\.


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 184
-- Name: tipo_detalle_viatico_idtipo_detalle_viatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_detalle_viatico_idtipo_detalle_viatico_seq', 3, true);


--
-- TOC entry 2399 (class 0 OID 30106)
-- Dependencies: 203
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_documento (idtipo_documento, sigla, descripcion) FROM stdin;
1	S/T	Sin Tipo de Documento
4	LC	LIBRETA CIVICA
5	LE	LIBRETA DE ENROLAMIENTO
7	DNI	DOCUMENTO NACIONAL DE IDENTIDAD
\.


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 202
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_documento_idtipo_documento_seq', 7, true);


--
-- TOC entry 2385 (class 0 OID 30050)
-- Dependencies: 189
-- Data for Name: tipo_telefono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_telefono (idtipo_telefono, descripcion) FROM stdin;
1	FIJO
2	CELULAR
3	FAX
\.


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 188
-- Name: tipo_telefono_idtipo_telefono_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_telefono_idtipo_telefono_seq', 3, true);


--
-- TOC entry 2403 (class 0 OID 30125)
-- Dependencies: 207
-- Data for Name: viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY viatico (idviatico, fecha_desde, nro_expediente, fecha_hasta, idpersona, idlocalidad_origen, idlocalidad_destino, cantidad_total_dias, mes, cantidad_dias_reintegro, cantidad_dias_disponible, cantidad_dias_) FROM stdin;
1	2017-11-07	213	2017-11-09	1	218	264	15	11	\N	10.5	4.5
3	\N	216	\N	1	\N	\N	7	12	\N	4	3
2	\N	215	\N	1	\N	\N	8	12	0	6	2
6	\N	288	\N	1	\N	\N	15	1	\N	\N	\N
\.


--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 206
-- Name: viatico_idviatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('viatico_idviatico_seq', 6, true);


--
-- TOC entry 2232 (class 2606 OID 31370)
-- Name: detalle_dias_viatico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_pkey PRIMARY KEY (iddetalle_dias_viatico);


--
-- TOC entry 2234 (class 2606 OID 31389)
-- Name: estudio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio
    ADD CONSTRAINT estudio_pkey PRIMARY KEY (idestudio);


--
-- TOC entry 2237 (class 2606 OID 31497)
-- Name: estudio_por_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_pkey PRIMARY KEY (idestudio, idnivel_estudio, idpersona, identidad);


--
-- TOC entry 2226 (class 2606 OID 30120)
-- Name: id_persona; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT id_persona PRIMARY KEY (idpersona);


--
-- TOC entry 2214 (class 2606 OID 30087)
-- Name: identidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidad
    ADD CONSTRAINT identidad PRIMARY KEY (identidad);


--
-- TOC entry 2217 (class 2606 OID 30095)
-- Name: idestado_civil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_civil
    ADD CONSTRAINT idestado_civil PRIMARY KEY (idestado_civil);


--
-- TOC entry 2198 (class 2606 OID 30045)
-- Name: idfuncion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funcion
    ADD CONSTRAINT idfuncion PRIMARY KEY (idfuncion);


--
-- TOC entry 2209 (class 2606 OID 30079)
-- Name: idlocalidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad
    ADD CONSTRAINT idlocalidad PRIMARY KEY (idlocalidad);


--
-- TOC entry 2192 (class 2606 OID 30023)
-- Name: idnivel_estudio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nivel_estudio
    ADD CONSTRAINT idnivel_estudio PRIMARY KEY (idnivel_estudio);


--
-- TOC entry 2203 (class 2606 OID 30063)
-- Name: idpais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT idpais PRIMARY KEY (idpais);


--
-- TOC entry 2206 (class 2606 OID 30071)
-- Name: idprovincia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT idprovincia PRIMARY KEY (idprovincia);


--
-- TOC entry 2219 (class 2606 OID 30103)
-- Name: idtipo_cargo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_cargo
    ADD CONSTRAINT idtipo_cargo PRIMARY KEY (idtipo_cargo);


--
-- TOC entry 2195 (class 2606 OID 30034)
-- Name: idtipo_detalle_viatico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_detalle_viatico
    ADD CONSTRAINT idtipo_detalle_viatico PRIMARY KEY (idtipo_detalle_viatico);


--
-- TOC entry 2222 (class 2606 OID 30111)
-- Name: idtipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT idtipo_documento PRIMARY KEY (idtipo_documento);


--
-- TOC entry 2200 (class 2606 OID 30055)
-- Name: idtipo_telefono; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_telefono
    ADD CONSTRAINT idtipo_telefono PRIMARY KEY (idtipo_telefono);


--
-- TOC entry 2229 (class 2606 OID 30130)
-- Name: idviatico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT idviatico PRIMARY KEY (idviatico);


--
-- TOC entry 2211 (class 1259 OID 31477)
-- Name: entidad_nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidad_nombre_idx ON entidad USING btree (nombre);


--
-- TOC entry 2212 (class 1259 OID 31478)
-- Name: entidad_sigla_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidad_sigla_idx ON entidad USING btree (sigla);


--
-- TOC entry 2215 (class 1259 OID 31479)
-- Name: estado_civil_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estado_civil_descripcion_idx ON estado_civil USING btree (descripcion);


--
-- TOC entry 2235 (class 1259 OID 31475)
-- Name: estudio_titulo_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estudio_titulo_idx ON estudio USING btree (titulo);


--
-- TOC entry 2210 (class 1259 OID 31481)
-- Name: localidad_descripcion_idprovincia_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX localidad_descripcion_idprovincia_idx ON localidad USING btree (descripcion, idprovincia);


--
-- TOC entry 2193 (class 1259 OID 31474)
-- Name: nivel_estudio_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nivel_estudio_descripcion_idx ON nivel_estudio USING btree (descripcion);


--
-- TOC entry 2204 (class 1259 OID 31469)
-- Name: pais_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pais_descripcion_idx ON pais USING btree (descripcion);


--
-- TOC entry 2227 (class 1259 OID 30121)
-- Name: persona_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX persona_idx ON persona USING btree (idtipo_documento, nro_documento);


--
-- TOC entry 2207 (class 1259 OID 31482)
-- Name: provincia_descripcion_idpais_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX provincia_descripcion_idpais_idx ON provincia USING btree (descripcion, idpais);


--
-- TOC entry 2220 (class 1259 OID 31473)
-- Name: tipo_cargo_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_cargo_descripcion_idx ON tipo_cargo USING btree (descripcion);


--
-- TOC entry 2196 (class 1259 OID 31472)
-- Name: tipo_detalle_viatico_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_detalle_viatico_descripcion_idx ON tipo_detalle_viatico USING btree (descripcion);


--
-- TOC entry 2223 (class 1259 OID 31338)
-- Name: tipo_documento_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_documento_descripcion_idx ON tipo_documento USING btree (descripcion);


--
-- TOC entry 2224 (class 1259 OID 31337)
-- Name: tipo_documento_sigla_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tipo_documento_sigla_idx ON tipo_documento USING btree (sigla);


--
-- TOC entry 2201 (class 1259 OID 31471)
-- Name: tipo_telefono_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_telefono_descripcion_idx ON tipo_telefono USING btree (descripcion);


--
-- TOC entry 2230 (class 1259 OID 31470)
-- Name: viatico_nro_expediente_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX viatico_nro_expediente_idx ON viatico USING btree (nro_expediente);


--
-- TOC entry 2256 (class 2606 OID 31364)
-- Name: detalle_dias_viatico_idlocalidad_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idlocalidad_destino_fkey FOREIGN KEY (idlocalidad_destino) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2257 (class 2606 OID 31359)
-- Name: detalle_dias_viatico_idlocalidad_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idlocalidad_origen_fkey FOREIGN KEY (idlocalidad_origen) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2258 (class 2606 OID 31354)
-- Name: detalle_dias_viatico_idviatico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idviatico_fkey FOREIGN KEY (idviatico) REFERENCES viatico(idviatico);


--
-- TOC entry 2249 (class 2606 OID 31292)
-- Name: entidad_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT entidad_cargo_por_persona_fk FOREIGN KEY (identidad) REFERENCES entidad(identidad);


--
-- TOC entry 2242 (class 2606 OID 31297)
-- Name: estado_civil_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT estado_civil_persona_fk FOREIGN KEY (idestado_civil) REFERENCES estado_civil(idestado_civil);


--
-- TOC entry 2260 (class 2606 OID 31413)
-- Name: estudio_por_persona_identidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_identidad_fkey FOREIGN KEY (identidad) REFERENCES entidad(identidad);


--
-- TOC entry 2259 (class 2606 OID 31491)
-- Name: estudio_por_persona_idestudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idestudio_fkey FOREIGN KEY (idestudio) REFERENCES estudio(idestudio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2261 (class 2606 OID 31408)
-- Name: estudio_por_persona_idnivel_estudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idnivel_estudio_fkey FOREIGN KEY (idnivel_estudio) REFERENCES nivel_estudio(idnivel_estudio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2262 (class 2606 OID 31403)
-- Name: estudio_por_persona_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES persona(idpersona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2250 (class 2606 OID 31252)
-- Name: funcion_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT funcion_cargo_por_persona_fk FOREIGN KEY (idfuncion) REFERENCES funcion(idfuncion);


--
-- TOC entry 2240 (class 2606 OID 31287)
-- Name: localidad_entidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidad
    ADD CONSTRAINT localidad_entidad_fk FOREIGN KEY (idlocalidad) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2243 (class 2606 OID 31272)
-- Name: localidad_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT localidad_persona_fk FOREIGN KEY (idlocalidad) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2246 (class 2606 OID 31277)
-- Name: localidad_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT localidad_viatico_fk FOREIGN KEY (idlocalidad_origen) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2245 (class 2606 OID 31282)
-- Name: localidad_viatico_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT localidad_viatico_fk1 FOREIGN KEY (idlocalidad_destino) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2251 (class 2606 OID 31242)
-- Name: nivel_estudio_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT nivel_estudio_cargo_por_persona_fk FOREIGN KEY (idnivel_estudio) REFERENCES nivel_estudio(idnivel_estudio);


--
-- TOC entry 2238 (class 2606 OID 31262)
-- Name: pais_provincia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pais_provincia_fk FOREIGN KEY (idpais) REFERENCES pais(idpais);


--
-- TOC entry 2247 (class 2606 OID 31312)
-- Name: persona_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT persona_cargo_por_persona_fk FOREIGN KEY (idpersona) REFERENCES persona(idpersona);


--
-- TOC entry 2254 (class 2606 OID 31317)
-- Name: persona_telefono_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_por_persona
    ADD CONSTRAINT persona_telefono_por_persona_fk FOREIGN KEY (idpersona) REFERENCES persona(idpersona);


--
-- TOC entry 2244 (class 2606 OID 31327)
-- Name: persona_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT persona_viatico_fk FOREIGN KEY (idpersona) REFERENCES persona(idpersona);


--
-- TOC entry 2239 (class 2606 OID 31267)
-- Name: provincia_localidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad
    ADD CONSTRAINT provincia_localidad_fk FOREIGN KEY (idprovincia) REFERENCES provincia(idprovincia);


--
-- TOC entry 2248 (class 2606 OID 31302)
-- Name: tipo_cargo_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT tipo_cargo_cargo_por_persona_fk FOREIGN KEY (idtipo_cargo) REFERENCES tipo_cargo(idtipo_cargo);


--
-- TOC entry 2253 (class 2606 OID 31247)
-- Name: tipo_detalle_viatico_detalle_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_viatico
    ADD CONSTRAINT tipo_detalle_viatico_detalle_viatico_fk FOREIGN KEY (idtipo_detalle_viatico) REFERENCES tipo_detalle_viatico(idtipo_detalle_viatico);


--
-- TOC entry 2241 (class 2606 OID 31307)
-- Name: tipo_documento_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT tipo_documento_persona_fk FOREIGN KEY (idtipo_documento) REFERENCES tipo_documento(idtipo_documento);


--
-- TOC entry 2255 (class 2606 OID 31257)
-- Name: tipo_telefono_telefono_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_por_persona
    ADD CONSTRAINT tipo_telefono_telefono_por_persona_fk FOREIGN KEY (idtipo_telefono) REFERENCES tipo_telefono(idtipo_telefono);


--
-- TOC entry 2252 (class 2606 OID 31332)
-- Name: viatico_detalle_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_viatico
    ADD CONSTRAINT viatico_detalle_viatico_fk FOREIGN KEY (idviatico) REFERENCES viatico(idviatico);


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-11-28 17:48:32 ART

--
-- PostgreSQL database dump complete
--

