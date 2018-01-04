<?php
class ei_frm_cargo_por_persona extends sicd_ei_formulario
{2
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__tipo__procesar = function(es_inicial)
		{

			t = this.ef('tipo').get_estado();
			if (t=='cargo')
			{
				this.ef('idtipo_cargo').mostrar();
				this.ef('idtipo_hora').ocultar();
				this.ef('cantidad_horas').set_estado(21);
				this.ef('cantidad_horas').set_solo_lectura(true);
				
			} else{
				this.ef('idtipo_cargo').ocultar();
				this.ef('idtipo_hora').mostrar();
				if (!es_inicial)
				{
					this.ef('cantidad_horas').resetear_estado();
				}
				
				this.ef('cantidad_horas').set_solo_lectura(false);
			}
			
		}
		";
	}

}

?>