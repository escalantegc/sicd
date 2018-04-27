--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.12
-- Dumped by pg_dump version 9.5.12

-- Started on 2018-04-27 06:38:28 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 494 (class 1255 OID 45227)
-- Name: cargos_de_una_persona(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cargos_de_una_persona(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    reg RECORD;
    cargos text;
BEGIN
    FOR REG IN (SELECT  
						
	coalesce(upper(tipo), ' ') || coalesce(' '||(case when  tipo_cargo.descripcion is null then tipo_hora.descripcion else tipo_cargo.descripcion end) ,' ') || coalesce(': '||cantidad_horas::text, ' ') as sabor,
	(case when historico = true then 'SI' else 'NO' end) as historico ,
	tipo
	FROM 
	cargo_por_persona
	inner join persona using(idpersona)
	left outer join tipo_cargo  using(idtipo_cargo)
	left outer join tipo_hora  using(idtipo_hora)

	WHERE
	historico = false and
	activo = true and
	cargo_por_persona.idpersona =$1
	order by 
		bloque,
		activo desc,
		apellido, nombres,
		fecha_inicio,
		cargo_por_persona.idtipo_hora) LOOP
	cargos:=  coalesce(cargos,'') ||coalesce(reg.sabor,'') ||coalesce(' | ','');
       
    END LOOP;
   RETURN cargos;
END
$_$;


ALTER FUNCTION public.cargos_de_una_persona(integer) OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 42593)
-- Name: contar_cargos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos() RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	      where activo = true and
	      historico = false) ;
    
    RETURN total;
END;
$$;


ALTER FUNCTION public.contar_cargos() OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 42716)
-- Name: contar_cargos(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos(character) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	      where activo = true and
		bloque = $1) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos(character) OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 42717)
-- Name: contar_cargos_por_bloque(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos_por_bloque(character) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	      where 	idtipo_cargo is not null and
			activo = true and
			historico = false and
		bloque ='bloque2'and idpersona =1) ;
    
    RETURN total;
END;
$$;


ALTER FUNCTION public.contar_cargos_por_bloque(character) OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 42718)
-- Name: contar_cargos_por_bloque(character, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos_por_bloque(character, integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	      where 	idtipo_cargo is not null and
			activo = true and
			historico = false and
		bloque ilike $1 and idpersona =$2) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_por_bloque(character, integer) OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 42591)
-- Name: contar_cargos_segun_tipo(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos_segun_tipo(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
              WHERE	idtipo_cargo is not null and
			cargo_por_persona.idtipo_cargo  = $1 and
			activo = true  and
			historico = false) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_segun_tipo(integer) OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 42719)
-- Name: contar_cargos_segun_tipo(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos_segun_tipo(integer, integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
              WHERE	idtipo_cargo is not null and
			cargo_por_persona.idtipo_cargo  = $1 and
			activo = true  and
			historico = false and
			idpersona = $2) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_segun_tipo(integer, integer) OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 42594)
-- Name: contar_cargos_segun_tipo_jerarquico(boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos_segun_tipo_jerarquico(boolean) RETURNS numeric
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
  		cargo_por_persona.activo = true  and
	      historico = false) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_segun_tipo_jerarquico(boolean) OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 42722)
-- Name: contar_cargos_segun_tipo_jerarquico(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.contar_cargos_segun_tipo_jerarquico(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT count(idcargo_por_persona) as cantidad
	      FROM cargo_por_persona
	inner join tipo_cargo on tipo_cargo.idtipo_cargo=cargo_por_persona.idtipo_cargo
              WHERE	cargo_por_persona.idtipo_cargo is not null and
			tipo_cargo.jerarquico  =  true and
			cargo_por_persona.activo = true  and
			historico = false and
			idpersona = $1) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.contar_cargos_segun_tipo_jerarquico(integer) OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 45267)
-- Name: recuperar_schema_temp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.recuperar_schema_temp() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
			DECLARE
			   schemas varchar;
			   pos_inicial int4;
			   pos_final int4;
			   schema_temp varchar;
			BEGIN
			   schema_temp := '';
			   SELECT INTO schemas current_schemas(true);
			   SELECT INTO pos_inicial strpos(schemas, 'pg_temp');
			   IF (pos_inicial > 0) THEN
			      SELECT INTO pos_final strpos(schemas, ',');
			      SELECT INTO schema_temp substr(schemas, pos_inicial, pos_final - pos_inicial);
			   END IF;
			   RETURN schema_temp;
			END;
			$$;


ALTER FUNCTION public.recuperar_schema_temp() OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 42603)
-- Name: sumar_dias_disponible_por_mes(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumar_dias_disponible_por_mes(character) RETURNS numeric
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
-- TOC entry 462 (class 1255 OID 39708)
-- Name: sumar_dias_disponible_por_mes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumar_dias_disponible_por_mes(integer) RETURNS numeric
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
-- TOC entry 489 (class 1255 OID 45216)
-- Name: sumar_dias_disponible_por_mes(character, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumar_dias_disponible_por_mes(character, integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_dias_disponible) FROM viatico
    WHERE 
	mes = $1 and
	viatico.idpersona = $2
    ) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumar_dias_disponible_por_mes(character, integer) OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 42713)
-- Name: sumar_horas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumar_horas() RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		tipo = 'horas' and
  		activo =true and
  		historico = false) ;
    
    RETURN total;
END;
$$;


