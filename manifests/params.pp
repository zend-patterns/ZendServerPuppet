class zendserver::params {
  $manage_repos = true

  case $::osfamily {
    'Debian': {
      include zendserver::repo::debian
    }
    'RedHat': {
      include zendserver::repo::redhat
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
