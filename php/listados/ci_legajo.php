<?php
class ci_legajo extends sicd_ci
{
	protected $s__criterios_filtrado;
	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(sicd_ei_filtro $filtro)
	{
		$filtro->columna('idpersona')->set_condicion_fija('es_igual_a');
		$filtro->columna('estudios')->set_condicion_fija('es_igual_a');
		$filtro->columna('viaticos')->set_condicion_fija('es_igual_a');
		$filtro->columna('cargos')->set_condicion_fija('es_igual_a');

	}
	function vista_jasperreports(toba_vista_jasperreports $report)

	{
		
		$reporte='legajo.jasper';
		$path=toba::proyecto()->get_path().'/exportaciones/'.$reporte;	

		$path_logo1=toba::proyecto()->get_path().'/www/logo1.jpg';	
		$path_logo2=toba::proyecto()->get_path().'/www/logo2.jpg';	

		$path_subreport = toba::proyecto()->get_path().'/exportaciones/';


		$report->set_path_reporte($path);
		$report->set_parametro('SUBREPORT_DIR','S',$path_subreport);
		//Parametro para el titulo
		$report->set_parametro('titulo','S','LEGAJO DE LA PERSONA ');
		//Parametros para el encabezado del titulo
		$report->set_parametro('logo1','S',$path_logo1);
		$report->set_parametro('logo2','S',$path_logo2);
		//Paramentro del filtro
		
		
		$idpersona = 0;
		$detalleamostrar ='-';




		if (isset($this->s__criterios_filtrado['idpersona']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idpersona']['valor'])!='nopar')
			{
				$idpersona = $this->s__criterios_filtrado['idpersona']['valor'];

			}
		}

		if (trim($this->s__criterios_filtrado['estudios']['valor']) != '-') 
		{
			$detalleamostrar = $detalleamostrar.'estudios';
		}

		if (trim($this->s__criterios_filtrado['viaticos']['valor']) != '-') 
		{
			$detalleamostrar = $detalleamostrar.'viaticos';
		}

		if (trim($this->s__criterios_filtrado['cargos']['valor']) != '-') 
		{
			$detalleamostrar = $detalleamostrar.'cargos';
		}

		
	
		$report->set_parametro('idpersona', 'E', $idpersona);
		$report->set_parametro('detalleamostrar', 'S', $detalleamostrar);

	

		//Parametros para el usuario
		$report->set_parametro('usuario','S',toba::usuario()->get_id());
		$report->set_nombre_archivo('legajo.pdf');   	
		$db=toba::fuente('sicd')->get_db();
		$report->set_conexion($db);	
	}

	function ajax__get_dato_filtro_idpersona($idpersona, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idpersona']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idpersona']['valor'] =  $idpersona;
		$respuesta->set($idpersona);	
	}	

	 function ajax__get_dato_filtro_cargos($cargos, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['cargos']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['cargos']['valor'] = $cargos;
		$respuesta->set($cargos);	
	}	 

	function ajax__get_dato_filtro_estudios($estudios, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['estudios']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['estudios']['valor'] = $estudios;
		$respuesta->set($estudios);	
	}	 

	function ajax__get_dato_filtro_viaticos($viaticos, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['viaticos']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['viaticos']['valor'] = $viaticos;
		$respuesta->set($viaticos);	
	}
	


}
?>