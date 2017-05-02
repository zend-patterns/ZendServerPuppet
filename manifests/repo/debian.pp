# == Class: zendserver::repo::debian
#   Manage Zend Server repositories on debian systems
#
class zendserver::repo::debian {
  if $caller_module_name != $module_name {
    warning("${name} should not be directly included in the manifest.")
  }

  apt::key { 'zend':
    key        => 'F7D2C623',
    key_source => 'http://repos.zend.com/zend.key',
  }

  # TODO: maybe move $zend_repository setting to params.pp
  #
  #  For Ubuntu 12.04 or Debian 7 and above, use:
  #  deb http://repos.zend.com/zend-server/8.0/deb_ssl1.0 server non-free
  #
  #  For Ubuntu 14.04 and above, use:
  #  deb http://repos.zend.com/zend-server/8.0/deb_apache2.4 server non-free
  notify { "server: {$::operatingsystemmajrelease}": }

  case $::operatingsystem {
    'Ubuntu' : {
      if $::operatingsystemrelease + 0 >= 14.04 {
        $zend_repository = "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/deb_apache2.4"
      } else {
        $zend_repository = "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/deb_ssl1.0"
      }
    }
    default  : {
      $zend_repository = "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/deb_ssl1.0"
    }
  }

  apt::source { 'zend-server':
    comment     => 'Zend Server Repository',
    location    => $zend_repository,
    release     => 'server',
    repos       => 'non-free',
    include_src => false,
    require     => Apt::Key['zend'],
  }
}
