# == Define: zendserver::zsmanage::command
#   This is defined type wraps around the zs-manage command that can be used to control Zend Server
#   This definition is used internally by other components in this module and can be called directly.
# === Parameters
# [*command*]
# The Zend Server command to run. See "/usr/local/zend/bin/zs-manage --help" for a list of available commands.
# [*target]
# The Zend Server target to which to send the command (this parameter is currently ignored by the module).
# [*zskey*]
# Zend Server Web API Key name
# [*zssecret*]
# Zend Server Web API Key hash.
# [*http_timeout*]
# Timeout for the remote Zend Server to respond (Default: 60 seconds)
# [*additional_options*]
# Options to supply to the Zend Server command.
# See "/usr/local/zend/bin/zs-manage --help" for a list of the relevant options for each command.
#TODO: implement the definition
define zendserver::zsmanage::command (
  $command            = $name,
  $target             = undef,
  $zsurl              = undef,
  $zskey              = $zendserver::admin_api_key_name,
  $zssecret           = $zendserver::admin_api_key_secret,
  $http_timeout       = undef,
  $additional_options = undef,) {

}
