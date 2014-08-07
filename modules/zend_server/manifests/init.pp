class zend-server (
  $manage_repos = $zend-server::params::manage_repos
) inherits zend-server::params {

  validate_bool($manage_repos)
  
  anchor { 'zend-server::begin': } ->
    class { '::zend-server::install': } ->
    class { '::zend-server::config': }  ~>
    class { '::zend-server::service': } ->
  anchor { 'zend-server::end': }
}