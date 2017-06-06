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
    notify {"You may see error messages if vhost, app, etc. settings are applied (defined) before the bootstrap is complete. If it's the case, just run puppet again.": }
    include zendserver::bootstrap::exec
  }
}
