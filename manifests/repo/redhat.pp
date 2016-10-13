# == Class: zendserver::repo::redhat
#  Manage Zend Server rpm repositories
#
class zendserver::repo::redhat inherits zendserver {
  if $caller_module_name != $module_name {
    warning("${name} should not be directly included in the manifest.")
  }

  yumrepo { 'Zend':
    baseurl  => "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/rpm_apache2.4/${::architecture}",
    descr    => 'Zend Server',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://repos.zend.com/zend.key',
  }

  yumrepo { 'Zend_noarch':
    baseurl  => "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/rpm_apache2.4/noarch",
    descr    => 'Zend Server',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://repos.zend.com/zend.key',
  }
}
