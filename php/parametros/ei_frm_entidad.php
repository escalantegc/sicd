<?php
class ei_frm_entidad extends sicd_ei_formulario
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

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

			this.ef('calle').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('calle');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}
		}
		";
	}

}
?>