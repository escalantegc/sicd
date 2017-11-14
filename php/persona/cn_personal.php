<?php
class cn_personal extends sicd_cn
{
	//-----------------------------------------------------------------------------------
	//---- DR-PERSONAL -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dr_personal($seleccion)
	{
		if(!$this->dep('dr_personal')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_personal')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_personal')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function guardar_dr_personal()
	{
		$this->dep('dr_personal')->sincronizar();
	}

	function resetear_dr_personal()
	{
		$this->dep('dr_personal')->resetear();
	}

	//-----------------------------------------------------------------------------------
	//---- DT-PERSONAL -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function set_cursor_dt_personal($seleccion)
	{
		$id = $this->dep('dr_personal')->tabla('dt_personal')->get_id_fila_condicion($seleccion);
		$this->dep('dr_personal')->tabla('dt_personal')->set_cursor($id[0]);
	}

	function hay_cursor_dt_personal()
	{
		return $this->dep('dr_personal')->tabla('dt_personal')->hay_cursor();
	}

	function resetear_cursor_dt_personal()
	{
		$this->dep('dr_personal')->tabla('dt_personal')->resetear_cursor();
	}

	function get_dt_personal()
	{
		return $this->dep('dr_personal')->tabla('dt_personal')->get();
	}

	function set_dt_personal($datos)
	{
		$this->dep('dr_personal')->tabla('dt_personal')->set($datos);
	}

	function agregar_dt_personal($datos)
	{
		$id = $this->dep('dr_personal')->tabla('dt_personal')->nueva_fila($datos);
		$this->dep('dr_personal')->tabla('dt_personal')->set_cursor($id);
	}	

	function eliminar_dt_personal($seleccion)
	{
		$id = $this->dep('dr_personal')->tabla('dt_personal')->get_id_fila_condicion($seleccion);
		$this->dep('dr_personal')->tabla('dt_personal')->eliminar_fila($id);
	}
	//-----------------------------------------------------------------------------------
	//---- DT-TELEFONO POR PERSONA -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function procesar_dt_telefono_por_persona($datos)
	{
		$id = $this->dep('dr_personal')->tabla('dt_telefono_por_persona')->procesar_filas($datos);
	}

	function get_dt_telefono_por_persona()
	{
		return $this->dep('dr_personal')->tabla('dt_telefono_por_persona')->get_filas();
	}

	//-----------------------------------------------------------------------------------
	//---- DT-CARGOS-POR-PERSONA -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function set_cursor_dt_cargo_por_persona($seleccion)
	{
		$id = $this->dep('dr_personal')->tabla('dt_cargo_por_persona')->get_id_fila_condicion($seleccion);
		$this->dep('dr_personal')->tabla('dt_cargo_por_persona')->set_cursor($id);
	}

	function resetear_cursor_dt_cargo_por_persona()
	{
		$this->dep('dr_personal')->tabla('dt_cargo_por_persona')->resetear_cursor();
	}

	function get_dt_cargo_por_persona()
	{
		return $this->dep('dr_personal')->tabla('dt_cargo_por_persona')->get();
	}

	function set_dt_cargo_por_persona($datos)
	{
		$this->dep('dr_personal')->tabla('dt_cargo_por_persona')->set($datos);
	}

	function agregar_dt_cargo_por_persona($datos)
	{
		$id = $this->dep('dr_personal')->tabla('dt_cargo_por_persona')->nueva_fila($datos);
		$this->dep('dr_personal')->tabla('dt_cargo_por_persona')->set_cursor($id);
	}	

	function eliminar_dt_cargo_por_persona($seleccion)
	{
		$id = $this->dep('dr_personal')->tabla('dt_cargo_por_persona')->get_id_fila_condicion($seleccion);
		$this->dep('dr_personal')->tabla('dt_cargo_por_persona')->eliminar_fila($id);
	}	

	function hay_cursor_dt_cargo_por_persona()
	{
		return $this->dep('dr_personal')->tabla('dt_cargo_por_persona')->hay_cursor();
	}
	//-----------------------------------------------------------------------------------
	//---- DT-VIATICO -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function set_cursor_dt_viatico($seleccion)
	{
		$id = $this->dep('dr_personal')->tabla('dt_viatico')->get_id_fila_condicion($seleccion);
		$this->dep('dr_personal')->tabla('dt_viatico')->set_cursor($id[0]);
	}
	function hay_cursor_dt_viatico()
	{
		return $this->dep('dr_personal')->tabla('dt_viatico')->hay_cursor();
	}

	function resetear_cursor_dt_viatico()
	{
		$this->dep('dr_personal')->tabla('dt_viatico')->resetear_cursor();
	}

	function get_dt_viatico()
	{
		return $this->dep('dr_personal')->tabla('dt_viatico')->get();
	}

	function set_dt_viatico($datos)
	{
		$this->dep('dr_personal')->tabla('dt_viatico')->set($datos);
	}

	function agregar_dt_viatico($datos)
	{

		$id = $this->dep('dr_personal')->tabla('dt_viatico')->nueva_fila($datos);
		$this->dep('dr_personal')->tabla('dt_viatico')->set_cursor($id);
	}	

	function eliminar_dt_viatico($seleccion)
	{
		$id = $this->dep('dr_personal')->tabla('dt_viatico')->get_id_fila_condicion($seleccion);
		$this->dep('dr_personal')->tabla('dt_viatico')->eliminar_fila($id);
	}

	//-----------------------------------------------------------------------------------
	//---- DT-DETALLE-VIATICO -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function procesar_dt_detalle_viatico($datos)
	{
		$id = $this->dep('dr_personal')->tabla('dt_detalle_viatico')->procesar_filas($datos);
	}

	function get_dt_detalle_viatico()
	{
		return $this->dep('dr_personal')->tabla('dt_detalle_viatico')->get_filas();
	}	

	//-----------------------------------------------------------------------------------
	//---- DT-DETALLE-DIAS-VIATICO -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function procesar_dt_detalle_dias_viatico($datos)
	{
		$id = $this->dep('dr_personal')->tabla('dt_detalle_dias_viatico')->procesar_filas($datos);
	}

	function get_dt_detalle_dias_viatico()
	{
		return $this->dep('dr_personal')->tabla('dt_detalle_dias_viatico')->get_filas();
	}



}

?>