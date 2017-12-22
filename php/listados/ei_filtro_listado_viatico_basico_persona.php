<?php
class ei_filtro_listado_viatico_basico_persona extends sicd_ei_filtro
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__idlocalidad_origen__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				idlocalidad_origen = this.ef('idlocalidad_origen').get_estado();
				this.controlador.ajax('get_dato_filtro_idlocalidadorigen', idlocalidad_origen, this, this.actualizar_datos); 
			}
		}
		
		{$this->objeto_js}.evt__idlocalidad_destino__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				idlocalidad_destino = this.ef('idlocalidad_destino').get_estado();
				this.controlador.ajax('get_dato_filtro_idlocalidaddestino', idlocalidad_destino, this, this.actualizar_datos); 
			}
		}
		
		{$this->objeto_js}.evt__mes__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				mes = this.ef('mes').get_estado();
				this.controlador.ajax('get_dato_filtro_mes', mes, this, this.actualizar_datos); 
			}
		}
		{$this->objeto_js}.actualizar_datos = function(datos)
		{                         
		}
		";
	}

}
?>