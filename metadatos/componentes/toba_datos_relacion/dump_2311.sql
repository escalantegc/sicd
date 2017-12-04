------------------------------------------------------------
--[2311]--  - dr_personal 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_datos_relacion', --clase
	'13', --punto_montaje
	NULL, --subclase
	NULL, --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'- dr_personal', --nombre
	NULL, --titulo
	NULL, --colapsable
	NULL, --descripcion
	'sicd', --fuente_datos_proyecto
	'sicd', --fuente_datos
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
	'2017-11-03 07:38:51', --creacion
	NULL  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel
------------------------------------------------------------
INSERT INTO apex_objeto_datos_rel (proyecto, objeto, debug, clave, ap, punto_montaje, ap_clase, ap_archivo, sinc_susp_constraints, sinc_orden_automatico, sinc_lock_optimista) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'0', --debug
	NULL, --clave
	'2', --ap
	'13', --punto_montaje
	NULL, --ap_clase
	NULL, --ap_archivo
	'0', --sinc_susp_constraints
	'1', --sinc_orden_automatico
	'1'  --sinc_lock_optimista
);

------------------------------------------------------------
-- apex_objeto_dependencias
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1197', --dep_id
	'2311', --objeto_consumidor
	'2322', --objeto_proveedor
	'dt_cargo_por_persona', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'1'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1234', --dep_id
	'2311', --objeto_consumidor
	'2365', --objeto_proveedor
	'dt_detalle_dias_viatico', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'2'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1195', --dep_id
	'2311', --objeto_consumidor
	'2320', --objeto_proveedor
	'dt_detalle_viatico', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'3'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1247', --dep_id
	'2311', --objeto_consumidor
	'2379', --objeto_proveedor
	'dt_estudio_por_persona', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'4'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1191', --dep_id
	'2311', --objeto_consumidor
	'2316', --objeto_proveedor
	'dt_personal', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'5'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1194', --dep_id
	'2311', --objeto_consumidor
	'2319', --objeto_proveedor
	'dt_telefono_por_persona', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'6'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'sicd', --proyecto
	'1196', --dep_id
	'2311', --objeto_consumidor
	'2321', --objeto_proveedor
	'dt_viatico', --identificador
	'', --parametros_a
	'', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'7'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel_asoc
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'44', --asoc_id
	NULL, --identificador
	'sicd', --padre_proyecto
	'2316', --padre_objeto
	'dt_personal', --padre_id
	NULL, --padre_clave
	'sicd', --hijo_proyecto
	'2319', --hijo_objeto
	'dt_telefono_por_persona', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'1'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'45', --asoc_id
	NULL, --identificador
	'sicd', --padre_proyecto
	'2316', --padre_objeto
	'dt_personal', --padre_id
	NULL, --padre_clave
	'sicd', --hijo_proyecto
	'2321', --hijo_objeto
	'dt_viatico', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'2'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'46', --asoc_id
	NULL, --identificador
	'sicd', --padre_proyecto
	'2321', --padre_objeto
	'dt_viatico', --padre_id
	NULL, --padre_clave
	'sicd', --hijo_proyecto
	'2320', --hijo_objeto
	'dt_detalle_viatico', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'3'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'47', --asoc_id
	NULL, --identificador
	'sicd', --padre_proyecto
	'2316', --padre_objeto
	'dt_personal', --padre_id
	NULL, --padre_clave
	'sicd', --hijo_proyecto
	'2322', --hijo_objeto
	'dt_cargo_por_persona', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'4'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'48', --asoc_id
	NULL, --identificador
	'sicd', --padre_proyecto
	'2321', --padre_objeto
	'dt_viatico', --padre_id
	NULL, --padre_clave
	'sicd', --hijo_proyecto
	'2365', --hijo_objeto
	'dt_detalle_dias_viatico', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'5'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'49', --asoc_id
	NULL, --identificador
	'sicd', --padre_proyecto
	'2316', --padre_objeto
	'dt_personal', --padre_id
	NULL, --padre_clave
	'sicd', --hijo_proyecto
	'2379', --hijo_objeto
	'dt_estudio_por_persona', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'6'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_rel_columnas_asoc
------------------------------------------------------------
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'44', --asoc_id
	'2316', --padre_objeto
	'812', --padre_clave
	'2319', --hijo_objeto
	'832'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'45', --asoc_id
	'2316', --padre_objeto
	'812', --padre_clave
	'2321', --hijo_objeto
	'843'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'46', --asoc_id
	'2321', --padre_objeto
	'839', --padre_clave
	'2320', --hijo_objeto
	'835'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'47', --asoc_id
	'2316', --padre_objeto
	'812', --padre_clave
	'2322', --hijo_objeto
	'846'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'48', --asoc_id
	'2321', --padre_objeto
	'839', --padre_clave
	'2365', --hijo_objeto
	'877'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'sicd', --proyecto
	'2311', --objeto
	'49', --asoc_id
	'2316', --padre_objeto
	'812', --padre_clave
	'2379', --hijo_objeto
	'895'  --hijo_clave
);
