#TODO: document class
class zendserver::params {
  $manage_repos = true
  $webserver    = 'apache'
  $phpversion   = '5.5'
  $license_name = undef
  $license_key  = undef
  $zend_server_version = 7
  $join_cluster = false
  #TODO: api_key_name + web_api_key_secret are required if join_cluster=true
  $admin_api_key_name = undef
  $admin_api_key_secret = undef

  
  case $::osfamily {
    'Debian': {
      $package_lsbrelease = 'lsb-release'
      include zendserver::repo::debian
    }
    'RedHat': {
      $package_lsbrelease = 'lsb-release'
      include zendserver::repo::redhat
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
