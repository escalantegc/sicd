<?php
class ei_cuadro_personal extends sicd_ei_cuadro
{
	//---- Config. EVENTOS sobre fila ---------------------------------------------------

	function conf_evt__baja($evento, $fila)
	{
		if ($this->datos[$fila]['baja']==1 ) 
		{
			$evento->anular();    
		}
	}

	function conf_evt__alta($evento, $fila)
	{
		if ($this->datos[$fila]['baja']==0 ) 
		{
			$evento->anular();    
		}
	}

}
?>