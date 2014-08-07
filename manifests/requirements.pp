class zendserver::requirements inherits zendserver {
    package { $package_lsbrelease:
      ensure => installed,
    }
}