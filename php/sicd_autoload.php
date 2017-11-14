<?php
/**
 * Esta clase fue y será generada automáticamente. NO EDITAR A MANO.
 * @ignore
 */
class sicd_autoload 
{
	static function existe_clase($nombre)
	{
		return isset(self::$clases[$nombre]);
	}

	static function cargar($nombre)
	{
		if (self::existe_clase($nombre)) { 
			 require_once(dirname(__FILE__) .'/'. self::$clases[$nombre]); 
		}
	}

	static protected $clases = array(
		'sicd_ci' => 'extension_toba/componentes/sicd_ci.php',
		'sicd_cn' => 'extension_toba/componentes/sicd_cn.php',
		'sicd_datos_relacion' => 'extension_toba/componentes/sicd_datos_relacion.php',
		'sicd_datos_tabla' => 'extension_toba/componentes/sicd_datos_tabla.php',
		'sicd_ei_arbol' => 'extension_toba/componentes/sicd_ei_arbol.php',
		'sicd_ei_archivos' => 'extension_toba/componentes/sicd_ei_archivos.php',
		'sicd_ei_calendario' => 'extension_toba/componentes/sicd_ei_calendario.php',
		'sicd_ei_codigo' => 'extension_toba/componentes/sicd_ei_codigo.php',
		'sicd_ei_cuadro' => 'extension_toba/componentes/sicd_ei_cuadro.php',
		'sicd_ei_esquema' => 'extension_toba/componentes/sicd_ei_esquema.php',
		'sicd_ei_filtro' => 'extension_toba/componentes/sicd_ei_filtro.php',
		'sicd_ei_firma' => 'extension_toba/componentes/sicd_ei_firma.php',
		'sicd_ei_formulario' => 'extension_toba/componentes/sicd_ei_formulario.php',
		'sicd_ei_formulario_ml' => 'extension_toba/componentes/sicd_ei_formulario_ml.php',
		'sicd_ei_grafico' => 'extension_toba/componentes/sicd_ei_grafico.php',
		'sicd_ei_mapa' => 'extension_toba/componentes/sicd_ei_mapa.php',
		'sicd_servicio_web' => 'extension_toba/componentes/sicd_servicio_web.php',
		'sicd_comando' => 'extension_toba/sicd_comando.php',
		'sicd_modelo' => 'extension_toba/sicd_modelo.php',
	);
}
?>