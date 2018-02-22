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
		$fecha_inicio = '';
		$fecha_fin = '';
		$idtipo_hora = '%%';
		
		
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
		if (isset($this->s__criterios_filtrado['fecha_fin']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['fecha_fin']['valor'])!='nopar')
			{
				$fecha_fin = utf8_encode(trim($this->s__criterios_filtrado['fecha_fin']['valor']));
				
			}
		}		

		if (isset($this->s__criterios_filtrado['idtipo_hora']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idtipo_hora']['valor'])!='nopar')
			{
				$idtipo_hora = utf8_encode(trim($this->s__criterios_filtrado['idtipo_hora']['valor']));
				
			}
		}
			
		$report->set_parametro('identidad', 'S', $identidad);
		$report->set_parametro('cantidad_horas', 'S', $cantidad_horas);
		$report->set_parametro('idtipo_cargo', 'S', $idtipo_cargo);
		$report->set_parametro('fecha_inicio', 'S', $fecha_inicio);
		$report->set_parametro('fecha_fin', 'S', $fecha_fin);
		$report->set_parametro('idtipo_hora', 'S', $fecha_fin);
		
		$report->set_parametro('orderby_mostrar', 'S', $orderby_mostrar);
	

		//Parametros para el usuario
		$report->set_parametro('usuario','S',toba::usuario()->get_id());
		$report->set_nombre_archivo('listado_basico_viaticos.pdf');   	
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
	
	function ajax__get_dato_filtro_fecha_fin($fecha_fin, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['fecha_fin']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['fecha_fin']['valor'] =  $fecha_fin;
		$respuesta->set($fecha_fin);	
	}	
}

?>