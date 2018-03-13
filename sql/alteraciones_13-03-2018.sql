
-- Function: public.contar_cargos()

-- DROP FUNCTION public.contar_cargos();

CREATE OR REPLACE FUNCTION traer_fuente_financiamiento(int)
  RETURNS text AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
