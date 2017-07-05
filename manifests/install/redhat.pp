# == Class: zendserver::install::redhat
#  RedHat specific settings for Zend Server install
class zendserver::install::redhat inherits zendserver::install {

  # We don't need to set requirements if we aren't managing the repositories.
  if $zendserver::manage_repos {
    Package[$zendserver::install::zendserverpkgname] {
      require => [Yumrepo['Zend'], Yumrepo['Zend_noarch']], }
  }

}
