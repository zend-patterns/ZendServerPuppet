class zendserver::params {
  $manage_repos = true
  $webserver    = 'apache'
  $phpversion   = '5.5'

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
