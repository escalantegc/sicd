<?php
class ei_frm_cargo_por_persona extends sicd_ei_formulario
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__tipo__procesar = function(es_inicial)
		{
			if (this.ef('tipo').tiene_estado())
			{
				t = this.ef('tipo').get_estado();
				if (t=='cargo')
				{
					this.ef('idtipo_cargo').mostrar();
					this.ef('idtipo_cargo').resetear_estado();
					this.ef('idtipo_hora').ocultar();
					this.ef('cantidad_horas').set_estado(21);
					this.ef('cantidad_horas').set_solo_lectura(true);
					
				} else{
					this.ef('idtipo_cargo').ocultar();
					this.ef('idtipo_cargo').resetear_estado();
					this.ef('idtipo_hora').mostrar();
					if (!es_inicial)
					{
						this.ef('cantidad_horas').resetear_estado();
					}
					
					this.ef('cantidad_horas').set_solo_lectura(false);
				}
			} else {
					this.ef('idtipo_cargo').ocultar();
					this.ef('idtipo_hora').ocultar();
			}
			
		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__fecha_inicio__procesar = function(es_inicial)
		{
			var fecha_inicio = this.ef('fecha_inicio').fecha();
			var fecha_fin = this.ef('fecha_fin').fecha();
			if (!es_inicial)
			{
				if (fecha_inicio != null)
				{
					if (fecha_fin != null)
					{
						if(fecha_inicio > fecha_fin)
						{
							alert('La fecha inicio no puede ser mayor a la fecha fin');
							this.ef('fecha_fin').resetear_estado();
							this.ef('fecha_inicio').resetear_estado();
						} else {
						
							diff = fecha_fin - fecha_inicio;
							dias = diff/(1000*60*60*24) ;
							this.ef('cantidad_dias').set_estado(dias);
						}
					}
				}
			}	
		}
		
		{$this->objeto_js}.evt__fecha_fin__procesar = function(es_inicial)
		{
			var fecha_inicio = this.ef('fecha_inicio').fecha();
			var fecha_fin = this.ef('fecha_fin').fecha();
			if (!es_inicial)
			{
				if (fecha_inicio != null)
				{
					if (fecha_fin != null)
					{
						if(fecha_fin < fecha_inicio)
						{
							alert('La fecha fin no puede ser menor a la fecha inicio');
							this.ef('fecha_fin').resetear_estado();
							this.ef('fecha_inicio').resetear_estado();
						} else {
						
							diff = fecha_fin - fecha_inicio;
							dias = diff/(1000*60*60*24) ;
							this.ef('cantidad_dias').set_estado(dias);
						}
					}
				}
			}	
		}
		";
	}


}
?>