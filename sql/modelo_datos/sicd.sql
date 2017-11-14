
CREATE TABLE public.nivel_estudio (
                idnivel_estudio INTEGER NOT NULL,
                descripcion VARCHAR(50) NOT NULL,
                maximo_horas DOUBLE PRECISION NOT NULL,
                CONSTRAINT idnivel_estudio PRIMARY KEY (idnivel_estudio)
);


CREATE TABLE public.configuracion (
                cantidas_dias_viatico INTEGER NOT NULL
);


CREATE SEQUENCE public.tipo_detalle_viatico_idtipo_detalle_viatico_seq;

CREATE TABLE public.tipo_detalle_viatico (
                idtipo_detalle_viatico INTEGER NOT NULL DEFAULT nextval('public.tipo_detalle_viatico_idtipo_detalle_viatico_seq'),
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idtipo_detalle_viatico PRIMARY KEY (idtipo_detalle_viatico)
);


ALTER SEQUENCE public.tipo_detalle_viatico_idtipo_detalle_viatico_seq OWNED BY public.tipo_detalle_viatico.idtipo_detalle_viatico;

CREATE SEQUENCE public.funcion_idfuncion_seq;

CREATE TABLE public.funcion (
                idfuncion INTEGER NOT NULL DEFAULT nextval('public.funcion_idfuncion_seq'),
                descripcion VARCHAR(50) NOT NULL,
                maximo_horas NUMERIC NOT NULL,
                cantidad_permitida INTEGER NOT NULL,
                CONSTRAINT idfuncion PRIMARY KEY (idfuncion)
);


ALTER SEQUENCE public.funcion_idfuncion_seq OWNED BY public.funcion.idfuncion;

CREATE SEQUENCE public.tipo_telefono_idtipo_telefono_seq;

CREATE TABLE public.tipo_telefono (
                idtipo_telefono INTEGER NOT NULL DEFAULT nextval('public.tipo_telefono_idtipo_telefono_seq'),
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idtipo_telefono PRIMARY KEY (idtipo_telefono)
);


ALTER SEQUENCE public.tipo_telefono_idtipo_telefono_seq OWNED BY public.tipo_telefono.idtipo_telefono;

CREATE SEQUENCE public.pais_idpais_seq;

CREATE TABLE public.pais (
                idpais INTEGER NOT NULL DEFAULT nextval('public.pais_idpais_seq'),
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idpais PRIMARY KEY (idpais)
);


ALTER SEQUENCE public.pais_idpais_seq OWNED BY public.pais.idpais;

CREATE SEQUENCE public.provincia_idprovincia_seq;

CREATE TABLE public.provincia (
                idprovincia INTEGER NOT NULL DEFAULT nextval('public.provincia_idprovincia_seq'),
                idpais INTEGER NOT NULL,
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idprovincia PRIMARY KEY (idprovincia)
);


ALTER SEQUENCE public.provincia_idprovincia_seq OWNED BY public.provincia.idprovincia;

CREATE SEQUENCE public.localidad_idlocalidad_seq_1;

CREATE TABLE public.localidad (
                idlocalidad INTEGER NOT NULL DEFAULT nextval('public.localidad_idlocalidad_seq_1'),
                idprovincia INTEGER NOT NULL,
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idlocalidad PRIMARY KEY (idlocalidad)
);


ALTER SEQUENCE public.localidad_idlocalidad_seq_1 OWNED BY public.localidad.idlocalidad;

CREATE TABLE public.entidad (
                identidad INTEGER NOT NULL,
                sigla VARCHAR(10),
                nombre VARCHAR(100) NOT NULL,
                idlocalidad INTEGER NOT NULL,
                calle VARCHAR(50),
                altura INTEGER,
                piso VARCHAR(2),
                depto VARCHAR(2),
                CONSTRAINT identidad PRIMARY KEY (identidad)
);


CREATE SEQUENCE public.estado_civil_idestado_civil_seq_1;

CREATE TABLE public.estado_civil (
                idestado_civil INTEGER NOT NULL DEFAULT nextval('public.estado_civil_idestado_civil_seq_1'),
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idestado_civil PRIMARY KEY (idestado_civil)
);


