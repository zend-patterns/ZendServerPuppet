# == Class: zendserver::install
#   Install Zend Server
#

class zendserver::install::vars {
  Class['zendserver::install::vars'] {
    before => Class['zendserver::install']
  }

  if ($zendserver::webserver != 'apache') {
    $zendserverpkgname = "zend-server-${zendserver::webserver}-php-${zendserver::phpversion}"
  } else {
    $zendserverpkgname = "zend-server-php-${zendserver::phpversion}"
  }
}

class zendserver::install {
  include zendserver::install::vars
  $zendserverpkgname = $zendserver::install::vars::zendserverpkgname
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

  # TODO:if api_key was not specified then save Zend Server API key as a fact.
  package { $zendserverpkgname: ensure => 'latest', }

  file { '/usr/local/zend':
    ensure  => directory,
    require => Package[$zendserverpkgname],
  }

  file { '/usr/local/zend/bin': ensure => directory, }
}
