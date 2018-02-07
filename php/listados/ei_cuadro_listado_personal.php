<?php
class ei_cuadro_listado_personal extends sicd_ei_cuadro
{
	function vista_excel(toba_vista_excel $salida)
	{
		$salida->inicializar();
		
		$titulo = 'Listado de personal';
		$salida->titulo($titulo); 
		       
		$salida->set_nombre_archivo('listado_personal.xls');
					   
		$this->generar_salida('excel', $salida);
	}
       
	function vista_pdf(toba_vista_pdf $salida)
	{
		$salida->inicializar();
		$titulo = 'Listado de personal';
		$salida->titulo($titulo); 
		       
		$salida->set_nombre_archivo('listado_personal.pdf');
					   
		//Pie de pagina
		$pdf = $salida->get_pdf();
		$formato = 'Pagina {PAGENUM} de {TOTALPAGENUM}';
		$pdf->ezStartPageNumbers(580, 20, 8, 'center', $formato, 1);  
		$this->generar_salida('pdf', $salida);
	}
}

?>