ALTER FUNCTION public.sumar_horas() OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 42714)
-- Name: sumar_horas(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumar_horas(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
	     
              WHERE
  		tipo ilike 'horas' and
  		activo =true and
  		historico = false and
  		idpersona = $1
  		group by
		bloque) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumar_horas(integer) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 46283)
-- Name: sumar_horas(integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumar_horas(integer, character) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
	     
              WHERE
  		tipo ilike 'horas' and
  		activo =true and
  		historico = false and
  		idpersona = $1 and
  		bloque= $2
  		) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumar_horas(integer, character) OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 42604)
-- Name: sumas_horas_segun_tipo(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumas_horas_segun_tipo(character) RETURNS numeric
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
-- TOC entry 463 (class 1255 OID 42579)
-- Name: sumas_horas_segun_tipo(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumas_horas_segun_tipo(integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idtipo_hora is not null and
  		activo = true and 
  		historico = false and
  		cargo_por_persona.idpersona = $1) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumas_horas_segun_tipo(integer) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 46387)
-- Name: sumas_horas_segun_tipo(integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumas_horas_segun_tipo(integer, character) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idtipo_hora is not null and
  		activo = true and 
  		historico = false and
  		cargo_por_persona.idpersona = $1 and
  		bloque = $2) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumas_horas_segun_tipo(integer, character) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 42723)
-- Name: sumas_horas_segun_tipo(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumas_horas_segun_tipo(integer, integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idpersona  = $1 and
  		cargo_por_persona.idtipo_hora = $2 and
  		activo =true) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumas_horas_segun_tipo(integer, integer) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 46397)
-- Name: sumas_horas_segun_tipo(integer, integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumas_horas_segun_tipo(integer, integer, character) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	total numeric;
BEGIN
    total := (SELECT sum(cantidad_horas) as total_horas
	      FROM cargo_por_persona
              WHERE
  		cargo_por_persona.idpersona  = $1 and
  		cargo_por_persona.idtipo_hora = $2 and
  		activo =true and
  		bloque = $3) ;
    
    RETURN total;
END;
$_$;


ALTER FUNCTION public.sumas_horas_segun_tipo(integer, integer, character) OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 45250)
-- Name: traer_fuente_financiamiento(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.traer_fuente_financiamiento(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	fuente text;
BEGIN
    fuente := (SELECT 	 
			 
			nombre
		FROM 
			public.fuente_financiamiento
		where 
			idfuente_financiamiento =$1) ;
    
    RETURN fuente;
END;
$_$;


ALTER FUNCTION public.traer_fuente_financiamiento(integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 233 (class 1259 OID 31515)
-- Name: cabecera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cabecera (
    logo1 bytea,
    logo2 bytea,
    nombre character(100),
    descripcion character(300)
);


ALTER TABLE public.cabecera OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 30174)
-- Name: cargo_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargo_por_persona (
    idpersona integer NOT NULL,
    identidad integer NOT NULL,
    idtipo_cargo integer,
    cantidad_horas double precision,
    fecha_inicio date,
    fecha_fin date,
    activo boolean DEFAULT true NOT NULL,
    idtipo_hora integer,
    tipo character(5),
    idcargo_por_persona integer NOT NULL,
    bloque character(7),
    historico boolean DEFAULT false,
    observaciones text,
    monto double precision,
    idfuente_financiamiento integer
);


ALTER TABLE public.cargo_por_persona OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 42580)
-- Name: cargo_por_persona_idcargo_por_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cargo_por_persona_idcargo_por_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cargo_por_persona_idcargo_por_persona_seq OWNER TO postgres;

--
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 236
-- Name: cargo_por_persona_idcargo_por_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargo_por_persona_idcargo_por_persona_seq OWNED BY public.cargo_por_persona.idcargo_por_persona;


--
-- TOC entry 199 (class 1259 OID 30024)
-- Name: configuracion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuracion (
    cantidad_max_dias_viatico_mensual integer,
    cantidad_max_hs_bloque integer,
    cantidad_max_cargos_bloque integer
);


ALTER TABLE public.configuracion OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 31345)
-- Name: detalle_dias_viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_dias_viatico (
    iddetalle_dias_viatico integer NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL,
    cantidad_dias numeric,
    idlocalidad_origen integer,
    idlocalidad_destino integer,
    idviatico integer,
    medio_dia boolean DEFAULT false
);


ALTER TABLE public.detalle_dias_viatico OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 31348)
-- Name: detalle_dias_viatico_iddetalle_dias_viatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_dias_viatico_iddetalle_dias_viatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalle_dias_viatico_iddetalle_dias_viatico_seq OWNER TO postgres;

--
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 229
-- Name: detalle_dias_viatico_iddetalle_dias_viatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_dias_viatico_iddetalle_dias_viatico_seq OWNED BY public.detalle_dias_viatico.iddetalle_dias_viatico;


--
-- TOC entry 226 (class 1259 OID 30197)
-- Name: detalle_viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_viatico (
    iddetalle_viatico integer NOT NULL,
    monto double precision NOT NULL,
    descripcion character varying(50),
    idtipo_detalle_viatico integer NOT NULL,
    idviatico integer
);


ALTER TABLE public.detalle_viatico OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 30195)
-- Name: detalle_viatico_iddetalle_viatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_viatico_iddetalle_viatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalle_viatico_iddetalle_viatico_seq OWNER TO postgres;

--
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 225
-- Name: detalle_viatico_iddetalle_viatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_viatico_iddetalle_viatico_seq OWNED BY public.detalle_viatico.iddetalle_viatico;


