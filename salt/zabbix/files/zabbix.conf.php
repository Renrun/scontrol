<?php
// Zabbix GUI configuration file
global $DB;

$DB['TYPE']           = 'MYSQL';
$DB['SERVER']         = '{{dbaddr}}';
$DB['PORT']           = '3306';
$DB['DATABASE']       = '{{dbname}}';
$DB['USER']           = '{{dbuser}}';
$DB['PASSWORD']       = '{{dbpassword}}';

// SCHEMA is relevant only for IBM_DB2 database
$DB['SCHEMA']         = '';

$ZBX_SERVER           = '{{server}}';
$ZBX_SERVER_PORT      = '10051';
$ZBX_SERVER_NAME      = '';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
