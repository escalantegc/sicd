<?php
require_once('persona/ei_cuadro_viaticos_salida_html.php');
require_once('persona/ei_cuadro_cargos_salida_html.php');
require_once('dao.php');
class ci_inicio extends sicd_ci
{
	//-----------------------------------------------------------------------------------
	//---- cuadro_cargos ----------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_cargos(sicd_ei_cuadro $cuadro)
	{
		$cuadro->set_manejador_salida('html', 'ei_cuadro_cargos_salida_html');
	
		/*if(isset($this->s__datos_filtro)){

			$datos = dao::get_listado_cargos_por_persona($where);
		}else{

		}*/
		$datos = dao::get_listado_cargos_por_persona();
		$datosexcedidos = array();
		for ($i = 0; $i < count($datos); $i++) 
		{
			if ($datos[$i]['estado']=='ACTIVO')
			{
				if ($datos[$i]['tipo']=='horas')
				{
					if ($datos[$i]['cantidad_total_horas']>21)
					{
						$datosexcedidos[] = $datos[$i];
					} else {
						if ($datos[$i]['idtipo_hora']==1)
						{
							if ($datos[$i]['total_horas']>$datos[$i]['max_hs_nivel_superior'])
							{
								$datosexcedidos[] = $datos[$i];
							}
						}
					}

				} else {				

					if ($datos[$i]['historico']=='NO')
					{
						if ($datos[$i]['cargos_bloque']>1)
						{
								$datosexcedidos[] = $datos[$i];
						} else {

							if ($datos[$i]['jerarquico']=='SI')
							{
								if ($datos[$i]['cantidad_cargos_jerarquicos']>$datos[$i]['max_cargos'])
								{
									$datosexcedidos[] = $datos[$i];
								}
							} else {
								if ($datos[$i]['cantidad_cargos']>$datos[$i]['max_cargos'])
								{
									$datosexcedidos[] = $datos[$i];
								}
							}
						}

					}
										
				}	
				
			}


	  
			}
		$cuadro->set_datos($datosexcedidos);

	}

	//-----------------------------------------------------------------------------------
	//---- cuadro_viaticos --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_viaticos(sicd_ei_cuadro $cuadro)
	{
		$cuadro->set_manejador_salida('html', 'ei_cuadro_viaticos_salida_html');

	
		
	
		/*if(isset($this->s__datos_filtro))
		{
		

			$datos = dao::get_listado_viatico($this->s__where);
		}else{
			
		}*/
		$datos = dao::get_listado_viatico();
		$configuracion = dao::get_configuracion();
		$datosexcedidos = array();
		for ($i = 0; $i < count($datos); $i++) 
		{
			if ($datos[$i]['total_disponible']>=$configuracion[0]['cantidad_max_dias_viatico_mensual'])
			{
				$datosexcedidos[] =$datos[$i];
			}	  
		}
		$cuadro->set_datos($datosexcedidos);
		
	}

}

?>