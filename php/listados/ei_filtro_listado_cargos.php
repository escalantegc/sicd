<?php
class ei_filtro_listado_cargos extends sicd_ei_filtro
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__idtipo_cargo__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        idtipo_cargo = this.ef('idtipo_cargo').get_estado();
                this.controlador.ajax('get_dato_filtro_idtipo_cargo', idtipo_cargo, this, this.actualizar_datos); 
		    }
		}		

		{$this->objeto_js}.evt__idtipo_hora__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        idtipo_hora = this.ef('idtipo_hora').get_estado();
                this.controlador.ajax('get_dato_filtro_idtipo_hora', idtipo_hora, this, this.actualizar_datos); 
		    }
		}
			
		
		{$this->objeto_js}.evt__identidad__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        identidad = this.ef('identidad').get_estado();
                this.controlador.ajax('get_dato_filtro_identidad', identidad, this, this.actualizar_datos); 
		    }
		}
		
		{$this->objeto_js}.evt__cantidad_horas__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        cantidad_horas = this.ef('cantidad_horas').get_estado();
                this.controlador.ajax('get_dato_filtro_cantidad_horas', cantidad_horas, this, this.actualizar_datos); 
		    }
		}
		
		{$this->objeto_js}.evt__fecha_inicio__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        fecha_inicio = this.ef('fecha_inicio').fecha();
		        inicio = fecha_inicio.getFullYear()+ '-' + fecha_inicio.getMonth()+1 +'-'+fecha_inicio.getDate();
                this.controlador.ajax('get_dato_filtro_fecha_inicio', inicio, this, this.actualizar_datos); 
		    }
		}
		
		{$this->objeto_js}.evt__fecha_fin__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        fecha_fin = this.ef('fecha_fin').fecha();
		         fin = fecha_fin.getFullYear()+ '-' + fecha_fin.getMonth()+1 +'-'+fecha_fin.getDate();
                this.controlador.ajax('get_dato_filtro_fecha_fin', fin, this, this.actualizar_datos); 
		    }
		}

		{$this->objeto_js}.actualizar_datos = function(datos)
        {                         
        }
		";
	}

}

?>