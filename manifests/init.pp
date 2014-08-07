class zendserver (
  $manage_repos = $zendserver::params::manage_repos
) inherits zendserver::params {

  validate_bool($manage_repos)
  
  anchor { 'zendserver::begin': } ->
    class { '::zendserver::install': } ->
    class { '::zendserver::config': }  ~>
    class { '::zendserver::service': } ->
  anchor { 'zendserver::end': }
}
