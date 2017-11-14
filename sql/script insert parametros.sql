select 'insert into pais values(default, ' || '''' || descripcion || '''' ||');'
from gral_pais

select 'insert into provincia values(default, '  || idpais ||', ' || '''' || descripcion || '''' ||  ');'
from gral_provincia

select 'insert into localidad values(default, ' || idprovincia || ', '  || '''' || descripcion || '''' ||  ');'
from gral_localidad


select 'insert into tipo_documento values(default, ' || '''' || sigla || ''' '||','|| '''' || descripcion || '''' ||');'
from leu_tipo_documento 


select 'insert into estado_civil values(default, ' || '''' || descripcion || '''' ||');'
from leu_estado_civil 


select 'insert into tipo_telefono values(default, ' || '''' || descripcion || '''' ||');'
from leu_tipo_telefono 


select 'insert into tipo_detalle_viatico values(default, ' || '''' || descripcion || '''' ||');'
from leu_motivo_viatico