--
-- TOC entry 213 (class 1259 OID 30082)
-- Name: entidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entidad (
    identidad integer NOT NULL,
    sigla character varying(10),
    nombre character varying(100) NOT NULL,
    idlocalidad integer,
    calle character varying(50),
    altura integer,
    piso character varying(2),
    depto character varying(2)
);


ALTER TABLE public.entidad OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 30080)
-- Name: entidad_identidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entidad_identidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entidad_identidad_seq OWNER TO postgres;

--
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 212
-- Name: entidad_identidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entidad_identidad_seq OWNED BY public.entidad.identidad;


--
-- TOC entry 215 (class 1259 OID 30090)
-- Name: estado_civil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_civil (
    idestado_civil integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.estado_civil OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 30088)
-- Name: estado_civil_idestado_civil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_civil_idestado_civil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_civil_idestado_civil_seq OWNER TO postgres;

--
-- TOC entry 3218 (class 0 OID 0)
-- Dependencies: 214
-- Name: estado_civil_idestado_civil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_civil_idestado_civil_seq OWNED BY public.estado_civil.idestado_civil;


--
-- TOC entry 230 (class 1259 OID 31371)
-- Name: estudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudio (
    titulo character(300),
    idestudio integer NOT NULL,
    sigla character(10)
);


ALTER TABLE public.estudio OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 31382)
-- Name: estudio_idestudio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estudio_idestudio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estudio_idestudio_seq OWNER TO postgres;

--
-- TOC entry 3219 (class 0 OID 0)
-- Dependencies: 231
-- Name: estudio_idestudio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estudio_idestudio_seq OWNED BY public.estudio.idestudio;


--
-- TOC entry 232 (class 1259 OID 31395)
-- Name: estudio_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudio_por_persona (
    idestudio integer NOT NULL,
    idnivel_estudio integer NOT NULL,
    idpersona integer NOT NULL,
    identidad integer NOT NULL,
    obervaciones text
);


ALTER TABLE public.estudio_por_persona OWNER TO postgres;

--
-- TOC entry 437 (class 1259 OID 45228)
-- Name: fuente_financiamiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuente_financiamiento (
    idfuente_financiamiento integer NOT NULL,
    sigla character(10),
    nombre character(300) NOT NULL
);


ALTER TABLE public.fuente_financiamiento OWNER TO postgres;

--
-- TOC entry 438 (class 1259 OID 45231)
-- Name: fuente_financiamiento_idfuente_financiamiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fuente_financiamiento_idfuente_financiamiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fuente_financiamiento_idfuente_financiamiento_seq OWNER TO postgres;

--
-- TOC entry 3220 (class 0 OID 0)
-- Dependencies: 438
-- Name: fuente_financiamiento_idfuente_financiamiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fuente_financiamiento_idfuente_financiamiento_seq OWNED BY public.fuente_financiamiento.idfuente_financiamiento;


--
-- TOC entry 203 (class 1259 OID 30037)
-- Name: funcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcion (
    idfuncion integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    maximo_horas numeric NOT NULL,
    cantidad_permitida integer NOT NULL
);


ALTER TABLE public.funcion OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 30035)
-- Name: funcion_idfuncion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funcion_idfuncion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.funcion_idfuncion_seq OWNER TO postgres;

--
-- TOC entry 3221 (class 0 OID 0)
-- Dependencies: 202
-- Name: funcion_idfuncion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funcion_idfuncion_seq OWNED BY public.funcion.idfuncion;


--
-- TOC entry 211 (class 1259 OID 30074)
-- Name: localidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.localidad (
    idlocalidad integer NOT NULL,
    idprovincia integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.localidad OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 30072)
-- Name: localidad_idlocalidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.localidad_idlocalidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localidad_idlocalidad_seq OWNER TO postgres;

--
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 210
-- Name: localidad_idlocalidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.localidad_idlocalidad_seq OWNED BY public.localidad.idlocalidad;


--
-- TOC entry 198 (class 1259 OID 30018)
-- Name: nivel_estudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nivel_estudio (
    idnivel_estudio integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    maximo_horas double precision,
    orden integer,
    nivel character(8)
);


ALTER TABLE public.nivel_estudio OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 30016)
-- Name: nivel_estudio_idnivel_estudio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nivel_estudio_idnivel_estudio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nivel_estudio_idnivel_estudio_seq OWNER TO postgres;

--
-- TOC entry 3223 (class 0 OID 0)
-- Dependencies: 197
-- Name: nivel_estudio_idnivel_estudio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_estudio_idnivel_estudio_seq OWNED BY public.nivel_estudio.idnivel_estudio;


--
-- TOC entry 207 (class 1259 OID 30058)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    idpais integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 30056)
-- Name: pais_idpais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pais_idpais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pais_idpais_seq OWNER TO postgres;

--
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 206
-- Name: pais_idpais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pais_idpais_seq OWNED BY public.pais.idpais;


--
-- TOC entry 221 (class 1259 OID 30114)
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    idpersona integer NOT NULL,
    nombres character varying(100) NOT NULL,
    apellido character varying(50) NOT NULL,
    idtipo_documento integer NOT NULL,
    nro_documento integer NOT NULL,
    matricula character varying(20),
    idestado_civil integer,
    cuil character varying(11),
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


ALTER TABLE public.persona OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 30112)
-- Name: persona_idpersona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.persona_idpersona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.persona_idpersona_seq OWNER TO postgres;

