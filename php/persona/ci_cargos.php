<?php
class ci_cargos extends sicd_ci
{

	function get_cn()
	{
		return $this->controlador()->cn();
	}
	protected $s__where;
	protected $s__datos_filtro;

	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__nuevo()
	{
		$this->set_pantalla('pant_edicion');
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(sicd_ei_cuadro $cuadro)
	{
	
		if(isset($this->s__datos_filtro)){
			
			$datos = dao::get_listado_cargos_por_persona($this->s__where);
		}else{
			$datos = dao::get_listado_cargos_por_persona();
		}

		$cuadro->set_datos($datos);
	}

	function evt__cuadro__seleccion($seleccion)
	{

		$this->get_cn()->set_cursor_dt_cargo_por_persona($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(sicd_ei_filtro $filtro)
	{
		if(isset($this->s__datos_filtro))
		{
			$filtro->set_datos($this->s__datos_filtro);
			$this->s__where=$filtro->get_sql_where();
		}
	}

	function evt__filtro__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__datos_filtro);
	}

	//-----------------------------------------------------------------------------------
	//---- frm --------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm(sicd_ei_formulario $form)
	{
		if ($this->get_cn()->hay_cursor_dt_cargo_por_persona())
		{
			$datos = $this->get_cn()->get_dt_cargo_por_persona();
			$form->set_datos($datos);
		}
	}

	function evt__frm__modificacion($datos)
	{
		if ($this->get_cn()->hay_cursor_dt_cargo_por_persona())
		{
			$this->get_cn()->set_dt_cargo_por_persona($datos);
		} else {
			$this->get_cn()->agregar_dt_cargo_por_persona($datos);
		}
	}

}
?>