#!/usr/local/zend/bin/php
<?php
error_reporting(E_ERROR);

$zs_api_config_file='/.zsapi.ini';
$zs_api_target='localadmin';
$zs_api_config=parse_ini_file($zs_api_config_file, true);

$api_key_name=$zs_api_config[$zs_api_target]['zskey'];
$api_key_hash=$zs_api_config[$zs_api_target]['zssecret'];

$get_lib_details="/usr/local/zend/bin/zs-manage library-get-status -N $api_key_name -K $api_key_hash 2>/dev/null|grep APPINFO|cut -f 2,3,4,5,6,7";

var_dump($get_lib_details);

exec($get_lib_details , $lib_exec_output);
foreach ($lib_exec_output as $line){
  if (preg_match("/\[NOTICE\]/",$line)) {
  } else {
    $lib_properties=explode("\t",$line);
    echo "zend_library_id_$lib_properties[2]=$lib_properties[0]".PHP_EOL;
    echo "zend_library_url_$lib_properties[2]=$lib_properties[1]".PHP_EOL;
    echo "zend_library_name_$lib_properties[2]=$lib_properties[2]".PHP_EOL;
    echo "zend_library_alias_$lib_properties[2]=$lib_properties[3]".PHP_EOL;
    echo "zend_library_path_$lib_properties[2]=$lib_properties[4]".PHP_EOL;
    echo "zend_library_status_$lib_properties[2]=$lib_properties[5]".PHP_EOL;
  }
}

