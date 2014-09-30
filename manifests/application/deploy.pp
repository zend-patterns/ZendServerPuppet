define zendserver::application::deploy (
  $app_package,
  $base_url,
  $create_vhost  = true,
  $target,
  $user_app_name = $name,
  $user_params   = '',) {
  $required_options   = "--zpk=${app_package} --baseUri=${base_url}"
  $additional_options = "--createVhost=${create_vhost} --userAppName=${user_app_name}"

  $app_name_fact = getvar("::zend_application_name_${user_app_name}")
  
  # Check if application is deployed by using facter
  if $app_name_fact != undef {
    
  } else {
    zendserver::sdk::command { "app_deploy_$name":
      target             => $target,
      api_command        => 'installApp',
      additional_options => "${required_options} ${additional_options}",
    }
  }
}
