#!/usr/local/zend/bin/php
<?php
error_reporting(E_ERROR);

$zs_api_config_file='/.zsapi.ini';
$zs_api_target='localadmin';
$zs_api_config=parse_ini_file($zs_api_config_file, true);

$api_key_name=$zs_api_config[$zs_api_target]['zskey'];
$api_key_hash=$zs_api_config[$zs_api_target]['zssecret'];

$get_extensions_details="/usr/local/zend/bin/zs-client.sh configurationExtensionsList --target=localadmin --output-format=json > /tmp/ZendExtensionsList";

exec($get_extensions_details , $extensions_exec_output);

$textJson = file_get_contents('/tmp/ZendExtensionsList');

//die ($extensions_exec_output);

//print_r ($extensions_exec_output);

//die;

$arr = json_decode($textJson, true);

//print_r ($arr);
//var_dump ($arr['extension']);
//print_r ($extensions_exec_output[2]);

foreach($arr['responseData']['extensions'] as $app) {
    $name = $app['name'];

    foreach($app as $key => $value) {
        if(! is_array($value))
            echo 'zend_extension_' . $key . '_' . $name . '=' . $value . PHP_EOL;
    }
}
