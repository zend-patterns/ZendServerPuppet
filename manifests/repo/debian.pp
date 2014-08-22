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
  ### APACHE:

  ## Default:
  # deb http://repos.zend.com/zend-server/7.0/deb server non-free

  ## Ubuntu >= 12.04 or Debian >= 7:
  # deb http://repos.zend.com/zend-server/7.0/deb_ssl1.0 server non-free

  ## Ubuntu 13.10:
  # deb http://repos.zend.com/zend-server/7.0/deb_apache2.4 server non-free
  case $::operatingsystem {
    'Ubuntu': {
      if $::lsbdistrelease    >= 13.10 {
        $zend_repository = 'http://repos.zend.com/zend-server/7.0/deb_apache2.4'
      }
      elsif $::lsbdistrelease >= 12.04 {
        $zend_repository = 'http://repos.zend.com/zend-server/7.0/deb_ssl1.0'
      }
      else {
        $zend_repository = 'http://repos.zend.com/zend-server/7.0/deb'
      }
   }
    #TODO: setup correct debian repositories
    'Debian': {}
    default: {$zend_repository='http://repos.zend.com/zend-server/7.0/deb'}
  }
  
  apt::source { 'zend-server':
    comment      => 'Zend Server Repository',
    location     => $zend_repository,
    release      => 'server',
    repos       => 'non-free',
    include_src => false,
    require      => Apt::Key['zend'],
  }
}
