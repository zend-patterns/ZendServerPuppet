# == Class: zendserver::bootstrap
# Bootstrap single server if the fact zend_gui.completed is not true. 
# This class is for internal use and should not be included in a manifest. 
class zendserver::bootstrap inherits zendserver {

  file { 'zs-puppet-common-functions.sh':
    path    => '/usr/local/zend/bin/zs-puppet-common-functions.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "puppet:///modules/${module_name}/zs-puppet-common-functions.sh",
    require => File['/usr/local/zend'],
  }

  if $::zend_gui_completed != 'true' {
    include zendserver::bootstrap::exec
  }
}
