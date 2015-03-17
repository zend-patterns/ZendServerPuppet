# == Define: zendserver::application::deploy
# Deploy/Update an application using the Zend Server SDK (zs-client.phar) "installApp" high-level command.
# This is an internal definition and should not be called directly by a user.
# === Parameters
# [*target]
# Zend Server SDK target from which to remove the application.
# [*app_package*]
# The name of the application package (zpk) to deploy.
# [*user_app_name*]
# The user application's name (alias) (Default: definition name)
# [*create_vhost*]
# Whether to create a web server vhost to access the app.
# [*user_params*]
# Optional parameters to pass to the deployment command.

define zendserver::application::deploy (
  $target,
  $app_package,
  $base_url,
  $user_app_name = $name,
  $create_vhost  = 'true',
  $user_params   = '',
  $cwd           = undef,
) {
  $required_options   = "--zpk=${app_package} --baseUri=${base_url}"
  $additional_options = "--createVhost=${create_vhost} --userAppName=${user_app_name} --userParams=\"${user_params}\""

  $app_name_fact = getvar("::zend_application_name_${user_app_name}")

  # Check if application is deployed by using facter
  if $app_name_fact != undef {

  } else {
    zendserver::sdk::command { "app_deploy_${name}":
      target             => $target,
      cwd                => $cwd,
      api_command        => 'installApp',
      additional_options => "${required_options} ${additional_options}",
    }
  }
}
