#!/usr/local/zend/bin/php
<?php
error_reporting(E_ERROR);

$zs_api_config_file='/.zsapi.ini';
$zs_api_target='localadmin';
$zs_api_config=parse_ini_file($zs_api_config_file, true);

$api_key_name=$zs_api_config[$zs_api_target]['zskey'];
$api_key_hash=$zs_api_config[$zs_api_target]['zssecret'];

$get_vhost_details="/usr/local/zend/bin/zs-manage vhost-get-status -N $api_key_name -K $api_key_hash 2>/dev/null|cut -f 2,3,4,5,6,7";

exec($get_vhost_details , $vhost_exec_output);
#print_r ($vhost_exec_output);
foreach ($vhost_exec_output as $line){
  if (preg_match("/\[NOTICE\]/",$line)) {
  } else {
    $vhost_properties=explode("\t",$line);
    echo "zend_vhost_id_$vhost_properties[1]_$vhost_properties[2]=$vhost_properties[0]".PHP_EOL;
    echo "zend_vhost_name_$vhost_properties[1]_$vhost_properties[2]=$vhost_properties[1]".PHP_EOL;
    echo "zend_vhost_port_$vhost_properties[1]_$vhost_properties[2]=$vhost_properties[2]".PHP_EOL;
    echo "zend_vhost_deploy_$vhost_properties[1]_$vhost_properties[2]=$vhost_properties[3]".PHP_EOL;
    echo "zend_vhost_status_$vhost_properties[1]_$vhost_properties[2]=$vhost_properties[4]".PHP_EOL;
  }
}
