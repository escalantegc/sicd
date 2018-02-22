<?php
class ei_filtro_legajo extends sicd_ei_filtro
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__idpersona__procesar = function(es_inicial)
		{
			if (!es_inicial) {
				idpersona = this.ef('idpersona').get_estado();
				
				this.controlador.ajax('get_dato_filtro_idpersona', idpersona, this, this.actualizar_datos); 
			}
		}
		{$this->objeto_js}.actualizar_datos = function(datos)
		{                         
		}
		";
	}

}
?>