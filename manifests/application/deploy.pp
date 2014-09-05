/* * applicationDeploy --appPackage= --baseUrl= [--createVhost=] [--defaultServer=] [--userAppName=] [--ignoreFailures=]
 * [--userParams=] [--target=] [--zsurl=] [--zskey=] [--zssecret=] [--zsversion=] [--http=]
 *
 * Deploy a new application to the server or cluster. This process is asynchronous, meaning the initial request will wait until the
 * application is uploaded and verified, and  the initial response will show information about the application being deployed.
 * However, the staging and activation process will proceed after the response is returned. You must continue checking the
 * application status using the applicationGetStatus method until the deployment process is complete.
 * --appPackage        The application package file.
 * --baseUrl           The base URL to which the application will be deployed. This must be an HTTP URL.
 * --createVhost       Create a virtual host based on the base URL (if the virtual host wasn't already created by Zend Server). The
 * default value is FALSE.
 * --defaultServer     Deploy the application on the default server. The provided base URL will be ignored and replaced with
 * '<default-server>'.
 *                    If this parameter and createVhost are both used, createVhost will be ignored. The default value is FALSE.
 *
 * --userAppName       Free text for a user defined application identifier. If not specified, the baseUrl parameter will be used.
 * --ignoreFailures    Ignore failures during staging if only some servers report failures. If all servers report failures the
 * operation will fail in any case.
 *                    The default value is FALSE, meaning any failure will return an error.
 * --userParams        Set values for user parameters defined in the package. Depending on package definitions, this parameter may
 * be required.
 *                    Each user parameter defined in the package must be provided as a key for this parameter.
 * Example:            applicationDeploy --appPackage=/path/to/application.zpk --baseUrl="http://test.domain.com/"
 * --userParams="APPLICATION_ENV=staging&p[a]=1&p[b]=2"
 */

define zendserver::application::deploy (
  $app_package,
  $base_url,
  $create_vhost  = false,
  $target,
  $user_app_name = $name,
  $user_params   = '',) {
  $required_options   = "--appPackage=${app_package} --baseUrl=${base_url}"
  $additional_options = "--createVhost=${create_vhost} --userAppName=${user_app_name}"

  $app_name_fact = getvar("::zend_application_name_${user_app_name}")
  
  # Check if application is deployed by using facter
  if $app_name_fact != undef {
    
  } else {
    zendserver::sdk::command { "app_deploy_$name":
      target             => $target,
      api_command        => 'applicationDeploy',
      additional_options => "${required_options} ${additional_options}",
    }
  }
}
