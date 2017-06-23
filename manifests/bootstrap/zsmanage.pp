# == Class: zendserver::bootstrap::zsmanage
#  Bootstrap single server if the fact zend_gui.completed is not true
#  Use the zsmanage tool
class zendserver::bootstrap::zsmanage inherits zendserver::bootstrap {
    # TODO:if api_key was not specified then save Zend Server API key as a fact.
  $options = "-p ${zendserver::admin_password} -a ${zendserver::accept_eula}"

  #Check if Zend Server is already bootstrapped.
  #The zend_gui_completed fact is a string and not a boolean.
  if $::zend_gui_completed != true {
    #Check if license details were passed to Class['zendserver']
    if defined('$zendserver::license_name') {
      $license = "-o ${zendserver::license_name} -l ${zendserver::license_key}"
    } else {
      #If license_details are empty then Zend Server will operate in trial mode
      $license = ''
    }
    #TODO: switch to using the zendserver::sdk once it's more reliable
    #Bootstrap Zend Server using zsmanage
    zendserver::zsmanage { 'bootstrap-single-server':
      command            => 'bootstrap-single-server',
      zskey              => $zendserver::admin_api_key_name,
      zssecret           => $zendserver::admin_api_key_secret,
      additional_options => "${options} ${license}",
      notify             => Service['zend-server'],
    }
  }
}
