<?php
class ei_frm_fuente extends sicd_ei_formulario
{
	function extender_objeto_js()
	{
		echo "

		{$this->objeto_js}.ini = function () {
		

			this.ef('nombre').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('nombre');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}
			this.ef('sigla').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('sigla');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}
			

		}
	
		";
	}
}

?>