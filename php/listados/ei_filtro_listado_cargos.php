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
		        
		        if (fecha_inicio!=null)
		        {
			        mes =  fecha_inicio.getMonth()+1;
			        dia = fecha_inicio.getDate();
			        if(mes < 10)
			        {
			        	mes = '0' + mes;
			        }
			        if (dia < 10)
			        {
			        	dia = '0' + dia;
			        }
		
			        inicio = fecha_inicio.getFullYear()+ '-' +mes+'-'+dia;
			       
			        inicio_mostrar = dia+'/'+mes+'/'+fecha_inicio.getFullYear();
			        this.controlador.ajax('get_dato_filtro_fecha_inicio', inicio, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_inicio_mostrar', inicio_mostrar, this, this.actualizar_datos); 
		        } else {
		
			        
			        inicio_mostrar = '';
			        inicio = '';
			        this.controlador.ajax('get_dato_filtro_fecha_inicio', inicio, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_inicio_mostrar', inicio_mostrar, this, this.actualizar_datos); 
		        }
		
		    }
		}
		{$this->objeto_js}.evt__fecha_inicio_hasta__procesar = function(es_inicial)
		{

			if (!es_inicial) 
			{
		        fecha_inicio_hasta = this.ef('fecha_inicio_hasta').fecha();
		       
		        if (fecha_inicio_hasta!=null)
		        {
			        mes =  fecha_inicio_hasta.getMonth()+1;
			        dia = fecha_inicio_hasta.getDate();
			        if(mes < 10)
			        {
			        	mes = '0' + mes;
			        }
			        if (dia < 10)
			        {
			        	dia = '0' + dia;
			        }
		
			        inicio = fecha_inicio_hasta.getFullYear()+ '-' +mes+'-'+dia;
			       
			        inicio_mostrar = dia+'/'+mes+'/'+fecha_inicio_hasta.getFullYear();
			        this.controlador.ajax('get_dato_filtro_fecha_inicio_hasta', inicio, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_inicio_mostrar_hasta', inicio_mostrar, this, this.actualizar_datos); 
		        } else {
		
			        
			        inicio_mostrar = '';
			        inicio = '';
			        this.controlador.ajax('get_dato_filtro_fecha_inicio_hasta', inicio, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_inicio_mostrar_hasta', inicio_mostrar, this, this.actualizar_datos); 
		        }
		
		    }
		}
		
		{$this->objeto_js}.evt__fecha_fin__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        fecha_fin = this.ef('fecha_fin').fecha();
		        if (fecha_fin!=null)
		        {
			        mes =  fecha_fin.getMonth()+1;
			        dia = fecha_fin.getDate();
			        if(mes < 10)
			        {
			        	mes = '0' + mes;
			        }
			        if (dia < 10)
			        {
			        	dia = '0' + dia;
			        }
			        fin = fecha_fin.getFullYear()+ '-' +mes+'-'+dia;
			        fin_mostrar = dia+'/'+mes+'/'+fecha_fin.getFullYear();
			        this.controlador.ajax('get_dato_filtro_fecha_fin', fin, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_fin_mostrar', fin_mostrar, this, this.actualizar_datos); 
		        } else {
			        
			        fin_mostrar = '';
			        fin = '';
			        this.controlador.ajax('get_dato_filtro_fecha_fin', fin, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_fin_mostrar', fin_mostrar, this, this.actualizar_datos); 
		        }
		
		    }
		}		

		{$this->objeto_js}.evt__fecha_fin_hasta__procesar = function(es_inicial)
		{
			if (!es_inicial) 
			{
		        fecha_fin_hasta = this.ef('fecha_fin_hasta').fecha();
		        if (fecha_fin_hasta!=null)
		        {
			        mes =  fecha_fin_hasta.getMonth()+1;
			        dia = fecha_fin_hasta.getDate();
			        if(mes < 10)
			        {
			        	mes = '0' + mes;
			        }
			        if (dia < 10)
			        {
			        	dia = '0' + dia;
			        }
			        fin = fecha_fin_hasta.getFullYear()+ '-' +mes+'-'+dia;
			        fin_mostrar_hasta = dia+'/'+mes+'/'+fecha_fin_hasta.getFullYear();
			        this.controlador.ajax('get_dato_filtro_fecha_fin_hasta', fin, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_fin_mostrar_hasta', fin_mostrar_hasta, this, this.actualizar_datos); 
		        } else {
			        
			        fin_mostrar_hasta = '';
			        fin = '';
			      	this.controlador.ajax('get_dato_filtro_fecha_fin_hasta', fin, this, this.actualizar_datos); 
			        this.controlador.ajax('get_dato_filtro_fecha_fin_mostrar_hasta', fin_mostrar_hasta, this, this.actualizar_datos); 
		        }
		
		    }
		}
		
		{$this->objeto_js}.actualizar_datos = function(datos)
		        {                         
		        }
		//---- Procesamiento de EFs --------------------------------
		
		
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
		//---- Validacion de EFs -----------------------------------
		
		{$this->objeto_js}.evt__idtipo_cargo__validar = function()
		{
			if (this.ef('idtipo_cargo').get_estado()!='nopar')
			{
				this.ef('idtipo_hora').ocultar();	
			} else {
				this.ef('idtipo_hora').mostrar();
			}
		}
		
		{$this->objeto_js}.evt__idtipo_hora__validar = function()
		{
			if (this.ef('idtipo_hora').get_estado()!='nopar')
			{
				this.ef('idtipo_cargo').ocultar();	
			} else {
				this.ef('idtipo_cargo').mostrar();
			}
		}
		";
	}



}
?>