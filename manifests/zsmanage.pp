# == Define: zendserver::zsmanage
#   This is defined type wraps around the zs-manage command that can be used to control Zend Server
#   This definition is used internally by other components in this module and can be called directly.
# === Parameters
# [*command*]
# The Zend Server command to run. See "/usr/local/zend/bin/zs-manage --help" for a list of available commands.
# [*zskey*]
# Zend Server Web API Key name
# [*zssecret*]
# Zend Server Web API Key hash.
# [*http_timeout*]
# Timeout for the remote Zend Server to respond (Default: 60 seconds)
# [*additional_options*]
# [*zsurl*]
# URL To the Zend Server web API (Default: http://localhost:10081/ZendServer)
# Options to supply to the Zend Server command. See "/usr/local/zend/bin/zs-manage --help" for a list of the relevant options for each command.
# TODO: use params class pattern
# TODO: merge into zendserver::sdk class as a provider
define zendserver::zsmanage (
  $command,
  $zskey,
  $zssecret,
  $http_timeout       = 60,
  $additional_options = '',
  $zsurl              =  "${zendserver::zsurl}",) {
  exec { "zsmanage_${name}":
    command => "/usr/local/zend/bin/zs-manage ${command} -N ${zskey} -K ${zssecret} -T ${http_timeout} ${additional_options}",
    require => Package[$zendserver::install::zendserverpkgname],
  }
}
