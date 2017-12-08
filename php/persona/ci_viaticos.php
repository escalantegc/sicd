<?php
require_once('persona/ei_cuadro_viaticos_salida_html.php');
class ci_viaticos extends sicd_ci
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
		$this->get_cn()->resetear_cursor_dt_viatico();
		$this->set_pantalla('pant_inicial');
	}
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(sicd_ei_cuadro $cuadro)
	{
		$cuadro->set_manejador_salida('html', 'ei_cuadro_viaticos_salida_html');

		$datos = $this->get_cn()->get_dt_personal();
		$where='viatico.idpersona ='.$datos['idpersona'];
		
	
		if(isset($this->s__datos_filtro))
		{
			$this->s__where.=' and ' .$where;

			$datos = dao::get_listado_viatico($this->s__where);
		}else{
			$datos = dao::get_listado_viatico($where);
		}
	

		$cuadro->set_datos($datos);
	}

	function evt__cuadro__seleccion($seleccion)
	{
		$this->get_cn()->set_cursor_dt_viatico($seleccion);
		$this->set_pantalla('pant_edicion');
	}
	function evt__cuadro__borrar($seleccion)
	{
			$this->get_cn()->eliminar_dt_viatico($seleccion);

			try{
			$this->get_cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("El viatico esta siendo referenciado, no puede eliminarlo",'error');
				
			}else{
				throw $error;
			}
		}

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
		if ($this->get_cn()->hay_cursor_dt_viatico())
		{
			$datos = $this->get_cn()->get_dt_viatico();
			$form->set_datos($datos);
		}
	}

	function evt__frm__modificacion($datos)
	{
		if ($this->get_cn()->hay_cursor_dt_viatico())
		{
			$this->get_cn()->set_dt_viatico($datos);
		} else {
			$this->get_cn()->agregar_dt_viatico($datos);
		}

		/*$this->get_cn()->resetear_cursor_dt_viatico();
		$this->set_pantalla('pant_inicial');*/
	}

	//-----------------------------------------------------------------------------------
	//---- frm_ml_detalle_viatico -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_ml_detalle_viatico(sicd_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_cn()->get_dt_detalle_viatico();
		$form_ml->set_datos($datos);
	}

	function evt__frm_ml_detalle_viatico__modificacion($datos)
	{
		$this->get_cn()->procesar_dt_detalle_viatico($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- frm_ml_detalle_dias_viatico --------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_ml_detalle_dias_viatico(sicd_ei_formulario_ml $form_ml)
	{
		$datos = $this->get_cn()->get_dt_detalle_dias_viatico();
		$form_ml->set_datos($datos);
	}

	function evt__frm_ml_detalle_dias_viatico__modificacion($datos)
	{
		$this->get_cn()->procesar_dt_detalle_dias_viatico($datos);
	}




}
?>