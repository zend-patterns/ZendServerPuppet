# == Define: zendserver::library::deploy
# Internal definition to deploy a Zend Server Library using the Zend Server SDK.g
#This defined type should not be called directly in a user's manifest.
#
# === Parameters
# [*target*]
# Zend Server SDK target from which to remove the library.
# [*lib_package*]
# Zend Server Library name to remove.

define zendserver::library::deploy ($lib_package, $target,) {
  $required_options = "--zpk=${lib_package}"
  $additional_options = ''

  # Check if application is deployed by using facter
  zendserver::sdk::command { "lib_deploy_${name}":
    target             => $target,
    api_command        => 'installLib',
    additional_options => "${required_options} ${additional_options}",
  }
}
