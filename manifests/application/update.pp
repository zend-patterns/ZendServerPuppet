/* applicationUpdate --appId= --appPackage= [--ignoreFailures=] [--userParams=] [--target=] [--zsurl=] [--zskey=] [--zssecret=]
 * [--zsversion=] [--http=]
 *
 * This method allows you to update an existing application. The package you provide must contain the same application.
 * Additionally, any new parameters or new values for existing parameters must be provided. This process is asynchronous, meaning
 * the initial request will wait until the package is uploaded and verified, and the initial response will show information about
 * the new version being deployed. However, the staging and activation process will proceed after the response is returned. You must
 * continue checking the application status using the applicationGetStatus method until the deployment process is complete.
 * --appId             The application ID you would like to update.
 * --appPackage        The application package file.
 * --ignoreFailures    Ignore failures during staging if only some servers report failures. If all servers report failures the
 * operation will fail in any case.
 *                    The default value is FALSE, meaning any failure will return an error.
 * --userParams        Set values for user parameters defined in the package. Depending on package definitions, this parameter may
 * be required.
 *                    Each user parameter defined in the package must be provided as a key for this parameter.
 * Example:            applicationUpdate --appId=3 --appPackage=/path/to/application-v0.3.zpk
 * --userParams="APPLICATION_ENV=staging&p[a]=1&p[b]=2"
 */


define zendserver::application::update ($target, $app_package, $user_app_name = $name, $user_params = undef,) {
  # TODO: check application version in zpk against deployed
  # Check if application is deployed by using facter
  if defined("$::zend_application_name_${name}") {
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