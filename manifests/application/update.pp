define zendserver::application::update ($target, $app_package, $user_app_name = $name, $user_params = undef,) {
  # TODO: check application version in zpk against deployed
  # Check if application is deployed by using facter
  $app_name_fact = getvar("::zend_application_name_${user_app_name}")

  # Check if application is deployed by using facter
  if $app_name_fact != undef {
    # Get application id from facter
    $app_id           = getvar("::zend_application_id_${user_app_name}")
    $required_options = "--appId=${app_id} --appPackage=${app_package}"

    zendserver::sdk::command { "app_update_$name":
      target             => $target,
      api_command        => 'applicationUpdate',
      additional_options => $required_options,
    }
  } else {

  }
}