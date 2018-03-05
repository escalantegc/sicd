<?php
require_once('dao.php');
class ci_personal_principal extends sicd_ci
{
	protected $s__where;
	protected $s__datos_filtro;

	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf()
	{
		if ($this->cn()->hay_cursor_dt_personal())
		{
			$datos = $this->cn()->get_dt_personal();

			    $titulo = '<font color= #ff5733 ><strong><u>Persona</u> :  </strong></font>';
              
                $titulo = $datos['apellido'].', ' .$datos['nombres'];
                $this->set_titulo($titulo);

		}
	}
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		try{
			$this->cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$mensaje_log= $error->get_mensaje_log();

			
			if (strstr($mensaje_log, 'persona_idx'))
			{
				toba::notificacion()->agregar("Esta persona se encuentra registrada",'info');
			}			

			if (strstr($mensaje_log, 'viatico_nro_expediente_idx'))
			{
				toba::notificacion()->agregar("El numero de expediente para el viatico que desea dar de alta o modificar ya esta registrado",'info');
			}			

			if (strstr($mensaje_log, 'estudio_por_persona_pkey'))
			{
				toba::notificacion()->agregar("El el titulo para el estudio que desea dar de alta ya esta registrado",'info');

			}

			$persona = $this->cn()->get_dt_personal();
			$id['idpersona'] = $persona['idpersona'];
			//$this->cn()->resetear_cursores_dr_personal();
			$this->cn()->resetear_dr_personal();
			

			$this->cn()->cargar_dr_personal($id);
			$this->cn()->set_cursor_dt_personal($id);

		}
	}

	function evt__cancelar()
	{
		$this->cn()->resetear_dr_personal();
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
		if(isset($this->s__datos_filtro)){
			
			$datos = dao::get_listado_personas($this->s__where);
		}else{
			$datos = dao::get_listado_personas();
		}

		$cuadro->set_datos($datos);
	}

	function evt__cuadro__seleccion($seleccion)
	{
		$this->cn()->cargar_dr_personal($seleccion);
		$this->cn()->set_cursor_dt_personal($seleccion);
		$this->set_pantalla('pant_edicion');
	}
	function evt__cuadro__baja($seleccion)
	{
		$this->cn()->cargar_dr_personal($seleccion);
		$this->cn()->set_cursor_dt_personal($seleccion);
		$datos['baja'] = 1;
		$this->cn()->set_dt_personal($datos);
			try{
			$this->cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("La persona esta siendo referenciada, no puede eliminarla",'error');
				$this->cn()->resetear();
			}else{
				throw $error;
			}
		}
		$this->cn()->resetear_dr_personal();
	}

	function evt__cuadro__alta($seleccion)
	{
		$this->cn()->cargar_dr_personal($seleccion);
		$this->cn()->set_cursor_dt_personal($seleccion);
		$datos['baja'] = 0;
		$this->cn()->set_dt_personal($datos);
			try{
			$this->cn()->guardar_dr_personal();
				toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
			$sql_state= $error->get_sqlstate();
			if($sql_state=='db_23503'){
				toba::notificacion()->agregar("La persona esta siendo referenciada, no puede eliminarla",'error');
				$this->cn()->resetear();
			}else{
				throw $error;
			}
		}
		$this->cn()->resetear_dr_personal();
	}


	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(sicd_ei_filtro $filtro)
	{
		if(isset($this->s__datos_filtro)){
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







}
?>