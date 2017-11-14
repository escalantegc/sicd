<?php
class cn_parametros extends sicd_cn
{

	//-----------------------------------------------------------------------------------
	//---- DR-PARAMETROS -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dr_parametros($seleccion)
	{
		if(!$this->dep('dr_parametros')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_parametros')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_parametros')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function guardar_dr_parametros()
	{
		$this->dep('dr_parametros')->sincronizar();
	}

	function resetear_dr_parametros()
	{
		$this->dep('dr_parametros')->resetear();
	}

	//-----------------------------------------------------------------------------------
	//---- DT-TIPO-DOCUMENTO -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dt_tipo_documento($seleccion)
	{
		if(!$this->dep('dr_parametros')->tabla('dt_tipo_documento')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_parametros')->tabla('dt_tipo_documento')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_parametros')->tabla('dt_tipo_documento')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function set_cursor_dt_tipo_documento($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_documento')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_tipo_documento')->set_cursor($id[0]);
	}

	function hay_cursor_dt_tipo_documento()
	{
		return $this->dep('dr_parametros')->tabla('dt_tipo_documento')->hay_cursor();
	}

	function resetear_cursor_dt_tipo_documento()
	{
		$this->dep('dr_parametros')->tabla('dt_tipo_documento')->resetear_cursor();
	}

	function get_dt_tipo_documento()
	{
		return $this->dep('dr_parametros')->tabla('dt_tipo_documento')->get();
	}

	function set_dt_tipo_documento($datos)
	{
		$this->dep('dr_parametros')->tabla('dt_tipo_documento')->set($datos);
	}

	function agregar_dt_tipo_documento($datos)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_documento')->nueva_fila($datos);
		$this->dep('dr_parametros')->tabla('dt_tipo_documento')->set_cursor($id);
	}	

	function eliminar_dt_tipo_documento($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_documento')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_tipo_documento')->eliminar_fila($id[0]);
	}	

	//-----------------------------------------------------------------------------------
	//---- DT-TIPO-TELEFONO -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dt_tipo_telefono($seleccion)
	{
		if(!$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function set_cursor_dt_tipo_telefono($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_telefono')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->set_cursor($id[0]);
	}

	function hay_cursor_dt_tipo_telefono()
	{
		return $this->dep('dr_parametros')->tabla('dt_tipo_telefono')->hay_cursor();
	}

	function resetear_cursor_dt_tipo_telefono()
	{
		$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->resetear_cursor();
	}

	function get_dt_tipo_telefono()
	{
		return $this->dep('dr_parametros')->tabla('dt_tipo_telefono')->get();
	}

	function set_dt_tipo_telefono($datos)
	{
		$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->set($datos);
	}

	function agregar_dt_tipo_telefono($datos)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_telefono')->nueva_fila($datos);
		$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->set_cursor($id);
	}	

	function eliminar_dt_tipo_telefono($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_telefono')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_tipo_telefono')->eliminar_fila($id[0]);
	}

	//-----------------------------------------------------------------------------------
	//---- DT-TIPO-DETALLE-VIATICO -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dt_tipo_detalle_viatico($seleccion)
	{
		if(!$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function set_cursor_dt_tipo_detalle_viatico($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->set_cursor($id[0]);
	}

	function hay_cursor_dt_tipo_detalle_viatico()
	{
		return $this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->hay_cursor();
	}

	function resetear_cursor_dt_tipo_detalle_viatico()
	{
		$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->resetear_cursor();
	}

	function get_dt_tipo_detalle_viatico()
	{
		return $this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->get();
	}

	function set_dt_tipo_detalle_viatico($datos)
	{
		$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->set($datos);
	}

	function agregar_dt_tipo_detalle_viatico($datos)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->nueva_fila($datos);
		$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->set_cursor($id);
	}	

	function eliminar_dt_tipo_detalle_viatico($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_tipo_detalle_viatico')->eliminar_fila($id[0]);
	}	

	//-----------------------------------------------------------------------------------
	//---- DT-PAIS -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dt_pais($seleccion)
	{
		if(!$this->dep('dr_parametros')->tabla('dt_pais')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_parametros')->tabla('dt_pais')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_parametros')->tabla('dt_pais')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function set_cursor_dt_pais($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_pais')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_pais')->set_cursor($id[0]);
	}

	function hay_cursor_dt_pais()
	{
		return $this->dep('dr_parametros')->tabla('dt_pais')->hay_cursor();
	}

	function resetear_cursor_dt_pais()
	{
		$this->dep('dr_parametros')->tabla('dt_pais')->resetear_cursor();
	}

	function get_dt_pais()
	{
		return $this->dep('dr_parametros')->tabla('dt_pais')->get();
	}

	function set_dt_pais($datos)
	{
		$this->dep('dr_parametros')->tabla('dt_pais')->set($datos);
	}

	function agregar_dt_pais($datos)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_pais')->nueva_fila($datos);
		$this->dep('dr_parametros')->tabla('dt_pais')->set_cursor($id);
	}	

	function eliminar_dt_pais($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_pais')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_pais')->eliminar_fila($id[0]);
	}
	//-----------------------------------------------------------------------------------
	//---- DT-PROVINCIA	 -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dt_provincia($seleccion)
	{
		if(!$this->dep('dr_parametros')->tabla('dt_provincia')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_parametros')->tabla('dt_provincia')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_parametros')->tabla('dt_provincia')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function set_cursor_dt_provincia($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_provincia')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_provincia')->set_cursor($id[0]);
	}

	function hay_cursor_dt_provincia()
	{
		return $this->dep('dr_parametros')->tabla('dt_provincia')->hay_cursor();
	}

	function resetear_cursor_dt_provincia()
	{
		$this->dep('dr_parametros')->tabla('dt_provincia')->resetear_cursor();
	}

	function get_dt_provincia()
	{
		return $this->dep('dr_parametros')->tabla('dt_provincia')->get();
	}

	function set_dt_provincia($datos)
	{
		$this->dep('dr_parametros')->tabla('dt_provincia')->set($datos);
	}

	function agregar_dt_provincia($datos)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_provincia')->nueva_fila($datos);
		$this->dep('dr_parametros')->tabla('dt_provincia')->set_cursor($id);
	}	

	function eliminar_dt_provincia($seleccion)
	{
		$id = $this->dep('dr_parametros')->tabla('dt_provincia')->get_id_fila_condicion($seleccion);
		$this->dep('dr_parametros')->tabla('dt_provincia')->eliminar_fila($id[0]);
	}
}

?>