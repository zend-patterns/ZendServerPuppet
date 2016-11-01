# == Class: zendserver::install
#   Install Zend Server
#

class zendserver::install {
  case $::zendserver::webserver {
    'nginx' : { $zendserverpkgname = "zend-server-${zendserver::webserver}-php-${zendserver::phpversion}" }
    default : { $zendserverpkgname = "zend-server-php-${zendserver::phpversion}" }
  }

  case $::osfamily {
    'Debian' : {
      if $zendserver::manage_repos {
        include ::zendserver::repo::debian
      }
      include zendserver::install::debian
    }
    'RedHat' : {
      if $zendserver::manage_repos {
        include ::zendserver::repo::redhat
      }
      include zendserver::install::redhat
    }
    default  : {
      fail("The ${module_name} is not supported on ${::osfamily}")
    }
  }

  # TODO:if api_key was not specified then save Zend Server API key as a fact.
  package { $zendserverpkgname: ensure => 'latest', }

  file { '/usr/local/zend':
    ensure  => directory,
    require => Package[$zendserverpkgname],
  }

  file { '/usr/local/zend/bin': ensure => directory, }

  file { '/usr/local/zend/bin/pear': }

  file { '/usr/local/zend/bin/pecl': }

}
