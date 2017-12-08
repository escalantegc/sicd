<?php
class ei_frm_tipo_documento extends sicd_ei_formulario
{
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		{$this->objeto_js}.ini = function () {
		

			this.ef('sigla').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('sigla');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}			

			this.ef('descripcion').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('descripcion');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}

		}
	
		";
	}
}

?>