<?php
require_once('persona/ei_cuadro_cargos_salida_html.php');
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
		
	}
	function evt__volver()
	{
		$this->get_cn()->resetear_cursor_dt_cargo_por_persona();
		$this->set_pantalla('pant_inicial');
	}
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(sicd_ei_cuadro $cuadro)
	{
		$cuadro->set_manejador_salida('html', 'ei_cuadro_cargos_salida_html');
		$datos = $this->get_cn()->get_dt_personal();
		$where = ' cargo_por_persona.idpersona ='.$datos['idpersona'];
	
		if(isset($this->s__datos_filtro)){
			$where = $where. ' and '. $this->s__where;

			$datos = dao::get_listado_cargos_por_persona($where);
		}else{
			$datos = dao::get_listado_cargos_por_persona($where);
		}

		$cuadro->set_datos($datos);
	}

	function evt__cuadro__seleccion($seleccion)
	{

		$this->get_cn()->set_cursor_dt_cargo_por_persona($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__borrar($seleccion)
	{
		$this->get_cn()->eliminar_dt_cargo_por_persona($seleccion);

		try{
			$this->get_cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("El cargo esta siendo referenciado, no puede eliminarlo",'error');
				
			}else{
				throw $error;
			}
		}
	}
	function evt__cuadro__nuevo($datos)
	{
		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__historico($seleccion)
	{
		$this->get_cn()->set_cursor_dt_cargo_por_persona($seleccion);
		if ($this->get_cn()->hay_cursor_dt_cargo_por_persona())
		{
			$datos['historico'] = true;
			$this->get_cn()->set_dt_cargo_por_persona($datos);

		} 

		try{
			$this->get_cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("El cargo esta siendo referenciado, no puede eliminarlo",'error');
				
			}else{
				throw $error;
			}
		}
					$this->get_cn()->resetear_cursor_dt_cargo_por_persona();
		$this->set_pantalla('pant_inicial');
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
		$this->get_cn()->resetear_cursor_dt_cargo_por_persona();
		$this->set_pantalla('pant_inicial');
	}





	//-----------------------------------------------------------------------------------
	//---- cuadro_historico -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_historico(sicd_ei_cuadro $cuadro)
	{
		$this->dep('cuadro_historico')->colapsar();
		$datos = $this->get_cn()->get_dt_personal();
		$where = ' cargo_por_persona.idpersona ='.$datos['idpersona'];
		$datos = dao::get_listado_cargos_por_persona_historico($where);
		$cuadro->set_datos($datos);
		
	}

	function evt__cuadro_historico__seleccion($seleccion)
	{
		$this->get_cn()->set_cursor_dt_cargo_por_persona($seleccion);
		$this->set_pantalla('pant_visualizar');
	}

	function evt__cuadro_historico__borrar($seleccion)
	{
			$this->get_cn()->eliminar_dt_cargo_por_persona($seleccion);

		try{
			$this->get_cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("El cargo esta siendo referenciado, no puede eliminarlo",'error');
				
			}else{
				throw $error;
			}
		}
	}

	function evt__cuadro_historico__quitar_historico($seleccion)
	{
		$this->get_cn()->set_cursor_dt_cargo_por_persona($seleccion);
		if ($this->get_cn()->hay_cursor_dt_cargo_por_persona())
		{
			$datos['historico'] = false;
			$this->get_cn()->set_dt_cargo_por_persona($datos);

		} 

		try{
			$this->get_cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("El cargo esta siendo referenciado, no puede eliminarlo",'error');
				
			}else{
				throw $error;
			}
		}
		$this->get_cn()->resetear_cursor_dt_cargo_por_persona();
		$this->set_pantalla('pant_inicial');
	}




	//-----------------------------------------------------------------------------------
	//---- frm_visualizar ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_visualizar(ei_frm_cargo_por_persona $form)
	{
		if ($this->get_cn()->hay_cursor_dt_cargo_por_persona())
		{
			$datos = $this->get_cn()->get_dt_cargo_por_persona();
			$form->set_datos($datos);
		}
	}

}
?>