<?php
class ei_frm_viatico extends sicd_ei_formulario
{
	

	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Validacion de EFs -----------------------------------
		
		{$this->objeto_js}.evt__cantidad_dias_reintegro__validar = function()
		{
			cantidad = this.ef('cantidad_dias_disponible').get_estado();
			
			if (cantidad=<-1)
			{
				return false;
			} else (
				return true;
			)

		}
		";
	}

}
?>