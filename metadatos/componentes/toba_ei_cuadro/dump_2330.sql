------------------------------------------------------------
--[2330]--  ci_personal_principal - ci_personal - ci_viaticos - cuadro 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'sicd', --proyecto
	'2330', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_ei_cuadro', --clase
	'13', --punto_montaje
	'ei_cuadro_viaticos', --subclase
	'persona/ei_cuadro_viaticos.php', --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'ci_personal_principal - ci_personal - ci_viaticos - cuadro', --nombre
	'Viaticos', --titulo
	'0', --colapsable
	NULL, --descripcion
	NULL, --fuente_datos_proyecto
	NULL, --fuente_datos
	NULL, --solicitud_registrar
	NULL, --solicitud_obj_obs_tipo
	NULL, --solicitud_obj_observacion
	NULL, --parametro_a
	NULL, --parametro_b
	NULL, --parametro_c
	NULL, --parametro_d
	NULL, --parametro_e
	NULL, --parametro_f
	NULL, --usuario
	'2017-11-07 20:47:21', --creacion
	'abajo'  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_eventos
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_eventos (proyecto, evento_id, objeto, identificador, etiqueta, maneja_datos, sobre_fila, confirmacion, estilo, imagen_recurso_origen, imagen, en_botonera, ayuda, orden, ci_predep, implicito, defecto, display_datos_cargados, grupo, accion, accion_imphtml_debug, accion_vinculo_carpeta, accion_vinculo_item, accion_vinculo_objeto, accion_vinculo_popup, accion_vinculo_popup_param, accion_vinculo_target, accion_vinculo_celda, accion_vinculo_servicio, es_seleccion_multiple, es_autovinculo) VALUES (
	'sicd', --proyecto
	'1115', --evento_id
	'2330', --objeto
	'seleccion', --identificador
	'', --etiqueta
	'1', --maneja_datos
	'1', --sobre_fila
	NULL, --confirmacion
	NULL, --estilo
	'apex', --imagen_recurso_origen
	'doc.gif', --imagen
	'0', --en_botonera
	NULL, --ayuda
	'1', --orden
	NULL, --ci_predep
	NULL, --implicito
	NULL, --defecto
	NULL, --display_datos_cargados
	NULL, --grupo
	NULL, --accion
	NULL, --accion_imphtml_debug
	NULL, --accion_vinculo_carpeta
	NULL, --accion_vinculo_item
	NULL, --accion_vinculo_objeto
	NULL, --accion_vinculo_popup
	NULL, --accion_vinculo_popup_param
	NULL, --accion_vinculo_target
	NULL, --accion_vinculo_celda
	NULL, --accion_vinculo_servicio
	'0', --es_seleccion_multiple
	'0'  --es_autovinculo
);
INSERT INTO apex_objeto_eventos (proyecto, evento_id, objeto, identificador, etiqueta, maneja_datos, sobre_fila, confirmacion, estilo, imagen_recurso_origen, imagen, en_botonera, ayuda, orden, ci_predep, implicito, defecto, display_datos_cargados, grupo, accion, accion_imphtml_debug, accion_vinculo_carpeta, accion_vinculo_item, accion_vinculo_objeto, accion_vinculo_popup, accion_vinculo_popup_param, accion_vinculo_target, accion_vinculo_celda, accion_vinculo_servicio, es_seleccion_multiple, es_autovinculo) VALUES (
	'sicd', --proyecto
	'1238', --evento_id
	'2330', --objeto
	'borrar', --identificador
	NULL, --etiqueta
	'1', --maneja_datos
	'1', --sobre_fila
	'�Esta seguro de borrar el registro?', --confirmacion
	NULL, --estilo
	'apex', --imagen_recurso_origen
	'borrar', --imagen
	'0', --en_botonera
	NULL, --ayuda
	'2', --orden
	NULL, --ci_predep
	NULL, --implicito
	NULL, --defecto
	NULL, --display_datos_cargados
	NULL, --grupo
	NULL, --accion
	NULL, --accion_imphtml_debug
	NULL, --accion_vinculo_carpeta
	NULL, --accion_vinculo_item
	NULL, --accion_vinculo_objeto
	'0', --accion_vinculo_popup
	NULL, --accion_vinculo_popup_param
	NULL, --accion_vinculo_target
	NULL, --accion_vinculo_celda
	NULL, --accion_vinculo_servicio
	'0', --es_seleccion_multiple
	'0'  --es_autovinculo
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_cuadro
------------------------------------------------------------
INSERT INTO apex_objeto_cuadro (objeto_cuadro_proyecto, objeto_cuadro, titulo, subtitulo, sql, columnas_clave, columna_descripcion, clave_dbr, archivos_callbacks, ancho, ordenar, paginar, tamano_pagina, tipo_paginado, mostrar_total_registros, eof_invisible, eof_customizado, siempre_con_titulo, exportar_paginado, exportar, exportar_rtf, pdf_propiedades, pdf_respetar_paginacion, asociacion_columnas, ev_seleccion, ev_eliminar, dao_nucleo_proyecto, dao_nucleo, dao_metodo, dao_parametros, desplegable, desplegable_activo, scroll, scroll_alto, cc_modo, cc_modo_anidado_colap, cc_modo_anidado_totcol, cc_modo_anidado_totcua) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	NULL, --titulo
	NULL, --subtitulo
	NULL, --sql
	'idviatico', --columnas_clave
	NULL, --columna_descripcion
	'0', --clave_dbr
	NULL, --archivos_callbacks
	'100%', --ancho
	'1', --ordenar
	'0', --paginar
	'10', --tamano_pagina
	'P', --tipo_paginado
	'0', --mostrar_total_registros
	'0', --eof_invisible
	NULL, --eof_customizado
	'0', --siempre_con_titulo
	'0', --exportar_paginado
	'1', --exportar
	'1', --exportar_rtf
	NULL, --pdf_propiedades
	NULL, --pdf_respetar_paginacion
	NULL, --asociacion_columnas
	NULL, --ev_seleccion
	NULL, --ev_eliminar
	NULL, --dao_nucleo_proyecto
	NULL, --dao_nucleo
	NULL, --dao_metodo
	NULL, --dao_parametros
	NULL, --desplegable
	NULL, --desplegable_activo
	'0', --scroll
	NULL, --scroll_alto
	't', --cc_modo
	'0', --cc_modo_anidado_colap
	NULL, --cc_modo_anidado_totcol
	NULL  --cc_modo_anidado_totcua
);

