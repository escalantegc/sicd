<?php
class ci_personal extends sicd_ci
{

	function get_cn()
	{
		return $this->controlador()->cn();
	}


	//-----------------------------------------------------------------------------------
	//---- frm_persona ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_persona(sicd_ei_formulario $form)
	{
		if ($this->get_cn()->hay_cursor_dt_personal())
		{
			$datos = $this->get_cn()->get_dt_personal();
			$form->set_datos($datos);
		} 
	}

	function evt__frm_persona__modificacion($datos)
	{
		if ($this->get_cn()->hay_cursor_dt_personal())
		{
			$this->get_cn()->set_dt_personal($datos);
		} else {
			$this->get_cn()->agregar_dt_personal($datos);
		}
	}

	//-----------------------------------------------------------------------------------
	//---- frm_ml_telefonos -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_ml_telefonos(sicd_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_cn()->get_dt_telefono_por_persona();
		$form_ml->set_datos($datos);
	}

	function evt__frm_ml_telefonos__modificacion($datos)
	{
		$this->get_cn()->procesar_dt_telefono_por_persona($datos);
		

	}

}

?>