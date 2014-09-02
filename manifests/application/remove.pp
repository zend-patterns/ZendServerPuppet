/* applicationRemove --appId= [--target=] [--zsurl=] [--zskey=] [--zssecret=] [--zsversion=] [--http=]
 *
 * This method allows you to remove an existing application. This process is asynchronous, meaning the initial request will start
 * the removal process and the initial response will show information about the application being removed. However, the removal
 * process will proceed after the response is returned. You must continue checking the application status using the
 * applicationGetStatus method until the removal process is complete. Once applicationGetStatus contains no information about the
 * application, it has been completely removed.
 * --appId    The application ID you would like to remove.
 */

define zendserver::application::remove ($target, $user_app_name = $name,) {
  # Check if application is deployed by using facter
  if defined("$::zend_application_name_${name}") {
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