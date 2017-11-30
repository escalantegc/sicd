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
			dias_disponible = this.ef('cantidad_dias_disponible').get_estado();
		
			if (dias_reintegro > dias_disponible)
			{
				alert('No puede reintegrar mas dias de los que tiene disponibles');
				this.ef('cantidad_dias_reintegro').set_estado(0);
			} else {
				dif = dias_disponible -dias_reintegro;
				this.ef('cantidad_dias_disponible').set_estado(dif)
			}
		
		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__cantidad_total_dias__procesar = function(es_inicial)
		{
			total_dias =  this.ef('cantidad_total_dias').get_estado();
			this.ef('cantidad_dias_disponible').set_estado(total_diaso);
		}
		";
	}



}
?>