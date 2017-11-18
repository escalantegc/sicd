<?php
require_once('dao.php');
class ci_entidad extends sicd_ci
{
	protected $s__where;
	protected $s__datos_filtro;
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		try{
			$this->cn()->guardar_dr_parametros();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			
			if($sql_state=='db_23503')
			{
				toba::notificacion()->agregar("La entidad esta siendo referenciada, no puede eliminarla",'error');
				
			} 
			$mensaje_log= $error->get_mensaje_log();
			if(strstr($mensaje_log,'entidad_nombre_idx'))
			{
				toba::notificacion()->agregar("El nombre de la entidad ya esta registrado.",'info');
				
			} 			

			if(strstr($mensaje_log,'entidad_sigla_idx'))
			{
				toba::notificacion()->agregar("La sigla de la entidad ya esta registrada.",'info');
				
			} 
			
		}
		$this->cn()->resetear_dr_parametros();
		$this->set_pantalla('pant_inicial');
	}

	function evt__cancelar()
	{
		$this->cn()->resetear_dr_parametros();
		$this->set_pantalla('pant_inicial');
	}

	function evt__nuevo()
	{
		$this->set_pantalla('pant_edicion');
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(sicd_ei_cuadro $cuadro)
	{
		if(isset($this->s__datos_filtro))
		{
			
			$datos = dao::get_listado_entidades($this->s__where);
		}else{
			$datos = dao::get_listado_entidades();
		}

		$cuadro->set_datos($datos);
	}

	function evt__cuadro__seleccion($seleccion)
	{
		$this->cn()->cargar_dt_entidad($seleccion);
		$this->cn()->set_cursor_dt_entidad($seleccion);
		$this->set_pantalla('pant_edicion');
	}

	function evt__cuadro__borrar($seleccion)
	{
		$this->cn()->cargar_dt_entidad($seleccion);
		$this->cn()->eliminar_dt_entidad($seleccion);
		try{
			$this->cn()->guardar_dr_parametros();
				toba::notificacion()->agregar("Los datos se han borrado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503')
			{
				toba::notificacion()->agregar("El titulo esta siendo referenciado, no puede eliminarlo",'error');
				
			} 		
		}
		$this->cn()->resetear_dr_parametros();
		$this->set_pantalla('pant_inicial');
	}

	//-----------------------------------------------------------------------------------
	//---- filto ------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filto(sicd_ei_filtro $filtro)
	{
		if(isset($this->s__datos_filtro))
		{
			$filtro->set_datos($this->s__datos_filtro);
			$this->s__where=$filtro->get_sql_where();
		}
	}

	function evt__filto__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__filto__cancelar()
	{
		unset($this->s__datos_filtro);
	}

	//-----------------------------------------------------------------------------------
	//---- frm --------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm(sicd_ei_formulario $form)
	{
		if ($this->cn()->hay_cursor_dt_entidad())
		{
			$datos = $this->cn()->get_dt_entidad();
			$form->set_datos($datos);
		}
	}

	function evt__frm__modificacion($datos)
	{
		if ($this->cn()->hay_cursor_dt_entidad())
		{
			$this->cn()->set_dt_entidad($datos);
		} else {
			$this->cn()->agregar_dt_entidad($datos);
		}
	}

}

?>