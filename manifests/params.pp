class zendserver::params {
  $manage_repos = true

  case $::osfamily {
    'Debian': {

    }
    'RedHat': {

    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
