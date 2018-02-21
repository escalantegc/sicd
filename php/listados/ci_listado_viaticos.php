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
		$filtro->columna('idlocalidad_origen')->set_condicion_fija('es_igual_a');
		$filtro->columna('idlocalidad_destino')->set_condicion_fija('es_igual_a');
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
		
		$idlocalidad_origen= '%%';
		$idlocalidad_destino= '%%';
		$mes = '%%';
		$nro_expediente = '%%';
		
		$orderby=' mes';
		$orderby_mostrar = 'Mes';

		
		if (isset($this->s__criterios_filtrado['nro_expediente']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['nro_expediente']['valor'])!='nopar')
			{
				$nro_expediente = utf8_encode(trim($this->s__criterios_filtrado['nro_expediente']['valor']));
				
				
			}
		}

		if (isset($this->s__criterios_filtrado['idlocalidad_origen']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idlocalidad_origen']['valor'])!='nopar')
			{
				$idlocalidad_origen = utf8_encode(trim($this->s__criterios_filtrado['idlocalidad_origen']['valor']));
				
				
			}
		}
	
		if (isset($this->s__criterios_filtrado['idlocalidad_destino']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idlocalidad_destino']['valor'])!='nopar')
			{
				$idlocalidad_destino = utf8_encode(trim($this->s__criterios_filtrado['idlocalidad_destino']['valor']));
			}
		}
	
		if (isset($this->s__criterios_filtrado['mes']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['mes']['valor'])!='nopar')
			{
				$mes = utf8_encode(trim($this->s__criterios_filtrado['mes']['valor']));
				
			}
		}
	
		$report->set_parametro('idlocalidad_origen', 'S', $idlocalidad_origen);
		
		$report->set_parametro('idlocalidad_destino', 'S', $idlocalidad_destino);
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

	function ajax__get_dato_filtro_idlocalidad_origen($idlocalidad_origen, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idlocalidad_origen']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idlocalidad_origen']['valor'] =  $idlocalidad_origen;
		$respuesta->set($idlocalidad_origen);	
	}	

	function ajax__get_dato_filtro_idlocalidad_destino($idlocalidad_destino, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idlocalidad_destino']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idlocalidad_destino']['valor'] =  $idlocalidad_destino;
		$respuesta->set($idlocalidad_destino);	
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