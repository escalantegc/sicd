--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

-- Started on 2018-01-04 19:59:34 ART

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
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 226 (class 1255 OID 42593)
-- Name: contar_cargos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION contar_cargos() RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	      where activo = true) ;
    
    RETURN total;
END;
$$;


ALTER FUNCTION public.contar_cargos() OWNER TO postgres;

--
-- TOC entry 221 (class 1255 OID 42591)
-- Name: contar_cargos_segun_tipo(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION contar_cargos_segun_tipo(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idtipo_cargo  = $1) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_segun_tipo(integer) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 42594)
-- Name: contar_cargos_segun_tipo_jerarquico(boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION contar_cargos_segun_tipo_jerarquico(boolean) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	inner join tipo_cargo on tipo_cargo.idtipo_cargo=cargo_por_persona.idtipo_cargo
              WHERE
  		tipo_cargo.jerarquico  =  $1 and
  		cargo_por_persona.activo = true) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_segun_tipo_jerarquico(boolean) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 42603)
-- Name: sumar_dias_disponible_por_mes(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sumar_dias_disponible_por_mes(character) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_dias_disponible) FROM viatico
    WHERE mes = $1) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumar_dias_disponible_por_mes(character) OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 39708)
-- Name: sumar_dias_disponible_por_mes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sumar_dias_disponible_por_mes(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_dias_disponible) FROM viatico
    WHERE mes = $1) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumar_dias_disponible_por_mes(integer) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 42604)
-- Name: sumas_horas_segun_tipo(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sumas_horas_segun_tipo(character) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idtipo_hora  = $1 and
  		activo =true) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumas_horas_segun_tipo(character) OWNER TO postgres;

--
-- TOC entry 223 (class 1255 OID 42579)
-- Name: sumas_horas_segun_tipo(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sumas_horas_segun_tipo(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idtipo_hora  = $1 and
  		activo =true) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumas_horas_segun_tipo(integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 217 (class 1259 OID 31515)
-- Name: cabecera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cabecera (
    logo1 bytea,
    logo2 bytea,
    nombre character(100),
    descripcion character(300)
);


ALTER TABLE cabecera OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 30174)
-- Name: cargo_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cargo_por_persona (
    idpersona integer NOT NULL,
    identidad integer NOT NULL,
    idtipo_cargo integer,
    cantidad_horas double precision,
    fecha_inicio date,
    fecha_fin character varying,
    activo boolean DEFAULT true NOT NULL,
    idtipo_hora integer,
    tipo character(5),
    idcargo_por_persona integer NOT NULL,
    bloque character(7),
    historico boolean DEFAULT false,
    observaciones text
);


ALTER TABLE cargo_por_persona OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 42580)
-- Name: cargo_por_persona_idcargo_por_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cargo_por_persona_idcargo_por_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cargo_por_persona_idcargo_por_persona_seq OWNER TO postgres;

--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 220
-- Name: cargo_por_persona_idcargo_por_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cargo_por_persona_idcargo_por_persona_seq OWNED BY cargo_por_persona.idcargo_por_persona;


--
-- TOC entry 183 (class 1259 OID 30024)
-- Name: configuracion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE configuracion (
    cantidad_max_dias_viatico_mensual integer,
    cantidad_max_hs_bloque integer
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
-- TOC entry 2454 (class 0 OID 0)
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
-- TOC entry 2455 (class 0 OID 0)
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
-- TOC entry 2456 (class 0 OID 0)
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
-- TOC entry 2457 (class 0 OID 0)
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
-- TOC entry 2458 (class 0 OID 0)
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
-- TOC entry 2459 (class 0 OID 0)
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
-- TOC entry 2460 (class 0 OID 0)
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
    maximo_horas double precision,
    orden integer,
    nivel character(8)
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
-- TOC entry 2461 (class 0 OID 0)
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
-- TOC entry 2462 (class 0 OID 0)
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
-- TOC entry 2463 (class 0 OID 0)
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
-- TOC entry 2464 (class 0 OID 0)
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
    descripcion character varying(50) NOT NULL,
    cantidad_cargos bigint,
    jerarquico boolean
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
-- TOC entry 2465 (class 0 OID 0)
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
-- TOC entry 2466 (class 0 OID 0)
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
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 202
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_documento_idtipo_documento_seq OWNED BY tipo_documento.idtipo_documento;


--
-- TOC entry 218 (class 1259 OID 42562)
-- Name: tipo_hora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_hora (
    idtipo_hora integer NOT NULL,
    descripcion character(50),
    max_hs_nivel_medio double precision,
    max_hs_nivel_superior double precision
);


ALTER TABLE tipo_hora OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 42565)
-- Name: tipo_hora_idtipo_hora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_hora_idtipo_hora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_hora_idtipo_hora_seq OWNER TO postgres;

--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 219
-- Name: tipo_hora_idtipo_hora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_hora_idtipo_hora_seq OWNED BY tipo_hora.idtipo_hora;


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
-- TOC entry 2469 (class 0 OID 0)
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
    mes character(2),
    cantidad_dias_reintegro numeric,
    cantidad_dias_disponible numeric,
    cantidad_dias_tomados numeric
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
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 206
-- Name: viatico_idviatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE viatico_idviatico_seq OWNED BY viatico.idviatico;


--
-- TOC entry 2207 (class 2604 OID 42582)
-- Name: idcargo_por_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona ALTER COLUMN idcargo_por_persona SET DEFAULT nextval('cargo_por_persona_idcargo_por_persona_seq'::regclass);


--
-- TOC entry 2210 (class 2604 OID 31350)
-- Name: iddetalle_dias_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico ALTER COLUMN iddetalle_dias_viatico SET DEFAULT nextval('detalle_dias_viatico_iddetalle_dias_viatico_seq'::regclass);


--
-- TOC entry 2209 (class 2604 OID 30200)
-- Name: iddetalle_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_viatico ALTER COLUMN iddetalle_viatico SET DEFAULT nextval('detalle_viatico_iddetalle_viatico_seq'::regclass);


--
-- TOC entry 2198 (class 2604 OID 30085)
-- Name: identidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidad ALTER COLUMN identidad SET DEFAULT nextval('entidad_identidad_seq'::regclass);


--
-- TOC entry 2199 (class 2604 OID 30093)
-- Name: idestado_civil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_civil ALTER COLUMN idestado_civil SET DEFAULT nextval('estado_civil_idestado_civil_seq'::regclass);


--
-- TOC entry 2212 (class 2604 OID 31384)
-- Name: idestudio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio ALTER COLUMN idestudio SET DEFAULT nextval('estudio_idestudio_seq'::regclass);


