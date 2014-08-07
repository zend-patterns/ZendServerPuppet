class zendserver::repo::debian inherits zendserver {

  if $caller_module_name != $module_name {
    warning("${name} should not be directly included in the manifest.")
  }

  apt::key { 'zend':
    key        => 'F7D2C623',
    key_source => 'http://repos.zend.com/zend.key',
  }

 ### APACHE:

  ## Default:
  # deb http://repos.zend.com/zend-server/7.0/deb server non-free

  ## Ubuntu >= 12.04 or Debian >= 7:
  # deb http://repos.zend.com/zend-server/7.0/deb_ssl1.0 server non-free

  ## Ubuntu 13.10:
  # deb http://repos.zend.com/zend-server/7.0/deb_apache2.4 server non-free
}