# == Class: zendserver::params
#  Parameters class for the zendserver class.
#  This class should not be included directly in the manifest.
#
class zendserver::params {
  $accept_eula           = lookup('zendserver::accept_eula',           undef, undef, true)
  $admin_password        = lookup('zendserver::admin_password',        undef, undef, 'changeme')
  $manage_repos          = lookup('zendserver::manage_repos',          undef, undef, true)
  $webserver             = lookup('zendserver::webserver',             undef, undef, 'apache')
  $phpversion            = lookup('zendserver::phpversion',            undef, undef, '5.5')
  $license_name          = lookup('zendserver::license_name',          undef, undef, undef)
  $license_key           = lookup('zendserver::license_key',           undef, undef, undef)
  $zend_server_version   = lookup('zendserver::zend_server_version',   undef, undef, '8.0')
  $join_cluster          = lookup('zendserver::join_cluster',          undef, undef, false)
  $admin_api_key_name    = lookup('zendserver::admin_api_key_name',    undef, undef, undef)
  $admin_api_key_secret  = lookup('zendserver::admin_api_key_secret',  undef, undef, undef)
  $admin_api_target_name = lookup('zendserver::admin_api_target_name', undef, undef, 'puppet')
  $admin_email           = lookup('zendserver::admin_email',           undef, undef, "root@${::fqdn}")
  $zsurl                 = lookup('zendserver::zsurl',                 undef, undef, 'http://localhost:10081')
  $create_facts          = lookup('zendserver::create_facts',          undef, undef, true)

  # Make sure that Zend Server is in the path of every exec
  Exec {
    environment => "PATH=/usr/local/zend/bin:${::path}" }

  case $::osfamily {
    'Debian' : { $package_lsbrelease = 'lsb-release' }
    'RedHat' : { $package_lsbrelease = 'redhat-lsb-core' }
    default  : { fail("${module_name} is not supported on ${::osfamily}") }
  }
}
