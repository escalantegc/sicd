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
       					(case when sexo ilike 'm' then 'Masculino' else (case when sexo ilike 'f' then 'Femenino' else 'Otros' end) end) as sexo, 
       					localidad.descripcion as localidad, 
       					calle, 
       					altura, 
       					depto, 
       					piso, 
       					domicilio, 
       					matricula_activa, 
       					fecha_baja_matricula,
       					baja
  				FROM 
  					public.persona
  				inner join tipo_documento using (idtipo_documento)
  				inner join estado_civil using (idestado_civil)
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
  					$where;";
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

	function get_estad_civil()
	{
		$sql = "SELECT 	idestado_civil, 
						descripcion
  				FROM 
  					public.estado_civil;";
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
  					$where";
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
						depto
  				FROM public.entidad
  				WHERE
  					$where";
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
						maximo_horas
  				FROM 
  				public.nivel_estudio
  				WHERE
  					$where";
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
  					$where";
  		return consultar_fuente($sql);	
	}

	function get_listado_tipo_cargo($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql ="SELECT 	idtipo_cargo, 
						descripcion
  				FROM 
  					public.tipo_cargo
  				WHERE
  					$where";
  		return consultar_fuente($sql);
	}

	function get_listado_cargos_por_persona($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT  cargo_por_persona.idpersona, 
						cargo_por_persona.idfuncion, 
						cargo_por_persona.identidad, 
						cargo_por_persona.idtipo_cargo, 
						cargo_por_persona.idnivel_estudio, 
						tipo_cargo.descripcion as cargo,
						funcion.descripcion as funcion,
						nivel_estudio.descripcion as nivel_estudio,
						entidad.nombre as entidad,
						cantidad_horas, 
						fecha_inicio, 
						fecha_fin, 
						activo
				FROM 
					cargo_por_persona
				  inner join funcion  using(idfuncion)
				  inner join entidad  using(identidad)
				  inner join tipo_cargo  using(idtipo_cargo)
				  inner join nivel_estudio using(idnivel_estudio)
				  WHERE
  					$where";
  		return consultar_fuente($sql);
	}


	function get_listado_viatico($where = null)
	{
		if (!isset($where))
		{
			$where = '1 = 1';
		}
		$sql = "SELECT 	idviatico, 
						fecha_desde, 
						nro_expediente, 
						fecha_hasta, 
						idpersona, 
				       idlocalidad_origen, 
				       idlocalidad_destino,
				       localidad_origen.descripcion as origen,
				       localidad_destino.descripcion as destino
  				FROM 
  					public.viatico
			  inner join localidad localidad_origen on localidad_origen.idlocalidad=viatico.idlocalidad_origen
			  inner join localidad localidad_destino on localidad_destino.idlocalidad=viatico.idlocalidad_destino 
			  WHERE
  					$where";
  					
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
  					$where";
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
  					$where";
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
  					$where";
  		return consultar_fuente($sql);
  	}
}
?>
