

CREATE OR REPLACE FUNCTION cargos_de_una_persona (int)
RETURNS text AS
$BODY$
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
$BODY$ LANGUAGE 'plpgsql'



-- Table: public.fuente_financiamiento

-- DROP TABLE public.fuente_financiamiento;

CREATE TABLE public.fuente_financiamiento
(
  idfuente_financiamiento serial NOT NULL ),
  sigla character(10),
  nombre character(300) NOT NULL,
  CONSTRAINT fuente_financiamiento_pkey PRIMARY KEY (idfuente_financiamiento)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.fuente_financiamiento
  OWNER TO postgres;

  CREATE UNIQUE INDEX fuente_financiamiento_nombre_idx
  ON public.fuente_financiamiento
  USING btree
  (nombre COLLATE pg_catalog."default");



ALTER TABLE public.cargo_por_persona ADD COLUMN idfuente_financiamiento integer;
ALTER TABLE public.cargo_por_persona ADD COLUMN monto double precision;




