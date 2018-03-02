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
		
		        
		        {$this->objeto_js}.evt__mes__procesar = function(es_inicial)
		        {
		            if (!es_inicial) {
		                mes = this.ef('mes').get_estado();
		                this.controlador.ajax('get_dato_filtro_mes', mes, this, this.actualizar_datos); 
		            }
		        }        
				{$this->objeto_js}.evt__nro_expediente__procesar = function(es_inicial)
				{
					   if (!es_inicial) {
		                nro_expediente = this.ef('nro_expediente').get_estado();
		                if(nro_expediente!='')
		                {
		                	this.controlador.ajax('get_dato_filtro_nro_expediente', nro_expediente, this, this.actualizar_datos); 
		                }
		                
		            }
				}				


	
				{$this->objeto_js}.evt__cantidad_total_dias__procesar = function(es_inicial)
				{
					   if (!es_inicial) {
		                cantidad_total_dias = this.ef('cantidad_total_dias').get_estado();
		                if(cantidad_total_dias!='')
		                {
		                	this.controlador.ajax('get_dato_filtro_cantidad_total_dias', cantidad_total_dias, this, this.actualizar_datos); 
		                }
		                
		            }
				}
		   		
		   		{$this->objeto_js}.evt__cantidad_dias_disponible__procesar = function(es_inicial)
				{
					   if (!es_inicial) {
		                cantidad_dias_disponible = this.ef('cantidad_dias_disponible').get_estado();
		                if(cantidad_dias_disponible!='')
		                {
		                	this.controlador.ajax('get_dato_filtro_cantidad_dias_disponible', cantidad_dias_disponible, this, this.actualizar_datos); 
		                }
		                
		            }
				}
		    	
		    	{$this->objeto_js}.evt__cantidad_dias_tomados__procesar = function(es_inicial)
				{
					   if (!es_inicial) {
		                cantidad_dias_tomados = this.ef('cantidad_dias_tomados').get_estado();
		                if(cantidad_dias_tomados!='')
		                {
		                	this.controlador.ajax('get_dato_filtro_cantidad_dias_tomados', cantidad_dias_tomados, this, this.actualizar_datos); 
		                }
		                
		            }
				}
				{$this->objeto_js}.evt__cantidad_dias_reintegro__procesar = function(es_inicial)
				{
					   if (!es_inicial) {
		                cantidad_dias_reintegro = this.ef('cantidad_dias_reintegro').get_estado();
		                if(cantidad_dias_reintegro!='')
		                {
		                	this.controlador.ajax('get_dato_filtro_cantidad_dias_reintegro', cantidad_dias_reintegro, this, this.actualizar_datos); 
		                }
		                
		            }
				}
		    
		        {$this->objeto_js}.actualizar_datos = function(datos)
		        {                         
		        }
		        //---- Procesamiento de EFs --------------------------------
		
		
		";
	}


}
?>