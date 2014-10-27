# == Defined type: zendserver::extension::pecl
#   Manage pecl extensions.  You should manually require build dependencies for the pecl module.
# === Parameters
# [*ensure*]
# present - Install the pecl package if it is not present
# latest - Make sure that the pecl package is at it's latest version
# absent - remove the module if present
# [*pecl_module*]
# Name of the module to install - defaults to the extension's name
# [*extension_binary*]
# Name of the extension to load
define zendserver::extension::pecl (
  $ensure           = 'present',
  $pecl_module      = $name,
  $pecl_binary      = '/usr/local/zend/bin/pecl',
  $extension_binary = "${name}.so",
  $overwrite_config = true,) {
  case $ensure {
    'present'         : {
      $action = 'install'
      $onlyif = ''
      $unless = "${pecl_binary} list ${pecl_module}"
      $config_file_ensure = $ensure
    }
    'latest', default : {
      $action = 'upgrade'
      $onlyif = ''
      $unless = ''
      $config_file_ensure = 'present'
    }
    'absent'          : {
      $action = 'uninstall'
      $onlyif = "${pecl_binary} list ${pecl_module}"
      $unless = ''
      $config_file_ensure = $ensure
      $config_file_template = undef
    }
  }

  exec { "pecl_${action}_${pecl_module}":
    path    => "/usr/local/zend/bin:${::path}",
    command => "${pecl_binary} ${action} ${pecl_module}",
    unless  => $unless,
    onlyif  => $onlyif,
    require => File[$pecl_binary],
  }
}