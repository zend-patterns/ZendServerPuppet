# == Class: zendserver::install
#   Install Zend Server
#
class zendserver::install {
  case $::osfamily {
    'Debian' : { include zendserver::install::debian }
    'RedHat' : { include zendserver::install::redhat }
    default  : { fail("The ${module_name} is not supported on ${::osfamily}") }
  }

  # TODO:if api_key was not specified then save Zend Server API key as a fact.
  package { "zend-server-php-${zendserver::phpversion}": ensure => 'latest', }

  file { '/usr/local/zend':
    ensure  => directory,
    require => Package["zend-server-php-${zendserver::phpversion}"],
  }

  file { '/usr/local/zend/bin': ensure => directory, }
}
