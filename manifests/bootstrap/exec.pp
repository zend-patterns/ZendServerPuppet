# == Class: zendserver::bootstrap::exec
#  Bootstrap single server if the fact zend_gui.completed is not true
#
class zendserver::bootstrap::exec inherits zendserver::bootstrap {
  file { 'zs-bootstrap-puppet.sh':
    path    => '/usr/local/zend/bin/zs-bootstrap-puppet.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/zs-bootstrap-puppet.sh.erb"),
    require => File['/usr/local/zend'],
  }

  file { 'zs-puppet-common-functions.sh':
    path    => '/usr/local/zend/bin/zs-puppet-common-functions.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "puppet:///modules/${module_name}/zs-puppet-common-functions.sh",
    require => File['/usr/local/zend'],
  }

  exec { 'zend-server-init':
    command => '/usr/local/zend/bin/zs-bootstrap-puppet.sh',
    creates => '/usr/local/zend/tmp/zs-done',
    require => [
      File['zs-bootstrap-puppet.sh'],
      File['/usr/local/zend/bin/zs-client.phar'],
      File['zs-puppet-common-functions.sh']],
  }
}