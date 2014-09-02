/* applicationDefine --name= --baseUrl= [--version=] [--healthCheck=] [--logo=] [--target=] [--zsurl=] [--zskey=] [--zssecret=]
 * [--zsversion=] [--http=]
 *
 * Define application to the server or cluster. This process is asynchronous – the initial request will wait until the application
 * is defined, and the initial response will show information about the application being defined – however the staging and
 * activation process will proceed after the response is returned. The user is expected to continue checking the application status
 * using the applicationGetStatus method until the deployment process is complete.
 * --name           Application name.
 * --baseUrl        Base URL to define the application to. Must be an HTTP URL. use <default-server> if needed.
 * --version        The version of the application.
 * --healthCheck    The health check url.
 * --logo           Logo image file.
 */

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

  $additional_options  = "$required_options $logo_option $health_check_option"

  # Check if application is deployed by using facter
  if defined("$::zend_application_name_${name}") {

  } else {
    zendserver::sdk::command { "app_remove_$name":
      target             => $target,
      api_command        => 'applicationDefine',
      additional_options => $additional_options,
    }
  }
}