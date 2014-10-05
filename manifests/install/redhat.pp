# == Class: zendserver::install::redhat
#  RedHat specific settings for Zend Server install
#
class zendserver::install::redhat inherits zendserver::install {
 Package[$zendserver::install::zendserverpkgname] {
    require => [Yumrepo['Zend'], Yumrepo['Zend_noarch']], }
}