--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 220
-- Name: persona_idpersona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.persona_idpersona_seq OWNED BY public.persona.idpersona;


--
-- TOC entry 209 (class 1259 OID 30066)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provincia (
    idprovincia integer NOT NULL,
    idpais integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 30064)
-- Name: provincia_idprovincia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provincia_idprovincia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provincia_idprovincia_seq OWNER TO postgres;

--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 208
-- Name: provincia_idprovincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provincia_idprovincia_seq OWNED BY public.provincia.idprovincia;


--
-- TOC entry 227 (class 1259 OID 30219)
-- Name: telefono_por_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono_por_persona (
    idtipo_telefono integer NOT NULL,
    idpersona integer NOT NULL,
    numero character varying(15) NOT NULL
);


ALTER TABLE public.telefono_por_persona OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 30098)
-- Name: tipo_cargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_cargo (
    idtipo_cargo integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    cantidad_cargos bigint,
    jerarquico boolean
);


ALTER TABLE public.tipo_cargo OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 30096)
-- Name: tipo_cargo_idtipo_cargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_cargo_idtipo_cargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_cargo_idtipo_cargo_seq OWNER TO postgres;

--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 216
-- Name: tipo_cargo_idtipo_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_cargo_idtipo_cargo_seq OWNED BY public.tipo_cargo.idtipo_cargo;


--
-- TOC entry 201 (class 1259 OID 30029)
-- Name: tipo_detalle_viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_detalle_viatico (
    idtipo_detalle_viatico integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.tipo_detalle_viatico OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 30027)
-- Name: tipo_detalle_viatico_idtipo_detalle_viatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_detalle_viatico_idtipo_detalle_viatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_detalle_viatico_idtipo_detalle_viatico_seq OWNER TO postgres;

--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 200
-- Name: tipo_detalle_viatico_idtipo_detalle_viatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_detalle_viatico_idtipo_detalle_viatico_seq OWNED BY public.tipo_detalle_viatico.idtipo_detalle_viatico;


--
-- TOC entry 219 (class 1259 OID 30106)
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_documento (
    idtipo_documento integer NOT NULL,
    sigla character varying(10) NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.tipo_documento OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 30104)
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_documento_idtipo_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_documento_idtipo_documento_seq OWNER TO postgres;

--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 218
-- Name: tipo_documento_idtipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_documento_idtipo_documento_seq OWNED BY public.tipo_documento.idtipo_documento;


--
-- TOC entry 234 (class 1259 OID 42562)
-- Name: tipo_hora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_hora (
    idtipo_hora integer NOT NULL,
    descripcion character(50),
    max_hs_nivel_medio double precision,
    max_hs_nivel_superior double precision
);


ALTER TABLE public.tipo_hora OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 42565)
-- Name: tipo_hora_idtipo_hora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_hora_idtipo_hora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_hora_idtipo_hora_seq OWNER TO postgres;

--
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 235
-- Name: tipo_hora_idtipo_hora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_hora_idtipo_hora_seq OWNED BY public.tipo_hora.idtipo_hora;


--
-- TOC entry 205 (class 1259 OID 30050)
-- Name: tipo_telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_telefono (
    idtipo_telefono integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.tipo_telefono OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 30048)
-- Name: tipo_telefono_idtipo_telefono_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_telefono_idtipo_telefono_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_telefono_idtipo_telefono_seq OWNER TO postgres;

--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 204
-- Name: tipo_telefono_idtipo_telefono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_telefono_idtipo_telefono_seq OWNED BY public.tipo_telefono.idtipo_telefono;


--
-- TOC entry 223 (class 1259 OID 30125)
-- Name: viatico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viatico (
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


ALTER TABLE public.viatico OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 30123)
-- Name: viatico_idviatico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.viatico_idviatico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.viatico_idviatico_seq OWNER TO postgres;

--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 222
-- Name: viatico_idviatico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.viatico_idviatico_seq OWNED BY public.viatico.idviatico;


--
-- TOC entry 2981 (class 2604 OID 45182)
-- Name: idcargo_por_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona ALTER COLUMN idcargo_por_persona SET DEFAULT nextval('public.cargo_por_persona_idcargo_por_persona_seq'::regclass);


--
-- TOC entry 2985 (class 2604 OID 45183)
-- Name: iddetalle_dias_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_dias_viatico ALTER COLUMN iddetalle_dias_viatico SET DEFAULT nextval('public.detalle_dias_viatico_iddetalle_dias_viatico_seq'::regclass);


--
-- TOC entry 2983 (class 2604 OID 45184)
-- Name: iddetalle_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_viatico ALTER COLUMN iddetalle_viatico SET DEFAULT nextval('public.detalle_viatico_iddetalle_viatico_seq'::regclass);


--
-- TOC entry 2972 (class 2604 OID 45185)
-- Name: identidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entidad ALTER COLUMN identidad SET DEFAULT nextval('public.entidad_identidad_seq'::regclass);


--
-- TOC entry 2973 (class 2604 OID 45186)
-- Name: idestado_civil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_civil ALTER COLUMN idestado_civil SET DEFAULT nextval('public.estado_civil_idestado_civil_seq'::regclass);


--
-- TOC entry 2986 (class 2604 OID 45187)
-- Name: idestudio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio ALTER COLUMN idestudio SET DEFAULT nextval('public.estudio_idestudio_seq'::regclass);


