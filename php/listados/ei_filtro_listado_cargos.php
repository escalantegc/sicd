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
		        mes =  fecha_inicio.getMonth()+1;
		        inicio = fecha_inicio.getFullYear()+ '-' +mes+'-'+fecha_inicio.getDate();
		        inicio_mostrar = fecha_inicio.getDate()+'/'+mes+'/'+fecha_inicio.getFullYear();
		        this.controlador.ajax('get_dato_filtro_fecha_inicio', inicio, this, this.actualizar_datos); 
		        this.controlador.ajax('get_dato_filtro_fecha_inicio_mostrar', inicio_mostrar, this, this.actualizar_datos); 
		    }
		}
		
		{$this->objeto_js}.evt__fecha_fin__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        fecha_fin = this.ef('fecha_fin').fecha();
		        mes =  fecha_fin.getMonth()+1 ;
		        fin = fecha_fin.getFullYear()+ '-' +mes+'-'+fecha_fin.getDate();
		        fin_mostrar = fecha_fin.getDate()+'/'+mes+'/0'+fecha_fin.getFullYear()

		        this.controlador.ajax('get_dato_filtro_fecha_fin', fin, this, this.actualizar_datos); 
		        this.controlador.ajax('get_dato_filtro_fecha_fin_mostrar', fin_mostrar, this, this.actualizar_datos); 
		    }
		}
		
		{$this->objeto_js}.actualizar_datos = function(datos)
		        {                         
		        }
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__tipo__procesar = function(es_inicial)
		{
			tipo = this.ef('tipo').get_estado();
			if (!es_inicial) 
			{
		        this.controlador.ajax('get_dato_filtro_tipo', tipo, this, this.actualizar_datos);
		    }
	    	if (tipo=='nopar')
	       	{
	       		this.ef('idtipo_hora').ocultar();
	       		this.ef('idtipo_cargo').ocultar();
	       	}
	       	
	       	if (tipo=='hora')
	       	{
	       		this.ef('idtipo_hora').mostrar();
	       		this.ef('idtipo_cargo').ocultar();
	       	}
	       	if (tipo=='cargo')
	       	{
	       		this.ef('idtipo_hora').ocultar();
	       		this.ef('idtipo_cargo').mostrar();
	       	}

		}	
		{$this->objeto_js}.evt__activo__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        activo = 'false';
		        if(this.ef('activo').get_estado() ==1)
		        {
		        	activo = 'true';
		        }
		         this.controlador.ajax('get_dato_filtro_activo', activo, this, this.actualizar_datos); 
		    }

		}		

		{$this->objeto_js}.evt__historico__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        historico = 'false';
		        if(this.ef('historico').get_estado() ==1)
		        {
		        	historico = 'true';
		        }

		        this.controlador.ajax('get_dato_filtro_historico', historico, this, this.actualizar_datos); 
		    }

		}
		";
	}


}
?>