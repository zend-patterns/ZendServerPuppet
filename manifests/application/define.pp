# TODO: autorequire logo file
define zendserver::application::define (
  $base_url,
  $target,
  $version       = '1.0',
  $health_check  = undef,
  $logo          = '',
  $user_app_name = $name,) {
  $required_options    = "--name=${user_app_name} --baseUrl=${base_url} --version=${version}"
  $logo_option         = $logo ? {
    ''      => '',
    default => "--logo=${logo}"
  }

  $health_check_option = $health_check ? {
    undef   => '',
    default => "--healthCheck=${health_check}"
  }

  $additional_options  = "${required_options} ${logo_option} ${health_check_option}"
  $app_name_fact       = getvar("::zend_application_name_${user_app_name}")

  # Check if application is deployed by using facter
  if $app_name_fact != undef {

  } else {
    zendserver::sdk::command { "app_remove_${name}":
      target             => $target,
      api_command        => 'applicationDefine',
      additional_options => $additional_options,
    }
  }
}