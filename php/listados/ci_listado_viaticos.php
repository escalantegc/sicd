<?php
require_once('dao.php');
class ci_listado_viaticos extends sicd_ci
{
	protected $s__criterios_filtrado;
	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(ei_filtro_listado_viatico_basico_persona $filtro)
	{
		$filtro->columna('cantidad_total_dias')->set_condicion_fija('es_mayor_que');
		$filtro->columna('cantidad_dias_disponible')->set_condicion_fija('es_mayor_que');
		$filtro->columna('cantidad_dias_tomados')->set_condicion_fija('es_mayor_que');
		$filtro->columna('cantidad_dias_reintegro')->set_condicion_fija('es_mayor_que');
		$filtro->columna('mes')->set_condicion_fija('es_igual_a');
		$filtro->columna('nro_expediente')->set_condicion_fija('es_igual_a');
	}

	function vista_jasperreports(toba_vista_jasperreports $report)
	{
		
		$reporte='listado_viatico.jasper';
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
		
		
		$cantidad_total_dias = 0;
		$cantidad_dias_disponible = 0;
		$cantidad_dias_tomados = 0;
		$cantidad_dias_reintegro = 0;

		$mes = '%%';
		$nro_expediente = '%%';
		
		$orderby=' mes::int';
		$orderby_mostrar = 'Mes';

		
		if (isset($this->s__criterios_filtrado['nro_expediente']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['nro_expediente']['valor'])!='nopar')
			{
				$nro_expediente = utf8_encode(trim($this->s__criterios_filtrado['nro_expediente']['valor']));
				
				
			}
		}

		if (isset($this->s__criterios_filtrado['cantidad_total_dias']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['cantidad_total_dias']['valor'])!='nopar')
			{
				$cantidad_total_dias = $this->s__criterios_filtrado['cantidad_total_dias']['valor'];
				
				
			}
		}
	
		if (isset($this->s__criterios_filtrado['cantidad_dias_disponible']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['cantidad_dias_disponible']['valor'])!='nopar')
			{
				$cantidad_dias_disponible = $this->s__criterios_filtrado['cantidad_dias_disponible']['valor'];
			}
		}

		if (isset($this->s__criterios_filtrado['cantidad_dias_tomados']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['cantidad_dias_tomados']['valor'])!='nopar')
			{
				$cantidad_dias_tomados = $this->s__criterios_filtrado['cantidad_dias_tomados']['valor'];
			}
		}		

		if (isset($this->s__criterios_filtrado['cantidad_dias_reintegro']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['cantidad_dias_reintegro']['valor'])!='nopar')
			{
				$cantidad_dias_reintegro = $this->s__criterios_filtrado['cantidad_dias_reintegro']['valor'];
			}
		}


	
		if (isset($this->s__criterios_filtrado['mes']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['mes']['valor'])!='nopar')
			{
				$mes = utf8_encode(trim($this->s__criterios_filtrado['mes']['valor']));
				
			}
		}
	


		$report->set_parametro('cantidad_total_dias', 'E', $cantidad_total_dias);
		
		$report->set_parametro('cantidad_dias_disponible', 'E', $cantidad_dias_disponible);
		$report->set_parametro('cantidad_dias_tomados', 'E', $cantidad_dias_tomados);
		$report->set_parametro('cantidad_dias_reintegro', 'E', $cantidad_dias_reintegro);

		$report->set_parametro('mes', 'S', $mes);
		$report->set_parametro('nro_expediente', 'S', $nro_expediente);
		
		$report->set_parametro('orderby', 'S', $orderby);
		$report->set_parametro('orderby_mostrar', 'S', $orderby_mostrar);
	

		//Parametros para el usuario
		$report->set_parametro('usuario','S',toba::usuario()->get_id());
		$report->set_nombre_archivo('listado_basico_viaticos.pdf');   	
		$db=toba::fuente('sicd')->get_db();
		$report->set_conexion($db);	
	}




	function ajax__get_dato_filtro_cantidad_total_dias($cantidad_total_dias, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['cantidad_total_dias']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['cantidad_total_dias']['valor'] =  $cantidad_total_dias;
		$respuesta->set($cantidad_total_dias);	
	}		

	function ajax__get_dato_filtro_cantidad_dias_disponible($cantidad_dias_disponible, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['cantidad_dias_disponible']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['cantidad_dias_disponible']['valor'] =  $cantidad_dias_disponible;
		$respuesta->set($cantidad_total_dias);	
	}		

	function ajax__get_dato_filtro_cantidad_dias_tomados($cantidad_dias_tomados, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['cantidad_dias_tomados']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['cantidad_dias_tomados']['valor'] =  $cantidad_dias_tomados;
		$respuesta->set($cantidad_dias_tomados);	
	}		
	function ajax__get_dato_filtro_cantidad_dias_reintegro($cantidad_dias_reintegro, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['cantidad_dias_reintegro']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['cantidad_dias_reintegro']['valor'] =  $cantidad_dias_reintegro;
		$respuesta->set($cantidad_dias_reintegro);	
	}	

		

	function ajax__get_dato_filtro_mes($mes, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['mes']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['mes']['valor'] =  $mes;
		$respuesta->set($mes);	
	}	

	function ajax__get_dato_filtro_nro_expediente($nro_expediente, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['nro_expediente']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['nro_expediente']['valor'] =  $nro_expediente;
		$respuesta->set($nro_expediente);	
	}	

	

}
?>