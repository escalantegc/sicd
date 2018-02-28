<?php
class ei_frm_ml_detalle_dias_viatico extends sicd_ei_formulario_ml
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		
		
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__cantidad_dias__procesar = function(es_inicial, fila)
		{
			dias_usados = this.total('cantidad_dias');
			total_dias = this.controlador.dep('frm').ef('cantidad_total_dias').get_estado();
			dias_reintegro = this.controlador.dep('frm').ef('cantidad_dias_reintegro').get_estado();
			total_dias_menos_reintegro = total_dias -dias_reintegro;
			dias_disponibles = total_dias_menos_reintegro - dias_usados;
			this.controlador.dep('frm').ef('cantidad_dias_disponible').set_estado(dias_disponibles);
			this.controlador.dep('frm').ef('cantidad_dias_tomados').set_estado(dias_usados);
		
		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__fecha_desde__procesar = function(es_inicial, fila)
		{
			var fecha_desde = this.ef('fecha_desde').ir_a_fila(fila).fecha();
			var fecha_hasta = this.ef('fecha_hasta').ir_a_fila(fila).fecha();
			if (!es_inicial)
			{
				if (fecha_desde != null)
				{
					if (fecha_hasta != null)
					{
						if(fecha_desde > fecha_hasta)
						{
							alert('La fecha desde no puede ser mayor a la fecha hasta');
							this.ef('fecha_desde').ir_a_fila(fila).resetear_estado();
							this.ef('fecha_hasta').ir_a_fila(fila).resetear_estado();
						} else {
						
							diff = fecha_hasta - fecha_desde;
							dias = diff/(1000*60*60*24) ;
							this.ef('cantidad_dias').ir_a_fila(fila).set_estado(dias);
						}
					}
				}
			}	
			
		}
		
		{$this->objeto_js}.evt__fecha_hasta__procesar = function(es_inicial, fila)
		{
			var fecha_desde = this.ef('fecha_desde').ir_a_fila(fila).fecha();
			var fecha_hasta = this.ef('fecha_hasta').ir_a_fila(fila).fecha();
			if (!es_inicial)
			{
				if (fecha_desde != null)
				{
					if (fecha_hasta != null)
					{
						if(fecha_hasta < fecha_desde)
						{
							alert('La fecha hasta no puede ser menor a la fecha desde');
							this.ef('fecha_hasta').ir_a_fila(fila).resetear_estado();
							this.ef('fecha_desde').ir_a_fila(fila).resetear_estado();
						} else {
						
							diff = fecha_hasta - fecha_desde;
							dias = diff/(1000*60*60*24) ;
							this.ef('cantidad_dias').ir_a_fila(fila).set_estado(dias);
							
						}
					}
				}
			}

		}
		";
	}




}
?>