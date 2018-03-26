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
			
			idpersona = this.ef('idpersona').get_estado();
			if (idpersona!='')
			{	
				this.mostrar_boton('filtrar');
				this.controlador.ajax('get_dato_filtro_idpersona', idpersona, this, this.actualizar_datos); 	
			} else {
				this.ocultar_boton('filtrar');
			}
				
			

			
		}
		
		{$this->objeto_js}.evt__cargos__procesar = function(es_inicial)
		{
			if (this.ef('cargos').get_estado()==1) {
				cargos = 'cargos';
			} else {
				cargos = '-';
			}
			this.controlador.ajax('get_dato_filtro_cargos', cargos, this, this.actualizar_datos);
		
		}
		
		{$this->objeto_js}.evt__viaticos__procesar = function(es_inicial)
		{
			if (this.ef('viaticos').get_estado()==1) {
				viaticos = 'viaticos';
			} else {
				viaticos = '-';
			}
			this.controlador.ajax('get_dato_filtro_viaticos', viaticos, this, this.actualizar_datos);
		}
		
		{$this->objeto_js}.evt__estudios__procesar = function(es_inicial)
		{
			if (this.ef('estudios').get_estado()==1) {
				estudios = 'estudios';
			} else {
				estudios = '-';
			}
			this.controlador.ajax('get_dato_filtro_estudios', estudios, this, this.actualizar_datos);
		}
		
		{$this->objeto_js}.actualizar_datos = function(datos)
		{                         
		}
		

		";
	}



}
?>