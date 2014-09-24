define zendserver::application::remove ($target, $user_app_name = $name,) {
  # Check if application is deployed by using facter
  $app_name_fact = getvar("::zend_application_name_${user_app_name}")

  # Check if application is deployed by using facter
  if $app_name_fact != undef {
    # Get application id from facter
    $app_id           = getvar("::zend_application_id_${user_app_name}")
    $required_options = "--appId=${app_id}"

    zendserver::sdk::command { "app_remove_$name":
      target             => $target,
      api_command        => 'applicationRemove',
      additional_options => $required_options,
    }
  } else {

  }
}