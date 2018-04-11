-- Function: public.sumar_horas(integer)

-- DROP FUNCTION public.sumar_horas(integer);

CREATE OR REPLACE FUNCTION public.sumar_horas(integer,character)
  RETURNS numeric AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sumar_horas(integer)
  OWNER TO postgres;

-- Function: public.sumas_horas_segun_tipo(integer, integer)

-- DROP FUNCTION public.sumas_horas_segun_tipo(integer, integer);

CREATE OR REPLACE FUNCTION public.sumas_horas_segun_tipo(
    integer,
    integer,
    character)
  RETURNS numeric AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sumas_horas_segun_tipo(integer, integer)
  OWNER TO postgres;


ALTER TABLE public.configuracion ADD COLUMN cantidad_max_cargos_bloque integer;
