# == Class: zendserver::bootstrap
#  Bootstrap single server if the fact zend_gui.completed is not true
#
class zendserver::bootstrap inherits zendserver {
  # TODO:if api_key was not specified then save Zend Server API key as a fact.
  if $::zend_gui_completed != 'true' {
    $options = "-p ${zendserver::admin_password} -a ${zendserver::accept_eula}"

    if $::zendserver::license_name {
      $zendserver::bootstrap::options += "-o ${zendserver::license_name} -l ${zendserver::license_key}"
    }

    zendserver::zsmanage { 'bootstrap-single-server':
      command            => 'bootstrap-single-server',
      zskey              => $zendserver::admin_api_key_name,
      zssecret           => $zendserver::admin_api_key_secret,
      additional_options => $options,
    }
  }
}
