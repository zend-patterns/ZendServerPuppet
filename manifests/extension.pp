# == Class: zendserver::extension
#   Manage php extensions
# === Parameters
# [*ensure*]
# present - Install the pear package if it is not present
# latest - Make sure that the pear package is at it's latest version
# absent - remove the module if present
# [*pear_module*]
# Name of the module to install - defaults to the extension's name

class zendserver::extension ($ensure = 'present', $enable = true, $provider = 'built_in',) {
  case $ensure {
    default : { }

  }
}