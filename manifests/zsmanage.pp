# TODO: use params class pattern
# TODO: merge into zendserver::sdk class as a provider
define zendserver::zsmanage (
  $command,
  $zskey,
  $zssecret,
  $http_timeout       = 60,
  $additional_options = '',
  $zsurl              = "http://localhost:10081/ZendServer",) {
  exec { "zsmanage_${name}":
    command => "/usr/local/zend/bin/zs-manage ${command} -N ${zskey} -K ${zssecret} -T ${http_timeout} ${additional_options}",
    require => Package["zend-server-php-${zendserver::phpversion}"],
  }
}