--
-- TOC entry 2988 (class 2604 OID 45233)
-- Name: idfuente_financiamiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuente_financiamiento ALTER COLUMN idfuente_financiamiento SET DEFAULT nextval('public.fuente_financiamiento_idfuente_financiamiento_seq'::regclass);


--
-- TOC entry 2967 (class 2604 OID 45188)
-- Name: idfuncion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcion ALTER COLUMN idfuncion SET DEFAULT nextval('public.funcion_idfuncion_seq'::regclass);


--
-- TOC entry 2971 (class 2604 OID 45189)
-- Name: idlocalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localidad ALTER COLUMN idlocalidad SET DEFAULT nextval('public.localidad_idlocalidad_seq'::regclass);


--
-- TOC entry 2965 (class 2604 OID 45190)
-- Name: idnivel_estudio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_estudio ALTER COLUMN idnivel_estudio SET DEFAULT nextval('public.nivel_estudio_idnivel_estudio_seq'::regclass);


--
-- TOC entry 2969 (class 2604 OID 45191)
-- Name: idpais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais ALTER COLUMN idpais SET DEFAULT nextval('public.pais_idpais_seq'::regclass);


--
-- TOC entry 2976 (class 2604 OID 45192)
-- Name: idpersona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona ALTER COLUMN idpersona SET DEFAULT nextval('public.persona_idpersona_seq'::regclass);


--
-- TOC entry 2970 (class 2604 OID 45193)
-- Name: idprovincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia ALTER COLUMN idprovincia SET DEFAULT nextval('public.provincia_idprovincia_seq'::regclass);


--
-- TOC entry 2974 (class 2604 OID 45194)
-- Name: idtipo_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cargo ALTER COLUMN idtipo_cargo SET DEFAULT nextval('public.tipo_cargo_idtipo_cargo_seq'::regclass);


--
-- TOC entry 2966 (class 2604 OID 45195)
-- Name: idtipo_detalle_viatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_detalle_viatico ALTER COLUMN idtipo_detalle_viatico SET DEFAULT nextval('public.tipo_detalle_viatico_idtipo_detalle_viatico_seq'::regclass);


--
-- TOC entry 2975 (class 2604 OID 45196)
-- Name: idtipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento ALTER COLUMN idtipo_documento SET DEFAULT nextval('public.tipo_documento_idtipo_documento_seq'::regclass);


--
-- TOC entry 2987 (class 2604 OID 45197)
-- Name: idtipo_hora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_hora ALTER COLUMN idtipo_hora SET DEFAULT nextval('public.tipo_hora_idtipo_hora_seq'::regclass);


--
-- TOC entry 2968 (class 2604 OID 45198)
-- Name: idtipo_telefono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_telefono ALTER COLUMN idtipo_telefono SET DEFAULT nextval('public.tipo_telefono_idtipo_telefono_seq'::regclass);


--
-- TOC entry 2979 (class 2604 OID 45199)
-- Name: idviatico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viatico ALTER COLUMN idviatico SET DEFAULT nextval('public.viatico_idviatico_seq'::regclass);


--
-- TOC entry 3031 (class 2606 OID 42590)
-- Name: cargo_por_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona
    ADD CONSTRAINT cargo_por_persona_pkey PRIMARY KEY (idcargo_por_persona);


--
-- TOC entry 3033 (class 2606 OID 31370)
-- Name: detalle_dias_viatico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_pkey PRIMARY KEY (iddetalle_dias_viatico);


--
-- TOC entry 3035 (class 2606 OID 31389)
-- Name: estudio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio
    ADD CONSTRAINT estudio_pkey PRIMARY KEY (idestudio);


--
-- TOC entry 3038 (class 2606 OID 31497)
-- Name: estudio_por_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_pkey PRIMARY KEY (idestudio, idnivel_estudio, idpersona, identidad);


--
-- TOC entry 3044 (class 2606 OID 45241)
-- Name: fuente_financiamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuente_financiamiento
    ADD CONSTRAINT fuente_financiamiento_pkey PRIMARY KEY (idfuente_financiamiento);


--
-- TOC entry 3025 (class 2606 OID 30120)
-- Name: id_persona; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT id_persona PRIMARY KEY (idpersona);


--
-- TOC entry 3013 (class 2606 OID 30087)
-- Name: identidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entidad
    ADD CONSTRAINT identidad PRIMARY KEY (identidad);


--
-- TOC entry 3016 (class 2606 OID 30095)
-- Name: idestado_civil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_civil
    ADD CONSTRAINT idestado_civil PRIMARY KEY (idestado_civil);


--
-- TOC entry 2997 (class 2606 OID 30045)
-- Name: idfuncion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcion
    ADD CONSTRAINT idfuncion PRIMARY KEY (idfuncion);


--
-- TOC entry 3008 (class 2606 OID 30079)
-- Name: idlocalidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localidad
    ADD CONSTRAINT idlocalidad PRIMARY KEY (idlocalidad);


--
-- TOC entry 2990 (class 2606 OID 30023)
-- Name: idnivel_estudio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_estudio
    ADD CONSTRAINT idnivel_estudio PRIMARY KEY (idnivel_estudio);


--
-- TOC entry 3002 (class 2606 OID 30063)
-- Name: idpais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT idpais PRIMARY KEY (idpais);


--
-- TOC entry 3005 (class 2606 OID 30071)
-- Name: idprovincia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT idprovincia PRIMARY KEY (idprovincia);


