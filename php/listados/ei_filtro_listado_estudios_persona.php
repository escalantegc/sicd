<?php
class ei_filtro_listado_estudios_persona extends sicd_ei_filtro
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__idlocalidad__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				idlocalidad = this.ef('idlocalidad').get_estado();
				this.controlador.ajax('get_dato_filtro_idlocalidad', idlocalidad, this, this.actualizar_datos); 
			}
		}
		
		{$this->objeto_js}.evt__idnivel_estudio__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				idnivel_estudio = this.ef('idnivel_estudio').get_estado();
				this.controlador.ajax('get_dato_filtro_idnivel_estudio', idnivel_estudio, this, this.actualizar_datos); 
			}
		}
		
		{$this->objeto_js}.evt__idestudio__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				idestudio = this.ef('idestudio').get_estado();
				this.controlador.ajax('get_dato_filtro_idestudio', idestudio, this, this.actualizar_datos); 
			}
		}
		
		{$this->objeto_js}.evt__identidad__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				identidad = this.ef('identidad').get_estado();
				this.controlador.ajax('get_dato_filtro_identidad', identidad, this, this.actualizar_datos); 
			}
		}
		{$this->objeto_js}.actualizar_datos = function(datos)
		{                         
		}
		";
	}

}
?>