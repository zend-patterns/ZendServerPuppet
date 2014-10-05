# == Class: zendserver::install
#   Install Zend Server
#

class zendserver::install {
  case $::osfamily {
    'Debian' : {
      include ::zendserver::repo::debian
      include zendserver::install::debian
    }
    'RedHat' : {
      include ::zendserver::repo::redhat
      include zendserver::install::redhat
    }
    default  : {
      fail("The ${module_name} is not supported on ${::osfamily}")
    }
  }

  case $::zendserver::webserver {
    'apache' : { $zendserverpkgname = "zend-server-${zendserver::webserver}-php-${zendserver::phpversion}" }
    default  : { $zendserverpkgname = "zend-server-php-${zendserver::phpversion}" }
  }

  # TODO:if api_key was not specified then save Zend Server API key as a fact.
  package { $zendserverpkgname: ensure => 'latest', }

  file { '/usr/local/zend':
    ensure  => directory,
    require => Package[$zendserverpkgname],
  }

  file { '/usr/local/zend/bin': ensure => directory, }
}
