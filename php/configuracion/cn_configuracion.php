<?php
class cn_configuracion extends sicd_cn
{
	//-----------------------------------------------------------------------------------
	//---- DR-PERSONAL -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar($seleccion)
	{
		if(!$this->dep('dr_conf')->esta_cargada())
		{				// verifica si esta cargada el datos relacion			
			if(!isset($seleccion))
			{
				$this->dep('dr_conf')->cargar();					// lee de la BD fisica y carga al datos relacion
			}else{
				$this->dep('dr_conf')->cargar($seleccion);				// lee de la BD fisica y carga al datos relacion
			}
		}
	}
	function guardar()
	{
		$this->dep('dr_conf')->sincronizar();
	}

	function resetear()
	{
		$this->dep('dr_conf')->resetear();
	}

	//-----------------------------------------------------------------------------------
	//---- DT-CONFIGURACION -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function set_dt_configuracion($datos)
	{
		
		$this->dep('dr_conf')->tabla('dt_configuracion')->set($datos);
	}	

	function get_dt_configuracion()
	{
		//$id = $this->dep('dr_conf')->tabla('dt_configuracion')->get_cursor();
		//$this->dep('dr_conf')->tabla('dt_configuracion')->set_cursor($id);
		return $this->dep('dr_conf')->tabla('dt_configuracion')->get();
	}	


	function guardar_dt_configuracion()
	{
		$this->dep('dr_conf')->tabla('dt_configuracion')->sincronizar();
	}	

	function cargar_dt_configuracion()
	{
		$this->dep('dr_conf')->tabla('dt_configuracion')->cargar();
	}
	//-----------------------------------------------------------------------------------
	//---- DT-CONFIGURACION -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function cargar_dt_cabecera()
	{
		$this->dep('dr_conf')->tabla('dt_cabecera')->cargar();
	}
	function set_dt_cabecera($datos)
	{

		$this->dep('dr_conf')->tabla('dt_cabecera')->set($datos);

		if ($datos['logo1']['name']!='') {
			  $fplogo1 = fopen($datos['logo1']['tmp_name'], 'rb');

			  $this->dep('dr_conf')->tabla('dt_cabecera')->set_blob('logo1', $fplogo1);
		 }		

		if ($datos['logo2']['name']!='') {
			  $fplogo2 = fopen($datos['logo2']['tmp_name'], 'rb');

			  $this->dep('dr_conf')->tabla('dt_cabecera')->set_blob('logo2', $fplogo2);
		 }
		
	}	

	function get_dt_cabecera()
	{
	
		$datos = $this->dep('dr_conf')->tabla('dt_cabecera')->get();
		$id = $this->dep('dr_conf')->tabla('dt_cabecera')->get_cursor();
		$fp_logo1 = $this->dep('dr_conf')->tabla('dt_cabecera')->get_blob('logo1', $id[0]);
		$fp_logo2 = $this->dep('dr_conf')->tabla('dt_cabecera')->get_blob('logo2', $id[0]);


 		if (isset($fp_logo1)) {
			$temp_nombre_archivo_logo = 'logo1.jpg';
			$archivologo = toba::proyecto()->get_www($temp_nombre_archivo_logo);
			//ei_arbol($archivologo);
			$temp_archivo_logo = fopen($archivologo['path'], 'w');
			stream_copy_to_stream($fp_logo1, $temp_archivo_logo);
			fclose($temp_archivo_logo);
		                                        
			$datos['logo1'] =  "<img src='{$archivologo['url']}' alt=\"Imagen\" WIDTH=180 HEIGHT=130 >";
			
		}else {
			$datos['logo1']   = null;
			//Agrego esto para cuando no existe imagen pero si registro
		}
 		if (isset($fp_logo2)) {
			$temp_nombre_archivo_logo2 = 'logo2.jpg';
			$archivologo2 = toba::proyecto()->get_www($temp_nombre_archivo_logo2);
			//ei_arbol($archivologo);
			$temp_archivo_logo2 = fopen($archivologo2['path'], 'w');
			stream_copy_to_stream($fp_logo2, $temp_archivo_logo2);
			fclose($temp_archivo_logo2);
		                                        
			$datos['logo2'] =  "<img src='{$archivologo2['url']}' alt=\"Imagen\" WIDTH=180 HEIGHT=130 >";
			
		}else {
			$datos['logo2']   = null;
			//Agrego esto para cuando no existe imagen pero si registro
		}
		return $datos;
				

	}

}

?>