# == Class: zendserver::install::redhat
#  RedHat specific settings for Zend Server install
#
class zendserver::install::redhat inherits zendserver::install {
 Package["zend-server-php-${zendserver::phpversion}"] {
    require => [Yumrepo['Zend'], Yumrepo['Zend_noarch']], }
}