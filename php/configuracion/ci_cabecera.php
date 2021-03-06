<?php
class ci_cabecera extends sicd_ci
{

	function conf()
	{
		$this->cn()->cargar_dt_cabecera();
	}
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		

		try{
			$this->cn()->guardar();
			
			toba::notificacion()->agregar("Los datos se han guardado correctamente",'info');
		} catch( toba_error_db $error){
		
		}
		toba::vinculador()->navegar_a('sicd','3486');
	}

	function evt__cancelar()
	{
		$this->cn()->procesar();
	}

	//-----------------------------------------------------------------------------------
	//---- frm --------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm(sicd_ei_formulario $form)
	{
		$this->cn()->cargar_dt_cabecera();
		$datos = $this->cn()->get_dt_cabecera();
		$form->set_datos($datos);
	}

	function evt__frm__modificacion($datos)
	{
		$this->cn()->set_dt_cabecera($datos);	
		$this->set_pantalla('pant_inicial');
	}

}

?>