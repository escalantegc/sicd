<?php
require_once('dao.php');
class ci_listado_estudios extends sicd_ci
{
	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	protected $s__criterios_filtrado;
	protected $s__idlocalidad;
	function conf__filtro(sicd_ei_filtro $filtro)
	{
		$filtro->columna('idlocalidad')->set_condicion_fija('es_igual_a');
		$filtro->columna('idnivel_estudio')->set_condicion_fija('es_igual_a');
		$filtro->columna('idestudio')->set_condicion_fija('es_igual_a');
		$filtro->columna('identidad')->set_condicion_fija('es_igual_a');
		
	}



	function vista_jasperreports(toba_vista_jasperreports $report)
	{
		
		$reporte='listado_estudio.jasper';
		$path=toba::proyecto()->get_path().'/exportaciones/'.$reporte;	

		$path_logo1=toba::proyecto()->get_path().'/www/logo1.jpg';	
		$path_logo2=toba::proyecto()->get_path().'/www/logo2.jpg';	



		$report->set_path_reporte($path);
		//Parametro para el titulo
		$report->set_parametro('titulo','S','LISTADO DE ESTUDIOS');
		//Parametros para el encabezado del titulo
		$report->set_parametro('logo1','S',$path_logo1);
		$report->set_parametro('logo2','S',$path_logo2);
		//Paramentro del filtro
		
		$idlocalidad= '%%';
		$idnivel_estudio= '%%';
		$identidad = '%%';
		$idestudio = '%%';
		$orderby='nivel_estudio.orden desc';
		$orderby_mostrar = 'Nivel Estudio';

		
		if (isset($this->s__criterios_filtrado['idlocalidad']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idlocalidad']['valor'])!='nopar')
			{
				$idlocalidad = utf8_encode(trim($this->s__criterios_filtrado['idlocalidad']['valor']));
				
				
			}
		}
	
		if (isset($this->s__criterios_filtrado['identidad']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['identidad']['valor'])!='nopar')
			{
				$identidad = utf8_encode(trim($this->s__criterios_filtrado['identidad']['valor']));
			}
		}
	
		if (isset($this->s__criterios_filtrado['idnivel_estudio']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idnivel_estudio']['valor'])!='nopar')
			{
				$idnivel_estudio = utf8_encode(trim($this->s__criterios_filtrado['idnivel_estudio']['valor']));
			}
		}
	
		if (isset($this->s__criterios_filtrado['idestudio']['valor'])!='')
		{
			if (trim($this->s__criterios_filtrado['idestudio']['valor'])!='nopar')
			{

				$idestudio = utf8_encode(trim($this->s__criterios_filtrado['idestudio']['valor']));
			}
		}
		

		

		$report->set_parametro('idlocalidad', 'S', $idlocalidad);
		
		$report->set_parametro('idnivel_estudio', 'S', $idnivel_estudio);
		$report->set_parametro('identidad', 'S', $identidad);
		$report->set_parametro('idestudio', 'S', $idestudio);
		$report->set_parametro('orderby', 'S', $orderby);
		$report->set_parametro('orderby_mostrar', 'S', $orderby_mostrar);
	

		//Parametros para el usuario
		$report->set_parametro('usuario','S',toba::usuario()->get_id());
		$report->set_nombre_archivo('listado_de_estudios.pdf');   	
		$db=toba::fuente('sicd')->get_db();
		$report->set_conexion($db);	
	}

	function ajax__get_dato_filtro_idlocalidad($idlocalidad, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idlocalidad']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idlocalidad']['valor'] =  $idlocalidad;
		$respuesta->set($idlocalidad);	
	}	

	function ajax__get_dato_filtro_idnivel_estudio($idnivel_estudio, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idnivel_estudio']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idnivel_estudio']['valor'] =  $idnivel_estudio;
		$respuesta->set($idnivel_estudio);	
	}	

	function ajax__get_dato_filtro_idestudio($idestudio, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['idestudio']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['idestudio']['valor'] =  $idestudio;
		$respuesta->set($idestudio);	
	}	

	function ajax__get_dato_filtro_identidad($identidad, toba_ajax_respuesta $respuesta)
	{
		$this->s__criterios_filtrado['identidad']['condicion'] =  'es_igual_a';
		$this->s__criterios_filtrado['identidad']['valor'] =  $identidad;
		$respuesta->set($identidad);	
	}
}

?>