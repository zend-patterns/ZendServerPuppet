# == Define: zendserver::application::define
# Define an existing application in Zend Server(that was not installed using Zend Server).
# This definition is for internal use, do not include it directly in your manifest - it is called by zendserver::application. 
# === Parameters
# [*base_url*]
# Path relative to the URI (without http....) in which the application is located. F.E if app is under http://www.fqdn.tld/app then you should enter /app.
# [*target*]
# Zend Server SDK target from which to remove the application.
# [*version*]
# The version of the application - you can manually enter your version. (Default:'1.0')
# [*health_check*]
# Optional URL that points to a health check in your application.
# [*logo*]
# Path to a local file on the server holding the apps logo (for displaying in the Zend Server console).
# It is advised you add a puppet "File" resource for the logo file and "require" it. 
# [*user_app_name*]
# The user application's name (alias) (Default: resource name)
# [*user_params*]
# Optional parameters to pass to the deployment command.


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
    zendserver::sdk::command { "app_define_${name}":
      target             => $target,
      api_command        => 'applicationDefine',
      additional_options => $additional_options,
    }
  }
}
