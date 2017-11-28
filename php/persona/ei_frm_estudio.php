<?php
class ei_frm_estudio extends sicd_ei_formulario
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "

		{$this->objeto_js}.ini = function () {
			
			this.ef('obervaciones').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('obervaciones');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}


		}

		";
	}
}

?>