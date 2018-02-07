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
		'ci_cabecera' => 'configuracion/ci_cabecera.php',
		'ci_configuracion' => 'configuracion/ci_configuracion.php',
		'cn_configuracion' => 'configuracion/cn_configuracion.php',
		'dao' => 'dao.php',
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
		'ci_listado_estudios' => 'listados/ci_listado_estudios.php',
		'ci_listado_personal' => 'listados/ci_listado_personal.php',
		'ci_listado_viaticos' => 'listados/ci_listado_viaticos.php',
		'ei_filtro_listado_estudios_persona' => 'listados/ei_filtro_listado_estudios_persona.php',
		'ei_filtro_listado_viatico_basico_persona' => 'listados/ei_filtro_listado_viatico_basico_persona.php',
		'ci_login' => 'login/ci_login.php',
		'cuadro_autologin' => 'login/cuadro_autologin.php',
		'pant_login' => 'login/pant_login.php',
		'ci_entidad' => 'parametros/ci_entidad.php',
		'ci_estado_civil' => 'parametros/ci_estado_civil.php',
		'ci_estudios' => 'parametros/ci_estudios.php',
		'ci_funcion' => 'parametros/ci_funcion.php',
		'ci_localidad' => 'parametros/ci_localidad.php',
		'ci_nivel_estudio' => 'parametros/ci_nivel_estudio.php',
		'ci_pais' => 'parametros/ci_pais.php',
		'ci_provincia' => 'parametros/ci_provincia.php',
		'ci_tipo_cargo' => 'parametros/ci_tipo_cargo.php',
		'ci_tipo_detalle_viatico' => 'parametros/ci_tipo_detalle_viatico.php',
		'ci_tipo_documento' => 'parametros/ci_tipo_documento.php',
		'ci_tipo_hora' => 'parametros/ci_tipo_hora.php',
		'ci_tipo_telefono' => 'parametros/ci_tipo_telefono.php',
		'cn_parametros' => 'parametros/cn_parametros.php',
		'ei_frm_entidad' => 'parametros/ei_frm_entidad.php',
		'ei_frm_estado_civil' => 'parametros/ei_frm_estado_civil.php',
		'ei_frm_estudio' => 'parametros/ei_frm_estudio.php',
		'ei_frm_funcion' => 'parametros/ei_frm_funcion.php',
		'ei_frm_localidad' => 'parametros/ei_frm_localidad.php',
		'ei_frm_nivel_estudio' => 'parametros/ei_frm_nivel_estudio.php',
		'ei_frm_pais' => 'parametros/ei_frm_pais.php',
		'ei_frm_provincia' => 'parametros/ei_frm_provincia.php',
		'ei_frm_tipo_cargo' => 'parametros/ei_frm_tipo_cargo.php',
		'ei_frm_tipo_detalle_viatico' => 'parametros/ei_frm_tipo_detalle_viatico.php',
		'ei_frm_tipo_documento' => 'parametros/ei_frm_tipo_documento.php',
		'ei_frm_tipo_hora' => 'parametros/ei_frm_tipo_hora.php',
		'ei_frm_tipo_telefono' => 'parametros/ei_frm_tipo_telefono.php',
		'ci_cargos' => 'persona/ci_cargos.php',
		'ci_estudios_por_persona' => 'persona/ci_estudios_por_persona.php',
		'ci_personal' => 'persona/ci_personal.php',
		'ci_personal_principal' => 'persona/ci_personal_principal.php',
		'ci_viaticos' => 'persona/ci_viaticos.php',
		'cn_personal' => 'persona/cn_personal.php',
		'ei_cuadro_cargos' => 'persona/ei_cuadro_cargos.php',
		'ei_cuadro_cargos_salida_html' => 'persona/ei_cuadro_cargos_salida_html.php',
		'ei_cuadro_personal' => 'persona/ei_cuadro_personal.php',
		'ei_cuadro_viaticos' => 'persona/ei_cuadro_viaticos.php',
		'ei_cuadro_viaticos_salida_html' => 'persona/ei_cuadro_viaticos_salida_html.php',
		'ei_frm_cargo_por_persona' => 'persona/ei_frm_cargo_por_persona.php',
		'ei_frm_ml_detalle_dias_viatico' => 'persona/ei_frm_ml_detalle_dias_viatico.php',
		'ei_frm_persona' => 'persona/ei_frm_persona.php',
		'ei_frm_viatico' => 'persona/ei_frm_viatico.php',
		'ei_pant_cargos' => 'persona/ei_pant_cargos.php',
		'sicd_autoload' => 'sicd_autoload.php',
	);
}
?>