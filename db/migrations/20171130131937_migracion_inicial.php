<?php

use Phinx\Migration\AbstractMigration;

class MigracionInicial extends AbstractMigration
{
    /**
     * Change Method.
     *
     * Write your reversible migrations using this method.
     *
     * More information on writing migrations is available here:
     * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
     *
     * The following commands can be used in this method and Phinx will
     * automatically reverse them when rolling back:
     *
     *    createTable
     *    renameTable
     *    addColumn
     *    renameColumn
     *    addIndex
     *    addForeignKey
     *
     * Remember to call "create()" or "update()" and NOT "save()" when working
     * with the Table class.
     */




    public function change()
    {


        $table = $this->table('cabecera', array('id' =>  false, 'primary_key' => 'nombre')); 
        $table->addColumn('nombre', 'string', array('limit' => 100))
              ->addColumn('descripcion', 'string', array('limit' => 300))
              ->addColumn('logo1', 'binary')
              ->addColumn('logo2', 'binary')
            ->create();
        
        $table = $this->table('configuracion', array('id' =>  false, 'primary_key' => 'cantidad_max_dias_viatico_mensual')); //aca digo que id_area va a hacer autonumerico
        $table->addColumn('cantidad_max_dias_viatico_mensual', 'integer')
              ->create();
        
        $table = $this->table('estado_civil', array('id' =>'idestado_civil'));//aca digo que id_area va a hacer autonumerico
        $table->addColumn('descripcion', 'string', array('limit' => 100))
              ->addIndex('descripcion', ['unique' => true])
            ->create();          

        $table = $this->table('funcion', array('id' =>'idfuncion'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addColumn('maximo_horas', 'integer' )
              ->addColumn('cantidad_permitida', 'integer' )
              ->addIndex('descripcion', ['unique' => true])
            ->create();        

        $table = $this->table('nivel_estudio', array('id' =>'idnivel_estudio'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addColumn('maximo_horas', 'integer' )
              ->addColumn('orden', 'integer' )
              ->addIndex('descripcion', ['unique' => true])
             ->create();              

        $table = $this->table('tipo_cargo', array('id' =>'idtipo_cargo'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addIndex('descripcion', ['unique' => true])
             ->create();     

        $table = $this->table('tipo_detalle_viatico', array('id' =>'idtipo_detalle_viatico'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addIndex('descripcion', ['unique' => true])
             ->create();  

        $table = $this->table('tipo_documento', array('id' =>'idtipo_documento'));
        $table->addColumn('sigla', 'string', array('limit' => 10))
              ->addColumn('descripcion', 'string', array('limit' => 50))
              ->addIndex('sigla', ['unique' => true])
              ->addIndex('descripcion', ['unique' => true])
             ->create();    

        $table = $this->table('tipo_telefono', array('id' =>'idtipo_telefono'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addIndex('descripcion', ['unique' => true])
             ->create();   

       
        $table = $this->table('pais', array('id' =>'idpais'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addIndex('descripcion', ['unique' => true])
             ->create(); 

        
        $table = $this->table('provincia', array('id' =>'idprovincia'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addColumn('idpais', 'integer')
              ->addForeignKey('idpais', 'pais', 'idpais')
              ->addIndex('descripcion', ['unique' => true])
            ->create();       


        $table = $this->table('localidad', array('id' =>'idlocalidad'));
        $table->addColumn('descripcion', 'string', array('limit' => 50))
              ->addColumn('idprovincia', 'integer')
              ->addForeignKey('idprovincia', 'provincia', 'idprovincia')
              ->addIndex('descripcion', ['unique' => true])
            ->create();      

        $table = $this->table('estudio', array('id' =>'idestudio'));
        $table->addColumn('titulo', 'string', array('limit' => 300))
              ->addColumn('sigla', 'string', array('limit' => 10))
              ->addIndex('titulo', ['unique' => true])
            ->create();     

      $table = $this->table('entidad', array('id' =>  'identidad'));
        $table->addColumn('sigla', 'string', array('limit' => 10))
              ->addColumn('nombre', 'string', array('limit' => 100))
              ->addColumn('idlocalidad', 'integer')
              ->addColumn('calle',  'string', array('limit' => 50))
              ->addColumn('altura', 'integer')
              ->addColumn('piso',  'string', array('limit' => 2))
              ->addColumn('depto',  'string', array('limit' => 2))
              ->addForeignKey('idlocalidad', 'localidad', 'idlocalidad')
              ->addIndex('nombre', ['unique' => true])
              ->addIndex('sigla', ['unique' => true])
            ->create();

        $table = $this->table('persona', array('id' =>'idpersona'));
        $table->addColumn('nombres', 'string', array('limit' => 100))
              ->addColumn('apellido', 'string', array('limit' => 100))
              ->addColumn('idtipo_documento', 'integer')
              ->addColumn('nro_documento', 'integer')
              ->addColumn('matricula', 'string', array('limit' => 20))
              ->addColumn('idestado_civil', 'integer')
              ->addColumn('cuil', 'string', array('limit' => 11))
              ->addColumn('correo', 'string', array('limit' => 100))
              ->addColumn('fecha_nacimiento', 'date')
              ->addColumn('sexo', 'string', array('limit' => 1))
              ->addColumn('idlocalidad', 'integer')
              ->addColumn('calle', 'string', array('limit' => 50))
              ->addColumn('altura', 'string', array('limit' => 5))
              ->addColumn('depto', 'string', array('limit' => 4))
              ->addColumn('piso', 'string', array('limit' => 2))
              ->addColumn('domicilio', 'string', array('limit' => 100))
              ->addColumn('matricula_activa', 'boolean')
              ->addColumn('fecha_baja_matricula', 'date')
              ->addColumn('baja', 'boolean')
              ->addForeignKey('idtipo_documento', 'tipo_documento', 'idtipo_documento')
              ->addForeignKey('idestado_civil', 'estado_civil', 'idestado_civil')
              ->addForeignKey('idlocalidad', 'localidad', 'idlocalidad')
              ->addIndex(['idtipo_documento','nro_documento'], ['unique' => true])
            ->create();       

        $table = $this->table('cargo_por_persona', array('id' => false,'primary_key' => ['idpersona','idfuncion','identidad','idtipo_cargo']));
        $table->addColumn('idpersona', 'integer')
              ->addColumn('idfuncion', 'integer')
              ->addColumn('identidad', 'integer')
              ->addColumn('idtipo_cargo', 'integer')
              ->addColumn('idnivel_estudio', 'integer')
              ->addColumn('cantidad_horas', 'float')
              ->addColumn('fecha_inicio', 'date')
              ->addColumn('fecha_fin', 'date')
              ->addColumn('activo', 'boolean', array('default' => true ))

              ->addForeignKey('idpersona', 'persona', 'idpersona')
              ->addForeignKey('identidad', 'entidad', 'identidad')
              ->addForeignKey('idfuncion', 'funcion', 'idfuncion')
              ->addForeignKey('idnivel_estudio', 'nivel_estudio', 'idnivel_estudio')
              ->addForeignKey('idtipo_cargo', 'tipo_cargo', 'idtipo_cargo')
              ->create();           

        $table = $this->table('viatico', array('id' => 'idviatico'));
        $table->addColumn('fecha_desde', 'date')
              ->addColumn('nro_expediente', 'string', array('limit' => 10))
              ->addColumn('fecha_hasta', 'date')
              ->addColumn('idpersona', 'integer')
              ->addColumn('idlocalidad_origen', 'integer')
              ->addColumn('idlocalidad_destino', 'integer')
              ->addColumn('cantidad_total_dias', 'float')
              ->addColumn('mes', 'integer')
              ->addColumn('cantidad_dias_reintegro', 'float')
              ->addColumn('cantidad_dias_disponible', 'float')
              ->addColumn('cantidad_dias_tomados', 'float')
              ->addForeignKey('idlocalidad_origen', 'localidad', 'idlocalidad')
              ->addForeignKey('idlocalidad_destino', 'localidad', 'idlocalidad')
              ->addForeignKey('idpersona', 'persona', 'idpersona')
             ->create();      
    

        $table = $this->table('detalle_dias_viatico', array('id' => 'iddetalle_dias_viatico'));
        $table->addColumn('fecha_desde', 'date')
              ->addColumn('fecha_hasta', 'date')
              ->addColumn('cantidad_dias', 'integer')
              ->addColumn('idlocalidad_origen', 'integer')
              ->addColumn('idlocalidad_destino', 'integer')
              ->addColumn('idviatico', 'integer')
              ->addColumn('medio_dia', 'boolean')
              ->addForeignKey('idviatico', 'viatico', 'idviatico')
             ->create();          

        $table = $this->table('detalle_viatico', array('id' => 'iddetalle_viatico'));
        $table->addColumn('monto', 'float')
              ->addColumn('descripcion', 'string', array('limit' => 50))
              ->addColumn('idtipo_detalle_viatico', 'integer')
              ->addColumn('idlocalidad_origen', 'integer')
              ->addColumn('idlocalidad_destino', 'integer')
              ->addColumn('idviatico', 'integer')
              ->addForeignKey('idtipo_detalle_viatico', 'tipo_detalle_viatico', 'idtipo_detalle_viatico')
              ->addForeignKey('idviatico', 'viatico', 'idviatico')
             ->create();        


  
        $table = $this->table('estudio_por_persona', array('id' => false , 'primary_key' => ['idpersona','idestudio','identidad','idnivel_estudio']));
        $table->addColumn('idestudio', 'integer')
              ->addColumn('idnivel_estudio', 'integer')
              ->addColumn('idpersona', 'integer')
              ->addColumn('identidad', 'integer')
              ->addColumn('obervaciones', 'text')
              ->addForeignKey('identidad', 'entidad', 'identidad')
              ->addForeignKey('idestudio', 'estudio', 'idestudio')
              ->addForeignKey('idnivel_estudio', 'nivel_estudio', 'idnivel_estudio')
              ->addForeignKey('idpersona', 'persona', 'idpersona')
             ->create();           

        $table = $this->table('telefono_por_persona', array('id' => false , 'primary_key' => ['idtipo_telefono','idpersona']));
        $table->addColumn('idtipo_telefono', 'integer')
              ->addColumn('idpersona', 'integer')
              ->addColumn('numero', 'string', array('limit' => 15))
              ->addForeignKey('idtipo_telefono', 'tipo_telefono', 'idtipo_telefono')
              ->addForeignKey('idpersona', 'persona', 'idpersona')
             ->create();    
  }

}