--
-- TOC entry 2193 (class 2604 OID 30040)
-- Name: idfuncion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funcion ALTER COLUMN idfuncion SET DEFAULT nextval('funcion_idfuncion_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 30077)
-- Name: idlocalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad ALTER COLUMN idlocalidad SET DEFAULT nextval('localidad_idlocalidad_seq'::regclass);


--
-- TOC entry 2191 (class 2604 OID 30021)
-- Name: idnivel_estudio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nivel_estudio ALTER COLUMN idnivel_estudio SET DEFAULT nextval('nivel_estudio_idnivel_estudio_seq'::regclass);


--
-- TOC entry 2195 (class 2604 OID 30061)
-- Name: idpais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pais ALTER COLUMN idpais SET DEFAULT nextval('pais_idpais_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 30117)
-- Name: idpersona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona ALTER COLUMN idpersona SET DEFAULT nextval('persona_idpersona_seq'::regclass);


--
-- TOC entry 2196 (class 2604 OID 30069)
-- Name: idprovincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia ALTER COLUMN idprovincia SET DEFAULT nextval('provincia_idprovincia_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 30101)
-- Name: idtipo_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_cargo ALTER COLUMN idtipo_cargo SET DEFAULT nextval('tipo_cargo_idtipo_cargo_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 30032)
-- Name: idtipo_detalle_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_detalle_viatico ALTER COLUMN idtipo_detalle_viatico SET DEFAULT nextval('tipo_detalle_viatico_idtipo_detalle_viatico_seq'::regclass);


--
-- TOC entry 2201 (class 2604 OID 30109)
-- Name: idtipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento ALTER COLUMN idtipo_documento SET DEFAULT nextval('tipo_documento_idtipo_documento_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 42567)
-- Name: idtipo_hora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_hora ALTER COLUMN idtipo_hora SET DEFAULT nextval('tipo_hora_idtipo_hora_seq'::regclass);


--
-- TOC entry 2194 (class 2604 OID 30053)
-- Name: idtipo_telefono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_telefono ALTER COLUMN idtipo_telefono SET DEFAULT nextval('tipo_telefono_idtipo_telefono_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 30128)
-- Name: idviatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico ALTER COLUMN idviatico SET DEFAULT nextval('viatico_idviatico_seq'::regclass);


--
-- TOC entry 2441 (class 0 OID 31515)
-- Dependencies: 217
-- Data for Name: cabecera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cabecera (logo1, logo2, nombre, descripcion) FROM stdin;
\\xffd8ffe000104a46494600010101004800480000fffe00134372656174656420776974682047494d50ffdb0043000b08080a08070b0a090a0d0c0b0d111c12110f0f1122191a141c29242b2a282427272d3240372d303d302727384c393d43454849482b364f554e465440474845ffdb0043010c0d0d110f1121121221452e272e4545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545454545ffc000110801f803bb03012200021101031101ffc4001b00010003010101010000000000000000000005060704030201ffc4005510000103020203090b080805030401050100010203040506111221310713354151617173b114223236728191a1b2c1d115162334425274c2333753546292a2e117244382f05663d2252683f193466465a3a4e2ffc4001a010101010101010100000000000000000000050403020106ffc4002d110100020201030303050003010101000000010203041131323312217113224114515261814291b1f023a1ffda000c03010002110311003f00d700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000047deab9d6db5cd55135ae7c7a3923b62e6e44f7954f9f15bfbb53ff57c4b0e29f172affd9edb4ce0dfab8a97a4cda3f29bb79af4bc4567f0b37cf8adfdda9ffabe23e7c56feed4ff00d5f12b20d5fa7c5fc593f5397f92df6fc5d57595f4f4efa785ad95e8d554cf34cfce5c8cb6c7c3943d737b4d48c1b54ad2d115851d3c96bd666d3c80032b6055eeb8b1f6db94d4a94ad937bd1ef95f9679b517939cb419b62af18aaffd9ec34d3ad4adef316fd9936f25b1d226b3f949bb1d4d977b451a2f3c8abee3f3e7d54fee717f3295506ffd362fd937f559bf92cff3deb7f76a7feaf8939872fb3de7ba77f8a366f3a396867af3cf97a0cf0b9605fd0d6794cf79c7630d298e6621df5b364be488b4fb2de0026ab00003ca79e3a685f34cf4644c45739cbb1108eb6e21b6dde474747528f91a99e82b55ab972a22ed3931bab930ad568e7966ccf2e4d2432a8279696764f03d592c6a8e6b936a29ced7f4cb1e7d99c5788e3d9bb021b0e5e997bb6326d49333bc9989c4ee5e85da4c9d2279f76aada2d11301c575aef936d95157a1be6f2cd2d0d2cb3f39da43e29f166e1d52f69f27a3dd7aab3fe267ff00c57ffe9fff00e494c3b8c7e5eb8ad2770ef1946afd3dfb4b62a6acb45394cb8b56e79e31bbf0eeed43956f3cb4df1d62b3310d440076650e4adafa7b7533a7ab99b144dfb4ee3e64e553de4959146e924546b1a8ae72aec444e3321c497d92f9707499aa5346aad859c89cabcea78bdbd30cf9f3c62aff006d46d97aa1bc46f7d14dbe682a23915aa8a99ecd4a4899aee73a7f2cd4a267bdf73ae7d3a4dcbde6947da4f31cbd60c93929ea90007a760a5498dea592399dc7177aaa9adca5d4c92b3556cfd63bb4d7ab8eb799f54316e64be388f4cf0b27cfaa9fdce2fe653e5d8e2af3ef696144e7555f795706dfd3e2fd93ff00539bf92cdf3e2b7f76a7feaf88f9f15bfbb53ff57c4ac83efe9f17f13f5397f9357a19d6aa829a77a223a589af544d88aa88a751c568e07a1fc3c7eca1da47b471330b749e6b1210188afb3d9df4ed8228dfbea39574f3d5965c9d24f94bc77fa6a2f25fda875c158b6488971d9b4d31ccd67dde1f3e2b7f76a7feaf88f9f15bfbb53ff57c4ac829fe9f17f14afd4e5fe4b37cf8adfdda9ffabe249d8712d4ddabd69e6862635235766ccf3d5973f39462d383682a5b5cb56e89cd816356a3ddab355cb672ec38e6c38eb4998876c19b2db24473ecbc00098ae00000392aebe9a859a55550c8b99cbad7a136a907598d68e2cd29629275fbcbde37e3ea3dd71defdb0e77cb4a774ace0cf6a7185ca6cd2258e16ff03735f4ae644d45c6b2ab3ee8aa9a445e273d72f41a6ba779eb3c325b7a91db1cb4e9ae1494faa7a98635e474888a714989ad3178558c5f25ae776219a83b46957f32e33bf7fc43427630b53535492bba235f79f1f3ced9f76a3f913e25001ebf478de27772ff004bfb7195ad575efede7567f73dd98b2d2e4d750e6f951bbdc867204e9e3fec8ddc9fd34f8af96d951342b61cd7ef3b47b4ef8e58e56e946f6bdbcad5cd0c84fa648f89da51bdcc772b57253c4e947e25d2bbf3f9ab5f06634f88ae94d9232adee4e493bfed266931ccadc92b295af4fbd12e4be85385b572474f768aeee39ebecba82228f12db6b3246cfbdbd7ec4bdeafa767ac9745cd33433dab359e261aab6ada39acf2000f2f400000000000000000000000000000000039ea2ae9e919a75334713795ee44cc83aac694106694ec92a1dca89a2df4aebf51eeb8ed7ed873be5a53ba5640502ab19d7cd9a40c8a04e544d25f5eaf51155178b8d57e9ab26722f123d513d09a8d15d4bcf5f665b6f638e91cb4d9aa6081339a68e3f2dc89da71cb882d71277d5d12f92ba5d8662aaaab9aeb550768d2afe65c277edf8ab457e2db4b53bda87bfc98ddef43c1719db1172449d79d189f12820f7fa3c7fdbc4eee5fe97ff9e76cfbb51fc89f10dc636c5dbbfb7a59fdca003efe931be7eb72ff004d1d98aed0fdb52adf2a377c0e98ef96d991342ba0d7f79e8ded32f0799d3a7e25ee37aff9886bd14b1ccdd289ed7272b5733ecc7daf731c8e6395aa9c68b91214f7db9d365bdd6caa89c4f5d24f5e6729d39fc4bad77ebff2ab50050e9b1ad6c792544114a9cadcdabef4f5137498c6dd51924dbe53bbf8db9a7a50e16d7c95fc34536b15bf2b083c20aa86aa3d3a79592b7958e453dce1d1a2279f780001f400000000000000000000000000010b8a7c5cabff0067b6d338346c54a89876ad178d5889fce867253d3ec9f948def247c0003630bbec7c3943d737b4d48cb6c7c3943d737b4d489bb9dd0ada1d93f2000c4de19a626557620ac55fbcd4fe9434b333c4de30d67949eca1b34fbe7e1877bc71f28a0014d202e5817f4359e533de534b9605fd0d6794cf799f6bc52d5a9e685bc00485b000071dca89971b75452bd724998adcf917897cca62d5104b4b5124133559244e56b9178950dd4a962dc29f2ab56b289112b1a99399b12544f79cf25798e618f6b0cde3d55eb0a3e1fbdcb62b8a4ec45742fef658fef37e286bb4759057d2b2a299e924522668e43119a1969e57453c6e8e462e4e6b932545242cd7eadb24fa74cfce372f7f13f5b5df05e739d2fc7b4b26bec7d2fb6dd1b310f8a7c59b8754bda465bf1edb2a9a9dd5a749271a3915cdf32a7bd10f4bfde682bb0ed7b296aa299eb12f7ac5cd535f1f21dbd5130a98f2d2d31c4b2b2d5b9e78c6efc3bbb50aa965c0d550d25f1f2d448d8a3481d9b9cb9226b43857aa8e49e292d58101538cacb4a8b9d624ae4fb30b55d9f9f67aca75f71bd55ca37d3d1356969dda9cb9f7ef4e9e24e8f49da6f109393631d23af2eec6b89db323ad742fcda8bf4f23576afdd4f7fa0a382d386308cd74959555b1ba2a26eb445d4b2f327373fa0e3ef794b99bec6458b00dadd476b92b654c9f56a8ad45fb89b3d2aabea2de7cb5ad6351ad446b51324444c9110fa3444711c2ce3a452b1580007d7b0c9ee3c2757d73fda535832abbf0cd77e224f694dda5dd29fbfdb571800a2940000d52d1c0f43f878fd943b4e2b4703d0fe1e3f650ed215bba5fa2a76c052f1dfe9a8bc97f6a17429b8da27cd55411c4c73dee47a235a99aaeb43b6b7961c36fc52a81d5416daab8cdbdd244af5e35d88de952c569c1ae768cb73768a6d4858bad7a57e05be9e9e1a585b153c6d8e36ec6b532435e5daad7da9eec5874ed6f7bfb420ad584a968f465accaa664d792a778df371f9cb1ec009f7bdaf3cda55298eb8e38ac0084bae25a2b6e9311dbf4e9fe9b1762f3af114db9621aeb966d924dea15ff004a3d49e7e53ae3d7bdfdfa43865daa63f6eb2b95c713dbe8155a927744a9f622d7974aec2ad5f8b6e1599b617252c6bc51f85fcdf0c88206fa6b63a7f69d936b25ff003c43e9ef748f57bdcae72ed572e6aa7c8068650000000000000000000000000eea2bc575bd53b9ea1ed6a7d85d6df429c20f9358b4712f55b4d67985d6dd8d21972657c5bcbbf691eb6fa36a7acb341511554492412b2462fda6ae686487451d7d4dbe6df6966746ee3cb62f4a7198f26a567de9ecdb8f76d5f6bfbb590556d38ca19f463b835217ecdf53c15e9e42cec7b64623d8e47355352a2e68a60be3b639e2d0a58f2d32473597d800f0e80000000000000000022ae97fa3b5355267e9cbc51335bbcfc852ee789ab6e39b11dbc40bfe9c6bb539d78cef8f05f27bf4866cbb34c7edd6570b8e23a0b6e6d7cbbeca9fe9c7ad7cebb10abd7e30afaacdb4da34d1afddd6ef4fc0af837d35a94ebef29d936f25fda3da1f72cb24d22be57ba47aed73973553e0034b28000f8000000000000000000000000fb8a6960911f0c8f8de9b1cc72a293b438c6be9b26d4a36a59fc5a9de94f7a15f078be3adfba1d2992f49e6b3c347b7e26b7d7e4ddf778917ec4babd0bb09a31e24edd882badaa8d8e5df214ff4a4d69e6e4f318f269fe692dd8f7bf1921a7020ad789e8ae3a31b9dbc4ebf61eba9579978c9d30dab6acf16850a5eb78e6b2000f2f60000000000000000000084c5de2f4fe533da4339346c5de2f4fe533da43392a69f8ffd47def27f8000d6c4efb22a25ee873fdb37b4d48caad1c3343f888fda435526ee7742ae876cfc8003128066789bc61acf293d9434c333c4de30d67949eca1b34fbe7e1837bc71f28a0014d242e5817f4359e533de534b9605fd0d6794cf799f6bc52d5a9e685bc00485b0a86e815b2d2d9e18a17ab1279345ea8b92ab513616f2b78d2d8eb8d89fbca2ba5a776fad44daa88992a7a173f31e6dd25c73c4ce398ab38b5de2b6cf3a494932b533efa35d6c7f4a1aad8ef74f7ca149e2ef646ea92255d6d5f872298d92364bccf65af6d445df3175491e7a9ede43852dc4fba66bec4e39e27a35bafb5515cdba35b4b1cd96a47393be4e854d6842c9806cd22e6d64d173364cfb7326edb72a6bad1b2aa95fa51bb6a71b57915394ed347113eeab34c77f7988957a9f055929d74bb8d64727ed2472fab3c8fbc434d052e15af8e9e18e18d225c9b1b51a9b7989e21f14f8b370ea97b4f9c4447b3de3a56b31e986385ab73cd7889f9feeeeed42aa5ab73cf18ddf87776a1c2bdd0df93b657aabc3168ae5574f411692ed5666c5f564472e01b32b91746744e449351680779ac4fe13671527ac4216870b5a281fa70d131644d8f9155ebebd9e625a5959044e9657a323622b9ce72e48887daaa2266ba90cdb18e296dc156df42fce99abf49227fa8a9c49cc9eb13315878c97a60a7310e5c4b8baa2eb33e0a37be1a24d5922e4b273af3730c0b5b3c18862a663d779a86b91eccf56a6aaa2f4ea2b25c773eb63a7b9495ef6aef50355ad5e57afc133f4a1c2b333684cc76be4cd13cfbb49001a56832dbe70dd775ceed352330bfa225f6b72fda29b74fba5837bb23e51a0029248000353b42a2d9e872fdde3f650ee23ec9c0945d4b7b090215fba5fa2c7db01f1a0d57a3d5a9a489922e5ad10fb0797b002b57ac57150e94147a335426a55fb2cf8a9ee94b5e78abc5f2571c73694cd7dca9ad90ef9552a31389bb5cee8429176c55575fa515367040bab26af7cee95f7210f53533d64ce96a2573debb55ca7894b16b569ef3ef2939b6ed93dabed0000d4c60000000003a29a82aaad7fcb534b2f3b18aa9e92520c23759bc28e3853fee3d3dd99e2d9295eb2e95c77b76c20c16c8b02caa99cb5ac6f332355ed543aa3c0f489fa4aa99de4a227c4e53b58a3f2ed1a99a7f0a482fadc156d4db2543ba5e9f03ebe665b3ef547f3a7c0f3fabc6f5fa2cbfd2800bd3b03d0aa77b51528bcead5f71cd26046afe8ab95399d1e7ef3ec6d629fcbccea658fc29c0b24d82abd9ae39609139155517b08c9ec173a6cf7ca2955138d89a69eacceb5cd8edd25cad87257ad651c0fd7355ae56b9151536a29f8747200000000092b5df2b2d4f4485fa70e7df44ff057a39148d07cb562d1c4bd56d359e6b2d36d57ba5bbc7f42ed19513be89de127c50943218a57c12b6489ee63dab9a39ab92a173b162c6d4e8d35c1c8c9b6365d8d774f22fa89b9b5a6bf753a2a60db8bfdb7f695ac00636f00000023ee776a6b4c1a73bb372f811a784eff009ca7d889b4f10f96b45639975cd3c74d0ba599ed8e36a66ae72e488536f18be49b4a1b6e71c7b1665f097a393b7a085bade6aaed3694eed18d17bc89be0b7e2bce479470eac57defd52b3edcdbeda7b43f5ce57395ce55572ae6aabc67e006d6000000000003ea38a499e8c898e7b97635a99a81f2096a6c3174a9c95295626af1caa8df56df51290606a8765dd1591b3998d5776e471b67c75eb2ef5d7cb6e955541788f0451b53e92a277aff000e4df729d2cc1f6a6a266c95dd326df41ce76f1bac6965967c0d17e68da7f777ff00f95df13e1d83ed4e4d51cade8917de7cfd663fedf7f4393fa67a0bccb82285dfa29ea18bcea8a9d870cf81676a7f97ab8dfcd2315bd999ee36b14fe5e27532c7e15404b54e18ba5366ab4ab2b538e25477ab6fa88b7c6f89ead91ae63936a3932543b56f5b74970b52d5ee8e1f2003d3c0000000004e5a714555b74639956a29d3568b975b53997dc4183cde95bc71687ba5ed49e6b2d4edf74a5b9c3be52c9a59784d5d4e6f4a1dc6474d53352ccd96091d1c8dd8e6a977b262a8abb460add186a17523b635ff000526e6d69a7bd7de15706dc5fedbfb4aca00323680000000000000002131778bd3f94cf690ce4d1b1778bd3f94cf690ce4a9a7e3ff0051f7bc9fe00035b13b2d1c3343f888fda435532ab470cd0fe223f690d549db9dd0aba1db2000c2a0199623769620ac5fe3cbd08869a66188787ab7ac3669f7cb06f7647ca340053490b9605fd0d6794cf794d2eb8153fc9d5aff00dc4ec336d78a5ab53cd0b600092b60054b17e2996cb2434b46c63a67b74dce7a668d6e792649cb9a2fa0f933111ccbc5ef18ebeab20f16e117d248faeb746af81caae9226a6b8d7953f87b0a71a0d8f1eb679920bb31b12b9726ccccd1bfee4e2e925ee983ad5745595235a791daf7c8151117a5361c66916f7aa75b05737df8a7fc66d6abc55d9aa37ea4932cfc363b5b5e9ce868569c736eae6b5954eee39b8d245ef17a1df1c8859f736a8455ee7af89e9ff718adecccf06ee7370cfbeaba644cf895cbabd023d70638d8c5ed11ecd1a29193311f1bdaf6aec735734522f14f8b370ea97b4afd0600969974df77963e54a76ab57d39fb890bdda63a2c355cbdd15750e6c5a9d5150e7fab3cbd475e6663de14315ef698f55786585ab73cf18ddf87776a1552c98169d9537d7c722bd116076b8dee62a6b4d8a8a8a71af552c9d92d5c88b8e24b65ad17ba6ad8b227fa51ae93bd09b3ce465cf06256b5da176ae6a3b6b6691656fad517d64149b9bd6a2fd1d6d3b9395cd727c4eb336fc42464c99a3b6ae1c418caaaeed753d3a2d3d22ed6a2f7cf4fe25f727acad1738f739ae73934eb29dade56a3957b1097b7ee7b6fa7723eb2696a953ecf80df56bf59ca6b699f7619c19f2cf36522c961abbe54ef74edd189abf493393bd627bd798d6edd6f82d9431d2d2b74638d3ceabc6abce43deb1050618a6653c10b1d2e8fd1c11e4d46a72af27bcaf5ab1e574d73863ac8e158267a3177b6aa2b735cb34d67b8f4d3d9a31fd2d79f4ccf332d1400756f0ccf12a22620accbef27621a619b629444c455689fc0bfd086cd3ef9f861def1c7ca1c00534800242cb6c7dd6e0c813348d3be91dc8df89f2d68ac732f55acda62b0d06c9c0945d4b7b0903ce28d90c6d8e36a358c4446b53890f4215a799997e86b1c4440003e3d29389efd52daa96df4ebbd46cc91ee45ef9f9a67e64d655095c4de30d67949eca1145ac358ad23840cf79b649e4001d5c400e9a2a0a9b84dbd52c2e91dc796c4e95e23e4cc44732fb11333c4398e8a4a0aaaf93429607caee3d14d49d2bb10b75b70643168c95efdf5fb77b6ea6a74aed5f51668618e9e348e18db1b13635a992218f26dd63da9eedd8b4ad6f7bfb29d4382657e4eae9d234fb916b5f4ec4f5960a4c3b6ca2445652b64727da97be5f5ea25818ef9f25facb7d35f1d3a43f1111111113244e243f4038bb800000000000000039ea68e9aad9a3510472a7f1b517220eb30650cf9ad33df4eee445d26fa175facb203dd725e9db2e77c54bf74339afc2971a4cdd1b12a634e38b5afa36fa33215cd56395ae456b9352a2a6b4360386bed145726e5550b5cee27a6a7279cd74dc9e97862c9a313ef496580b35cb0654419c942edfe3fb8ed4f4f7295b9237c52399231cc7b57256b932543753256f1cd653f262be39e2d0f9001edcc000165c3f89df47a34d5ce57d3ec6c9b563f8a7617963db2b11ec7239ae4cd151734543212730fe2292d722413aabe91cbad36ab39d3e062d8d689fba9d5435f6bd3f6dfa345079c52b2789b2c4e47b1c99b5c8ba950f426aaa26fb79f91e912448d649245d16265dea2f3a99d55d5cf5d50e9ea6457c8ee35e2e64e44352aca48aba99f04edd28de992f373a7399b5ded535a6ad6193be8d75c7265a9c9f137e9cd3de3f299bd5bfb4fe1c0002826800000fd4457391ad45555d4889c6582d9846aead1b255af7344bc4a99bd7cdc5e73c5f25691cda5d298ed79e2b0af222b951113355d8884d50615b8d6e4e7c694f1afda9752fa36976a0b2515b5a9dcf0a69f1c8ed6e5f3f17989130df727fe10a18f463ade55ca2c1d414f93aa15f50ffe25d16fa13e24e414d0d2b3429e1644de463510f7064b64b5fba5b698a94ed800078740000000000000e7a8a4a7ab66854c31cade47b51723a0089e1f26227da558aec17473e6ea391d4eff00babdf37e3eb2af70b057db7374d0e9c49fea47df37fb79cd3c1a69b37af5f765c9a98efd3d98f0343ba616a2afd27c49dcf3afda626a55e7429972b3565a9f954479c6ab93656eb6afc3ce6fc7b14c9ed1d5372ebdf17bcf447800eece00000000b458714be995b4d7072be2d8d9575ab3a7950bb31ed9588f6391cd72668a8b9a2a19093b60c4525ade90ceaafa572eb4daace74f81873eb44fdd4eaa1afb535fb6fd1a203ce29593c4d962723d8e4cdae45d4a87a13954000000000001098bbc5e9fca67b4867268d8bbc5e9fca67b4867254d3f1ffa8fbde4ff000001ad89d968e19a1fc447ed21aa9955a386687f111fb486aa4edcee855d0ed900061500cc310f0f56f5869e66188787ab7ac3669f7cb06f7647ca340053490bb606faa55f589d8524bb606faa55f589d866daf14b569f9a16b001256c339dd1a95edb852d5e4bbdbe2deb3e454555fcdea346236f9698ef56c929255d172f7d1bfee39362ff00ce53cde398e1c73e3fa949ac3172fb82713e9232d75d26b4d5048e5dbfc0beef47214aaea1a8b755c94b531ab258d7254e5e74e63c11551734d4a867899aca3e3c96c57e61bc82838731ca23594b7872a65a9953b73f2be3e9e52f50cb1cf136489ed7c6e4cdae6ae68a9d2698b45ba2ce3cb5c91cd5e843e29f166e1d52f693043e29f166e1d52f689e8ed5ee86385ab73cf18ddf87776a1552d5b9e78c6efc3bbb50cf5ee86dc9db2d44006961085c457d8ac542b2bb274efd51479f84bcabcc873df71751599ab1b1c95155b12262ea6aff0012f1746d332b85c6a6e956fa9ab934e477a1a9c889c4873bdf8e8c7b1b3148f4d7affe3c6a2a25aa9e49e77ac92c8ed273978d4eab252beb2f5450468aaae95bb389117355f4229c069382b0dbedf12d7d63346a656e51b1c9ae36f3f3afa8e358f54a7e1c7396eb8800d4b819be2b444c4350a9c68c55fe5434833ac5ed44bf48a9c6c6afa8d7a9e4ff0018b7bc71f283001511dfad6ab9c8d6a2ab9572444e3349b05a92d36f6b1c89bf49df4abcfc9e6f895ec1f67dfa6f94276fd1c6b9448bc6ee5f376f417826ed65e67d10aba78788fa960006250000066789bc61acf293d9422895c4de30d67949eca1145cc7d91f0fcf65f25be40899ae487b53534d593b61823591eed8885eec98660b635b354653556dd2fb2ce8f89e32e6ae38f7eaf78705b2cfb744259f08cb53a33dc34a18975a469e1bba793b4ba5352c1470a454f1b638d3ecb50f704bc996d927dd63160a628fb4001c9d8000000e6a8ada6a46e751511c5e5b9104473d1f26623de5d20829f16daa24546caf95538a362fbf23865c734e9fa1a495de5b91bf13ac61c93d21c6763157ad96b052d71dbf3ef681a89cf2e7ee3e531d4f9ae951c6a9ccf543dfe9b2fecf1fabc3fbff00fc95d814d663bfbf41e76cbfd8ea8b1b50b951258278f9d111c9da7c9d7cb1f87a8dac53ff0025a01114f896d550b936adac55e29115b979d7512714b1ccc47c6f6bdabc6d5cd0e56adabd61dab7adbb6797a000f2f4000011f72b3d25d19a3531f7e9e0c8dd4e6f9c9007d899acf30f96ac5a38966f77c35576bd291bf4f4c9fea3535b7a53888636154cd3252ab7bc24ca9d2a8b735b1cdb562d8d774722fa8df876b9f6bffda667d3e3eec7ff004a403ee58a48257472b1cc7b572735c992a1f06f4f0001f139877103ed7324350aaea47aeb4dba0bca9ef434263db231af6391cd72668a9b150c84b2618c41dc52368ea9ff00e5debde397fd35f8298b675f98f5d7aa86aec7a7ecb745f4e1b9db20bad23a09d39daf44d6c5e543b813a266279854b562d1c4b27b8504f6eab7d3d43727b762a6c7272a1cc6997cb34777a4562e4d999ae39391791798ce9f4750cab5a5742fdfd1da3bda266aaa56c19e3257dfaa26c609c56f6e92f0256d587eb2eae4731bbd419eb95e9abcc9c64fd9b08b22d19ae488f7ed48535b53a797b3a4b5b5a8d6a35a888d44c911388e3976e23da8ef874e67eec9ff0048cb65868ed688b1334e5e395fadde6e4254027dad369e654eb58ac71580007c7a0000003e2596385ba52bdac6f2b972403ec1172e21b5d3a77f5d12f919bfb3338e4c616b6a77af95fe4c7f13a462bcf48729cd8e3ada160056971bdb9172486a579d18dffc8fd6e35b6aed8ea5bd2c4f89f7e864fe2f3fa8c5fc9640413316da5fb677b3ca8ddee3b61bcdbaa3248ab61555d88af445f429e671de3ac4bdc65a5ba4c2401f88a8e445454545e343f4f0e800001e72c4c9a3747235af6393256b933453d0014dbce10c91d3db3a56055f657dc545ec746f563daad735725454c9514d8085bd61ea7bb315e889154a26a91136f32f29b70ed4c7db74fcfa716fbb1f5fd99c03a2b68a7a0a9741531ab1edf42a72a72a1ce5189898e612e62627890007d7c00004e61ec40fb5cc90ceaaea47aeb4dba0bca9f03418e464b1b648dc8e639334722e68a86445970bdffb8e44a3aa7fd03d7bc7397f46bf05316cebfaa3d75eaa1abb1e9fb2dd17c001355400000001038c1da3609532f09ed4f599e1a1631e027f58d33d2a69f8d1f77c9fe00035b13b2d1c3343f888fda435532ab470cd0fe223f690d549db9dd0aba1db2000c2a01985fd516fb5b97ed14d3ccb6f9c395dd73bb4dba7dd2c1bdd91f2e000149242ed81bea957d62761492ed81bea957d627619b6bc52d5a7e685ac00495b0f85918d7235cf6a397622aeb53ecc36b6b66b856cb553bd5d248e572ae7b3993a0f16b7a59f3e7fa511edcf2d76f162a2be4091d546ba6df02466a733fe72142b8e03ba52b95d4ba1571f12b1745de745f72a9d1863194b472b292e92ba5a776a6cae5cdd1f4af1a761a4a2a39115aa8a8bad1538cf9c56feee715c5b31eafcb1296d37085729a86a58bfc51393dc755ba5bddbe4cedecac8d575ab1b1aaa2f4b72c94d901f3e97f6f11a5113cc594ab75e316cc88d92d2c7b7ef4ad5897cf9afb890be3ae0ec315ceae6411fd0f831395cb9f4ae5ef2ca43e29f166e1d52f69ef8e23ab662a4d6639b4cb1c2cd80f7df979fbc2b11fdceecb4d15536a721592d5b9e78c6efc3bbb50e35eb0a393b656baeaec4f4c8bbcdb29674fbd1c8aef52aa2951ba5d31454a39953155c11aed6470ab117cf966be93540759af3f948c9826fff002961cdb756bdd93692a1cabc491b97dc49d1610bcd6b91528dd0b57ed4fde65e65d7ea35e0798c50e31a35fccaad62c154b6a7b6a2a952aaa5bad1553263179938d79d4b2be5646a88f7b5aaed488ab96656715e2a4b333b9a93464ad7a66aabad224e554e5e44ff008b9a54d54f573ba6a995f2caedae7ae6a26d15f687dbe7c783eca4375057f06d5cb598729dd3395cf8d5d1e92aeb5445d5ead5e62c07489e6396ca5bd558b7ee19ee326e57ccfef44d5ed3422818d5b95e635fbd0357d6e35ea7919777c5feaba75daedf25ceba3a78f34472e6f77dd6f1a9c8689866d1f25d0e9ca99544d939f9fd94e269bb3e5fa75e7f29daf87eadf8fc25e9e08e969e38216e8c71b51ad4e63d81f2e7a31aae72a235133555e2423ae71c43e81c56caf6dc693ba189931cf72379d1172453b4fb31313c4913131cc0003e3eb33c4de30d67949eca1cb6fb7545cea920a7666bb5ce5d8d4e55252e96e9ee78aeaa9e9d35ab915ce5d8d4c935a974b5dae0b4d2241026bdaf7aed7af2a94ef9e31e3888ebc24535e72e4b4cf4e5e768b353da20d08934a4778722a6b77c139892009b33369e6556b58ac710000f8f401b0ad5db175351e947468951326ad2cfbc6af4f1f9bd27ba52d79e2b0f17c95c71cda5619658e08d6495ed631bb5ce5c910ae57e32a5a75565231d52f4fb5e0b7e2a542bee55771974eaa673f91bb1ade84390df8f5223defee9b9376d3ed48e12f5989ae758aa8b50b0b17ecc3defaf6fac897395ce5739555576aa9f80d75a56b1c44315af6b4f369e4001e9e0000000003d21a89a99fa704af89dcac72a29e604c73d5f62784fd162fb8532a24eada86723d3277a53df9963a0c596fac446cae5a69178a4d9fcdb3d3919e833df5b1dbfa69c7b5929f9e5b022a3911517345d8a87e9975baf75b6c72773caab1f1c4fd6d5f371798b9dab14525c746295778a85d5a2e5d4e5e653064d6bd3de3de14716d5327b4fb4a7800676a0000445eac305e22cd728ea1a9deca89ea5e5433daea19edf52ea7a96683dbe854e54e635923aeb6a82ef4ab0ca993935b2444d6c5ff9c46ac1b138fedb7463d8d58c9f757ab2f07557d04f6daa753d4b72726b454d8e4e54394a913131cc23cc4c4f12000faf8bb613bef74312df54fce5627d1b957c24e4e942d66411c8f8646c91b95af62e6d726d45349b15d9b77a1491724999decad4e25e5e85266ce1f4cfaebd15b533faa3d16ea963c7788b7f59f7b66faadd1d3cb5e5c999ec0c6de0000000003c2a6aa1a38565a895b1469f69ca54ae98cdee57476d8f45366fd226bf327c4e98f15f276c3964cd4c71f74adb535705245be54cac8d9cae5c8ae57635a68955b4513a75fbeeef5bf15f514da8a99aae5592a257caf5fb4f5ccf237e3d4ac777ba764ddbcfb53d931578a6e9579a24fbcb57ecc29a3ebdbeb22a496499eaf95ee7b978dcb9a9f00d55a56bdb0c76bdafdd3c8003d3c000000003da9eb2a295da54f3c912ff000395098a3c6172a7c926565437f8db92fa5081078b63adbba1d2b92f4ed95fa8b1850d4aa36a11f4cf5fbdadbe94f7a13f14b1cf1a4913daf62ec73573453223a68ebeaa824df29277c4bc688ba97a5362992fa759ec9e1b31ef5a3daf1cb580542d78cd8fca3b8b341db37c8d334f3a71798b54334751136485ed7b1dad1cd5cd14c57c76c73c5a1431e5a648e6b2f5001cdd51f74b553dda99629db93935b1e9b58bff00388ceae56c9ed752b0cede76bd36393950d54e2b8db60ba52ba0a86eadad726d6af2a1a70679c73c4f465d8d78cb1cc756560ecb8dba7b6553a0a86f3b5c9b1c9ca871956262d1cc22cc4d67890007d7c00005e309df3baa34a1a87673469f46e5fb6de4e94ec2d26430cd253ccc9a272b6462a39aa9c4a69d67b9b2eb40c9d9923fc17b7eebb8c97b387d13eaaf4957d4cfeb8f45bac24000646e000040631e027f58d33d342c63c04feb1a67a54d3f1a3eef93fc0006b62765a386687f111fb486aa65568e19a1fc447ed21aa93b73ba15743b64001854032dbe70e5775ceed35232dbe70e5775ceed36e9f74b06ff00647cb800052490bb606faa55f589d8524bc60744f936a578f7ef7219b6bc52d7a7e685a400495a0c73135a9f69bd4f168aa4323964897895abc5e6d9e6363226fb61a7bed12c12f792375c72a26b62fc398f17afaa19f630fd5afb7586365d30862d4a5465bae2fca1d90cce5f03f8579b9f8ba36562e769abb454ac15712b17ecb93c17a72a2f19c470899aca4d2f6c56e63ab7945454cd35a1fa64f62c615967d18654ee8a54d91b975b3c95f717bb7e2db4dc911195490c8bf627ef17d3b17cca77ade255b1ecd3247ed29d21f14f8b370ea97b4966b91cd47355151762a719138a7c59b8754bda7a9e8d35ee86385ab73cf18ddf87776a1552d5b9e78c6efc3bbb50cf5ee86dc9db2d440382baf16fb722f75d5c512a7d95766ef426b34b04cc44732ef2bd897134163a75646ad92b1e9de479f83fc4ee6ed202f5ba02bdae86d11ab73d5bfc89afccdf8fa0a44d3493cae9667ba491eb9b9ce5cd554e56c9f8861cfb7111e9c7d5fb3cf254cef9a77abe591cae73976aa9f31c6f9646c71b55cf7aa35ad4daaaa7ec713e691b1c4c73dee5c9ad6a66aaa68b84b092db95b5f716a2d4e5f471eddef9d79fb0e55acda587162b65b710b058addf2559e9a917257b1b9bd53ef2eb5f5a92401aa2385cac4563880a1e376e57685dcb0227f53be25f0a6e29a096bef945042bdf48ccb3e44455cd54d1ad311939966db899c5c47f4e3c2767eecabeec99b9c102f7a8bf69ff00db6fa0bf1cd454915052474d0a64c8d32e9e553a4f19b24e4b72f7831462a71f90abe30baf7352250c4efa59d337e5c4cfeff12c353511d253c93cab9471b55caa65d5f5b257d6cb532f8523b3cb913890ebad8bd76f54f4871dccbe8a7a63acafb8551130ed265c6afcff009d49b2230ca2261fa3cbeeafb4a4b9c7277cfcb461f1d7e20001cdd5e1152c50cb2c91b511d33b49eee355cb23dc01d5f22380001f4396aeb60a0a774d5322471b78d78d7913954f2ba5d69ed54cb3543b5af80c4daf5e6339b9dd2a2eb50b2ceed49e0469e0b5398d18704e49e7f0cbb1b318a388f79485eb13545cd5d0c39c14df75175bfa57dc418055a52b48e2a8f7bdaf3cda4001e9e0000000000000000000000000000161b2e299e855b0d6694f4fb117ed33a395398bcd35543590366a791248ddb1c864a77daaef5369a8df215d28dde1c6aba9c9f1e73266d68b7dd5eadb836e69f6dfde1a9038adb7282eb4a9353bb3fbcc5dad5e453b49931313c4abc4c5a3980007c7d46de2d10dde916293bd91bae3938dabf0336aca49a86a9f4f50dd1918b92f3f3a731ad90788ac8dbad2e9c4889551a778bf793eea9ab5f3fa27d36e8c5b5aff00523d55eace81fae6ab5cad722a2a2e4a8bc47e1551c2eb83ad72410baba557377e4d18d9cade55f77f72bb61b4baed5ed63915208fbe95dcdc9d2a696d6b636235a888d6a64889b110c3b79788f44286961e67ea4ff8fb001395400f87bdb1b15ef7235ad4cd5557244403ecafde713d3db34a18329ea53568a2f7ace95f71117dc58e995d4d6e72b23d8e99352bba39139caa9bb0eaf3f75d3b3ee71f6e3ffb74d75c2a6e33efb552abddc49c4de644e2398028444447109933333cc8003ebe0000000000000000000000000765baeb556b934a9a4c917c262eb6bba50e307c988b4712fb13359e61a359f11d2dd51235fa1a8e38dcbb7a178c9b31f4556b91cd55454d68a9c45bac58b3356d2dc9faf63675fcdf1ffec9d9b578fba8a9836fd5f6e4ff00b5c8045cd33406250475e2d30dda91629326c89ad8fcb5b57e066b554b35154c904edd17b17254f79ad901892c8db9d2efb0b53baa24ef57efa7ddf81af5f3fa27d36e8c5b5aff00523d55eacf41faa8ad554545454d4a8bc47e1511c000025f0e5dbe4bb826f8eca9e6c9b273722f9be24403cdeb17acd65ee979a5a2d0d87682bf84ee7ddd6ede24767353e4d5cf8dbc4beef3160225eb34b4d657f1de2f58b40003cbda0318f013fac699e9a1631e027f58d33d2a69f8d1f77c9fe00035b13b2d1c3343f888fda435532ab470cd0fe223f690d549db9dd0aba1db2000c2a0196df3872bbae7769a91955e173bcd767fbc49ed29b74fba53f7fb63e5c600292505e703f065475df950a3179c0fc1951d77e54336df89af4fcb0b400092b40000f0a9a482ba1586aa164b1aed6bd3342af5db9edbaa155d492cb4cabf67c36a79975facb783e4d627ab9df152fdd0cedfb9b5422f797089c9cae8d53de7eb3736a8577d25c626a7f0c6abef4343078fa7571fd262fd950a1c054d4b92c95d56f5e348ddbda2fa335f59db7ea0828f0cdc3796bf4962c95ef7abdcbad38d5554b110f8a7c59b8754bda7af4c447b3be2c54a4c7a618e168c031b26bfc8c91a8e6ba9dc8a8bd2855cb56e79e31bbf0eeed43857ac28e4ed95c2bf08d1d6a2e551570aaf1326556fa1d990336e6ab9aad3dc532e247c5ef45f717f0779a5652adaf8edd619d7f86f57fbfc3fc8a7652ee6f035516aebe49138db1311beb5ccbc83e7d3abcc6ae28fc232db61b7da1bfe4a9dac7e592c8badebe7524c03d4470d1158ac710000fafa1e3bc47dd1bf68a6fba3a1a5cd9e791ec0000725c2b23b7d0cb552ec8db9a272af127a4fb11333c43e4cc44732abe33bae6e65be276a4c9f2e5cbc49eff41513d279e4a89e4964769492395ce5e753ccb58a918e91540cd92725e6cd370f26562a2cbf67ef2508fb270251752dec2408d7ee95cc7d91f0000f2e800001c374b9c36aa474f3af331a9b5cbc87b55d545434cfa89dda31b13355f719a5dae935dab1d34ba989aa3671350d1830fd49f7e8cbb19fe94711d5e75f5f3dcaa9d5152ecdcba91136353910e500ad11111c422cccccf32000faf8004a5aec1597554744ddee1e395fb3cdca79b5a2b1cccbd56b369e2b08b3ba8ecd5f5f92d3d33dcc5fb6eef5be952f16ec31416f46b9d1f744c9f6e54cfd09b109bd862bee7e290df8f4667def2a4d360799daea6a98cfe18daaef5ae44945832dd1a269ba7957f89e889ea42c80cd6d8c93f96caeae2afe10edc2d67626aa345e97b97de7d2e19b42a65dc6dfe677c496073fa97fde5d3e963fe31ff48293085a9e9dec2f8fc9917df99c13e06a7722f73d5c8ce691a8eecc8b603dc67c91ff002789d7c53d6acf2af085ca9f3589aca86a7ecddafd0a42cd04b4f22c73c6f8de9f65ed54535d39ea6929eae3deea6264ace47a6677a6e5a3ba3966be8d67b27864c0b95cf05c6f4592dcf563bf6522e68bd0bc5e72a755473d14cb0d4c4e8de9c4e4dbd1ca6dc79ab93b583261be3ee878800eae20000ebb6dc67b5d5b6785766a73389e9c8a6956db8c173a46d440ba97539abb5abc8a65449592ef25a2b5244cdd0bf54ace54e5e9432ec60fa91cc756cd6d89c73e99e8d3c1e50caca88592c4e4746f4456b938d0f5252c80002978becda0ef94606f7ae5ca66a26c5e277c4aa4513e6959144d573dea8d6b538d4d6e58993c4e8a56a398f45473578d0af58f0dfc9b719ea26547a31cad87a17ed74f17a4dd8767d3498b758e89d9f566d9226bd27aa4acd6b6daa8190264b22f7d23938ddf0e224c0314ccda7996fad62b11580007c7a080c5d1492d8dee89ce448de8e7a22f84dd9ef45f313e78d440ca9a796193c091aad5e8543d52de9b459e3257d749afeec901e93c2fa7a892191327c6e56bba51723ccbb13cfbbf3d31c0000f80075d0db2aee2fd1a581d265b5db1a9d2a7c99888e65f6226d3c43902266b92172a1c12c6a23abe657afece2d49e952c5476ba2a144ee6a68e35fbd966ef4aeb32df6e91dbeed94d2c96eef66754d64b955a22c3452aa2ec57268a2f9d7224a2c1972935bdd045cce7aaafa90d0019adb779e9ecd55d1c71d6795219816a17c3ab8d3a1aaa7eae059fec5646bd2c542ec0f1fa9cbfbba7e8f0feca04b82ee2c4cd8f824e6472a2fad08caab1dc6911566a4951a9b5cd4d24f4a1a903dd76ef1d7ddceda38e7a7b31e06a55b68a1af45ee9a6639cbf6d13277a535957b8e0b9588b25be4df53f6726a7799762fa8d54dba5bda7d993269e4afbd7dd5507dcd0c94f2ba39a37472376b5c992a1f06a64e380001f0000166c3789568dcda3ae7aac0ba9922ff00a7ccbcdd85e9151c88a8b9a2ec5431f2d385b102c0f65055bbe8dcb944f5fb2bc8bcc60d8d7ff9d54757678fb2ff00e2f00027aa2918bacbbcbfe50a76f78f5ca66a26c5fbde7ede92aa6b9342ca885f14ad4746f456b9abc6866177b6bed95f240ecd5be146e5fb4de25296ae6f547a27ac24ee61f4cfaebd25c40036b00000242c7715b65d229d57e8d7bc913f857e1b7cc6a08a8a99a2e68a63e68985ae1ddb67635eb9c907d1bba3897d1d860dcc7d2f0a5a397de6929d0013d4d018c7809fd634cf4bf633554b2265c73373f429412a6a78d1f77cbfe00035b13b2d1c3343f888fda435532ab470cd0fe223f690d549db9dd0aba1db2000c2a01955df866bbf1127b4a6aa65577e19aefc449ed29bb4bba53f7fb61c60028a505e703f065475df950a3179c0fc1951d77e54336df89af4fcb0b400092b400000000000010f8a7c59b8754bda4c10f8a7c59b8754bda7c9e8fb5ee86385ab73cf18ddf87776a1552d5b9e78c6efc3bbb50cf5ee86dc9db2d4400696100000000000000000a3e33b96f950ca18dddec5dfc9971b97627993b4b6d7d64741452d4c9b236e7972af127a4cb2699f513be695da4f91cae72f2aa9b3531f36f5cfe183772fa6be88fcbe00053496a7684cacf449ff00ede3f650ee392de8a96da545da9133b10eb20dbacbf474ed80007c7a002b18b6efdc74a94703b29a7f0d53ecb3fbfc4f74a4ded15873c99231d66d282c4f7a5b955ef103bfcac2bab2fb6ee5f8104016a948a57d30837bcded3690007a780222b951113355d88811335c90bce1bc36946d6d656b739d75b18bf639d79fb0e5972d71c732ed8715b2db8872d8f09a64ca9b9339db07fe5f0ffe8b7b5ad6351ad446b51324444c910fb049c992d9279b2d62c55c51c54001cdd40000000000000000392ba829ae302c5551a3dbc4bc6de745e23ac1f626627987c98898e259cdef0e4f6a55963ce6a555f0f2d6df2be2421af39ad91aad7351cd7264a8a99a2a144c478716dee755d235569957be6a6d8ffb14706cfabedbf54ad9d5f47dd4e8ae000dac00000b560fbbe849f27ceeef1f9ac2abc4bc69e7ff009b4bb99031ee8a46bd8e56bdaa8ad54e254350b3d7b6e76d8aa532d254c9e89c4e4da4cdbc5e99f5c7e55b4b37aabe89fc3bc00636f000000000f174d13666c4b235247a2ab58abad5136e482a278e9a092699da31c6d5739798cceb6ed3d55d56b91cac91aece34cfc044d8877c38672f3c33e7cf1878feda9038ad75ecb9d04552cc93493be6fdd771a1da7198989e25de262d1cc33dc6145dcd77df9a9932a1a8ef3a6a5f72f9c802fd8c68bba2d093b5337d3b91dfed5d4beef41412b6b5fd58e3fa44daa7a32cff0061ed4d4b3d64c9153c4e7bd7635a849d970e54dd55247670d2f1c8a9adde4a71f497ca0b7535b20dea96246271bb6abb9d54f99b66b8fda3de5ef06adb27bcfb42bf6ac1d143a32dc5dbebf6ef48bdea74af19688a26431a47135ac6375235a99221e80997c96bcf36955c78a98e38ac0003c3a0000000000000000382e369a5bac5a1531e6e4f05edd4e6f42941bc586a2d1266efa4a755ef656a6ae85e4534d3ca68a39e27452b11f1bd32735c99a2a1df167b63f866cdaf5cbefd2591827710e1d7dadeb3d3a2be91cbd2b1af22f37390456a5e2f1ea846bd2d8ede9b0003d3c00002fd85ef4b70a6ee6a876753126a55daf6f2f4a163326a1ac9282b22a9857bf8dd9e5ca9c686a347551d652c55116b648dd24e6e6256ce2f45b98e92b3a99bea57d33d61d041627b57ca36e59234ce78337332e34e34ff009c84e833d2d34b45a1a6f48bd66b2c7812f896dbf275d1fa0dca19be919cdca9e65f71105ba5a2d58b43f3f7acd2d359fc0003d3c84fe0faeee5bbef0e5c9952dd1ff726b4f7a79c803ee195d04f1cd1ae4f8dc8e6af3a2e678c95f5d66ae98ef34bc5a1af03c29a76d4d3453b3c19588f4f3a667b90dfa089e7de15cc69c089d737b14a097ec69c089d737b14a095753c68fb9e5ff0001a98dd969544bc50aaea44a88fda4355327b7709d275ccf690d609dbbdd0aba1db600061500caaefc335df8893da5355328ba395d75ac72ed59debfd4a6ed3ee94fdfedab9400514a0bce07e0ca8ebbf2a1462f782113e489978d6754fe969976fc4d7a7e5598004a5a000000000000087c53e2cdc3aa5ed26087c53e2cdc3aa5ed3e4f47daf7431c2d5b9e78c6efc3bbb50aa96adcf3c6377e1ddda867af7436e4ed96a20034b0800000000000000029d8dabf2486858bb7e924ec44edf514f25311cae96fd56ae5cf45fa29cc889911659c15f4e38841d8bcdf24c8003b3835aa4454a381176a46dec3dcf88d15b135176a35114fb204bf491d00007d73d6554743492544da991b735e7e632dadac92bab25a995737c8b9af3722164c6774d3999411bbbd677f2e5c6bc49e8d7e72a853d5c5e9afaa7aca46e65f55bd31d20001b1840091b1dadd75b8b21c95226f7d2b9389bfdf61f2d68ac732f55acda62b09cc256347ab6e552dd48bf42d54dabf7be05d0f8646d8a36b236a358d4c91136221f645cb92725bd52bd871462afa60001cdd40000000000000000000000003e1ec6c8c563da8e6b9325454cd150fb0066f88ecab6aaad3891569655cd8bf757eea90c6ab72a18ee5432534bb1c9debbeeaf1299754412534f2432a68c91b95ae4e72aeb66f5d789eb08bb587e9db98e92f3001a9902cd82ebf79ae9289ebde4e9a4df293fb761593da92a1d4b570d433c289e8e4e7c94e7969ebacd5d715fd178b35b079c72b6589b231736b911c8bca8a7a111fa000000039eaeaa3a3a592a255ef236ab97e022397c99e239955b19dd72465be276dc9f2e5ea4f7fa0a79ed575525655cb512ae6f91cae5e6e63c4b78b1fd3ac55073649c979b2cd836e3dcf5cfa291df473eb6e7c4f4f8a76217b3218657c133258d745ec7239abc8a86a94356dada386a19e0cac4765c8bc6860dbc7e9b7aa3f2a1a5939acd27f0f4a8819534f2c327812355abd0a854acb841525dfae689a2d55d18917c2e75e6e62e60cf4c96a44c57f2d57c34bda2d68e8f96b51ad46b51111132444e23e8039ba80000000000000000000000000003ce58993c4e8a56a3d8e4c9cd54d4a866f7eb33ed157dee6ea7935c6e5ec5e7434c38ae96f8ae9432534a89df266d77dd77129df0659c76fe99f630c65aff0070cac1eb510494b3c90cadd192372b5c879162279f784398e00007c0b8609b82aa4b40f5d9f48cec54ec5f494f3b6d157dc576a69f3c9ad7a23bc95d4bea53966a7ae930ed8327d3c912d5000455f41e27b77775a1ee62672c1f48de8e34f47619d1b0ed32dbd50fc9f759e9d132623b499e4aeb4f8798a1a77f69a4a5ef63e262f0e0001bd380001a0e10aa5a8b2b18bb607ab3cdb53b7d4580abe07e0ca8ebbf2a16822e68e32597b5e66715795731a702275cdec52825fb1a702275cdec528250d4f1a6ee797fc0006a6374dbb84e93ae67b486b064f6ee13a4eb99ed21ac13b77ac2a6876d80018544327b8f09d5f5cff694d60c9ee3c2757d73fda53769774a76ff004ab9800514b0bde09e069bf10ef65a510bde09e069bf10ef65a65dbf1b5e9f9566001296800000000000021f14f8b370ea97b49821f14f8b370ea97b4f93d1f6bdd0c70b56e79e31bbf0eeed42aa5ab73cf18ddf87776a19ebdd0db93b65a8800d2c20000000000000000caeeeba578ae5cf3fa77e5fcca711ef5aed3aea876aefa472eae93c0bb5e90fce5a79b4c87eb5aae723536aae47e1e94ed575444d4daaf44f59f65f21ae80082fd207257d5b2868a6a993646dcf2e55e24f49d656b1b395b6789115534a76a2f3f7ae3de3afaaf15973cb79a526d0a3cf3bea2a249a55d292472b9cbcea79805c88e3d9f9f99e40007c0d130cdafe4fb5b5cf4d19e6c9efe544e24f476a94cb0d07ca37686172671b574e4f253e3a93ce6a060dcc9d290a5a38f9e72480027a98000000000000000000000000000000005271adb9193c75cc4d527d1c9d29b17d1d85d88ebdd1f775a2a60cb372b1559e526b4ec3ae1bfa2f12e19f1fd4c730cbc005a41000069385ea3ba6c34eaab9ba3458d7ccbabd5913056704affe8f2fe21decb4b31132c71926217f04f38eb2000e6ec150c6b7056450d0b175bfe924e84d89e9cfd05bccbefd54b557aab917623d58de86eaf71ab569eac9ccfe18f72fe9c7c7ee8e00155182f982e6749687c6e5cd239551bcc8a88bdb99432f381f832a3aefca865dbf1b5e9cff00faad000252d00000000000000000000000000000000000029d8d2d9fa3b8469c91cb927a17dde829e6af5d4acada29a99fe0cad56e7c8bc4be932b9627432be291327b1cad72722a14f5327aabe99fc246ee3f4dfd51f97c000d8c20000d5a826ee8b7d34cab9ac9135cbe7443ac8fb270251752dec240856f6b4c3f4549e6b1214fc734add1a5ab4f0b358ddce9b53dfe92e055f1c70653f5df954ebaf3c65872da889c52a3000b0840000bce07e0ca8ebbf2a1682af81f832a3aefca85a08d9fcb65dd6f1555cc69c089d737b14a097ec68a89646f3ccdec52826fd4f1a76e797fc0006a6374dbb84e93ae67b486b064f6ee13a4eb99ed21ac13b77ac2a6876d80018544327b8f09d5f5cff694d60c9abdc8eb8d4b9362cae5f5a9bb4baca76ff4ab9c00514b0bde09e069bf10ef65a510bde09e069bf10ef65a65dbf1b5e9f9566001296800000000000021f14f8b370ea97b49821f14f8b370ea97b4f93d1f6bdd0c70b56e79e31bbf0eeed42aa5ab73cf18ddf87776a19ebdd0db93b65a8800d2c20000000000000078d4bb429a57659e4c55f507c9f664af7693dcee55ccfc00befcd87bd0b74ebe99bcb2b53d68781d56b6e9dda8dbb339d89fd4879b7497aaf7435700109fa30ace36e0687f10df65c598ace36e0687f10df65c76c1e4ab86c78aca2000b2820000bb608a2dee967ab726b95da0de84dbeb5f516b382cf4a9456aa5832c95b1a2bba575afad4ef2265b7aef32fd061a7a31c54001cdd4000000000000000000000000000000000001945ce9d296e755022648c95c89d19eaf51ca4b6296a2622ab444e36aff00421125cc73cd225f9dc91c5e63fb0007b785e703aafc97509c4937e542d0557033b3a1a96f24a8beafec5a88d9fcb65dd6f154001c5a0327b8f09d5f5cff00694d60c9ee3c2757d73fda53769774a76ff4ab9800514b0bce07e0ca8ebbf2a1462f381f832a3aefca866dbf135e9f961680012568000000000000000000000000000000000000339c5b4bdcf7c91c9a9b3b5244ec5f5a1a3148c75f5da5ead7b4d5ab3c64e18f76227173fb2aa002aa30000351b270251752dec2408fb270251752dec240857ee97e8b1f647c055f1c70653f5df954b4157c71c194fd77e553a60f2d5cb67c5651800594200005e703f065475df950b4157c0fc1951d77e542d046cfe5b2eeb78aaace36e0687f10df65c510bde36e0687f10df65c510a1a9e34ddcf280034b23a6ddc2749d733da4358327b7709d275ccf690d609dbbd615343b6c000c2a219255fd727eb1dda6b664957f5c9fac7769bf4bad93b7fa55e200282585ef04f034df8877b2d2885f705a22591ea9c733957d0865dbf1b669f9564001296400000000000021f14f8b370ea97b49821f14f8b370ea97b4f93d1f6bdd0c70b56e79e31bbf0eeed42aa5ab73cf18ddf87776a19ebdd0db93b65a8800d2c20000000000001c574768daeaddc90bd7fa54ed236faed0b256aebfd1393573ea3d5639b43c5e78acb3000175f9d0eeb2b74af3429ff007d8beb438491b0b74afb448bfb5453c64ed97bc7df1f2d4000437e882b38db81a1fc437d971662b38db81a1fc437d971db0792ae1b1e2b288002ca0800035d87f431f929d87a1e14aaaea585cbb558d5f51ee409eafd24740001f40000000000000000000000000000000000019c62cf1827f259eca10a4d62cf1827f259eca10a5bc3e3afc3f3f9bc96f900074725d303393b96adbc68f6afa8b6950c0aa9bd56a71e933de5bc8fb1e595dd5f0d4001c1a0327b8f09d5f5cff694d60c9ee3c2757d73fda53769774a76ff004ab9800514b0bce07e0ca8ebbf2a1462f381f832a3aefca866dbf135e9f9616800125680000000000000000000000000000000000002918ebebb4bd5af69772918ebebb4bd5af69a35bcb0c9b9e1955400574500006a364e04a2ea5bd84811f64e04a2ea5bd84810afdd2fd163ec8f80abe38e0ca7ebbf2a9682af8dd17e4b81789274f654e983cb572d9f159460016508000177c0eece86a5bc92a2fabfb16a2a981bea957d627616b236c7965775bc355671b70343f886fb2e2885ef1b70343f886fb2e28850d4f1a6ee794001a591d36ee13a4eb99ed21ac193dbb84e93ae67b486b04eddeb0a9a1db600061510c92afeb93f58eed35b324ab5ceb2754fda3bb4dfa5d6c9dbfd2af1001412c2fd82f8117ae77621412ff8317ff44775ceec432edf8db34bcbfe2c400252c800000000000043e29f166e1d52f69307356d1c55f472d2ce8ab14add1764b92e47c9e8fb13c4f2c34b56e79e31bbf0eeed42d5f302c9fb39ff00fcaa765ab0bdb6cf56b5146d912456ab7be7e6992fff004738a4c4f2d17cb59acc26c007566000000000000088c4cfd0b055ae7977ad4f4b9109720f173b470fce99e5a4e6274f7c8bee3a628e6f5f972cd3c63b7c33a0016df9f094c36d47620a345fbeabea522c97c2c88ec45488bcae5fe8539e5ec9f874c5e4afcc34a00111fa10ace36e0687f10df65c598ace36e0687f10df65c76c1e4ab86c78aca2000b2820000d6a8fea70756dec3dce5a1769d0533b9626afa90ea20cf57e8ebd20001f1e80000000000000000000000000000000000019c62cf1827f259eca10a4d62cf1827f259eca10a5bc3e3afc3f3f9bc96f900074725c301edaff00fe3fcc5c4a66045fa5ad4e2d167bcb992367cb3ffdf85cd4f0c7ff007e40019da4327b8f09d5f5cff694d60c9ee3c2757d73fda53769774a76ff004ab9800514b0bce07e0ca8ebbf2a1462f381f832a3aefca866dbf135e9f9616800125680000000000000000000000000000000000002918ebebb4bd5af69772918ebebb4bd5af69a35bcb0c9b9e19554005745000069f6076958e8957f64884911987b80a8fab424c877ef97e871f647c05671b70343f886fb2e2cc5671b70343f886fb2e3de0f255e363c5651000594100005db037d52afac4ec2d6553037d52afac4ec2d646d8f2caeeaf86aace36e0687f10df65c510bde36e0687f10df65c510a1a9e34ddcf280034b23d29e5582a229535ac6f477a17335b63d1ec4735736aa668a640697872a92aac74ce55cdcc6e82ffb75766460ddafb4594742dc4cd52c0027aa065172a75a5b954c2bf6247227467a8d5ccfb1952ef17949913bd9d88ef3a6a5ec43669db8bcc7eec3bd5e6916fd95f0014d202db81aaf296a695cbe12248d4e8d4beef41523b6d15bf27dd29ea15726b5d93fc95d4bea3966a7ae930ed82fe8c9166a80fc45454cd173453f48abe000000000000000000000000000000000000157c6f508cb6c1022eb965d2f3227c550b419e62fae4aabc2c4d5cd94edd0ff0076d5f8798d1ad5f5648fe9976efe9c53fda0400574409ac2888b8829d5789af54fe552149dc1edd2beb172cf46372f41cb378edf0ed83cb5f96880022af85671b70343f886fb2e2cc5671baa7c910a67afba13d971db0792ae1b3e2b288002ca08000356b6f0652752cf650eb38ad6e475aa91c9b16062ff004a1da41b7597e8ebdb0000f8f4000000000000000000000000000000000000ce31678c13f92cf6508526b1678c13f92cf650852de1f1d7e1f9fcde4b7c8003a392d581557baeadbc4ac6afacbb946c0cecabea5b96d8917d7fdcbc9276bcb2b7a7e18000666a0c9ee3c2757d73fda5358327b8f09d5f5cff00694dda5dd29dbfd2ae6001452c2f381f832a3aefca8518bce07e0ca8ebbf2a19b6fc4d7a7e585a000495a0000000000000000000000000000000000000a463afaed2f56bda5dca463afaed2f56bda68d6f2c326e7865550015d140001a761ee02a3ead0932330f70151f5684990f277cbf438bb23e02b38db81a1fc437d971662b38db81a1fc437d971ef0792af1b1e2b288002ca080002ed81bea957d627616b2a981bea957d627616b236c79657757c3556b1b355d678d513c19daabfcae2866958920ee8b0d53511336b74d3fdab9f62299a9bb4e7ffcf84fdd8e3273fd00035b105c703d5a2b6aa915762a48d4f52fb8a712560adee0bc53caab931ced07f42eafefe63967a7af1cc3be0bfa3244b4f00115782b78ce8fba2d4da86a66ea77e6be4aea5f5e4590f1a8819554f2432266c91aad5e853de3bfa2d1673cb4f5d26bfbb2407ad553be96aa5a795327c6e56af98f22e44f3ef0fcfcc700003e343c2971eeeb53637bb3969fbc773a7d95f46af313c66163b9adaae4c9973589ddec889c6dfedb4d31923658daf8dc8e63933454d8a848d8c7e8bf31d256b572fae9c4f587d800ced60000000000000000000000000000007e2aa3515557244daaa070ddae2cb5dba5a9764ae44c98dfbce5d8865ef7ba491cf7ae939caaaaabc6a4c624bcfca959a10aff009687533f8978dc4295b5b17a2bccf5945dacdf52fc474800069640b6e06a6ce5aba954d8891b57a75af62152348c314694764811c993e5fa4779f67ab232eddb8c7c7eed7a74f565e7f64c80094b4152c73268d3d1c59f84f73bd0889ef2da5071a546f9768e145d514499a722aae7d991a35a39c90cbb76e314ab8002ba20000354b4703d0fe1e3f650ed38edf1ef56da58feec2c4f4221d841b7597e8e91c560001f1e80000000000000000000000000000000000019c62cf1827f259eca10a4d62cf1827f259eca10a5bc3e3afc3f3f9bc96f9000747259b03aa7ca9509c6b0aaff005217b2858238666fc3bbda697d24ed7956b4fc4000ccd6193dc784eafae7fb4a6b064f71e13abeb9fed29bb4bba53b7fa55cc0028a585e703f065475df950a3179c0fc1951d77e54336df89af4fcb0b400092b4000000000000000000000000000000000000148c75f5da5ead7b4bb948c75f5da5ead7b4d1ade5864dcf0caaa002ba2800034ec3dc0547d5a1264661ee02a3ead09321e4ef97e8717647c05671b70343f886fb2e2cc57719a7fe88deb9bd8a7bc1e4abc6c78aca0000b2820000b9e0555de2b13891cd5f5296e2a1817f4359e533de5bc8fb1e595cd5f0c3ce489b2c4e8de99b5e8ad54e653269e1753d4490bfc28dcad5e945c8d74ceb16d27735f1ef44c993b5244e9d8beb4f59db4edc5a6bfbb86f539ac5bf641800a4940000d36c15ff285a2199573911341fe527c76f9c94285836e3dcf5efa3917bca84ef799c9f14f717d2367c7e8bcc2eebe4fa98e27f2000e2d0a3e34b76854475d1b7bd93bc932fbc9b17ce9d8558d5ae1471dc2865a697c1913245e45e25f49975441252d4490cadd192372b5c854d5c9eaafa67ac23ee62f4dfd51d25e40035b105b709df519a36eaa777aabf42f55d8bf77e054822e4b9a1cf2638c95f4cbae2c938adea86c20a9e1bc4c9528da3af7e5326a8e577dbe65e7ededb611ef4b527d365cc792b92beaa8003c3a00000000000000000000001e72cac8637492b9ac635335739724403d0a4e27c449369d0d13b366c9646fdafe14e6e53ceff8a16ad1f4b40aad81753e4d8afe64e442b050d7d6e3efba5eced73f653fec001bd380001d968a15b8dce0a6c9745cecdfccd4d6a6a8888d44444c913622157c1b6dee7a47d74adca49f5333e2627c57b10b49276b27aafc47e1674f1fa31f33d6400199b055c9335329ba55f775cea6a73cd247aab7c9d89eac8bee26aeee1b34ca8b9492fd1b3cfb7d5999b9434e9ed364bdec9ef1480006f4e0f5a5816a6aa181bb647a313ceb91e44de13a4ee9be46f54cd9035645e9d89eb5f51e325bd359b3de3afaef1568a88888889a910fd0086fd1000000000000000000000000000000000000000033bc5e8897e91538d8d55f41044f630e1d7f56d204b587c7540cfe5b7c8003ab8ac382b871dd4bbb50d00cf3072aa5f5b971c6eccd0c95b7e459d2f17fa000cad8193dc784eafae7fb4a6b064f71e13abeb9fed29bb4bba53b7fa55cc0028a585e703f065475df950a3179c0fc1951d77e54336df89af4fcb0b400092b4000000000000000000000000000000000000148c75f5da5ead7b4bb948c75f5da5ead7b4d1ade5864dcf0caaa002ba2800034ec3dc0547d5a1264661ee02a3ead09321e4ef97e8717647c05731a702275cdec52c65731a702275cdec53d60f255e363c56f8504005a4100005cb02fe86b3ca67bcb7950c0bfa1acf299ef2de47d8f2cae6af8602b58ce8bba2d8ca96a66ea776bf25752faf22ca78d440ca98248654cd92355aee8539e3b7a2d1675cb4f5d26ac901ed574cfa3ab969e5f0e272b579f9cf12e44f2fcfcc713c48000f8fa8e47c32b248dcad7b151cd54e254351b4dc1b73b74552dc915c993da9f65c9b50cb09fc2976ee1aeee699d94350a89af635dc4beef41976b17aebcc7586cd4cbe8bf13d25a100094b2153c5f66dfa2f94206fd246994a89c6de5f3767416c3f1511c8a8a88a8ba95178cf78ef34b7aa1cf2e38c95f4cb1f04de24b22daeab7d85abdc92af7abf717eefc0842d52f17afaa106f49a5bd360007a780b3d9316494a8d82e0ae9214d4d976b9bd3ca9eb2b00f17c75c91c59d31e4b639e6b2d6e9ea61ab85b2d3c8d92376c735733d8c9e8ae3556f977ca499d1af1a26c5e94e32d5418da372232be1562fed22d69e74da9eb2764d5bd7b7dd5316e52ded6f695b81c94b72a3ad6e74b531c9cc8bafd1b4eb32cc4c7b4b644c4c730000f8fa000000785455c148cd2a89a389bcaf722088e5f26623de5ee0add6e32a18115b4ed7d43b99345be95f815ab8627b857e6ddf378897ec45abd2bb4d14d6c96eb1c3364dbc74e93cae175c47456ccd8afdf674ff004d8bb3a5788a45d2f757767fd33f46245cdb137c14f8a91c0df8b5e98fdfaca6e5d9be5f6e90000d0cc000012165b5beeb70643ad226f7d239389bf15d871430c9513321858af91eb935a9c6a69364b4b2d14491a64b2bfbe91fcabc9d0867d8cbf4ebedd65ab5b0ce5b733d2124c63638dac6351ac6a64889b110fb0090b60043621baa5aedee562fd3cbdec69c9cabe6f81eab59b4f10f37bc52b36955716dc92b6e7bc46ece2a6cdbab8ddc6beef310215555735d6aa0b74a452b1587e7f25e6f69b4fe4001e9e02f782e8778b73ea9c9df543bbdf253fbe652e8a964adac8a9a34efe4723539b954d529e0652d3c7044993236a35a9cc862dcc9c562b1f96fd2c7cda6f3f87b0009aac0000000000000000000000000000000000000000cf31870ebfab69024f630e1d7f56d204b587c7540cfe5b7c8003ab8a6f08b952ff1272b1c9ea346337c28ecb10d327de47a7f4a9a412f6fc9fe2c68f8e7e400191b4327b8f09d5f5cff00694d60c9ee3c2757d73fda53769774a76ff4ab9800514b0bce07e0ca8ebbf2a1462f381f832a3aefca866dbf135e9f9616800125680000000000000000000000000000000000002918ebebb4bd5af69772918ebebb4bd5af69a35bcb0c9b9e19554005745000069d87b80a8fab424c8ac36ed2b051aff07bd49521e4ef97e8717647c05731a702275cdec52c65731a702275cdec53d60f255e363c56f8504005a4100005cb02fe86b3ca67bcb7950c0bfa1adf299ef2de47d8f2cae6af860001c1a54bc696dd1923b8469a9df47274f12fbbcc8548d5eb6923aea3969e5f0246e59f27229975553494955253cc99491bb454a7a993d55f4cfe1237317a6feb8e92f1001b1840001a0619bcfca549bc4cecea614c973fb6de25f8ff0072c264d45592dbeae3a981d93d8b9f32a7229a65b2e30dd2899510aedd4e6f1b578d095b387d16f5474959d5cff52be9b75876800cad8f0aaa586b699f04ec47c6f4c950cdef3679ad152ac7e6e85cbf4727de4e4e934f396b68a0aea674150c4746ef4a2f2a739df0e69c53fd336c608cb1fdb2804adeac551689b35ce4a772f792a762f2291456ada2d1cc22de9349f4d8001e9e4000045545cd352a1214f7cb952a22455b2a226c472e9227997323c1f26b16eb0f5169af494fc58cae8cf0b7993ca67c150e86e37acd5a54d02f2e5a49ef2b00e53831cfe1d63632c7fc9677637adcd74696044e2cf497de73c98cee8ff07788fc967c554800235f1c7e09d8cb3ff2494f7fb9d4e7be56ca88bc4c5d0ecc88e739cf72b9ee573976aaae6a7e03a456b5e90e56b5add64001e9e4000000003f58c748f6b18d5739cb9222266aaa7d430c9512b62858e7c8e5c91ad4cd54be61fc34cb6224f5393ea953571a47d1cfce71cb9ab8e399eaef8705b2cf11d1fb86f0fa5b22ee8a8445aa7a6cfb89c9d25840245ef37b7aacb74a463afa6a007cb9c8c6ab9ca88d44cd557621e5ede7515115240f9e77a3236266e729995dee725d6b9f3bfbd67831b3eeb490c4b7e5b94fdcf4ee54a48d76fed1797a390812a6b60f447aadd51f6b3fae7d35e90000d6c400765b2824b9d7474f1ead25cdcefbade353e4cc44732fb11369e2165c176b546c97091be1779167c9c6beef49703ca9e08e9a06431374636351ad4e622f115e12d542ba0a9dd12e6d8d39395de6235ad6cd93dbf2bb4ad7062f7fc2420ac8aa279e28973585c8d7f26796c3a4aa60772ba92adce5555591155578f516b3e64a452d3587ac379bd22d2000e6ea000000000000000000000000000000000000cf31870ebfab69024f630e1d7f56d204b587c7540cfe5b7c8003ab8a630b2a2622a4cff8fd85349333c33e30d1f94beca9a613373be3e15f47c73f2000c6dc193dc784eafae7fb4a6b064f71e13abeb9fed29bb4bba53b7fa55cc0028a585e703f065475df950a3179c0fc1951d77e54336df89af4fcb0b400092b4000000000000000000000000000000000000148c75f5da5ead7b4bb948c75f5da5ead7b4d1ade5864dcf0caaa002ba2800034bc33e2fd2792bed292c44e19f17e93c95f6949621e4ef9f97e87178ebf1015dc64dcec6abf7656af696220318f013fac69eb0f92af39fc56f867a002d2000002e180f6d7ff00f1fe62e253b01edaff00fe3fcc5c48fb3e59ff003ff17353c35ff7ff004001c1a42a78c2d1bec295f0b7bf8d3295138dbc4be6ece82d87c39ad918ad7222b5c992a2ec543de3bcd2d16873cb8e32526b2c8412b7fb43ad35ead6a2ad3c9df46ee6e4f31145aada2d1ea840bd66969ac8003d3c84859eef2da2ab7d8fbe8ddaa48f3d4e4f891e0f96ac5a3897aada6b3cc359a4ab86b69993c0f47c6f4d4a874198d96f53d9ea349b9be07fe922cf6f3a739a25157415f4cd9e9de8f63bd28bc8bce48cd8671cff004b5836232c7f6ea001c1a5e72c4c9e27472b5af63932735c99a294bbd611920574f6e45922dab0ed737a397b7a4bc03a63cb6c73cd5c72e1ae58e2cc7d515aaa8a8a8a9a951788fc349bae1ea3ba22bdecdee7fdab36f9d38ca6dcb0d575b95cedef7e853fd48d33f4a6d429e2d8a5fdba4a565d6be3f7eb088001a1940000000000000000000000e8a3a0aaaf977ba481f2bb8f24d49d2bb10f933111ccbec44ccf10e73bed966aabacba34ecca345efa576a6b7e2bcc596d583638f465b8bf7c76dde98bdea74af19698a26431b6389ad631a99235a992218f2edc47b51bb0e94dbdf27b23ad163a6b447f469a72aa77d2bb6af472212a013ad69b4f32a95ac5638a801e351530d240e9aa246c71b53357394f8fb33c3d1ce46355ce5446a266aabb10a2e23c49ddda54944e54a7fb6f4d4b27374769e17ec4b2dcd560a7d28a9538b8dfd3cdcc4094b5f5bd3f75faa5eced7abeca740006d4f000011155724d6aa68986ace96ba2d3953fcccc88affe14e2690984ec7bf4a970a86fd1b17e85aa9e12fdef376978276d66e7ecaffaa9a7838fff004b7f8f1a9a88e929df3cced18e34cdca66174b8c974ae92a24d48ba98dfbade2426716de7baaa3b869dd9c312f7ea9f69dc9d09da568edab87d31eb9eb2e3b79fd76f457a42ed81bea957d627616b2a981bea957d627616b30ec7965bf57c3500071680000000000000000000000000000000000006798c3875fd5b48127b1870ebfab69025ac3e3aa067f2dbe4001d5c52587b87a8bac34f32eb1aaa5ee8953f6cd4f59a893773be15b43b27e400189bc327b8f09d5f5cff694d60c9ee3c2757d73fda53769774a76ff004ab9800514b0bce07e0ca8ebbf2a1462f381f832a3aefca866dbf135e9f9616800125680000000000000000000000000000000000002918ebebb4bd5af69772918ebebb4bd5af69a35bcb0c9b9e195540057450000697867c5fa4f257da525889c33e2fd2792bed292c43c9df3f2fd0e2f1d7e2020318f013fac693e40631e027f58d3d61f255e73f8edf0cf4005a4000005c301edafff00e3fcc5c4a7603db5ff00fc7f98b891f67cb3fe7fe2e6a786bfeffe80038348000386eb6d8ae942fa79752aeb6bb8daee25333aca49a8aaa4a79dba3231725e7e7435a20f10d8db76a6d38911b531a778bf793eea9ab5f37a27d33d18f6b5fea47aabd619d03ea48df148e8e46ab5ed5c95aa992a29f255470001f03b6db74a9b55424b03b52f84c5f05c9ce7103e4c45a3897a899acf30d36d37ba5bbc59c4ed09913be89cbad3e284a190c52c904ad9227b98f6ae68e6ae4a85bad18c5ae46c3734c97624cd4d4bd29f026e6d59afbd3de15306e45bdb27b4ae00f38a564d1b6489cd7b1c99a39ab9a29e8636f000044dc30fdbee0aae96046c8bfea47deafc17ce576b304d446aaea3a86cadfbafef5df0ec2f00ed4cf929d25c326be3c9ef30caeaad170a3cfba29256a26d723736fa5351c46c2724f6ea4aacd67a586455e3731157d269aeecff00ca192da1fc6cca41a3cb85ad32e6bdcba2abc6c7b93df91cafc176c726a75433a1e9ef43ac6e63fcf2e33a5963a70a102f4b81e833ef6a2a5139d5abee3e9304db917359aa57995edffc4fbfabc4f9fa3caa183448f07da989dfc4f93ca917dd91d70d8edb06b8e8a1cd38dcdd25f59e67729f887a8d1bfe6619ac14b5154ed1a7824957918d55ec26293085cea72595aca76f2c8ed7e843426b5ac6a35a88889b1110fa385b72d3db1c34534691dd3cab745836869f275439f50f4e25ef5be84f89608618e08d23858d6313635a99221e80cd6bdafdd2d74c74a47158e0001e1d007255d7d2dbe2df2aa66c6de2cd75af426d52a175c6135422c56f458635d4b23bc35e8e43ae3c37c9db0e3973d3147dd2b25defd496862a3dc924d977b13575f9f910a1dceef55759b4ea1f9313c08dbe0b7fe729c2e739ee573dcae72ae6aaab9aa9f852c5af5c7eff00949cdb36cbedd20001a19800002670f58dd76aad3951529635efddf797eea1e365b3cd77aa463736c2dd724996c4e44e7347a5a58a8e9d9040c4646c4c910c9b19fd1f6d7ab6eaebfd49f55ba3d18c6c6c6b18d46b1a992226c4420f12de7e4ba2dea15ff333264dfe14e377c3fb12d5b5715052495332e4c8d335e7e44330b857cb71ad92a665ef9eba9389a9c48865d6c5f52dccf486cdacdf4ebe9af5973000aa8cbb606faa55f589d85acaa606faa55f589d85ac8db1e595dd5f0d4001c5a00000000000000000000000000000000000019ee326e57ccfef44d5ed200b0e35e1c6f52ded52bc5ac1e3aa067f2dbe4001d5c5db66768dea857fefb13d686a86536a7236ef44e5d893b17fa90d589bb9dd0aba1db600062500c9ee3c2757d73fda5358327b8f09d5f5cff694dda5dd29dbfd2ae6001452c2f381f832a3aefca8518bce07e0ca8ebbf2a19b6fc4d7a7e585a000495a0000000000000000000000000000000000000a463afaed2f56bda5dca463afaed2f56bda68d6f2c326e7865550015d140001a5e19f17e93c95f694962270cf8bf49e4afb4a4b10f277cfcbf438bc75f88080c63c04feb1a4f9018c3809fd634f587c9579cfe3b7c33d0016900000170c07b6bfff008ff317129b811c9a55cde3548d7da2e448d9f2cff9ff008b9a9e18ff00efc80033b4800000002b78930f25c2375552b72aa6a6b44fb69f1286e6ab1cad722a39172545da86c057310e1a65c5ab51488d655a6d4d89274f3f39b75f63d3f65fa27eceb7abefa755041f5246f8a474723558f6ae4ad7264a8a7c9492c0007c000076505d6aed9269534aad6aed62eb6bba50b75bb19535464cad62d3bfef26b62fbd0a2838e4c14c9d61df16c64c7d27d9aec33473c69242f6bd8bb1cd5cd14f4325a5ada9a2934e9677c4ee3d15cb3e9e527e8b1b55c5936ae164e9f79bdebbe062bea5e3b7dd429bb49ee8e17b040d362db654a223a47c0e5e291bef4cd09782ae9ea9b9c13c7227f03914cb6a5abdd0d75c94bf6cbdc00797b00000000000001f1248c89ba5239ac6a71b972422ea3125aa953beab63d7922effb351eab5b5ba43cdaf5af74a5c14fabc70d4454a4a5555e274ab97a93e240d6622b956a2b64a856317ec45dea7c4d15d5c96ebeccb7dcc75e9eebf575ea82dc8a9513b51e9f61bdf3bd0855ee18d279736504490b7f68fd6ef46c4f595606ba6a52bef3eec5937325fa7b3d279e5a995659e474922ed7397353cc0354471d192679ea0003e000004959acb3dde7d167790357e9255d89cc9caa7bd8f0f4d7691249338a9117be7f1bb99bf1341a5a5868a9db0d3b1238d89a910c99f63d1f6d7ab6ebeace4fbadd1f1454505052b60a766846df4aaf2af39d40af62bbabedf40d861cd25a8cda8e4fb2d4cb3f3eb42756b392dc7e6552f6ae3a73f8857f14de7e50aaee585d9c10aed4fb6ee5e82be0166948a57d308392f392d3690007b785db037d52afac4ec2d6553037d52afac4ec2d646d8f2caeeaf86a000e2d0000000000000000000000000000000000000cff001af0e37a96f6a95e2c38d7871bd4b7b54af16b078ea83b1e5b7c8003ab83a6dca8972a5555c9126676a1ac192527d720eb1bda6b64eddeb554d0e9600061510c9ee3c2757d73fda5358327b8f09d5f5cff00694dda5dd29dbfd2ae6001452c2f381f832a3aefca8518bce07e0ca8ebbf2a19b6fc4d7a7e585a000495a0000000000000000000000000000000000000a463afaed2f56bda5dca463afaed2f56bda68d6f2c326e7865550015d140001a5e19f17e93c95f694962270cf8bf49e4afb4a4b10f277cfcbf438bc75f88084c5de2f4fe533da426c84c5de2f4fe533da43ee1f257e5f33f8edf0ce4005b7e7c00016dc09fa6adf259daa5d0a5e04fd356f92ced52e848d9f2cadea78600019da8000000000001077cc3f0dd99be3728ea5a9dec996a5e67141aca29e82a1d054c6ac91bc4bc69ca9ca86b4715c6d94d74837aaa6679782e4d4e6af329ab0ec4d3da7a31e7d58c9f757da5958256f187eaad2f572a6fb4eabaa56a6ce9e4228a75b45a39848b52d49e2c000f4f2000000001fad72b5515aaa8a9b150fc00774379b8c19247593a226c457aaa7a14ee8f175d63f0a6649e5469eec8830789c549eb10e9196f1d25646637b827870533bfdae4f79ea98e6ab2d7490aaf3394ab03c4ebe2fd9d23672c7fc96a5c755396aa48bf994f27637af5f069e993a51cbef2b40f9fa7c5fb1fa9cbfc9392630babfc19238fc98d3df99c935fae73e7a75d3267f71da3d9911c0f718a91d21e272e49eb697d492c92bb4a47b9eee572e6a7c807472000000000000003aa86df51719d22a6895eee35e26a72aaf11f266223997d88999e21ca899ae485aac7849d368d45c5aac8f6b61d8aee9e44e6262cd8669ed9a334d94d53f7953bd67427bc9f27e6dae7eda7fda9e0d3e3eec9ff004f8631b13118c6a35ad4c9111324443ec030a885371daa6950a71a248bec9722958e953ba28d38d18e5f5a1a35bcb0cbb7e19ffefcaa6002ba200002ed81bea957d627616b2a981bea957d627616b236c79657757c35000716800000000000000000000000000000000000067f8d7871bd4b7b54af161c6bc38dea5bdaa578b583c7541d8f2dbe4001d5c1f70ae53c6a9f793b4d78c7dae56b91c9b517336027eeff00c54f43fe5fe0003029064f71e13abeb9fed29ac193dc784eafae7fb4a6ed2ee94edfe9573000a296179c0fc1951d77e5428c5e703f065475df950cdb7e26bd3f2c2d00024ad00000000000000000000000000000000000005231d7d7697ab5ed2ee5231d7d7697ab5ed346b79619373c32aa800ae8a0000d2b0c3b4b0f522f33bda525c85c2de2e527fbfdb713443cbdf6f97e830f8ebf101098bbc5e9fca67b484d9098bbc5e9fca67b487dc3e4afc99fc76f8672002dbf3e0000b6e04fd356f92ced52e852f027e9ab7c9676a974246cf9656f53c30000ced40000000000000000f8735af6ab5c88e6aa64a8a99a2955bbe0f64ba535b95237ed585cbdeaf42f17fcd85b41ee992d8e79acb9e4c54c91c5a191d453cd4d33a39e37472376b5c991e46ab5d6ea5b8c3bdd544d9138978dbd0bc4542e5836a20d29285dbf47f71753d3dca51c5b55b7b5bda52f2ea5e9ef5f785641f5246f86458e56398f6ea56b932543e4d6c60003e0000000000000000000000000000001fac63a47a318d573975223533550fafc3f58c748f4631aae72ea4444cd54b0db70855d564fac5ee68b915337af9b8bce5badf67a2b637fcb4393f2c96476b72f9fe065c9b34a7b47bcb5e2d4bdfde7da157b560f9a7d196e0ab0c7b77a6f84bd3c85c69a8e0a28522a689b1c69c4d4ede53a0f29a68e9e274933dac8dbad5ce5c9109f932df24fba9e3c34c51edff6f5236e97aa3b53339df9bd53bd8dbadcbf02bd77c64aba50db1356c59dc9eca7c4a9c923e691d24af73dee5cd5ce5cd54d18b566def7f666cdb915f6c7ef2d4edd59ddf410d4e8e86fa99e8e79e5acec2230cf8bd47e4afb4a4b992f11169886cc73334899fd82918e553bba9538d2355f59772898dd53e53a74e3de7f329df57cb0cfb9e2956400564500005db037d52afac4ec2d655302fd4eafac4ec2d646d8f2caeeaf86a000e2d0000000000000000000000000000000000000cff1af0e37a96f6a95e2c38d3871bd4b7b54af16b078ea83b1e5b7c8003ab806bec769b11d9659a666406b94ee4753c4a9b1588bea306eff00c7fd52d0eb6ff1ea0027a9864f71e13abeb9fed29ac193dc784eafae7f6a9bb4bba53b7fa55cc0028a585e703f065475df950a3178c0fc1951d77b90cdb7e26bd3f2c2d20024ad00000000000000000000000000000000000005231d7d7697ab5ed2ee5231d7d7697ab5ed346b79619373c32aa800ae8a0000d1f0b78b949feff6dc4d10b85bc5ca4ff7fb6e2688997c96f97e830f8ebf101098bbc5e9fca67b484d9098ad1170f54afdd56aff00520c5e4afc99bc76f89672002dbf3e0000b6e04fd356f92ced52e852b02bb2aaac6f2b1abeb5f8975246cf9656f53c30000ced4000000000000000000000000e2adb651dc59a355035fc8ed8e4e85da562e1825ed557dbe74727ece5d4be652e80eb4cb7c7db2e393063c9dd0c9eb2dd5740ed1aaa77c5cea9a97a17629cc6bce63646ab5ed473576a2a668a43d5e16b655a2aa40b03d7ed42ba3ead9ea36537227ba186fa33ff00096720b5556079db9ad2d531e9f764456afa533226a30edd29bc2a37bd3963effb0d35cf8edd2592d83257ad5160fb922921768cb1b98ee47264a7c1d5c400000000011335c90eb82d75d5396f3473bd178d18b97a4f93311d5f62267a3901394f842eb365a6c8e14e591ff0cc96a7c0d1a2675356e7ff000c6dd1f5ae7d871b6c63afe5debad96dd214d3b68ed35d5ea9dcd4d23dabf6d5326fa57517fa4c3f6da2c962a562b93ed49df2faf679894d867bee7f186aa687f39ffa53683042ea757d465ff6e2f8afc0b2d0dae8edccd1a5818c5d8ae4d6e5e95da770325f35efdd2db8f063c7db00043e26a97d358aa1f13d5923b45ad7357254cd533f56678ad7d53110e97b7a6b36fd9f177c49496bd28d177fa84ff4dabe0f4af1146b8ddaaae92695449dea7831b7535be63895735cd415b160ae3f944cbb17cbed3ed0000eeced1f0af8b949feff006dc4d109847c5e83ca7fb4a4d9132f92df2fd061f1d7e202838d9516f3165c50373fe6717e33fc66a8b7b4e685bdaa76d4f2386ef8bfd57800554600005db02fd4eafac4ec2d655302fd4eafac4ec2d646d8f2caeeaf86a000e2d0000000000000000000000000000000000000cff1a357e5a62af1c2d54f4a95e2c98df8661fc3b7da715b2ce0f1d50763cb6f900076700d668f5d141d5b7b0c98d5addc1949d4b3d9430eef4aa8e875b3ac004e540c9ee3c2557d73fb54d60c9ee3c2557d73fb54dda5dd29dbfd2ae6001452c2f181f836a3aef721472f181f836a3aef7219b6fc4d7a7e55a400495a0000000000000000000000000000000000000a463afaed2f56bda5dca463afaed2f56bda68d6f2c326e7865550015d140001a3e16f17293fdfedb89a2170b78b949feff6dc4d1132f92df2fd061f1d7e2021714f8b957fecf6da4d10b8a7c5cabff67b6d18bc95f93378edf12ce0005b7e7c00016ac0bf5daaead3b4bb948c0bf5daaead3b4bb92367cb2b5a7e18000676b0000000000000000000000000000000000007c3d8d7b745ed472722a6671cb68a0975c9474eabcbbda22fa4ef07d8998e92f33589eb088761ab4bf3ce8dbaf91ce4ec53e3e6ad9bf73fff00b5ff0012681ebea5ff0094bcfd2c7fc63fe910dc336966595137572b9cbdaa7b32cb6d8fc1a0a7f3c68bda4881392f3f99231523a447fd3ca3a7861fd144c6792d443d403c3dc4700003e800000000705d2d915da9529e69246351c8ece35445d5d28bca7783ec4cc4f30f9358b4712adb7055b536c952ee97a7c0fb6e0db626d499dd2ffec5841d3eb64fe4e5fa7c5fc6104dc216a4ff004a4774c8a7d370a5a1135d22bba6477c49b07cfab93f797dfa38ff008c3968e8a0a1a7486999a11b55551ba4abb7a4ea00e733cfbcba444447101195962b7dc2759eaa9f7c9151134b4dc9abcca4983ec5a6b3cc3e5ab168e26104b846d4a8b942e4e8914f3760db62a6a499bd0ffec5841d3eb64fe52e7f4317f18569d82adcabaa5a96f323dbf03cd703d16bd1a9a84e4cf457dc5a41f7ebe5fe4f9fa6c5fc51567b3c7678a58e395d2248e472ab932c89500e56b4da79975ad62b1c4740007c7a00000000000000000000000000000000000046d6d9282e1324d5706f9223745174dc9ab355e25e753997095a15734a77273248ef89360f7192f11c44b9ce2a4cf3310805c1f6a55cd23953992453cd7065b1573459d3991e9f02c60f5f5b27f279fa18bf8c2b4b826dcab9a4d529cc8f6ffe24f53c0d829a285aaaad8d88c455daa88996b3dc1e6d92d7ee9e5ea98a94ed8e0001e1d02b3360ca59ea2599f533672395d9351132cd732cc0f74bda9db2e77c75bf7472acb704dbd32ce6a955f29bafd47a37075b136efeee97ff0062c40f5f5f27f278fd3e2fe2826e11b4b72ce07bb2e591dafd648d15ba96db13994716f6c72e92a692ae6be753b01e6d92f68e265eeb8e959e6b1c0003c3a000000000000000000000000000000000000042de70fc5789629249df1ac6d56a23511732681eab69acf3579bd22f1c5ba2a9f3169bf7c97f9507cc5a6fdf25fe542d60e9fa8cbfbb8fe970ff001553e62d37ef92ff002a0f98d4dfbdcbfca85ac0fd465fdcfd2e1fe2e3b65036d941152b1eaf6c79e4e5dab9aaafbcec00e533333ccbbc44447101c771a28ee344fa6955ed8e4cb3562a22ea545e3e83b0089e279826226389567e64dbbf6d55fcedff00c47cc9b77edaabf9dbff008966075faf97f938fe9f17f1567e64dbbf6d55fcedff00c47cc9b77edaabf9dbff00896603ebe5fe47e9f17f144dab0fd35a2491f0492bdd2374577c545ec442580395ad369e65d6b58a471580007c7a00000000000000000038aed5df25da6aeb7434fb9e2749a3cb9201da082c27887e7358e3b8ef2b0e9b9cdd055cf62e44e800556d78c7e51c595564ee5566f08abbe67b4f4c698b7e69514351dccb3efaed1c9172c80b302a38331cc38b56a22ee75a79e0c9558abb514b6397458e77226607d02ad86718fce1bbdc287b9562ee35cb49573d2d791fb8c317fcd54a4ff2cb3f743f4352e590168057f146237e1db1a5c994ab3a669a4d45cb245e3242c9748ef568a6af8934593b749139009000a9da31a25e315555a21a55dea9d174a7cf5669c405b0147c5bba03b0d5dd9411dbdf52f7b51c9a2a447f8ab70ffa72abd0a069e0a1583742abbcde20a196c9514ec973ce4722e4dc9097c678b3e6950c351dccb3efafd1c9172c80b3032f6eeaf5ee6a2b70ed4aa2ec54453de9775c852a638ae76ba8a363d72df1c9a900d241e34f530d55332a207a3e17b749ae4d8a850ef7ba8474d709282cd43257ccc5c9cf6266d450342065a9ba3e2287bea8c3f2ab7f85a5d70b6219311dbdd532d0cb46e6bb47424e30274156a0c61ddb8c6a2c3dcaadde58aedf73da74e2fc4df35ad1dddbc2cfdfa3745172da0580197b7757ae7b51cdc3d52ad54cd1511759d147badd3f754715d2d95142c7ae5be3d35201a403c69ea22aba764f03d1f1489a4d7271a1fb34a90c124aed8c6ab97cc07a832b7eec4ec9f2c76795d4ed768efb9eaf49a4db6b9973b7415917813311c8075823310ddfe42b254dc37a597786e96822e599408b75aac9e34922c3f50f63b639b9aa281a903338b75c48a46a5c6cd534d12ae4b22a6a4341b6dce96ed431d5d14a92c322668e403ac0232ff76f912cf3d7ef6b2ef299e8a2ed024c19f616dd422c43788e825a25a774a8aac7abb52e4682001569718ef78de1c3ddcaabbe334b7dcf66df8169000a762fc769862ba9e8e2a27d54f3b7491ad5d790c1f8ed31456d4524946ea59e14d256b975e405c402a98b31dd0e175640ac754d63fc1859b7ce05ac195b774cbf3be91b6199625d9deeb2d584b17cb895f3c735b66a37c2899ac9b140b502aff3bfff007cfcdcee65fd1e9efd9f367b0b15454454b0493cee46451b55ce72f12201ec0cd2b775674f54f82c56c9ab1ad5c92544d4a79c5baa565148d6de6cb3431aae4b222648d034f0725b6e54d76a18ab28a549609133472157c678f3e69d553c0944ea85999a59a2e590173057b08e2a8715db1d551c6b13e3768be355d8a4c5754f71d14d51a3a5bd315d972e407482b983f14fceaa19aa3b9d60dea45664ab9e65895511335d4807e8330acdd71f0d4d5320b4492c54ef563a445d5ab94be586ef1df6d1057c4dd16ca99e8e7b140930715d2bbe4db6d455e869ef2c5768f2e446e11c47f3a2ca970de160ce473341573d997c409f000000cdee7ba94d457aaab753da24a8753bb45558b9e7ce06900cc3fc57ad66b930ed52378f52969c2d8dedd8a1aac815d0d53533740fda8059811f7ab8fc9168a9aed0df37862bf4794cf21dd72ae78f7c86c13c8c5d8e6e6a806a60cc3fc56aff00fa72a7d0a5f30fdd64bcda62ac9699f4cf7ed8dfb5009300a4633dd07e69dc62a44a27542c8cd3cd1d90177043618c411624b3455f137434b53999e7a2bc84c80051f196e891e15b8c546da45a97b99a6e54765a3cc5870d5e7e705869ae5bd2c5bfa2ae82ae7964aa9ee025c15583186fd8e27c3bdcca9bd334f7dcf6ea4f892389311d1619b73aaeb5dccc626d7af201320cb7fc4cbe562ef96fb04bbcf12b9369d76cdd22e3357c1495961a862caf4669a26a6e7c6068e084c577ff009b5619ae5bcefdbdb9add0cf2cf35c8ecb35c3e56b452d7686f7bfb11fa3c807782a98ab1dd06187b69d58ea9ac7ec823da55ffc4bbeafd325826de36f83af20353054f0ae3ea0c4b23a996375256b76c126d5e82c174adf936d95157a1a7bcb15da3ca0760337b06eb115def34f413d0ba9d27768364576accd20002ab78c65f25e29a1b3772abfba972df33f049cbbd7fc9769abaed0d3ee789d268a71e48077032c8775caba88d2486c13c8c5d5a4ccd50f4ff156e1ff004e557a140d3c10f61bd3aef656dc2a69dd49b55cc936b5138ca7dcf7535757494962b74b5aac5c9656a77aa06900cb53749bfd3ae75587e656ff000b4bee1dbcbefb6a8eb5f4b252abff00d3936812a000000000000000000000000000000000000000000004362cf152ebf867f61324362cf152ebf867f60101b92f88f4fd63fda52f051f725f11e9fac7fb4a5e00cb70c7eb5ee7e4af629d5bb0706dbbf10872e18fd6bdcfc95ec53ab760e0db77e210087b845f3371559ef1033468aba36b256b762bb8f3f49adb9ed929dcf6aa2b5cc55454e82ab892c297fc0cd81a89bfc70a49139789510f1dceafab77c2a904cb95451a2c2f6aed5444da041ee6be37620f297b50fadd7f65a7af43e7735f1bb10794bda87d6ebfb2d3d7a0174c4341f29e13aba444cdd253e4de9c8ae6e495ee9f0d4b44f5efa86558f2e95552f10a6952b1bcac44f519960acec7ba35e2cee5d18e44595bceba97de068f73ac4b7db2a6addb208dcfd7cc8503724a474b15ceeb2375d54cba0abc84cee9f725b760ea946af7d50a90e5cca77e05b62dab0950d3b93be56e9af9f58150c51fad6b5f929d886a463fba0bab99ba1512dad88fac4626f6d76c5d4848ad66e999fd429bd29f1034f338dd87826dff008842c784a5c432d34ab88a18e2973ef119c69e92b7bb1bb42cd42efbb3a2817bb4affe954bd5b7b085c7b6ba6b9615adee88daaf8a3d28dea9adabcc56a87759b6d3d1410adbead558c46aaa37fb11d7dc7f518be99f64b05ba6496a3bd91cf54cd1bcdc804ce00aca89773b99ad5557c0d7323e83c371e8e9be4caf91119dd4b3aa39572d2cbe05b70958530fe1da7a093274a8dfa554d8aaa546ebb9bd7d0dc65b8616b8ba91d266ae89576f3201a603287626c7186588fbc5b595148d5efa46a66b97994bfe1bc454989ad6cada4cdb9ea7c6bb58bc8a0516c3fae3b8752bee24b761f1413ae6f691b61fd71dc3a95f7125bb0f8a09d737b40b7d83c5fb77e1a3f650e3c5360a4bfd96a21a989ae7b58ae8df96b6aa27129d960f17eddf868fd943b27cbb9e4cf668af6019f6e47729a4b4d55b6a1cae7d24ab966bb1390b063eb97c97842ba56bb291cd46b39d554a96e59e32e21d1f074932f4a9edbab54ad5d45a6cd0ae724d3239ede5681fb6ac36afdc924a76b7e96aa2dff2cb5a292db95dcbbbf08470af8548e58553d7ef2d94f4b1d3d032963c918d8f4113cc66fb9e2bacd8caf76372e51b5eaf6a72a816cdd0bc4ab9757ef43cf7375ffd8d6df217b4f4dd0bc4ab9757ef43cf736f11adbe42f6813974b5d25e2864a4ad89b246f6aa6b4d9ce8673b984f25aaff0074b048e55631eaf8d1576221aa194e1ccbfc64b8e8783bcbb3f4201ab15ac7fe275c3c82ca56b1ff0089d70f200cc25b4ba0c0969c4344dd19e8e5ce556ed7373363b25d23bcd9e96ba354ca68d1ca89c4b96b42b18128a3b8ee771d24cd473256b9bac8cdcdab64b45cae3862b1d93a9a45742aedaf4cf880f0a9fd7751f52bd8e35232da9fd7751f52bd8e347b955328adb535122e4d8e35555f3019c5269620dd7e795574a3b6277abc5a94f99f4b0f6ec2c7f831dd13cdaf57b8ebdc969166a6b8dde7fd354cca88e5e343e7759a55a7f92ef50afd2d3ca8ccd38933cc0d29cb93557910c970552b31263bbaddeb98d9529deac623933445cf245f51a6d2d436aecf1cf1bb492485173f319fee43969df9576f74a76b80d38fce3cf8cfd006609faf15fc3fe543bb75bb84b058a9a8215d17574a8ccd39953e270a7ebc57f0ff009506eb7aebf0e22f83dd3ef68171c2364a6b1d869608226b247311d239135b9dc6485d6db4d76b7cd495513658ded54c9c99e4a754288904689b3453b0f4032edcae69adf75bbd8a472ab299fa699fa3dc7e6e8ac6c98dec2c7a22b5c992a2f9c611cd3757c428dd9a4b9fa4fddd0fc7bc3fff0038d40f3b527ccbdd21f40bded05cd3e8533d48abc668d7be05acea9dd854774eb22d6d823b952b72aaa054911c9b74536a1296ebd32ff815d5ad4447ba9d51ed45d8a88041ee3fc075bf88716dc515e96dc395f52aed17362768f4e5a8a96e3fc075bf8871f5badd76563a6b6c4bf4d5933724e544ff00ec0e5c0b64ee9dceee2f91b9cd716c8ab9a6d5c97253a7723ae72d96a6d727e928a5722f9d4b958a8d96fb2d1d33511ba113734e7cb599ee1cd2b06ea970b62ae51d622c89c99e59a017dc51e2d57f52eec2b7b90f890cfc43fdc59314f8b55fd4bbb0adee43e2433f10ff007017b0001f9c4a66182bf5a588bc8f7a1a7f1299860afd69622f23de8069ca88e45454cd176a2992635b7c58571a5aef16e6ef31cf226fcd66a4dbef35d332dd932f93e832f0f7d4c80b662d9126c195f226c7d3abbd2846ee55e2251f96ff00694edc45e205467fb9a7b28673842a71b4787606d8e920928749da0e7aa66ab9ebe3e5036c06714155ba1babe9d2b28a9db4cb2377d5454cd1b9ebe3e4347006538f216d4ee8b6881e88ad923d1545e7ccd58cb31afeb36c9e4a7681d1b9d48b65c4578c3922e8b227efb167c79e5b0d25ce4631ce5d889999a6336ae1ec7967bf3534609b2865cb8d75fc4b3e3abca5a709555431fa32cacd18b9d540cd2a234c44cc5b7f91ba50471ac70e7f65798d1b735f112d9e4bbda52b71da3e48dc6eb1ae6ab669e0596545e552c9b9af8896cf25ded28159a2fd77d7751ee69f3ba7a46fc598723abcbb8dcfefd1db1534933ccfaa2fd77d7751ee6971c5785293155bd20a8558e566b8a56ed6afc009b81b1b20636046a448d44668ecc8f53286d8f1ee1ad165baad2e3033c1639752279d492b06e8d52b766da71250f71d53d745af44c9b9f20123bab788b57d633b493c292ef382e864fb94da5e84233756f116afac6769dd61fd5e4397ee4ef6540a5e00a08f11e2cbadeab9892a4722ef28ed68d5ccd68cd771a44f916ad7ed2cab99a501936e8f6e6d83115af105031b0bdf2a31fa299693b97d05fb1049bee13ab933cf4e9f3f5154dd8d13e43b72f1a55265e82c35caab806455dbdcbee032ca5b1ad66e70b74a46e8d650cdbe69a6dd1435dc277965fb0ed256b7247399a2f6f22a6a2b3b95411d4e0d96195a8e8def56b9178d08fc0f33f0c62fb8e1ba9765148edf6172ec5e6403e717feb4ac7d285eb1778a775fc33fb0a2e2ff00d6958fa50bd62ef14eebf867f60105b93788b4dd6c9da5d8c4b06d4e358f0ec4db152c1250e9bb45cf54cf3cf5f1963a4abdd156b204a9a2a74815e9be2a2a6a6f1f1816fc5af959862bd60cf4b7a5d9c9915cdc8e3a46e14d38119bfba576fabf6b8b697a9a164f0be2913498f6ab5c9ca8a66559b9cde2cb5b2d5614b9ba18deb9ac0abeae803510650ec638c70c682e20b6365a445c964626bf4e668d64bcd35fad915751bb38e44cf25dad5e4502440000000000000000000000000000000000000000000089c4f1ba6c31738d899b9d4ef444f312c7cb9a8e6ab5c88a8a992a28141dc8ab62930b2d1a3937ea791da6ce34cd554bf39e8c6ab9ca8d6a6d555d866d73dcdae1497692e1862e4b46e9155ce62aaa6b5e4c8e69707639b944ea7aebf26f0ed4e4d25d6807e60a7a57ee9577ab83be8599b55c9b38d0eddd83836ddf8842d184f0951e15a05869d5649a4d72caedae538b1ce16aac5349491524d1c4b0cba6ab222eb402c16b445b4d2a2a668b137b0cdd3ff65ee952b1cba36fbab15557635abaf57a8d368a05a6a38617aa2ba36235550aee39c26b8aed91c5048d8aa617e946f76c02b1b9a64b8bb10aa2e68ababd287d6ebfb2d3d7a1298070557e15aaab9ab6a629f7f6e49a19e79e7ce75639c25578a128bb9278a2ee7911eedf1175816c83eaf17909d86638c99f22ee8f67b9b7bd8ea1746577ab234f89aac898c5dad6a2157c778526c536e822a396386a61951e8f7e7b35815add2e5f95310586cf1ae932a24473d3ce99769a653c49053c7126c6351be833dc3f802ef4b8920ba5eee31d6242cc9b966ae45e2da68e065b8a3f5ad6bf253b10d48cfb18608bb5f3104373b657454ce89a88d5767a48a717cd0c78bffea64fe6701a719c6ec299da2de8bb16a10eab0e1bc5d457882a2e77e4a9a4667a71692ae96a2471d616a9c53454b0d24d1c4e86547aac88bad0093b5daa81d6ba572d1c2aab1a6bd14e433ec554df32f1d50dee923d0a2aa768cad6ec5771fb8d46860752d14303d515d1b11aaa84562fc3cdc4d629a8b36b66db13ddb1ae0266195b3c2c9635456bda8e4543d135ec20b0cdaee169c3d1dbebe78e59a26ab192333d9c599507e11c734ee7f72e24cd8ae5546ab9500d06e6e8196ca975568ef291ae9696ccb233fdc79bfe5af2f62650baa7e8f932d7b0e79b04632bc3129eed7d45a555efdba4bad0d02c162a5c3b6b8a868d174189adcbb5cbcaa0506c3fae3b8752bee24b761f1413ae6f69dd6ec2357458f2aafaf9e2753cd1ab523445d24d875e3ac37518a2c7dc54b2c713f4d1d9c9b35012d60f17eddf868fd943c312de29ecd63aba99e446e51ab5a99eb5554d451a2c178e20859145891ad8e36a35ad473b24443ea2dccae974ac649896f2eaa898b9a318abafd20746e436f91b6aabb9ce8a8faa9572cd36a271facafdf68ebb196e8f3c16da86d3c942dd1df573c9b91aec1491d15bdb4b44c6c4c8d9a31a26c4d5a8ac60ec215560b8dcabebe78e6a8ac72eb8d17526798103f30718ff00d52df4bbe04036d972c19ba0db26bad6a552d52e6f99b9eb4d6992e66dc54b1ce139b1452d27724b1c3514f2a3d1ef45d9c807b6e80a8ec117154d8b1a2a7a50f8dcdbc46b6f90bda765facf5377c2b2db1b246da89224669af839a645228b01e34b7d2474b4988590c11f82c6b9d9201a5d7d7416da29aaaa6446451355ce555334dcc217dd3115defaf45d073d58c554da8aa7dbf737c4377958cbfdf967a645d6d62aaafacd0acf67a4b1dba3a1a18d191469e755e550240ad63ff13ae1e4165223135aa5bd586a68207b639266e48e76c4021f732f12e93a5480dd0a965b0622b6e27a34cb27a473e49a913954b8610b2cf87f0fc16fa99192491e79b99b0eac41678afd65a8b7cda9256ea5e45e2033b4aa8ab7764b754c0e47452d3e935539327164dd46e7dc38427851727d5b9226fa73f710384f735ba58b11525c6aeb609638115345b9e7964bb0b0e34c275b8a2aade91d4451d2d348923dae45cd57980a8d9373ec52db553ba92feda48a46a39214d2ef7d47c5ff0000627f91aa25acbf36b2285aafde7beefb2e4d46bec6a3236b13635110fc9636cd0be37222b5ed5454502a1b9a5c52e3836089cb9cb4fa51bf3e952b5b9e54a59b18de2d354a91be57ac8dd25cb3d7fdcb4e0ac295985a5b8325a88a5a6a99564623517369cd8c373e65faadb71b74fdc971665dff0013b9d40bc0e332e6e1add09aa9125ff26a6a4769a967c2362be5a65a896f774eee74b968a66aba3e902b49faf15fc3fe543a375fa4916d56fb831aaada29f49de754f812ff0034aaff00c44f9c3bfc5dcdbd686f7af4b3cb22cb71b7d3dd2865a3ab623e195b92a2f681cb87ae515dac949550bdaed28d34b25d8b96c3baaaa23a4a692795e8c631aaaaae5c8ccffc3cc45639a5f9b57958a99cb9a46e55453f25c0f8bef88d86f57bce973ef988abac0fddccd5f74c517cbd2357799dda2d773e799f5ba1f8f787ff00e71a97db05868f0edb23a1a16e4c6eb73976bd795481c51846aef988ed971a79e28e2a4f09af45cd75f1016c921654532c52b51cc7b72545e3327b04cec2f73bf61ba97e50c8c749039da91572d886ba8993513910a3e3cc0736289e9aaa8678e9ea624d1573b3d69e6038f71fe04adfc43885c73055e29dd0696d1412a452d247a48f5d8dcf25ccb9e03c2d55856d7352d5cf1caf91fa48b1e791cf87b07d5dbb15d7deae15114af9f36c68c45cdade7f50107f3031826a4c52dcba5df02b979b25e308e25b55cae7716d6be5951ab2a67a933d8b99b9959c6f865f8a2c9dcb03d91d4b5ed73247ec4c97581d988e46cd85ab6462e6d7c0aa8bcd915edc87c4867e21fee27d6d15526126dae5958b5294e90ac89b155132cca15bf73dc5f6aa5ee6a1bf470439abb418ae44cc0d64198b307e3947b55d895aa88a99f7ce347a4649152c4c9dfa72b5a88e772a81edc4a66182bf5a588bc8f7a1a8197d6ee7f889988ebae968bb4548b54efb2aa8b96ad4a069eab9266ab92192e3dac6622c6b69b3523b7c48644dfb475a22e675bf056379d8b1cd89516376a54d27161c2180e8f0bb9d54f916a6ba44c9d2bb8b97203bb1647bce0baf8d3ec53ab7d0846ee55e22d1f96ff694b05fedf25d6c757430bdac9278d5ad73b6219dd0600c656ba46d2d16208e0818aaa8c639c8899ed03570663f33f1e7fd4c9fcce2f587e8ebe86d314174aaeeaaa6f852a7181286598dbf59b64f253b4d4ca6620c215976c5d6fbbc33c4c8695111cc722e6bd007b6e8968f95708d43a36e94f4d94b165ca8a9ee28153795c689866c8c7ab9c993ea5791c9ca6cf2c4d9a07c4ef05ed56af9d0a8e1adcf28b0dde65b84533e57391518d77d9cd40ebc7ac48f025cd8d4c91b0648887c6e6be225b3c977b4a4a627b5cb7ac3d5b6f81ed649511ab5ae76c43cf0959e6b0e1ba4b75448c924851515ccd8b9aaafbc0a4d17ebbebba8f734d40a753e11ab8b742a9c42b3c4b4d2c7a291a67a5b13e07562eb1deaeeb4ceb2dcfb85d167a5ad7bef4016832cdd4d627dfec11c3a2b53beebd1db96699667a3b0d6e84c5d16e2047272e929db87373b9e9af1f2be20adeeeac6eb6a6d445e55cc0ebdd411c9b9fd423fc247479fa495c311acd8228a24dafa5d1f4a29f58d2c53624c3935ba9a46472bdcd7239fb3529dd61a092d563a3a299cd7c90468c739bb1540cef730ab65aef976b254b92391922e823b5692e7b0d58a362ddcf597aad4b9db2a168ee09f693522af2a911f3737424fa24bf268ecd2d2503e7756ad657d6da6cd4ca92542cc922b5baf2e22eb7d8920c1f5512265a14d97a882c27b9e25a6e2b75bbd4f76dc73cd1cbb1abcbd25aef144fb8da6aa9227235f3315a8aed880547723f151dd6a9c9ba75ba4a396831251b7e9a8a4447a3536a67b54b1607c3951866cab47552c72bd5fa59c69a89aba504774b6d4514c9de4ec5628195de6e315db1ee1aad81c8e6cad6aae5cbab3347c5de29dd7f0cfec33fb2ee5774b5dfa92b1f5d03e9e9a5d26b35e7a39ec349be50bee764ada289cd649510ba36b9db115500acee4de22d375b276976328a0c018c6d548da5a1bfc7040d5554631ce444553a7e67e3cff00a993f99c069c3a081b55baeb061b7d1d7d724f5ee6b93ba138b34d453be69e3ca64ca0c47a6d4d89a4a05e3143e999872b9d59a3bcef6b9e9155dc79923709caaf4546baa1cadcf9324231f80715ded5915faf7a7488ecdcc472aaa9a35a6d74f67b7434348dca285ba29cabd2077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffd9	\\x4749463839617a002000c410009393d2afafe87676bcc5c5f96060abb6b6ee6f6fb6a1a1dd8484c76767b08c8ccda8a8e39999d7bebef47d7dc15959a5ccccff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000021f90401000010002c000000007a0020000005ff20248e64699e68aaae6cebbe702ccf746ddf78aeef7cefffc0a070482c1a8fc8a472c96c3a9fb14160ca9a060a2aeb00aa033c04a982e0412623b6a582a35c762c480304fb8be5dabce0d3814c4000d60f0475227b817e0a0665230504640e00088d0f0776357827038d0668108c5f8b8e9c100d6b23638223038904a2952f97265eac25016401226b062875b50fb7708d00ae32b025630a2789c21064942a5eba260a9fc330c524646fd29fbdad26c7270b64d5d6d425b62797bd240700eeee2263cbb4e3e42ed723e8b1dc649c636cf11ecc23b1ce5e0b7c22949d003720dba2290cea4dcb53029ac183e648c84960a241b3841945142cd4c0448207082e72b24038ca0c9c441c09b924580fc2c94d1ac99454f9ec418277ef4a4efb72200083930fb48990f3c000832900fe8d10e7f3e9817fc878f69ca38f81a432097e91f0caf52741a4650830d0baa28195b701380d58f04eec8900ef0e0ca2f56e8137b680030b1e4cb8b0e1c388132b5eccb85208003b	asassa                                                                                              	ministerioaaaszczxcxc                                                                                                                                                                                                                                                                                       
\.


--
-- TOC entry 2432 (class 0 OID 30174)
-- Dependencies: 208
-- Data for Name: cargo_por_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cargo_por_persona (idpersona, identidad, idtipo_cargo, cantidad_horas, fecha_inicio, fecha_fin, activo, idtipo_hora, tipo, idcargo_por_persona, bloque, historico, observaciones) FROM stdin;
1	2	\N	5	\N	\N	t	1	horas	6	bloque2	f	\N
1	2	\N	3	\N	\N	f	2	horas	5	bloque2	f	\N
1	2	3	21	\N	\N	f	\N	cargo	10	bloque1	f	\N
1	2	\N	10	2017-12-18	2017-12-20	f	1	horas	4	bloque2	t	\N
1	2	\N	5	\N	\N	t	2	horas	1	bloque2	t	\N
1	1	5	21	2017-12-18	2017-12-20	t	\N	cargo	2	bloque1	f	ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
1	1	5	21	2017-12-20	\N	f	\N	cargo	11	bloque1	f	asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdas
\.


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 220
-- Name: cargo_por_persona_idcargo_por_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cargo_por_persona_idcargo_por_persona_seq', 11, true);


--
-- TOC entry 2407 (class 0 OID 30024)
-- Dependencies: 183
-- Data for Name: configuracion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY configuracion (cantidad_max_dias_viatico_mensual, cantidad_max_hs_bloque) FROM stdin;
15	21
\.


--
-- TOC entry 2436 (class 0 OID 31345)
-- Dependencies: 212
-- Data for Name: detalle_dias_viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY detalle_dias_viatico (iddetalle_dias_viatico, fecha_desde, fecha_hasta, cantidad_dias, idlocalidad_origen, idlocalidad_destino, idviatico, medio_dia) FROM stdin;
12	2017-12-06	2017-12-08	2	218	264	8	f
8	2017-11-11	2017-11-09	6	218	264	9	f
4	2017-11-11	2017-11-13	3	218	264	1	f
9	2017-12-04	2017-12-05	2	218	278	10	f
15	2017-11-11	2017-12-09	3	218	278	10	f
16	2017-11-15	2017-11-09	3	218	275	12	f
6	2017-12-01	2017-12-02	2	218	278	2	f
7	2017-11-11	2017-11-09	1	278	218	3	f
10	2017-11-22	2017-11-08	1	197	275	11	f
\.


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 213
-- Name: detalle_dias_viatico_iddetalle_dias_viatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('detalle_dias_viatico_iddetalle_dias_viatico_seq', 16, true);


--
-- TOC entry 2434 (class 0 OID 30197)
-- Dependencies: 210
-- Data for Name: detalle_viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY detalle_viatico (iddetalle_viatico, monto, descripcion, idtipo_detalle_viatico, idviatico) FROM stdin;
1	500	\N	2	1
\.


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 209
-- Name: detalle_viatico_iddetalle_viatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('detalle_viatico_iddetalle_viatico_seq', 1, true);


--
-- TOC entry 2421 (class 0 OID 30082)
-- Dependencies: 197
-- Data for Name: entidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidad (identidad, sigla, nombre, idlocalidad, calle, altura, piso, depto) FROM stdin;
1	UNAM	UNIVERSIDAD NACIONAL DE MISIONESMISIONESMISMISIONMISIONESMISIONESESMISIONESIONES	218	\N	\N	\N	\N
2	UNCAUS	UNIVERSIDAD DEL CHACO AUSTRAL	218	\N	\N	\N	\N
\.


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 196
-- Name: entidad_identidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('entidad_identidad_seq', 3, true);


--
-- TOC entry 2423 (class 0 OID 30090)
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
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 198
-- Name: estado_civil_idestado_civil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estado_civil_idestado_civil_seq', 9, true);


--
-- TOC entry 2438 (class 0 OID 31371)
-- Dependencies: 214
-- Data for Name: estudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estudio (titulo, idestudio, sigla) FROM stdin;
LICENCIATURA EN SISTEMAS DE INFORMACION                                                                                                                                                                                                                                                                     	2	LSI       
ANALISTA SISTEMAS DE COMPUTACION                                                                                                                                                                                                                                                                            	1	ASC       
\.


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 215
-- Name: estudio_idestudio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estudio_idestudio_seq', 3, true);


--
-- TOC entry 2440 (class 0 OID 31395)
-- Dependencies: 216
-- Data for Name: estudio_por_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estudio_por_persona (idestudio, idnivel_estudio, idpersona, identidad, obervaciones) FROM stdin;
1	7	4	1	DFGDDG
1	7	1	2	\N
1	7	1	1	\N
2	7	4	2	\N
2	7	4	1	\N
2	6	1	2	\N
\.


--
-- TOC entry 2411 (class 0 OID 30037)
-- Dependencies: 187
-- Data for Name: funcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY funcion (idfuncion, descripcion, maximo_horas, cantidad_permitida) FROM stdin;
1	PROFESIONAL	10	2
\.


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 186
-- Name: funcion_idfuncion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('funcion_idfuncion_seq', 1, true);


--
-- TOC entry 2419 (class 0 OID 30074)
-- Dependencies: 195
-- Data for Name: localidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localidad (idlocalidad, idprovincia, descripcion) FROM stdin;
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
\.


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 194
-- Name: localidad_idlocalidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localidad_idlocalidad_seq', 450, true);


--
-- TOC entry 2406 (class 0 OID 30018)
-- Dependencies: 182
-- Data for Name: nivel_estudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY nivel_estudio (idnivel_estudio, descripcion, maximo_horas, orden, nivel) FROM stdin;
7	UNIVERSITARIO	20	1	superior
5	PRIMARIO	10	3	inferior
6	SECUNDARIO	20	2	superior
\.


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 181
-- Name: nivel_estudio_idnivel_estudio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('nivel_estudio_idnivel_estudio_seq', 7, true);


--
-- TOC entry 2415 (class 0 OID 30058)
-- Dependencies: 191
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pais (idpais, descripcion) FROM stdin;
2	ARGENTINA
4	PARAGUAY
\.


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 190
-- Name: pais_idpais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pais_idpais_seq', 20, true);


--
-- TOC entry 2429 (class 0 OID 30114)
-- Dependencies: 205
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY persona (idpersona, nombres, apellido, idtipo_documento, nro_documento, matricula, idestado_civil, cuil, correo, fecha_nacimiento, sexo, idlocalidad, calle, altura, depto, piso, domicilio, matricula_activa, fecha_baja_matricula, baja) FROM stdin;
4	FACUNDO	PIOTROSKI	7	30475293	\N	\N	20304752190	\N	1984-10-01	m	218	CALLE	1	\N	\N	\N	t	\N	f
1	GUSTAVO	ESCALANTE	7	30047529	644	6	20304752190	escalantegc@gmail.com	1983-09-13	m	218	CALLEA	1538	22	1	QA	f	\N	f
5	BMB	MH	1	30047529	\N	\N	20304752190	\N	\N	m	218	CALLE	5454	\N	\N	\N	t	\N	f
\.


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 204
-- Name: persona_idpersona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('persona_idpersona_seq', 5, true);


--
-- TOC entry 2417 (class 0 OID 30066)
-- Dependencies: 193
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincia (idprovincia, idpais, descripcion) FROM stdin;
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
\.


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 192
-- Name: provincia_idprovincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('provincia_idprovincia_seq', 63, true);


--
-- TOC entry 2435 (class 0 OID 30219)
-- Dependencies: 211
-- Data for Name: telefono_por_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY telefono_por_persona (idtipo_telefono, idpersona, numero) FROM stdin;
2	1	367689846
2	4	37648945
\.


--
-- TOC entry 2425 (class 0 OID 30098)
-- Dependencies: 201
-- Data for Name: tipo_cargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_cargo (idtipo_cargo, descripcion, cantidad_cargos, jerarquico) FROM stdin;
5	DOCENTE	2	f
4	ADMINISTRATIVO	2	f
7	JERARQUICO DOCENTE	1	t
3	JERARQUICO ADMINISTRATIVO	1	t
\.


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_cargo_idtipo_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_cargo_idtipo_cargo_seq', 7, true);


--
-- TOC entry 2409 (class 0 OID 30029)
-- Dependencies: 185
-- Data for Name: tipo_detalle_viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_detalle_viatico (idtipo_detalle_viatico, descripcion) FROM stdin;
2	COMBUSTIBLE
3	HOSPEDAJE
1	SIN MOTIVOS
\.


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 184
-- Name: tipo_detalle_viatico_idtipo_detalle_viatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_detalle_viatico_idtipo_detalle_viatico_seq', 3, true);


--
-- TOC entry 2427 (class 0 OID 30106)
-- Dependencies: 203
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_documento (idtipo_documento, sigla, descripcion) FROM stdin;
1	S/T	Sin Tipo de Documento
4	LC	LIBRETA CIVICA
5	LE	LIBRETA DE ENROLAMIENTO
7	DNI	DOCUMENTO NACIONAL DE IDENTIDAD
8	SAS	AS
\.


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 202
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_documento_idtipo_documento_seq', 8, true);


--
-- TOC entry 2442 (class 0 OID 42562)
-- Dependencies: 218
-- Data for Name: tipo_hora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_hora (idtipo_hora, descripcion, max_hs_nivel_medio, max_hs_nivel_superior) FROM stdin;
2	NIVEL MEDIO                                       	12	0
1	NIVEL SUPERIOR                                    	0	15
\.


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 219
-- Name: tipo_hora_idtipo_hora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_hora_idtipo_hora_seq', 3, true);


--
-- TOC entry 2413 (class 0 OID 30050)
-- Dependencies: 189
-- Data for Name: tipo_telefono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_telefono (idtipo_telefono, descripcion) FROM stdin;
1	FIJO
2	CELULAR
3	FAX
\.


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 188
-- Name: tipo_telefono_idtipo_telefono_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_telefono_idtipo_telefono_seq', 3, true);


--
-- TOC entry 2431 (class 0 OID 30125)
-- Dependencies: 207
-- Data for Name: viatico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY viatico (idviatico, fecha_desde, nro_expediente, fecha_hasta, idpersona, idlocalidad_origen, idlocalidad_destino, cantidad_total_dias, mes, cantidad_dias_reintegro, cantidad_dias_disponible, cantidad_dias_tomados) FROM stdin;
7	\N	888	\N	1	\N	\N	10	1 	0	10	0
9	\N	164	\N	1	\N	\N	15	10	0	9	6
10	\N	931	\N	1	\N	\N	10	11	0	5	5
11	\N	647	\N	1	\N	\N	15	12	5	9	1
2	\N	215	\N	1	\N	\N	8	12	3	3	2
12	\N	11789	\N	1	\N	\N	15	11	3	9	3
8	\N	989	\N	1	\N	\N	10	1 	0	8	2
1	2017-11-07	213	2017-11-09	1	218	264	15	11	7	5	3
3	\N	216	\N	1	\N	\N	7	12	0	6	1
\.


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 206
-- Name: viatico_idviatico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('viatico_idviatico_seq', 12, true);


--
-- TOC entry 2256 (class 2606 OID 42590)
-- Name: cargo_por_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT cargo_por_persona_pkey PRIMARY KEY (idcargo_por_persona);


--
-- TOC entry 2258 (class 2606 OID 31370)
-- Name: detalle_dias_viatico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_pkey PRIMARY KEY (iddetalle_dias_viatico);


--
-- TOC entry 2260 (class 2606 OID 31389)
-- Name: estudio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio
    ADD CONSTRAINT estudio_pkey PRIMARY KEY (idestudio);


--
-- TOC entry 2263 (class 2606 OID 31497)
-- Name: estudio_por_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_pkey PRIMARY KEY (idestudio, idnivel_estudio, idpersona, identidad);


--
-- TOC entry 2250 (class 2606 OID 30120)
-- Name: id_persona; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT id_persona PRIMARY KEY (idpersona);


--
-- TOC entry 2238 (class 2606 OID 30087)
-- Name: identidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidad
    ADD CONSTRAINT identidad PRIMARY KEY (identidad);


--
-- TOC entry 2241 (class 2606 OID 30095)
-- Name: idestado_civil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado_civil
    ADD CONSTRAINT idestado_civil PRIMARY KEY (idestado_civil);


--
-- TOC entry 2222 (class 2606 OID 30045)
-- Name: idfuncion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funcion
    ADD CONSTRAINT idfuncion PRIMARY KEY (idfuncion);


--
-- TOC entry 2233 (class 2606 OID 30079)
-- Name: idlocalidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad
    ADD CONSTRAINT idlocalidad PRIMARY KEY (idlocalidad);


--
-- TOC entry 2215 (class 2606 OID 30023)
-- Name: idnivel_estudio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nivel_estudio
    ADD CONSTRAINT idnivel_estudio PRIMARY KEY (idnivel_estudio);


--
-- TOC entry 2227 (class 2606 OID 30063)
-- Name: idpais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT idpais PRIMARY KEY (idpais);


--
-- TOC entry 2230 (class 2606 OID 30071)
-- Name: idprovincia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT idprovincia PRIMARY KEY (idprovincia);


--
-- TOC entry 2243 (class 2606 OID 30103)
-- Name: idtipo_cargo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_cargo
    ADD CONSTRAINT idtipo_cargo PRIMARY KEY (idtipo_cargo);


--
-- TOC entry 2218 (class 2606 OID 30034)
-- Name: idtipo_detalle_viatico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_detalle_viatico
    ADD CONSTRAINT idtipo_detalle_viatico PRIMARY KEY (idtipo_detalle_viatico);


--
-- TOC entry 2246 (class 2606 OID 30111)
-- Name: idtipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT idtipo_documento PRIMARY KEY (idtipo_documento);


--
-- TOC entry 2224 (class 2606 OID 30055)
-- Name: idtipo_telefono; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_telefono
    ADD CONSTRAINT idtipo_telefono PRIMARY KEY (idtipo_telefono);


--
-- TOC entry 2253 (class 2606 OID 30130)
-- Name: idviatico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT idviatico PRIMARY KEY (idviatico);


--
-- TOC entry 2266 (class 2606 OID 42572)
-- Name: tipo_hora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_hora
    ADD CONSTRAINT tipo_hora_pkey PRIMARY KEY (idtipo_hora);


--
-- TOC entry 2235 (class 1259 OID 31477)
-- Name: entidad_nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidad_nombre_idx ON entidad USING btree (nombre);


--
-- TOC entry 2236 (class 1259 OID 31478)
-- Name: entidad_sigla_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidad_sigla_idx ON entidad USING btree (sigla);


--
-- TOC entry 2239 (class 1259 OID 31479)
-- Name: estado_civil_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estado_civil_descripcion_idx ON estado_civil USING btree (descripcion);


--
-- TOC entry 2261 (class 1259 OID 31475)
-- Name: estudio_titulo_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estudio_titulo_idx ON estudio USING btree (titulo);


--
-- TOC entry 2220 (class 1259 OID 39793)
-- Name: funcion_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX funcion_descripcion_idx ON funcion USING btree (descripcion);


--
-- TOC entry 2264 (class 1259 OID 42578)
-- Name: idx_descripcion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_descripcion ON tipo_hora USING btree (descripcion);


--
-- TOC entry 2234 (class 1259 OID 31481)
-- Name: localidad_descripcion_idprovincia_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX localidad_descripcion_idprovincia_idx ON localidad USING btree (descripcion, idprovincia);


--
-- TOC entry 2216 (class 1259 OID 31474)
-- Name: nivel_estudio_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nivel_estudio_descripcion_idx ON nivel_estudio USING btree (descripcion);


--
-- TOC entry 2228 (class 1259 OID 31469)
-- Name: pais_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pais_descripcion_idx ON pais USING btree (descripcion);


--
-- TOC entry 2251 (class 1259 OID 30121)
-- Name: persona_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX persona_idx ON persona USING btree (idtipo_documento, nro_documento);


--
-- TOC entry 2231 (class 1259 OID 31482)
-- Name: provincia_descripcion_idpais_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX provincia_descripcion_idpais_idx ON provincia USING btree (descripcion, idpais);


--
-- TOC entry 2244 (class 1259 OID 31473)
-- Name: tipo_cargo_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_cargo_descripcion_idx ON tipo_cargo USING btree (descripcion);


--
-- TOC entry 2219 (class 1259 OID 31472)
-- Name: tipo_detalle_viatico_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_detalle_viatico_descripcion_idx ON tipo_detalle_viatico USING btree (descripcion);


--
-- TOC entry 2247 (class 1259 OID 31338)
-- Name: tipo_documento_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_documento_descripcion_idx ON tipo_documento USING btree (descripcion);


--
-- TOC entry 2248 (class 1259 OID 31337)
-- Name: tipo_documento_sigla_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tipo_documento_sigla_idx ON tipo_documento USING btree (sigla);


--
-- TOC entry 2225 (class 1259 OID 31471)
-- Name: tipo_telefono_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_telefono_descripcion_idx ON tipo_telefono USING btree (descripcion);


--
-- TOC entry 2254 (class 1259 OID 31470)
-- Name: viatico_nro_expediente_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX viatico_nro_expediente_idx ON viatico USING btree (nro_expediente);


--
-- TOC entry 2276 (class 2606 OID 42573)
-- Name: cargo_por_persona_idtipo_hora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT cargo_por_persona_idtipo_hora_fkey FOREIGN KEY (idtipo_hora) REFERENCES tipo_hora(idtipo_hora) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2284 (class 2606 OID 31364)
-- Name: detalle_dias_viatico_idlocalidad_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idlocalidad_destino_fkey FOREIGN KEY (idlocalidad_destino) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2285 (class 2606 OID 31359)
-- Name: detalle_dias_viatico_idlocalidad_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idlocalidad_origen_fkey FOREIGN KEY (idlocalidad_origen) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2286 (class 2606 OID 31354)
-- Name: detalle_dias_viatico_idviatico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idviatico_fkey FOREIGN KEY (idviatico) REFERENCES viatico(idviatico);


--
-- TOC entry 2279 (class 2606 OID 31292)
-- Name: entidad_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT entidad_cargo_por_persona_fk FOREIGN KEY (identidad) REFERENCES entidad(identidad);


--
-- TOC entry 2271 (class 2606 OID 31297)
-- Name: estado_civil_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT estado_civil_persona_fk FOREIGN KEY (idestado_civil) REFERENCES estado_civil(idestado_civil);


--
-- TOC entry 2288 (class 2606 OID 31413)
-- Name: estudio_por_persona_identidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_identidad_fkey FOREIGN KEY (identidad) REFERENCES entidad(identidad);


--
-- TOC entry 2287 (class 2606 OID 31491)
-- Name: estudio_por_persona_idestudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idestudio_fkey FOREIGN KEY (idestudio) REFERENCES estudio(idestudio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2289 (class 2606 OID 31408)
-- Name: estudio_por_persona_idnivel_estudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idnivel_estudio_fkey FOREIGN KEY (idnivel_estudio) REFERENCES nivel_estudio(idnivel_estudio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2290 (class 2606 OID 31403)
-- Name: estudio_por_persona_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES persona(idpersona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2269 (class 2606 OID 31287)
-- Name: localidad_entidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidad
    ADD CONSTRAINT localidad_entidad_fk FOREIGN KEY (idlocalidad) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2272 (class 2606 OID 31272)
-- Name: localidad_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT localidad_persona_fk FOREIGN KEY (idlocalidad) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2275 (class 2606 OID 31277)
-- Name: localidad_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT localidad_viatico_fk FOREIGN KEY (idlocalidad_origen) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2274 (class 2606 OID 31282)
-- Name: localidad_viatico_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT localidad_viatico_fk1 FOREIGN KEY (idlocalidad_destino) REFERENCES localidad(idlocalidad);


--
-- TOC entry 2267 (class 2606 OID 31262)
-- Name: pais_provincia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pais_provincia_fk FOREIGN KEY (idpais) REFERENCES pais(idpais);


--
-- TOC entry 2277 (class 2606 OID 31312)
-- Name: persona_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT persona_cargo_por_persona_fk FOREIGN KEY (idpersona) REFERENCES persona(idpersona);


--
-- TOC entry 2282 (class 2606 OID 31317)
-- Name: persona_telefono_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_por_persona
    ADD CONSTRAINT persona_telefono_por_persona_fk FOREIGN KEY (idpersona) REFERENCES persona(idpersona);


--
-- TOC entry 2273 (class 2606 OID 31327)
-- Name: persona_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY viatico
    ADD CONSTRAINT persona_viatico_fk FOREIGN KEY (idpersona) REFERENCES persona(idpersona);


--
-- TOC entry 2268 (class 2606 OID 31267)
-- Name: provincia_localidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad
    ADD CONSTRAINT provincia_localidad_fk FOREIGN KEY (idprovincia) REFERENCES provincia(idprovincia);


--
-- TOC entry 2278 (class 2606 OID 31302)
-- Name: tipo_cargo_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cargo_por_persona
    ADD CONSTRAINT tipo_cargo_cargo_por_persona_fk FOREIGN KEY (idtipo_cargo) REFERENCES tipo_cargo(idtipo_cargo);


--
-- TOC entry 2281 (class 2606 OID 31247)
-- Name: tipo_detalle_viatico_detalle_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_viatico
    ADD CONSTRAINT tipo_detalle_viatico_detalle_viatico_fk FOREIGN KEY (idtipo_detalle_viatico) REFERENCES tipo_detalle_viatico(idtipo_detalle_viatico);


--
-- TOC entry 2270 (class 2606 OID 31307)
-- Name: tipo_documento_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT tipo_documento_persona_fk FOREIGN KEY (idtipo_documento) REFERENCES tipo_documento(idtipo_documento);


--
-- TOC entry 2283 (class 2606 OID 31257)
-- Name: tipo_telefono_telefono_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_por_persona
    ADD CONSTRAINT tipo_telefono_telefono_por_persona_fk FOREIGN KEY (idtipo_telefono) REFERENCES tipo_telefono(idtipo_telefono);


--
-- TOC entry 2280 (class 2606 OID 31332)
-- Name: viatico_detalle_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_viatico
    ADD CONSTRAINT viatico_detalle_viatico_fk FOREIGN KEY (idviatico) REFERENCES viatico(idviatico);


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-01-04 19:59:35 ART

--
-- PostgreSQL database dump complete
--

