# == Class: zendserver::params
#  Parameters class for zendserver class
#
class zendserver::params {
  $accept_eula = true
  $admin_password = 'changeme'
  $manage_repos = true
  $webserver    = 'apache'
  $phpversion   = '5.5'
  $license_name = undef
  $license_key  = undef
  $zend_server_version = 7
  $join_cluster = false
  $admin_api_key_name = undef
  $admin_api_key_secret = undef
  $admin_email = "root@${::fqdn}"

  case $::osfamily {
    'Debian': {
      $package_lsbrelease = 'lsb-release'
      include ::zendserver::repo::debian
    }
    'RedHat': {
      $package_lsbrelease = 'lsb-release'
      include ::zendserver::repo::redhat
    }
    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
    }
  }
}
