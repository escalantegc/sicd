<?php
class ei_pant_cargos extends toba_ei_pantalla
{

	function extender_objeto_js()
	{

		echo "
			//----Eventos---------------------------------------------------------------------
		{$this->objeto_js}.ini = function()
		{
			this.controlador.controlador.ocultar_boton('procesar');
			this.controlador.controlador.ocultar_boton('cancelar');
		}
		";
	}
}
?>