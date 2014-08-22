# == Class: zendserver::install::debian
#   Debian specific settings for Zend Server install
#
class zendserver::install::debian inherits zendserver::install {
  include apt
	Package["zend-server-php-${zendserver::phpversion}"] {
	  require => Apt::Source['zend-server'],
	} 
}
