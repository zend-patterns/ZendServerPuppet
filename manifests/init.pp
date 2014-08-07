class zendserver (
  $manage_repos = $zendserver::params::manage_repos,
  $webserver    = $zendserver::params::webserver,
  $phpversion   = $zendserver::params::phpversion,
  $package_lsbrelease = $zendserver::params::package_lsbrelease
) inherits zendserver::params {

  validate_bool($manage_repos)
  validate_re($webserver, ['\Aapache|nginx\Z',], 'Only apache or nginx is supported.')
  validate_re($phpversion, ['\A5.4|5.5\Z',], 'Only version 5.4 or 5.5 is supported.')


  anchor { 'zendserver::begin': } ->
    class { '::zendserver::requirements': } ->
    class { '::zendserver::install': } ->
    class { '::zendserver::config': }  ~>
    class { '::zendserver::service': } ->
  anchor { 'zendserver::end': }
}
