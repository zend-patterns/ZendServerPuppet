define zendserver::library::deploy ($lib_package, $target,) {
  $required_options = "--zpk=${lib_package}"
  $additional_options = ''

  # Check if application is deployed by using facter
  zendserver::sdk::command { "lib_deploy_$name":
    target             => $target,
    api_command        => 'installApp',
    additional_options => "${required_options} ${additional_options}",
  }
}
