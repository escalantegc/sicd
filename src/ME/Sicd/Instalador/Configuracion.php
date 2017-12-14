<?php

namespace ME\Sicd\Instalador;

use SIU\Instalador\Toba\Configuracion as BaseConfiguracion;

/**
 * Objeto de Configuracion para un proyecto basado en SIU-Toba.
 *
 * Gestiona toda la configuración estática, ligada al código fuente:
 *  - nombre, descripción y versión
 *  - requerimientos de instalación
 *  - etc.
 *
 * @author Fernando Alvez <fernando.alvez@campus.unam.edu.ar>
 */
class Configuracion extends BaseConfiguracion
{

    /**
     * {@inheritdoc}
     */
    public function getProyectoDescripcion()
    {
        $descripcion = <<<'DESCRIPCION'
Proyecto %1$s generado con el framework SIU-Toba
%2$s
DESCRIPCION;

        return sprintf($descripcion, $this->getProyectoNombre(), $this->ini['proyecto']['descripcion']);
    }

    /**
     * {@inheritdoc}
     */
    public function getProyectoLogo()
    {
        // para armar la tipografía loca:
        // http://patorjk.com/software/taag/#p=display&f=Standard&t=SIU-Proyecto

       $logo = <<<'LOGO'
     ____    _    ___   ____
    / ___|  | |  / __| |  _ \
    \___ \  | | | |    | | \ |
     ___) | | | | |__  | |_/ |
    |____/  |_|  \___| |____/
    
      
LOGO;

        return $logo;
    }

}