--
-- TOC entry 3018 (class 2606 OID 30103)
-- Name: idtipo_cargo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cargo
    ADD CONSTRAINT idtipo_cargo PRIMARY KEY (idtipo_cargo);


--
-- TOC entry 2993 (class 2606 OID 30034)
-- Name: idtipo_detalle_viatico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_detalle_viatico
    ADD CONSTRAINT idtipo_detalle_viatico PRIMARY KEY (idtipo_detalle_viatico);


--
-- TOC entry 3021 (class 2606 OID 30111)
-- Name: idtipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT idtipo_documento PRIMARY KEY (idtipo_documento);


--
-- TOC entry 2999 (class 2606 OID 30055)
-- Name: idtipo_telefono; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_telefono
    ADD CONSTRAINT idtipo_telefono PRIMARY KEY (idtipo_telefono);


--
-- TOC entry 3028 (class 2606 OID 30130)
-- Name: idviatico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viatico
    ADD CONSTRAINT idviatico PRIMARY KEY (idviatico);


--
-- TOC entry 3041 (class 2606 OID 42572)
-- Name: tipo_hora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_hora
    ADD CONSTRAINT tipo_hora_pkey PRIMARY KEY (idtipo_hora);


--
-- TOC entry 3010 (class 1259 OID 31477)
-- Name: entidad_nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidad_nombre_idx ON public.entidad USING btree (nombre);


--
-- TOC entry 3011 (class 1259 OID 31478)
-- Name: entidad_sigla_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidad_sigla_idx ON public.entidad USING btree (sigla);


--
-- TOC entry 3014 (class 1259 OID 31479)
-- Name: estado_civil_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estado_civil_descripcion_idx ON public.estado_civil USING btree (descripcion);


--
-- TOC entry 3036 (class 1259 OID 31475)
-- Name: estudio_titulo_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX estudio_titulo_idx ON public.estudio USING btree (titulo);


--
-- TOC entry 3042 (class 1259 OID 45248)
-- Name: fuente_financiamiento_nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fuente_financiamiento_nombre_idx ON public.fuente_financiamiento USING btree (nombre);


--
-- TOC entry 2995 (class 1259 OID 39793)
-- Name: funcion_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX funcion_descripcion_idx ON public.funcion USING btree (descripcion);


--
-- TOC entry 3039 (class 1259 OID 42578)
-- Name: idx_descripcion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_descripcion ON public.tipo_hora USING btree (descripcion);


--
-- TOC entry 3009 (class 1259 OID 31481)
-- Name: localidad_descripcion_idprovincia_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX localidad_descripcion_idprovincia_idx ON public.localidad USING btree (descripcion, idprovincia);


--
-- TOC entry 2991 (class 1259 OID 31474)
-- Name: nivel_estudio_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX nivel_estudio_descripcion_idx ON public.nivel_estudio USING btree (descripcion);


--
-- TOC entry 3003 (class 1259 OID 31469)
-- Name: pais_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX pais_descripcion_idx ON public.pais USING btree (descripcion);


--
-- TOC entry 3026 (class 1259 OID 30121)
-- Name: persona_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX persona_idx ON public.persona USING btree (idtipo_documento, nro_documento);


--
-- TOC entry 3006 (class 1259 OID 31482)
-- Name: provincia_descripcion_idpais_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX provincia_descripcion_idpais_idx ON public.provincia USING btree (descripcion, idpais);


--
-- TOC entry 3019 (class 1259 OID 31473)
-- Name: tipo_cargo_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_cargo_descripcion_idx ON public.tipo_cargo USING btree (descripcion);


--
-- TOC entry 2994 (class 1259 OID 31472)
-- Name: tipo_detalle_viatico_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_detalle_viatico_descripcion_idx ON public.tipo_detalle_viatico USING btree (descripcion);


--
-- TOC entry 3022 (class 1259 OID 31338)
-- Name: tipo_documento_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_documento_descripcion_idx ON public.tipo_documento USING btree (descripcion);


--
-- TOC entry 3023 (class 1259 OID 31337)
-- Name: tipo_documento_sigla_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tipo_documento_sigla_idx ON public.tipo_documento USING btree (sigla);


--
-- TOC entry 3000 (class 1259 OID 31471)
-- Name: tipo_telefono_descripcion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tipo_telefono_descripcion_idx ON public.tipo_telefono USING btree (descripcion);


--
-- TOC entry 3029 (class 1259 OID 42715)
-- Name: viatico_nro_expediente_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX viatico_nro_expediente_idx ON public.viatico USING btree (nro_expediente, mes);


--
-- TOC entry 3090 (class 2620 OID 45378)
-- Name: tauditoria_cabecera; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_cabecera AFTER INSERT OR DELETE OR UPDATE ON public.cabecera FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_cabecera();


--
-- TOC entry 3084 (class 2620 OID 45379)
-- Name: tauditoria_cargo_por_persona; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_cargo_por_persona AFTER INSERT OR DELETE OR UPDATE ON public.cargo_por_persona FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_cargo_por_persona();


--
-- TOC entry 3071 (class 2620 OID 45380)
-- Name: tauditoria_configuracion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_configuracion AFTER INSERT OR DELETE OR UPDATE ON public.configuracion FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_configuracion();


--
-- TOC entry 3087 (class 2620 OID 45381)
-- Name: tauditoria_detalle_dias_viatico; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_detalle_dias_viatico AFTER INSERT OR DELETE OR UPDATE ON public.detalle_dias_viatico FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_detalle_dias_viatico();