ALTER SEQUENCE public.estado_civil_idestado_civil_seq_1 OWNED BY public.estado_civil.idestado_civil;

CREATE SEQUENCE public.tipo_cargo_idtipo_cargo_seq;

CREATE TABLE public.tipo_cargo (
                idtipo_cargo INTEGER NOT NULL DEFAULT nextval('public.tipo_cargo_idtipo_cargo_seq'),
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idtipo_cargo PRIMARY KEY (idtipo_cargo)
);


ALTER SEQUENCE public.tipo_cargo_idtipo_cargo_seq OWNED BY public.tipo_cargo.idtipo_cargo;

CREATE SEQUENCE public.tipo_documento_idtipo_documento_seq_1;

CREATE TABLE public.tipo_documento (
                idtipo_documento INTEGER NOT NULL DEFAULT nextval('public.tipo_documento_idtipo_documento_seq_1'),
                sigla VARCHAR(10) NOT NULL,
                descripcion VARCHAR(50) NOT NULL,
                CONSTRAINT idtipo_documento PRIMARY KEY (idtipo_documento)
);


ALTER SEQUENCE public.tipo_documento_idtipo_documento_seq_1 OWNED BY public.tipo_documento.idtipo_documento;

CREATE SEQUENCE public.persona_idpersona_seq;

CREATE TABLE public.persona (
                idpersona INTEGER NOT NULL DEFAULT nextval('public.persona_idpersona_seq'),
                nombres VARCHAR(100) NOT NULL,
                apellido VARCHAR(50) NOT NULL,
                idtipo_documento INTEGER NOT NULL,
                nro_documento INTEGER NOT NULL,
                matricula VARCHAR(20) NOT NULL,
                idestado_civil INTEGER NOT NULL,
                cuil VARCHAR(11) NOT NULL,
                correo VARCHAR(100),
                fecha_nacimiento DATE,
                sexo VARCHAR(1) NOT NULL,
                idlocalidad INTEGER NOT NULL,
                calle VARCHAR(50) NOT NULL,
                altura VARCHAR(5) NOT NULL,
                depto VARCHAR(4),
                piso VARCHAR(2),
                domicilio VARCHAR(100),
                matricula_activa BOOLEAN DEFAULT true NOT NULL,
                fecha_baja_matricula DATE,
                CONSTRAINT id_persona PRIMARY KEY (idpersona)
);


ALTER SEQUENCE public.persona_idpersona_seq OWNED BY public.persona.idpersona;

CREATE UNIQUE INDEX persona_idx
 ON public.persona
 ( idtipo_documento, nro_documento );

CREATE SEQUENCE public.viatico_idviatico_seq;

CREATE TABLE public.viatico (
                idviatico VARCHAR NOT NULL DEFAULT nextval('public.viatico_idviatico_seq'),
                fecha_desde DATE,
                nro_expediente VARCHAR(10) NOT NULL,
                fecha_hasta DATE,
                idpersona INTEGER NOT NULL,
                idlocalidad_origen INTEGER,
                idlocalidad_destino INTEGER,
                CONSTRAINT idviatico PRIMARY KEY (idviatico)
);


ALTER SEQUENCE public.viatico_idviatico_seq OWNED BY public.viatico.idviatico;

CREATE SEQUENCE public.detalle_viatico_iddetalle_viatico_seq;

CREATE TABLE public.detalle_viatico (
                iddetalle_viatico INTEGER NOT NULL DEFAULT nextval('public.detalle_viatico_iddetalle_viatico_seq'),
                idviatico VARCHAR NOT NULL,
                monto DOUBLE PRECISION NOT NULL,
                descripcion VARCHAR(50),
                idtipo_detalle_viatico INTEGER NOT NULL,
                CONSTRAINT detalle_viatico PRIMARY KEY (iddetalle_viatico)
);


ALTER SEQUENCE public.detalle_viatico_iddetalle_viatico_seq OWNED BY public.detalle_viatico.iddetalle_viatico;

