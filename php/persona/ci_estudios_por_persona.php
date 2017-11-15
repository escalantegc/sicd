<?php
class ci_estudios_por_persona extends sicd_ci
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
	function evt__volver()
	{
		$this->get_cn()->resetear_cursor_dt_estudio_por_persona();
		$this->set_pantalla('pant_inicial');
	}
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(sicd_ei_cuadro $cuadro)
	{
		$datos = $this->get_cn()->get_dt_personal();
		$where='estudio_por_persona.idpersona ='.$datos['idpersona'];
		
		if(isset($this->s__datos_filtro))
		{
			$this->s__where.=' and ' .$where;
			$datos = dao::get_listado_estudios_por_persona($this->s__where);
		}else{
			$datos = dao::get_listado_estudios_por_persona($where);
		}

		$cuadro->set_datos($datos);
	}

	function evt__cuadro__seleccion($seleccion)
	{
		$this->get_cn()->set_cursor_dt_estudio_por_persona($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__borrar($seleccion)
	{

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
		if ($this->get_cn()->hay_cursor_dt_estudio_por_persona())
		{
			$datos = $this->get_cn()->get_dt_estudio_por_persona();
			$form->set_datos($datos);
		}
	}

	function evt__frm__modificacion($datos)
	{
		if ($this->get_cn()->hay_cursor_dt_estudio_por_persona())
		{
			$this->get_cn()->set_dt_estudio_por_persona($datos);
		} else {
			$this->get_cn()->agregar_dt_estudio_por_persona($datos);
		}
	}



}
?>