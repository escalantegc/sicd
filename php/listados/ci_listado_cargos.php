<?php
require_once('dao.php');
class ci_listado_cargos extends sicd_ci
{
	protected $s__criterios_filtrado;
	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(sicd_ei_filtro $filtro)
	{
		$filtro->columna('idtipo_cargo')->set_condicion_fija('es_igual_a');
		$filtro->columna('identidad')->set_condicion_fija('es_igual_a');
		$filtro->columna('cantidad_horas')->set_condicion_fija('es_igual_a');
		$filtro->columna('fecha_inicio')->set_condicion_fija('es_igual_a');
		$filtro->columna('fecha_fin')->set_condicion_fija('es_igual_a');
		$filtro->columna('idtipo_hora')->set_condicion_fija('es_igual_a');
		$filtro->columna('tipo')->set_condicion_fija('es_igual_a');
		$filtro->columna('activo')->set_condicion_fija('es_igual_a');
		$filtro->columna('historico')->set_condicion_fija('es_igual_a');
	}


	function vista_jasperreports(toba_vista_jasperreports $report)
	{
		
		$reporte='listado_cargos.jasper';
		$path=toba::proyecto()->get_path().'/exportaciones/'.$reporte;	

		$path_logo1=toba::proyecto()->get_path().'/www/logo1.jpg';	
		$path_logo2=toba::proyecto()->get_path().'/www/logo2.jpg';	



		$report->set_path_reporte($path);
		//Parametro para el titulo
		$report->set_parametro('titulo','S','LISTADO DE VIATICOS ');
		//Parametros para el encabezado del titulo
		$report->set_parametro('logo1','S',$path_logo1);
		$report->set_parametro('logo2','S',$path_logo2);
		//Paramentro del filtro
		
		$idtipo_cargo= '%%';
		$identidad = '%%';
		$cantidad_horas = '';
		$fecha_inicio = '%%';
		$fecha_fin = '%%';	
		$fecha_inicio_mostrar = '%%';
		$fecha_fin_mostrar = '%%';
		$idtipo_hora = '%%';
		$tipo = '%%';
		$activo = 'true';
		$historico = 'false';
		
		
		$orderby_mostrar = 'Persona';

		
		if (isset($this->s__criterios_filtrado['idtipo_cargo']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idtipo_cargo']['valor'])!='nopar')
			{
				$idtipo_cargo = utf8_encode(trim($this->s__criterios_filtrado['idtipo_cargo']['valor']));
				
				
			}
		}

		
	
		if (isset($this->s__criterios_filtrado['identidad']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['identidad']['valor'])!='nopar')
			{
				$identidad = utf8_encode(trim($this->s__criterios_filtrado['identidad']['valor']));
			}
		}
	
		if (isset($this->s__criterios_filtrado['cantidad_horas']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['cantidad_horas']['valor'])!='nopar')
			{
				$cantidad_horas = utf8_encode(trim($this->s__criterios_filtrado['cantidad_horas']['valor']));
				
			}
		}		

