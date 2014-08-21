#TODO: document class
class zendserver (
  $admin_password,
  $manage_repos         = $zendserver::params::manage_repos,
  $webserver            = $zendserver::params::webserver,
  $phpversion           = $zendserver::params::phpversion,
  $package_lsbrelease   = $zendserver::params::package_lsbrelease,
  $license_name         = $zendserver::params::license_name,
  $license_key          = $zendserver::params::license_key,
  $zend_server_version  = $zendserver::params::zend_server_version,
  $join_cluster         = $zendserver::params::join_cluster,
  $db_username          = undef,
  $db_password          = undef,
  $db_schema            = undef,
  $admin_api_key_name   = $zendserver::params::admin_api_key_name,
  $admin_api_key_secret = $zendserver::params::admin_api_key_secret,
){
  include zendserver::params
  validate_bool($manage_repos)
  validate_re($webserver, ['\Aapache|nginx\Z',], 'Only apache or nginx are supported.')
  validate_re($phpversion, ['\A5.4|5.5\Z',], 'Only versions 5.4 or 5.5 are supported.')


  anchor { 'zendserver::begin': } ->
    class { '::zendserver::requirements': } ->
    class { '::zendserver::install': } ->
    class { '::zendserver::config': }  ~>
    class { '::zendserver::service': } ->
  anchor { 'zendserver::end': }
}
