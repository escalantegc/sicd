<?php
class ei_frm_persona extends sicd_ei_formulario
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "

		{$this->objeto_js}.ini = function () {
			this.ef('apellido').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('apellido');
				var apellido = ef.get_estado().toUpperCase();
				var apellido_comprobado = apellido.match(/[a-z\s\'\u00d1]/gi);
				var cadena = apellido_comprobado.toString();
				while(cadena.indexOf(',') >= 0){
					cadena = cadena.replace(',','');
				}
				ef.set_estado(cadena);
			}
		
			this.ef('nombres').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('nombres');
				var nombre = ef.get_estado().toUpperCase();
				var nombre_comprobado = nombre.match(/[a-z\s\'\u00d1]/gi);
				var cadena = nombre_comprobado.toString();
				while(cadena.indexOf(',') >= 0){
					cadena = cadena.replace(',','');
				}
				ef.set_estado(cadena);
			}			

			this.ef('calle').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('calle');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}
			this.ef('domicilio').input().onchange = function() {
				var ef = {$this->objeto_js}.ef('domicilio');
				var cadena = ef.get_estado().toUpperCase();
			
				ef.set_estado(cadena);
			}
			

		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__fecha_nacimiento__procesar = function(es_inicial)
		{
			var fecha = new Date();

			if (this.ef('fecha_nacimiento').tiene_estado())
			{
				this.ef('edad').set_estado(this.ef('fecha_nacimiento').calcular_edad(fecha));	
			} else {
				this.ef('edad').resetear_estado();
			}
			
		}
		";
	}

}

?>