--
-- TOC entry 3085 (class 2620 OID 45382)
-- Name: tauditoria_detalle_viatico; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_detalle_viatico AFTER INSERT OR DELETE OR UPDATE ON public.detalle_viatico FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_detalle_viatico();


--
-- TOC entry 3078 (class 2620 OID 45383)
-- Name: tauditoria_entidad; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_entidad AFTER INSERT OR DELETE OR UPDATE ON public.entidad FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_entidad();


--
-- TOC entry 3079 (class 2620 OID 45384)
-- Name: tauditoria_estado_civil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_estado_civil AFTER INSERT OR DELETE OR UPDATE ON public.estado_civil FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_estado_civil();


--
-- TOC entry 3088 (class 2620 OID 45385)
-- Name: tauditoria_estudio; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_estudio AFTER INSERT OR DELETE OR UPDATE ON public.estudio FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_estudio();


--
-- TOC entry 3089 (class 2620 OID 45386)
-- Name: tauditoria_estudio_por_persona; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_estudio_por_persona AFTER INSERT OR DELETE OR UPDATE ON public.estudio_por_persona FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_estudio_por_persona();


--
-- TOC entry 3092 (class 2620 OID 45387)
-- Name: tauditoria_fuente_financiamiento; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_fuente_financiamiento AFTER INSERT OR DELETE OR UPDATE ON public.fuente_financiamiento FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_fuente_financiamiento();


--
-- TOC entry 3073 (class 2620 OID 45388)
-- Name: tauditoria_funcion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_funcion AFTER INSERT OR DELETE OR UPDATE ON public.funcion FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_funcion();


--
-- TOC entry 3077 (class 2620 OID 45389)
-- Name: tauditoria_localidad; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_localidad AFTER INSERT OR DELETE OR UPDATE ON public.localidad FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_localidad();


--
-- TOC entry 3070 (class 2620 OID 45390)
-- Name: tauditoria_nivel_estudio; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_nivel_estudio AFTER INSERT OR DELETE OR UPDATE ON public.nivel_estudio FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_nivel_estudio();


--
-- TOC entry 3075 (class 2620 OID 45391)
-- Name: tauditoria_pais; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_pais AFTER INSERT OR DELETE OR UPDATE ON public.pais FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_pais();


--
-- TOC entry 3082 (class 2620 OID 45392)
-- Name: tauditoria_persona; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_persona AFTER INSERT OR DELETE OR UPDATE ON public.persona FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_persona();


--
-- TOC entry 3076 (class 2620 OID 45393)
-- Name: tauditoria_provincia; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_provincia AFTER INSERT OR DELETE OR UPDATE ON public.provincia FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_provincia();


--
-- TOC entry 3086 (class 2620 OID 45394)
-- Name: tauditoria_telefono_por_persona; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_telefono_por_persona AFTER INSERT OR DELETE OR UPDATE ON public.telefono_por_persona FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_telefono_por_persona();


--
-- TOC entry 3080 (class 2620 OID 45395)
-- Name: tauditoria_tipo_cargo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_tipo_cargo AFTER INSERT OR DELETE OR UPDATE ON public.tipo_cargo FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_tipo_cargo();


--
-- TOC entry 3072 (class 2620 OID 45396)
-- Name: tauditoria_tipo_detalle_viatico; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_tipo_detalle_viatico AFTER INSERT OR DELETE OR UPDATE ON public.tipo_detalle_viatico FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_tipo_detalle_viatico();


--
-- TOC entry 3081 (class 2620 OID 45397)
-- Name: tauditoria_tipo_documento; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_tipo_documento AFTER INSERT OR DELETE OR UPDATE ON public.tipo_documento FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_tipo_documento();


--
-- TOC entry 3091 (class 2620 OID 45398)
-- Name: tauditoria_tipo_hora; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_tipo_hora AFTER INSERT OR DELETE OR UPDATE ON public.tipo_hora FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_tipo_hora();


--
-- TOC entry 3074 (class 2620 OID 45399)
-- Name: tauditoria_tipo_telefono; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_tipo_telefono AFTER INSERT OR DELETE OR UPDATE ON public.tipo_telefono FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_tipo_telefono();


--
-- TOC entry 3083 (class 2620 OID 45400)
-- Name: tauditoria_viatico; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tauditoria_viatico AFTER INSERT OR DELETE OR UPDATE ON public.viatico FOR EACH ROW EXECUTE PROCEDURE public_auditoria.sp_viatico();


