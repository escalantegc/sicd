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

        //-----------------------------------------------------------------------------------
        //---- Estructura -------------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        $table = $this->table('agente_estado', array('id' => false,'primary_key' => 'sigla'));
        $table->addColumn('sigla', 'char', array('limit' => 2))
            ->addColumn('descripcion', 'string', array('limit' => 30))
            ->create();

        $table = $this->table('unidad_gestion');
        $table->addColumn('nombre', 'string', array('limit' => 30))
            ->addColumn('descripcion', 'text', array('null' => true))
            ->addColumn('id_ubicacion', 'integer', array('null' => true))
            ->create();

        $table = $this->table('unidad_desempenio');
        $table->addColumn('descripcion', 'string', array('limit' => 50))
            ->addColumn('id_mapuche', 'char', array('limit' => 4))
            ->addColumn('id_unidad_gestion', 'integer', array('null' => true))
            ->addForeignKey('id_unidad_gestion', 'unidad_gestion', 'id')
            ->create();

        $table = $this->table('agente');
        $table->addColumn('nombre', 'string', array('limit'=>30))
            ->addColumn('apellido', 'string', array('limit' => 30))
            ->addColumn('tipo', 'string', array('limit' => 4))
            ->addColumn('documento', 'integer')
            ->addColumn('fecha_nac', 'datetime', array('null' => true))
            ->addColumn('cargo_desempenio', 'string', array('limit' => 50))
            ->addColumn('legajo', 'integer', array('null' => true))
            ->addColumn('estado_civil', 'string', array('limit' => 30, 'null' => true))
            ->addColumn('nacionalidad', 'string', array('limit' => 30, 'null' => true))
            ->addColumn('genero', 'char', array('limit' => 1))
            ->addColumn('modificado', 'datetime', array('null' => true))
            ->addColumn('id_unidad_desempenio', 'integer')
            ->addColumn('id_agente_estado', 'char', array('limit' => 2))
            ->addForeignKey('id_unidad_desempenio', 'unidad_desempenio', 'id')
            ->addForeignKey('id_agente_estado', 'agente_estado', 'sigla')
            ->create();

        $table = $this->table('ubicacion');
        $table->addColumn('nombre', 'string', array('limit' => 60))
            ->create();

        $table = $this->table('agente_psicofisico', array('id' => false,'primary_key' => 'sigla'));
        $table->addColumn('sigla', 'char', array('limit' => 2))
            ->addColumn('descripcion', 'text', array('null' => true))
            ->create();

        $table = $this->table('tipo_evento', array('id' => false,'primary_key' => 'sigla'));
        $table->addColumn('sigla', 'string')
            ->addColumn('descripcion', 'text', array('null' => true))
            ->create();


        $table = $this->table('historico_estados');
        $table->addColumn('descripcion', 'string', array('limit' => 250))
            ->create();

        $table = $this->table('historico_eventos');
        $table->addColumn('id_agente', 'integer')
            ->addColumn('fecha_hora', 'datetime')
            ->addColumn('id_tipo_evento', 'string')
            ->addColumn('id_estado', 'integer')
            ->addColumn('id_usuario', 'string', array('limit' => 60))
            ->addColumn('id_historico_padre', 'integer', array('null' => true))
            ->addForeignKey('id_tipo_evento', 'tipo_evento', 'sigla')
            ->addForeignKey('id_estado', 'historico_estados', 'id')
            ->create();

        $table = $this->table('evento_ingreso');
        $table->addColumn('conclusion', 'text', array('null' => true))
            ->addColumn('id_apto', 'char', array('limit' => 2))
            ->addColumn('id_historico_evento', 'integer')
            ->addForeignKey('id_apto', 'agente_psicofisico', 'sigla')
            ->addForeignKey('id_historico_evento', 'historico_eventos', 'id')
            ->create();


        $table = $this->table('evento_orden_medica');
        $table->addColumn('tipo_atencion', 'string', array('limit' => 10))
            ->addColumn('fecha_solicitud', 'date')
            ->addColumn('id_historico_evento', 'integer')
            ->addForeignKey('id_historico_evento', 'historico_eventos', 'id')
            ->create();

        $table = $this->table('computo_dias');
        $table->addColumn('corto_tratamiento_per', 'integer', array('null' => true))
              ->addColumn('largo_tratamiento_per', 'integer', array('null' => true))
              ->addColumn('ordinaria', 'integer', array('null' => true))
              ->addColumn('excepcional', 'integer', array('null' => true))
              ->addColumn('id_evento_orden_medica', 'integer')
              ->addForeignKey('id_evento_orden_medica', 'evento_orden_medica', 'id')
              ->create();

        $table = $this->table('datos_familiar');
        $table->addColumn('nombre', 'string', array('limit' => 250))
            ->addColumn('apellido', 'string', array('limit' => 250))
            ->addColumn('parentesco', 'string', array('limit' => 250))
            ->addColumn('id_evento_orden_medica', 'integer')
            ->addForeignKey('id_evento_orden_medica', 'evento_orden_medica', 'id')
            ->create();

        $table = $this->table('evento_orden_medica_anula');
        $table->addColumn('observaciones', 'text', array('null' => true))
            ->addColumn('id_historico_evento', 'integer')
            ->addForeignKey('id_historico_evento', 'historico_eventos', 'id')
            ->create();

        $table = $this->table('evento_recepcion_certificado');
        $table->addColumn('detalle_recepcion', 'text', array('null' => true))                
            ->addColumn('id_historico_evento', 'integer')
            ->addForeignKey('id_historico_evento','historico_eventos','id')  
            ->create(); 

        $table = $this->table('evento_emitir_licencia');
        $table->addColumn('tipo_licencia','string', array('limit' => 10)) 
            ->addColumn('observaciones', 'text')               
            ->addColumn('fecha_inicio', 'date')               
            ->addColumn('fecha_fin', 'date')               
            ->addColumn('id_historico_evento', 'integer')    
            ->addForeignKey('id_historico_evento','historico_eventos','id')  
            ->create(); 


        //-----------------------------------------------------------------------------------
        //---- Datos Basicos-----------------------------------------------------------------
        //-----------------------------------------------------------------------------------

        $agente_estado = [
            [
              'sigla'    => 'SA',
              'descripcion'  => 'Solicitud de alta'
            ],
            [
              'sigla'    => 'EE',
              'descripcion'  => 'En estudio'
            ],
            [
              'sigla'    => 'AM',
              'descripcion'  => 'Alta médica'
            ],
            [
              'sigla'    => 'AD',
              'descripcion'  => 'Alta definitiva'
            ],
            [
              'sigla'    => 'AC',
              'descripcion'  => 'Activo'
            ],
            [
              'sigla'    => 'IN',
              'descripcion'  => 'Inactivo'
            ]
        ];

        $this->insert('agente_estado', $agente_estado);

        $ubicacion = [
            [
              'id'    => '1',
              'nombre'  => 'POSADAS'
            ],
            [
              'id'    => '2',
              'nombre'  => 'OBERA'
            ],
            [
              'id'    => '3',
              'nombre'  => 'ELDORADO'
            ]
        ];

        $this->insert('ubicacion', $ubicacion);

        $unidad_gestion = [
            [
              'id'    => '1',
              'nombre'  => 'FHyCS',
              'descripcion'  => 'Facultad de Humanidades y Ciencias Sociales',
              'id_ubicacion'  => 1,
            ],
            [
              'id'    => '2',
              'nombre'  => 'FIO',
              'descripcion'  => 'Facultad de Ingeniería',
              'id_ubicacion'  => 2,
            ],
            [
              'id'    => '3',
              'nombre'  => 'FCE',
              'descripcion'  => 'Facultad de Ciencias Económicas',
              'id_ubicacion'  => 1,
            ],
            [
              'id'    => '4',
              'nombre'  => 'FCEQyN',
              'descripcion'  => 'Facultad de Ciencias Exactas, Químicas y Naturales',
              'id_ubicacion'  => 1,
            ],
            [
              'id'    => '5',
              'nombre'  => 'Rectorado',
              'descripcion'  => 'Rectorado',
              'id_ubicacion'  => 1,
            ],
            [
              'id'    => '6',
              'nombre'  => 'ESCENF',
              'descripcion'  => 'Escuela de Enfermería',
              'id_ubicacion'  => 1,
            ],
            [
              'id'    => '7',
              'nombre'  => 'FAyD',
              'descripcion'  => 'Facultad de Arte y Diseño',
              'id_ubicacion'  => 2,
            ],
            [
              'id'    => '8',
              'nombre'  => 'EAE',
              'descripcion'  => 'Escuela Agrotécnica de Eldorado',
              'id_ubicacion'  => 3,
            ],
            [
              'id'    => '9',
              'nombre'  => 'FCF',
              'descripcion'  => 'Facultad de Ciencias Forestales',
              'id_ubicacion'  => 3,
            ]
            
        ];

        $this->insert('unidad_gestion', $unidad_gestion);

        $unidad_desempenio = [
            [
              'descripcion'    => 'FAC.DE CS. EXACTAS QCAS. Y NAT',
              'id_mapuche'  => '01',
              'id_unidad_gestion' => '4'
            ],
            [
              'descripcion'    => 'ESCUELA DE ENFERMERIA',
              'id_mapuche'  => '02',
              'id_unidad_gestion' => '4'
            ],
            [
              'descripcion'    => 'FAC. DE HUM. Y CS. SOCIALES',
              'id_mapuche'  => '03',
              'id_unidad_gestion' => '1'
            ],
            [
              'descripcion'    => 'FAC. DE CS. ECONOMICAS',
              'id_mapuche'  => '04',
              'id_unidad_gestion' => '3'
            ],
            [
              'descripcion'    => 'FACULTAD DE ARTES',
              'id_mapuche'  => '05',
              'id_unidad_gestion' => '7'
            ],
            [
              'descripcion'    => 'FACULTAD DE INGENIERIA',
              'id_mapuche'  => '06',
              'id_unidad_gestion' => '2'
            ],
            [
              'descripcion'    => 'FACULTAD DE CS. FORESTALES',
              'id_mapuche'  => '07',
              'id_unidad_gestion' => '9'
            ],
            [
              'descripcion'    => 'ESCUELA AGROTECNICA ELDORADO',
              'id_mapuche'  => '08',
              'id_unidad_gestion' => '8'
            ],
            [
              'descripcion'    => 'EDITORIAL UNIVERSITARIA',
              'id_mapuche'  => '09',
              'id_unidad_gestion' => '5'
            ],
            [
              'descripcion'    => 'RADIO FM UNIVERSIDAD',
              'id_mapuche'  => '10',
              'id_unidad_gestion' => '5'
            ],
            [
              'descripcion'    => 'RECTORADO',
              'id_mapuche'  => '11',
              'id_unidad_gestion' => '5'
            ]
        ];

        $this->insert('unidad_desempenio', $unidad_desempenio);

        $agente_psicofisico = [
            [
              'sigla'    => 'AA',
              'descripcion'  => 'APTO'
            ],
            [
              'sigla'    => 'AP',
              'descripcion'  => 'APTO PROVISORIO'
            ],
            [
              'sigla'    => 'NP',
              'descripcion'  => 'NO APTO'
            ]
        ];

        $this->insert('agente_psicofisico', $agente_psicofisico);

        $tipo_evento = [
            [
              'sigla'    => 'ingreso',
              'descripcion'  => 'Ingreso'
            ],
            [
              'sigla'    => 'orden_medica',
              'descripcion'  => 'Solicitud de orden medica'
            ],
            [
              'sigla'    => 'anular_orden',
              'descripcion'  => 'Anular solicitud orden medica'
            ],
             [
              'sigla'    => 'certificado_medico',
              'descripcion'  => 'Recepcion de certificado medico'
            ],
            [
              'sigla'    => 'emitir_licencia',
              'descripcion'  => 'Emitir licencia medica'
            ]
        ];

        $this->insert('tipo_evento', $tipo_evento);

        $historico_estados = [
            [
              'descripcion'  => 'Autorizado'
            ],
            [
              'descripcion'  => 'Generado'
            ],
            [
              'descripcion'  => 'Rechazado'
            ],
            [
              'descripcion'  => 'Anulado'
            ],
            [
              'descripcion'  => 'Borrador'
            ],
            [
              'descripcion'  => 'Cerrado'
            ],
            [
              'descripcion'  => 'Recibido'
            ]
        ];

        $this->insert('historico_estados', $historico_estados);
    }
}