------------------------------------------------------------
-- apex_objeto_cuadro_cc
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_cuadro_cc (objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_cc, identificador, descripcion, orden, columnas_id, columnas_descripcion, pie_contar_filas, pie_mostrar_titular, pie_mostrar_titulos, imp_paginar, modo_inicio_colapsado) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'33', --objeto_cuadro_cc
	'mes', --identificador
	'Detalle del mes', --descripcion
	'1', --orden
	'mes', --columnas_id
	'mes', --columnas_descripcion
	'0', --pie_contar_filas
	'0', --pie_mostrar_titular
	'0', --pie_mostrar_titulos
	NULL, --imp_paginar
	'0'  --modo_inicio_colapsado
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_ei_cuadro_columna
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_ei_cuadro_columna (objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, clave, orden, titulo, estilo_titulo, estilo, ancho, formateo, vinculo_indice, no_ordenar, mostrar_xls, mostrar_pdf, pdf_propiedades, desabilitado, total, total_cc, usar_vinculo, vinculo_carpeta, vinculo_item, vinculo_popup, vinculo_popup_param, vinculo_target, vinculo_celda, vinculo_servicio, permitir_html, grupo, evento_asociado) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'844', --objeto_cuadro_col
	'nro_expediente', --clave
	'1', --orden
	'Nro expediente', --titulo
	'ei-cuadro-col-tit', --estilo_titulo
	'4', --estilo
	NULL, --ancho
	'1', --formateo
	NULL, --vinculo_indice
	'0', --no_ordenar
	NULL, --mostrar_xls
	NULL, --mostrar_pdf
	NULL, --pdf_propiedades
	NULL, --desabilitado
	'0', --total
	NULL, --total_cc
	'0', --usar_vinculo
	NULL, --vinculo_carpeta
	NULL, --vinculo_item
	NULL, --vinculo_popup
	NULL, --vinculo_popup_param
	NULL, --vinculo_target
	NULL, --vinculo_celda
	NULL, --vinculo_servicio
	'1', --permitir_html
	NULL, --grupo
	NULL  --evento_asociado
);
INSERT INTO apex_objeto_ei_cuadro_columna (objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, clave, orden, titulo, estilo_titulo, estilo, ancho, formateo, vinculo_indice, no_ordenar, mostrar_xls, mostrar_pdf, pdf_propiedades, desabilitado, total, total_cc, usar_vinculo, vinculo_carpeta, vinculo_item, vinculo_popup, vinculo_popup_param, vinculo_target, vinculo_celda, vinculo_servicio, permitir_html, grupo, evento_asociado) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'868', --objeto_cuadro_col
	'cantidad_dias_reintegro', --clave
	'4', --orden
	'Dias reintegrados', --titulo
	'ei-cuadro-col-tit', --estilo_titulo
	'col-num-p1', --estilo
	NULL, --ancho
	'1', --formateo
	NULL, --vinculo_indice
	'0', --no_ordenar
	NULL, --mostrar_xls
	NULL, --mostrar_pdf
	NULL, --pdf_propiedades
	NULL, --desabilitado
	'0', --total
	NULL, --total_cc
	'0', --usar_vinculo
	NULL, --vinculo_carpeta
	NULL, --vinculo_item
	NULL, --vinculo_popup
	NULL, --vinculo_popup_param
	NULL, --vinculo_target
	NULL, --vinculo_celda
	NULL, --vinculo_servicio
	'1', --permitir_html
	NULL, --grupo
	NULL  --evento_asociado
);
INSERT INTO apex_objeto_ei_cuadro_columna (objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, clave, orden, titulo, estilo_titulo, estilo, ancho, formateo, vinculo_indice, no_ordenar, mostrar_xls, mostrar_pdf, pdf_propiedades, desabilitado, total, total_cc, usar_vinculo, vinculo_carpeta, vinculo_item, vinculo_popup, vinculo_popup_param, vinculo_target, vinculo_celda, vinculo_servicio, permitir_html, grupo, evento_asociado) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'869', --objeto_cuadro_col
	'cantidad_total_dias', --clave
	'2', --orden
	'Total dias', --titulo
	'ei-cuadro-col-tit', --estilo_titulo
	'col-num-p1', --estilo
	NULL, --ancho
	'1', --formateo
	NULL, --vinculo_indice
	'0', --no_ordenar
	NULL, --mostrar_xls
	NULL, --mostrar_pdf
	NULL, --pdf_propiedades
	NULL, --desabilitado
	'0', --total
	NULL, --total_cc
	'0', --usar_vinculo
	NULL, --vinculo_carpeta
	NULL, --vinculo_item
	NULL, --vinculo_popup
	NULL, --vinculo_popup_param
	NULL, --vinculo_target
	NULL, --vinculo_celda
	NULL, --vinculo_servicio
	'1', --permitir_html
	NULL, --grupo
	NULL  --evento_asociado
);
INSERT INTO apex_objeto_ei_cuadro_columna (objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, clave, orden, titulo, estilo_titulo, estilo, ancho, formateo, vinculo_indice, no_ordenar, mostrar_xls, mostrar_pdf, pdf_propiedades, desabilitado, total, total_cc, usar_vinculo, vinculo_carpeta, vinculo_item, vinculo_popup, vinculo_popup_param, vinculo_target, vinculo_celda, vinculo_servicio, permitir_html, grupo, evento_asociado) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'871', --objeto_cuadro_col
	'cantidad_dias_disponible', --clave
	'3', --orden
	'Dias disponibles', --titulo
	'ei-cuadro-col-tit', --estilo_titulo
	'col-num-p1', --estilo
	NULL, --ancho
	'1', --formateo
	NULL, --vinculo_indice
	'0', --no_ordenar
	NULL, --mostrar_xls
	NULL, --mostrar_pdf
	NULL, --pdf_propiedades
	NULL, --desabilitado
	'0', --total
	NULL, --total_cc
	'0', --usar_vinculo
	NULL, --vinculo_carpeta
	NULL, --vinculo_item
	NULL, --vinculo_popup
	NULL, --vinculo_popup_param
	NULL, --vinculo_target
	NULL, --vinculo_celda
	NULL, --vinculo_servicio
	'1', --permitir_html
	NULL, --grupo
	NULL  --evento_asociado
);
INSERT INTO apex_objeto_ei_cuadro_columna (objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, clave, orden, titulo, estilo_titulo, estilo, ancho, formateo, vinculo_indice, no_ordenar, mostrar_xls, mostrar_pdf, pdf_propiedades, desabilitado, total, total_cc, usar_vinculo, vinculo_carpeta, vinculo_item, vinculo_popup, vinculo_popup_param, vinculo_target, vinculo_celda, vinculo_servicio, permitir_html, grupo, evento_asociado) VALUES (
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'872', --objeto_cuadro_col
	'cantidad_dias_tomados', --clave
	'5', --orden
	'Dias tomados', --titulo
	'ei-cuadro-col-tit', --estilo_titulo
	'col-num-p1', --estilo
	NULL, --ancho
	'1', --formateo
	NULL, --vinculo_indice
	'0', --no_ordenar
	NULL, --mostrar_xls
	NULL, --mostrar_pdf
	NULL, --pdf_propiedades
	NULL, --desabilitado
	'0', --total
	NULL, --total_cc
	'0', --usar_vinculo
	NULL, --vinculo_carpeta
	NULL, --vinculo_item
	NULL, --vinculo_popup
	NULL, --vinculo_popup_param
	NULL, --vinculo_target
	NULL, --vinculo_celda
	NULL, --vinculo_servicio
	'1', --permitir_html
	NULL, --grupo
	NULL  --evento_asociado
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_cuadro_col_cc
------------------------------------------------------------
INSERT INTO apex_objeto_cuadro_col_cc (objeto_cuadro_cc, objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, total) VALUES (
	'33', --objeto_cuadro_cc
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'868', --objeto_cuadro_col
	'1'  --total
);
INSERT INTO apex_objeto_cuadro_col_cc (objeto_cuadro_cc, objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, total) VALUES (
	'33', --objeto_cuadro_cc
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'869', --objeto_cuadro_col
	'1'  --total
);
INSERT INTO apex_objeto_cuadro_col_cc (objeto_cuadro_cc, objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, total) VALUES (
	'33', --objeto_cuadro_cc
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'871', --objeto_cuadro_col
	'1'  --total
);
INSERT INTO apex_objeto_cuadro_col_cc (objeto_cuadro_cc, objeto_cuadro_proyecto, objeto_cuadro, objeto_cuadro_col, total) VALUES (
	'33', --objeto_cuadro_cc
	'sicd', --objeto_cuadro_proyecto
	'2330', --objeto_cuadro
	'872', --objeto_cuadro_col
	'1'  --total
);