		if (isset($this->s__criterios_filtrado['fecha_inicio']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['fecha_inicio']['valor'])!='nopar')
			{
				$fecha_inicio = utf8_encode(trim($this->s__criterios_filtrado['fecha_inicio']['valor']));
				
			}
		}		

		if (isset($this->s__criterios_filtrado['fecha_inicio_mostrar']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['fecha_inicio_mostrar']['valor'])!='nopar')
			{
				$fecha_inicio_mostrar = utf8_encode(trim($this->s__criterios_filtrado['fecha_inicio_mostrar']['valor']));
				
			}
		}
		
		if (isset($this->s__criterios_filtrado['fecha_fin']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['fecha_fin']['valor'])!='nopar')
			{
				$fecha_fin = utf8_encode(trim($this->s__criterios_filtrado['fecha_fin']['valor']));
				
			}
		}
		
		if (isset($this->s__criterios_filtrado['fecha_fin_mostrar']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['fecha_fin_mostrar']['valor'])!='nopar')
			{
				$fecha_fin_mostrar = utf8_encode(trim($this->s__criterios_filtrado['fecha_fin_mostrar']['valor']));
				
			}
		}		

		if (isset($this->s__criterios_filtrado['idtipo_hora']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idtipo_hora']['valor'])!='nopar')
			{
				$idtipo_hora = utf8_encode(trim($this->s__criterios_filtrado['idtipo_hora']['valor']));
				
			}
		}		

		if (isset($this->s__criterios_filtrado['tipo']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['tipo']['valor'])!='nopar')
			{
				$tipo = utf8_encode(trim($this->s__criterios_filtrado['tipo']['valor']));
				
			}
		}		

		if (isset($this->s__criterios_filtrado['activo']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['activo']['valor'])!='nopar')
			{
				$activo = utf8_encode(trim($this->s__criterios_filtrado['activo']['valor']));
				
			}
		}		
		if (isset($this->s__criterios_filtrado['historico']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['historico']['valor'])!='nopar')
			{
				$historico = utf8_encode(trim($this->s__criterios_filtrado['historico']['valor']));
				
			}
		}
			
		$report->set_parametro('identidad', 'S', $identidad);
		$report->set_parametro('cantidad_horas', 'S', $cantidad_horas);
		$report->set_parametro('idtipo_cargo', 'S', $idtipo_cargo);
		$report->set_parametro('fecha_inicio', 'S', $fecha_inicio);
		$report->set_parametro('fecha_fin', 'S', $fecha_fin);	
		$report->set_parametro('fecha_inicio_mostrar', 'S', $fecha_inicio_mostrar);
		$report->set_parametro('fecha_fin_mostrar', 'S', $fecha_fin_mostrar);
		$report->set_parametro('idtipo_hora', 'S', $idtipo_hora);
		$report->set_parametro('tipo', 'S', $tipo);
		$report->set_parametro('activo', 'S', $activo);
		$report->set_parametro('historico', 'S', $historico);
		
		$report->set_parametro('orderby_mostrar', 'S', $orderby_mostrar);
	

		//Parametros para el usuario
		$report->set_parametro('usuario','S',toba::usuario()->get_id());
		$report->set_nombre_archivo('listado_cargos.pdf');   	
		$db=toba::fuente('sicd')->get_db();
		$report->set_conexion($db);	
	}

	

	function ajax__get_dato_filtro_identidad($identidad, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['identidad']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['identidad']['valor'] =  $identidad;
		$respuesta->set($identidad);	
	}	

	function ajax__get_dato_filtro_cantidad_horas($cantidad_horas, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['cantidad_horas']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['cantidad_horas']['valor'] =  $cantidad_horas;
		$respuesta->set($cantidad_horas);	
	}	

	function ajax__get_dato_filtro_idtipo_cargo($idtipo_cargo, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idtipo_cargo']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idtipo_cargo']['valor'] =  $idtipo_cargo;
		$respuesta->set($idtipo_cargo);	
	}		

	function ajax__get_dato_filtro_idtipo_hora($idtipo_hora, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idtipo_hora']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idtipo_hora']['valor'] =  $idtipo_hora;
		$respuesta->set($idtipo_hora);	
	}	


	function ajax__get_dato_filtro_fecha_inicio($fecha_inicio, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['fecha_inicio']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['fecha_inicio']['valor'] =  $fecha_inicio;
		$respuesta->set($fecha_inicio);	
	}	

	function ajax__get_dato_filtro_fecha_inicio_mostrar($fecha_inicio_mostrar, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['fecha_inicio_mostrar']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['fecha_inicio_mostrar']['valor'] =  $fecha_inicio_mostrar;
		$respuesta->set($fecha_inicio_mostrar);	
	}		
	
	function ajax__get_dato_filtro_fecha_fin($fecha_fin, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['fecha_fin']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['fecha_fin']['valor'] =  $fecha_fin;
		$respuesta->set($fecha_fin);	
	}			

	function ajax__get_dato_filtro_fecha_fin_mostrar($fecha_fin_mostrar, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['fecha_fin_mostrar']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['fecha_fin_mostrar']['valor'] =  $fecha_fin_mostrar;
		$respuesta->set($fecha_fin_mostrar);	
	}		

	function ajax__get_dato_filtro_tipo($tipo, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['tipo']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['tipo']['valor'] =  $tipo;
		$respuesta->set($tipo);	
	}		

	function ajax__get_dato_filtro_activo($activo, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['activo']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['activo']['valor'] =  $activo;
		$respuesta->set($activo);	
	}		

	function ajax__get_dato_filtro_historico($historico, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['historico']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['historico']['valor'] =  $historico;
		$respuesta->set($historico);	
	}	



}

?>