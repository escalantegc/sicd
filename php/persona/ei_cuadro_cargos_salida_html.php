<?php
require_once('dao.php');
class ei_cuadro_cargos_salida_html extends toba_ei_cuadro_salida_html
{
	//-------------------------------------------------------------------------------
	//-- Generacion del CUADRO
	//-------------------------------------------------------------------------------

	/**
	 * Genera el html correspondiente a las filas del cuadro
	 */
	function html_cuadro(&$filas)
	{
		
		//Si existen cortes de control y el layout es tabular, el encabezado de la tabla ya se genero
		if( ! $this->_cuadro->tabla_datos_es_general() ){
			$this->html_cuadro_inicio();
		}
		//-- Se puede por api cambiar a que los titulos de las columnas se muestren antes que los cortes, en ese caso se evita hacerlo aqui
		if (! $this->_cuadro->debe_mostrar_titulos_columnas_cc()) {
			$this->html_cuadro_cabecera_columnas();
		}
		$par = false;
		$formateo = $this->_cuadro->get_instancia_clase_formateo('html');
		$layout_cant_columnas = $this->_cuadro->get_layout_cant_columnas();
		$i = 0;
		if (!is_null($layout_cant_columnas)) {
			echo "<tr>";
		}

		$columnas = $this->_cuadro->get_columnas();
		$datos = $this->_cuadro->get_datos();

		$objeto_js = $this->_cuadro->get_id_objeto_js();
		$evt_multiples = $this->_cuadro->get_eventos_multiples();

		foreach($filas as $f)
		{
			if (!is_null($layout_cant_columnas) && ($i % $layout_cant_columnas == 0)) {
				$ancho = floor(100 / (count($filas) / $layout_cant_columnas));
				echo "<td><table class='ei-cuadro-agrupador-filas' width='$ancho%' >";
			}
			$estilo_fila = $par ? 'ei-cuadro-celda-par' : 'ei-cuadro-celda-impar';
			$clave_fila = $this->_cuadro->get_clave_fila($f);
			
			//Recorro el array de datos para identificar en mi caso que fila excede el total_dispnible de 15
			//Este dato no lo seteo en el cuadro pero si lo traigo desde mi consulta en el dao
			//
			$claves = array();
			for ($i = 0; $i < count($datos); $i++) 
			{
				if ($datos[$i]['activo']==1)
				{
					if ($datos[$i]['idtipo_hora']==2)
					{
						if ($datos[$i]['total_horas']>$datos[$i]['max_hs_nivel_medio'])
						{
							$claves[] = $i;
						}

					} 

					if ($datos[$i]['idtipo_hora']==1)
					{
						if ($datos[$i]['total_horas']>$datos[$i]['max_hs_nivel_superior'])
						{
							$claves[] = $i;
						}
					}
					
					/*if (isset($datos[$i]['idtipo_cargo']))
					{
						if (isset($datos[$i]['jerarquico'])==1)
						{
					
							if ($datos[$i]['cantidad_cargos']>$datos[$i]['max_cargos'])
							{
								$claves[] = $i;
							}
						} 
						if (isset($datos[$i]['jerarquico'])==0)
						{
							if ($datos[$i]['cantidad_cargos']>$datos[$i]['max_cargos'])
							{
								$claves[] = $i;
							}
						}						

					
						
					}	*/
					
				}


	  
			}

			
			
			//Una vez que tengo las claves de fila que debo pintar
			// busco si la fila en la que estoy parado tengo q pintar y cambio el estilo 
			if (in_array($clave_fila, $claves)) 
			{
				$estilo_fila = 'ei-cuadro-celda-roja';
			}
			
			//Genero el html de la fila, junto con sus eventos y vinculos
			$this->generar_layout_fila($columnas, $datos, $f, $clave_fila, $evt_multiples, $objeto_js, $estilo_fila, $formateo);
			$par = !$par;
			if (isset($layout_cant_columnas) && $i % $layout_cant_columnas == $layout_cant_columnas-1) {
				echo "</table></td>";
			}
			$i++;
		}
		
		if (isset($layout_cant_columnas)) {
			echo "</tr>";
		}
		if( ! $this->_cuadro->tabla_datos_es_general() ){
			$this->html_acumulador_usuario();
			$this->html_cuadro_fin();
		}
	}

	
	
}
?>