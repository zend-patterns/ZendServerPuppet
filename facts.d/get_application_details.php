#!/usr/local/zend/bin/php
<?php
error_reporting(E_ERROR);

$zs_api_config_file='/.zsapi.ini';
$zs_api_target='localadmin';
$zs_api_config=parse_ini_file($zs_api_config_file, true);

$api_key_name=$zs_api_config[$zs_api_target]['zskey'];
$api_key_hash=$zs_api_config[$zs_api_target]['zssecret'];

$get_app_details="/usr/local/zend/bin/zs-manage app-get-status -N $api_key_name -K $api_key_hash 2>/dev/null|grep http|cut -f 2,3,4,5,6,7";

exec($get_app_details , $app_exec_output);
foreach ($app_exec_output as $line){
  if (preg_match("/\[NOTICE\]/",$line)) {
  } else {
    $app_properties=explode("\t",$line);
    echo "zend_application_id_$app_properties[2]=$app_properties[0]".PHP_EOL;
    echo "zend_application_url_$app_properties[2]=$app_properties[1]".PHP_EOL;
    echo "zend_application_name_$app_properties[2]=$app_properties[2]".PHP_EOL;
    echo "zend_application_alias_$app_properties[2]=$app_properties[3]".PHP_EOL;
    echo "zend_application_path_$app_properties[2]=$app_properties[4]".PHP_EOL;
    echo "zend_application_status_$app_properties[2]=$app_properties[5]".PHP_EOL;
  }
}

