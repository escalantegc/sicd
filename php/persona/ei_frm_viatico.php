<?php
class ei_frm_viatico extends sicd_ei_formulario
{
	

	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
			
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__cantidad_dias_reintegro__procesar = function(es_inicial)
		{
			dias_reintegro = this.ef('cantidad_dias_reintegro').get_estado();
			dias_disponible = this.ef('cantidad_total_dias').get_estado();
			dias_usados = this.controlador.dep('frm_ml_detalle_dias_viatico').total('cantidad_dias');
			dias_disponibles_menos_usados = dias_disponible - dias_usados;
			
			if (dias_reintegro > dias_disponibles_menos_usados)
			{
				alert('No puede reintegrar mas dias de los que tiene disponibles');
				this.ef('cantidad_dias_reintegro').set_estado(0);
			} else {

	
				dif = dias_disponibles_menos_usados - dias_reintegro;
				this.ef('cantidad_dias_disponible').set_estado(dif)
			}
		
		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__cantidad_total_dias__procesar = function(es_inicial)
		{
			total_dias =  this.ef('cantidad_total_dias').get_estado();
			this.ef('cantidad_dias_disponible').set_estado(total_dias);
		}
		";
	}



}
?>