<?php
class ci_configuracion extends sicd_ci
{

		function conf()
	{
		$this->cn()->cargar_dt_configuracion(null);
	}
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
$this->cn()->guardar_dt_configuracion();

		try{
			
			toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
		
		}
	}

	function evt__cancelar()
	{
		$this->cn()->procesar();
	}

	//-----------------------------------------------------------------------------------
	//---- frm --------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm(sicd_ei_formulario $form)
	{
		$datos = $this->cn()->get_dt_configuracion();
		$form->set_datos($datos);
	}

	function evt__frm__modificacion($datos)
	{
		$this->cn()->set_dt_configuracion($datos);	
	}

}

?>