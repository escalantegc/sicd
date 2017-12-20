<?php
class dao 
{
	function get_listado_personas($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1 and baja = false';
		}
		$sql = "SELECT 	idpersona, 
						nombres ||', '|| apellido as persona, 
						sigla ||' - '||  nro_documento as nro_documento , 
       					matricula, 
       					estado_civil.descripcion as estado_civil, 
       					cuil, 
       					correo,
       					fecha_nacimiento, 
       					(case when sexo ilike 'm' then 'MASCULINO' else (case when sexo ilike 'f' then 'FEMENINO' else 'Otros' end) end) as sexo, 
       					localidad.descripcion as localidad, 
       					calle, 
       					altura, 
       					depto, 
       					piso, 
       					domicilio, 
       					matricula_activa, 
       					fecha_baja_matricula,
       					baja,
       					date_part('year',age(fecha_nacimiento))  as edad
  				FROM 
  					public.persona
  				inner join tipo_documento using (idtipo_documento)
  				left outer join estado_civil using (idestado_civil)
  				inner join localidad using (idlocalidad)
  				where
  					$where;";
  		return consultar_fuente($sql);
	}

	function get_tipo_documento($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idtipo_documento, 
						sigla, 
						descripcion
  				FROM 
  					public.tipo_documento
  				where
  					$where
  				order by
  					sigla,
  					descripcion";
  		return consultar_fuente($sql);
	}

	function get_localidades_combo_editable($filtro = null)
	{
		if (! isset($filtro) || trim($filtro)=='')
		{
			return array();
		}
		$filtro = quote("%{$filtro}%");

		$sql = "SELECT 	localidad.idlocalidad, 
						localidad.descripcion ||' - '||provincia.descripcion ||' - '|| pais.descripcion as localidad
				  FROM 
				  	public.localidad
				  inner join provincia using (idprovincia)
				  inner join pais using (idpais)
				 WHERE 
				 	(localidad.descripcion ||' - '||provincia.descripcion ||' - '|| pais.descripcion) ilike $filtro limit 20 ";
		return consultar_fuente($sql);

	}	

	function get_descripcion_localidad($idlocalidad = null)
	{
	

		$sql = "SELECT 	localidad.idlocalidad, 
						localidad.descripcion ||' - '||provincia.descripcion ||' - '|| pais.descripcion as localidad
				  FROM 
				  	public.localidad
				  inner join provincia using (idprovincia)
				  inner join pais using (idpais)
				 WHERE 
				 	localidad.idlocalidad =  $idlocalidad";
		$res = consultar_fuente($sql);
		if (isset($res[0]['localidad']))
		{
			return $res[0]['localidad'];
		}

	}

	function get_listado_estado_civil($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idestado_civil, 
						descripcion
  				FROM 
  					public.estado_civil	
  				WHERE
  					$where
  				order by
  					descripcion";
  		return consultar_fuente($sql);	
	}

	function get_tipo_telefono($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idtipo_telefono, 
						descripcion
  				FROM 
  					public.tipo_telefono
  				WHERE
  					$where
  				order by
  					descripcion";
  		return consultar_fuente($sql);	
	}

	function get_listado_entidades($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	identidad, 
						sigla, 
						nombre, 
						idlocalidad, 
						calle, 
						altura, 
						piso, 
						depto,
						localidad.descripcion as localidad
  				FROM public.entidad
  				inner join localidad using (idlocalidad)
  				WHERE
  					$where
  					order by nombre";
  		return consultar_fuente($sql);			
	}

	function get_listado_nivel_estudio($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}

		$sql = "SELECT idnivel_estudio, 
						descripcion, 
						nivel,
						orden
  				FROM 
  				public.nivel_estudio
  				WHERE
  					$where
  				order by orden asc";
  		return consultar_fuente($sql);		
	}

	function get_listado_funcion($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT idfuncion, 
						descripcion, 
						maximo_horas, 
						cantidad_permitida
  				FROM 
  					public.funcion
  				WHERE
  					$where
  				order by
  					descripcion";
  		return consultar_fuente($sql);	
	}

	function get_listado_tipo_cargo($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql ="SELECT 	idtipo_cargo, 
						descripcion,
						cantidad_cargos
  				FROM 
  					public.tipo_cargo
  				WHERE
  					$where
  				order by
  					descripcion";
  		return consultar_fuente($sql);
	}

	function get_listado_cargos_por_persona($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT  cargo_por_persona.idcargo_por_persona,
						cargo_por_persona.idpersona, 
						cargo_por_persona.identidad, 
						cargo_por_persona.idtipo_cargo, 
						(case when  tipo_cargo.descripcion is null then tipo_hora.descripcion else tipo_cargo.descripcion end) as cargo,
						cargo_por_persona.idtipo_hora, 
						tipo_cargo.cantidad_cargos as max_cargos,
						entidad.nombre as entidad,
						tipo_hora.max_hs_nivel_medio,
						tipo_hora.max_hs_nivel_superior,
						cantidad_horas, 
					    (sumas_horas_segun_tipo(cargo_por_persona.idtipo_hora)) as total_horas,
					    --(contar_cargos_segun_tipo(cargo_por_persona.idtipo_cargo)) as cantidad_cargos,
					    --(contar_cargos()) as cantidad_cargos,
					    (contar_cargos_segun_tipo_jerarquico(tipo_cargo.jerarquico))  as cantidad_cargos,
					    tipo_cargo.jerarquico,
						fecha_fin, 
						activo,
						(case when idtipo_cargo is null then 'Bloque 2' else 'Bloque 1' end ) as bloque
				FROM 
					cargo_por_persona
				  inner join entidad  using(identidad)
				  left outer join tipo_cargo  using(idtipo_cargo)
				  left outer join tipo_hora  using(idtipo_hora)

				  WHERE
  					$where
  					order by 
  						bloque,
  						cargo_por_persona.idtipo_hora";
  		return consultar_fuente($sql);
	}


	function get_listado_viatico($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idviatico, 
						nro_expediente, 
						idpersona, 
						cantidad_total_dias ,
						mes ,
						cantidad_dias_reintegro ,
						cantidad_dias_disponible ,
						cantidad_dias_tomados, 
						(select sumar_dias_disponible_por_mes(mes)) as total_disponible


  				FROM 
  					public.viatico

  				left outer join detalle_dias_viatico using(idviatico)
				left outer join localidad localidad_origen on localidad_origen.idlocalidad=detalle_dias_viatico.idlocalidad_origen
				left outer join localidad localidad_destino on localidad_destino.idlocalidad=detalle_dias_viatico.idlocalidad_destino 
				WHERE
  					$where
  				
  				group by 
  				idviatico, 
						nro_expediente, 
						idpersona, 
					    cantidad_total_dias ,
  						mes,
  						cantidad_dias_reintegro,
  						cantidad_dias_disponible,
  						cantidad_dias_tomados
  				order by mes asc		
  				";
  		return consultar_fuente($sql);
	}

	function get_localidad_origen($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idlocalidad as idlocalidad_origen, 
						 localidad.descripcion||' - '||  provincia.descripcion as localidad
						
  				FROM public.localidad
  				inner join provincia using (idprovincia) 
  				where $where 
  				order by provincia.descripcion";
  		return consultar_fuente($sql);
  	}	

  	function get_localidad_destino($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idlocalidad as idlocalidad_destino, 
						 localidad.descripcion||' - '||  provincia.descripcion as localidad
						
  				FROM public.localidad
  				inner join provincia using (idprovincia) 
  				where $where 
  				order by provincia.descripcion";
  		return consultar_fuente($sql);
  	}

  	function get_tipo_detalle_viatico($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 	idtipo_detalle_viatico, 
  						descripcion
  				FROM 
  					public.tipo_detalle_viatico
  				WHERE
  					$where
  				order by
  					descripcion";
  		return consultar_fuente($sql);
  	}  
  	function get_listado_pais($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 	idpais, 
  						descripcion
  				FROM public.pais
  				WHERE
  					$where
  				order by 
  					descripcion";
  		return consultar_fuente($sql);
  	}  

  	function get_listado_provincia($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 	idprovincia, 
  						pais.descripcion as pais,
  						provincia.descripcion
  				FROM 
  					public.provincia
  				inner join pais using (idpais)
   				WHERE
  					$where
  				order by 
  					provincia.descripcion";
  		return consultar_fuente($sql);
  	}  
  	function get_listado_localidad($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 	localidad.idprovincia, 
  						localidad.idlocalidad,
  						pais.descripcion as pais,
  						provincia.descripcion as provincia,
  						localidad.descripcion as localidad
  				FROM 
  					public.localidad
  				inner join provincia using (idprovincia)
  				inner join pais using (idpais)
   				WHERE
  					$where
  				order by 
  					localidad.descripcion";
  		return consultar_fuente($sql);
  	}

  	function get_pais_localidad($idlocalidad)
  	{
  		$sql = "SELECT idpais
				FROM 
					public.localidad
				 inner join provincia using (idprovincia)
				   where idlocalidad =$idlocalidad";

		return consultar_fuente($sql);
  	}
  	function get_pais_provincia($idprovincia)
  	{
  		$sql = "SELECT idpais
				FROM 
					public.provincia
				   where idprovincia =$idprovincia";

		return consultar_fuente($sql);
  	}


  	  function get_listado_provincia_cascada($idpais = null)
	{

  		$sql = "SELECT 	idprovincia, 
  						provincia.descripcion
  				FROM 
  					public.provincia
   				WHERE
  					provincia.idpais = $idpais ";
  		return consultar_fuente($sql);
  	}  
  	function get_listado_estudio($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 	titulo, 
  						idestudio,
  						sigla
  				FROM public.estudio
  				WHERE
  					$where
  				order by titulo";
  		return consultar_fuente($sql);
  	}

  	function get_listado_estudios_por_persona($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 
					estudio_por_persona.idestudio, 
					estudio_por_persona.idnivel_estudio, 
					estudio_por_persona.idpersona, 
					estudio_por_persona.identidad, 
					estudio_por_persona.obervaciones,
					nivel_estudio.descripcion as nivel_estudio,
					entidad.nombre as entidad,
					estudio.titulo
	
			  	FROM 
			  		public.estudio_por_persona
				inner join nivel_estudio using(idnivel_estudio)
				inner join persona using(idpersona)
				left outer join entidad using(identidad)
				inner join estudio using(idestudio)
				WHERE
  					$where
  				order by nivel_estudio.orden";
  		return consultar_fuente($sql);
  	}

  	function get_nombre_localidad($idlocalidad = null)
  	{
  		$sql = "SELECT  descripcion
  				FROM 
  					public.localidad
  				WHERE
  					idlocalidad = $idlocalidad;";
  		return consultar_fuente($sql);
  	}

  	function get_configuracion()
  	{
  		$sql ="	SELECT cantidad_max_dias_viatico_mensual
 				 FROM 
 				 	public.configuracion;";
 		return consultar_fuente($sql);
  	
  	}

  	function get_listado_tipo_hora($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
  		$sql = "SELECT 	idtipo_hora, 
  						descripcion, 
  						max_hs_nivel_medio, 
  						max_hs_nivel_superior
  				FROM 
  					public.tipo_hora
  				where 
  					$where
  				order by
  					descripcion";
  		return consultar_fuente($sql);			
  	}

  
}
?>