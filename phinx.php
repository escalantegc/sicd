<?php

if (file_exists(__DIR__."/../../autoload.php")) {
    $pathAutoload = __DIR__."/../../autoload.php"; // consumido como lib
} else {
    $pathAutoload = __DIR__."/vendor/autoload.php";
}

include_once $pathAutoload;

if (!getenv('TOBA_INSTALACION_DIR')) {
   $entorno_toba = new Dotenv\Dotenv(__DIR__.'/instalacion/', 'entorno_toba.env');
   $entorno_toba->load();
}

$dir_instalacion = getenv('TOBA_INSTALACION_DIR');

$instancia = 'desarrollo';
if (getenv('TOBA_INSTANCIA')) {
    $instancia = getenv('TOBA_INSTANCIA');
}

$proyecto_ini = parse_ini_file('proyecto.ini', true);
$bases_ini = parse_ini_file($dir_instalacion.'/bases.ini', true);

$dbParams = $bases_ini[$instancia.' '.$proyecto_ini['proyecto']['id'].' '.$proyecto_ini['proyecto']['id']];
$dbParams['dbname'] = $dbParams['base'];
$dbParams['host'] = $dbParams['profile'];
$dbParams['port'] = $dbParams['puerto'];
$dbParams['username'] = $dbParams['usuario'];
$dbParams['password'] = $dbParams['clave'];
$dbParams['encoding'] = 'UTF8';


$pdoConnection = new SIU\TobaDb\DbPDO($dbParams);
$conn = $pdoConnection->conexion();

return array(
    "paths" => array(
        "migrations" => __DIR__."/db/migrations"
    ),
    "environments" => array(
        "default_migration_table" => "phinxlog",
        "default_database" => "default",
        "default" => [
            "name" => $dbParams['dbname'],
            "schema" => $dbParams['schema'],
            "connection" => $conn
        ]
    )
);
