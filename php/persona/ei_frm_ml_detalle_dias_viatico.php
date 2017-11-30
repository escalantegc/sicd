<?php
class ei_frm_ml_detalle_dias_viatico extends sicd_ei_formulario_ml
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
	
		//---- Procesamiento de EFs --------------------------------
		
		
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__cantidad_dias__procesar = function(es_inicial, fila)
		{
			dias_usados = this.total('cantidad_dias');
			total_dias = this.controlador.dep('frm').ef('cantidad_total_dias').get_estado();
			dias_reintegro = total_dias - dias_usados;
			this.controlador.dep('frm').ef('cantidad_dias_disponible').set_estado(dias_reintegro);
			this.controlador.dep('frm').ef('cantidad_dias_tomados').set_estado(dias_usados);

		}
		";
	}



}
?>