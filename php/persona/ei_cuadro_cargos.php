<?php
class ei_cuadro_cargos extends sicd_ei_cuadro
{
	//---- Config. EVENTOS sobre fila ---------------------------------------------------

	function conf_evt__historico($evento, $fila)
	{
		//-ei_arbol($this->datos);
			if ($this->datos[$fila]['activo']==1 ) 
		{
			$evento->anular();    
		}
	}

	

	function sumarizar_cc__estado__horas($filas)
	{
		$total = 0;
		foreach ($filas as $fila) {
			if ($this->datos[$fila]['activo']==1)
			{
				$total += $this->datos[$fila]['cantidad_horas'];
			}
			
		}
		$resultado = $total;

		//echo "<strong>Cantidad Total de Horas</strong>: $resultado ";
		return number_format($resultado, 1, ',', '.');
	}

	

	//---- Configuracion de cortes de control -------------------------------------------

	function html_cabecera_cc_contenido__estado(&$nodo)
	{
		$zona = toba::escaper()->escapeHtml($nodo['descripcion']['estado']);
		$locs = count($nodo['filas']);
		$deps = count($nodo['hijos']);
		echo "<strong>Zona</strong>: $zona - 
			<strong>Departamentos</strong>: $deps - 
			<strong>Localidades</strong>: $locs";
	}
	
	function html_pie_cc_contenido__estado(&$nodo)
	{
			$escapador = toba::escaper();
		$zona = $escapador->escapeHtml($nodo['descripcion']['estado']);
		
		//Hago unos calculos
		$total = 0;
		foreach ($filas as $fila) {
			if ($this->datos[$fila]['activo']==1)
			{
				$total += $this->datos[$fila]['cantidad_horas'];
			}
			
		}
		$resultado = $total;

		$promedio = $escapador->escapeHtml($resultado);
		//$resultado = number_format($promedio, 2, ',', '.');
		echo "Cantidad de horas: <strong>$promedio</strong>.";
	}

}
?>