# == Define: zendserver::extension::config_file
# Create and manage a Zend Server and PHP configuration file for an extension. This type is also used internally by the module.
#
# === Parameters
# [*ensure*]
# Ensures the configuration file is present or absent. See puppet type reference for "File" for valid options.
# [*config_file_name*]
# Full path to the configuration file to manage. (Default: /usr/local/zend/etc/<name>.ini).
# [*extension_so*]
# The extension name to load.
# [*config_file_template*]
# Location of the erb template to use for the configuration file. See puppet type reference for "File" for valid syntax. (Default: <module_name>/extenstion_config_file.ini.erb - the template supplied with the module).
# === Examples
#
# zendserver::extension:config_file {'extension': ensure => present, }
#g
#TODO: Inform Zend Server to update the blue-print after updating config files.

define zendserver::extension::config_file (
  $ensure,
  $config_file_name     = "/usr/local/zend/etc/${name}.ini",
  $extension_so         = "${name}.so",
  $config_file_template = "${::module_name}/extension_config_file.ini.erb",) {
  if !defined(File[$config_file_name]) {
    file { $config_file_name:
      ensure  => $ensure,
      content => template("${::module_name}/${config_file_template}"),
      owner   => 'zend',
      group   => 'zend',
      mode    => '0655',
    }
  }
}
