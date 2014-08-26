#TODO: use params class pattern
define zendserver::sdk::command ( $target,
                                  $api_command  = $name,
                                  $zsurl    = undef,
                                  $zskey    = undef,
                                  $zssecret = undef,
                                  $http_timeout = 60,
                                  $additional_options = '',){
    exec {"zsapi_${name}":
    path    => "/usr/local/zend/bin:${::path}",
    command => "zs-client.phar ${api_command} --target=${target} ${additional_options} "
  }
}