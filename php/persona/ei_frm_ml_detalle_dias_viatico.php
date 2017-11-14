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
		
		{$this->objeto_js}.evt__fecha_desde__procesar = function(es_inicial, fila)
		{
			fecha_desde = this.ef('fecha_desde').ir_a_fila(fila).fecha();
			fecha_hasta = this.ef('fecha_hasta').ir_a_fila(fila).fecha();
		
			if (fecha_desde!=null)
			{
				if (fecha_hasta!=null)
				{
					dif = fecha_hasta - fecha_desde;
					this.ef('cantidad_dias').ir_a_fila(fila).set_estado(dif/(1000*60*60*24)+1);
					
					dias_usados = this.total('cantidad_dias');
					total_dias = this.controlador.dep('frm').ef('cantidad_total_dias').get_estado();
					dias_reintegro = total_dias - dias_usados;
					this.controlador.dep('frm').ef('cantidad_dias_reintegro').set_estado(dias_reintegro);
				}
			}
		
			
		}
		
		{$this->objeto_js}.evt__fecha_hasta__procesar = function(es_inicial, fila)
		{
			fecha_desde = this.ef('fecha_desde').ir_a_fila(fila).fecha();
			fecha_hasta = this.ef('fecha_hasta').ir_a_fila(fila).fecha();
		
			if (fecha_desde!=null)
			{
				if (fecha_hasta!=null)
				{
					dif = fecha_hasta - fecha_desde;
					this.ef('cantidad_dias').ir_a_fila(fila).set_estado(dif/(1000*60*60*24)+1);
				
					dias_usados = this.total('cantidad_dias');
					total_dias = this.controlador.dep('frm').ef('cantidad_total_dias').get_estado();
					dias_reintegro = total_dias - dias_usados;
					this.controlador.dep('frm').ef('cantidad_dias_reintegro').set_estado(dias_reintegro);
				}
			}
		}
		//---- Procesamiento de EFs --------------------------------
		

		";
	}


}
?>