--
-- TOC entry 3054 (class 2606 OID 45243)
-- Name: cargo_por_persona_idfuente_financiamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona
    ADD CONSTRAINT cargo_por_persona_idfuente_financiamiento_fkey FOREIGN KEY (idfuente_financiamiento) REFERENCES public.fuente_financiamiento(idfuente_financiamiento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3055 (class 2606 OID 42573)
-- Name: cargo_por_persona_idtipo_hora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona
    ADD CONSTRAINT cargo_por_persona_idtipo_hora_fkey FOREIGN KEY (idtipo_hora) REFERENCES public.tipo_hora(idtipo_hora) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3063 (class 2606 OID 31364)
-- Name: detalle_dias_viatico_idlocalidad_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idlocalidad_destino_fkey FOREIGN KEY (idlocalidad_destino) REFERENCES public.localidad(idlocalidad);


--
-- TOC entry 3064 (class 2606 OID 31359)
-- Name: detalle_dias_viatico_idlocalidad_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idlocalidad_origen_fkey FOREIGN KEY (idlocalidad_origen) REFERENCES public.localidad(idlocalidad);


--
-- TOC entry 3065 (class 2606 OID 31354)
-- Name: detalle_dias_viatico_idviatico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_dias_viatico
    ADD CONSTRAINT detalle_dias_viatico_idviatico_fkey FOREIGN KEY (idviatico) REFERENCES public.viatico(idviatico);


--
-- TOC entry 3058 (class 2606 OID 31292)
-- Name: entidad_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona
    ADD CONSTRAINT entidad_cargo_por_persona_fk FOREIGN KEY (identidad) REFERENCES public.entidad(identidad);


--
-- TOC entry 3049 (class 2606 OID 31297)
-- Name: estado_civil_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT estado_civil_persona_fk FOREIGN KEY (idestado_civil) REFERENCES public.estado_civil(idestado_civil);


--
-- TOC entry 3067 (class 2606 OID 31413)
-- Name: estudio_por_persona_identidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_identidad_fkey FOREIGN KEY (identidad) REFERENCES public.entidad(identidad);


--
-- TOC entry 3066 (class 2606 OID 31491)
-- Name: estudio_por_persona_idestudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idestudio_fkey FOREIGN KEY (idestudio) REFERENCES public.estudio(idestudio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3068 (class 2606 OID 31408)
-- Name: estudio_por_persona_idnivel_estudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idnivel_estudio_fkey FOREIGN KEY (idnivel_estudio) REFERENCES public.nivel_estudio(idnivel_estudio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3069 (class 2606 OID 31403)
-- Name: estudio_por_persona_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio_por_persona
    ADD CONSTRAINT estudio_por_persona_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.persona(idpersona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3047 (class 2606 OID 31287)
-- Name: localidad_entidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entidad
    ADD CONSTRAINT localidad_entidad_fk FOREIGN KEY (idlocalidad) REFERENCES public.localidad(idlocalidad);


--
-- TOC entry 3050 (class 2606 OID 31272)
-- Name: localidad_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT localidad_persona_fk FOREIGN KEY (idlocalidad) REFERENCES public.localidad(idlocalidad);


--
-- TOC entry 3053 (class 2606 OID 31277)
-- Name: localidad_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viatico
    ADD CONSTRAINT localidad_viatico_fk FOREIGN KEY (idlocalidad_origen) REFERENCES public.localidad(idlocalidad);


--
-- TOC entry 3052 (class 2606 OID 31282)
-- Name: localidad_viatico_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viatico
    ADD CONSTRAINT localidad_viatico_fk1 FOREIGN KEY (idlocalidad_destino) REFERENCES public.localidad(idlocalidad);


--
-- TOC entry 3045 (class 2606 OID 31262)
-- Name: pais_provincia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT pais_provincia_fk FOREIGN KEY (idpais) REFERENCES public.pais(idpais);


--
-- TOC entry 3056 (class 2606 OID 31312)
-- Name: persona_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona
    ADD CONSTRAINT persona_cargo_por_persona_fk FOREIGN KEY (idpersona) REFERENCES public.persona(idpersona);


--
-- TOC entry 3061 (class 2606 OID 31317)
-- Name: persona_telefono_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_por_persona
    ADD CONSTRAINT persona_telefono_por_persona_fk FOREIGN KEY (idpersona) REFERENCES public.persona(idpersona);


--
-- TOC entry 3051 (class 2606 OID 31327)
-- Name: persona_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viatico
    ADD CONSTRAINT persona_viatico_fk FOREIGN KEY (idpersona) REFERENCES public.persona(idpersona);


--
-- TOC entry 3046 (class 2606 OID 31267)
-- Name: provincia_localidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.localidad
    ADD CONSTRAINT provincia_localidad_fk FOREIGN KEY (idprovincia) REFERENCES public.provincia(idprovincia);


--
-- TOC entry 3057 (class 2606 OID 31302)
-- Name: tipo_cargo_cargo_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo_por_persona
    ADD CONSTRAINT tipo_cargo_cargo_por_persona_fk FOREIGN KEY (idtipo_cargo) REFERENCES public.tipo_cargo(idtipo_cargo);


--
-- TOC entry 3060 (class 2606 OID 31247)
-- Name: tipo_detalle_viatico_detalle_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_viatico
    ADD CONSTRAINT tipo_detalle_viatico_detalle_viatico_fk FOREIGN KEY (idtipo_detalle_viatico) REFERENCES public.tipo_detalle_viatico(idtipo_detalle_viatico);


--
-- TOC entry 3048 (class 2606 OID 31307)
-- Name: tipo_documento_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT tipo_documento_persona_fk FOREIGN KEY (idtipo_documento) REFERENCES public.tipo_documento(idtipo_documento);


--
-- TOC entry 3062 (class 2606 OID 31257)
-- Name: tipo_telefono_telefono_por_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_por_persona
    ADD CONSTRAINT tipo_telefono_telefono_por_persona_fk FOREIGN KEY (idtipo_telefono) REFERENCES public.tipo_telefono(idtipo_telefono);


--
-- TOC entry 3059 (class 2606 OID 31332)
-- Name: viatico_detalle_viatico_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_viatico
    ADD CONSTRAINT viatico_detalle_viatico_fk FOREIGN KEY (idviatico) REFERENCES public.viatico(idviatico);


--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-04-27 06:38:28 -03

--
-- PostgreSQL database dump complete
--