CREATE TABLE public.telefono_por_persona (
                idtipo_telefono INTEGER NOT NULL,
                idpersona INTEGER NOT NULL,
                numero VARCHAR(15) NOT NULL,
                CONSTRAINT telefono_por_persona PRIMARY KEY (idtipo_telefono, idpersona)
);


CREATE TABLE public.cargo_por_persona (
                idpersona INTEGER NOT NULL,
                idfuncion INTEGER NOT NULL,
                identidad INTEGER NOT NULL,
                idtipo_cargo INTEGER NOT NULL,
                idnivel_estudio INTEGER NOT NULL,
                cantidad_horas DOUBLE PRECISION NOT NULL,
                fecha_inicio DATE,
                fecha_fin VARCHAR,
                activo BOOLEAN DEFAULT true NOT NULL,
                CONSTRAINT cargo_por_persona PRIMARY KEY (idpersona, idfuncion, identidad, idtipo_cargo)
);


ALTER TABLE public.cargo_por_persona ADD CONSTRAINT nivel_estudio_cargo_por_persona_fk
FOREIGN KEY (idnivel_estudio)
REFERENCES public.nivel_estudio (idnivel_estudio)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.detalle_viatico ADD CONSTRAINT tipo_detalle_viatico_detalle_viatico_fk
FOREIGN KEY (idtipo_detalle_viatico)
REFERENCES public.tipo_detalle_viatico (idtipo_detalle_viatico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cargo_por_persona ADD CONSTRAINT funcion_cargo_por_persona_fk
FOREIGN KEY (idfuncion)
REFERENCES public.funcion (idfuncion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.telefono_por_persona ADD CONSTRAINT tipo_telefono_telefono_por_persona_fk
FOREIGN KEY (idtipo_telefono)
REFERENCES public.tipo_telefono (idtipo_telefono)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.provincia ADD CONSTRAINT pais_provincia_fk
FOREIGN KEY (idpais)
REFERENCES public.pais (idpais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localidad ADD CONSTRAINT provincia_localidad_fk
FOREIGN KEY (idprovincia)
REFERENCES public.provincia (idprovincia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.persona ADD CONSTRAINT localidad_persona_fk
FOREIGN KEY (idlocalidad)
REFERENCES public.localidad (idlocalidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.viatico ADD CONSTRAINT localidad_viatico_fk
FOREIGN KEY (idlocalidad_origen)
REFERENCES public.localidad (idlocalidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.viatico ADD CONSTRAINT localidad_viatico_fk1
FOREIGN KEY (idlocalidad_destino)
REFERENCES public.localidad (idlocalidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.entidad ADD CONSTRAINT localidad_entidad_fk
FOREIGN KEY (idlocalidad)
REFERENCES public.localidad (idlocalidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cargo_por_persona ADD CONSTRAINT entidad_cargo_por_persona_fk
FOREIGN KEY (identidad)
REFERENCES public.entidad (identidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.persona ADD CONSTRAINT estado_civil_persona_fk
FOREIGN KEY (idestado_civil)
REFERENCES public.estado_civil (idestado_civil)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cargo_por_persona ADD CONSTRAINT tipo_cargo_cargo_por_persona_fk
FOREIGN KEY (idtipo_cargo)
REFERENCES public.tipo_cargo (idtipo_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.persona ADD CONSTRAINT tipo_documento_persona_fk
FOREIGN KEY (idtipo_documento)
REFERENCES public.tipo_documento (idtipo_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cargo_por_persona ADD CONSTRAINT persona_cargo_por_persona_fk
FOREIGN KEY (idpersona)
REFERENCES public.persona (idpersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.telefono_por_persona ADD CONSTRAINT persona_telefono_por_persona_fk
FOREIGN KEY (idpersona)
REFERENCES public.persona (idpersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.viatico ADD CONSTRAINT persona_viatico_fk
FOREIGN KEY (idpersona)
REFERENCES public.persona (idpersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.detalle_viatico ADD CONSTRAINT viatico_detalle_viatico_fk
FOREIGN KEY (idviatico)
REFERENCES public.viatico (idviatico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
