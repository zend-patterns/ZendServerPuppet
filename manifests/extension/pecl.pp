# == Class: zendserver::extension::pear
#   Manage pear extensions.  You should manually require build dependencies for the pear module.
# === Parameters
# [*ensure*]
# present - Install the pear package if it is not present
# latest - Make sure that the pear package is at it's latest version
# absent - remove the module if present
# [*pear_module*]
# Name of the module to install - defaults to the extension's name

class zendserver::extension::pear ($ensure = 'present', $pear_module = $name, $pear_binary = '/usr/local/zend/bin/pear',) {
  case $ensure {
    'present'         : {
      $action = 'install'

      exec { "pear_${action}_${pear_module}":
        path    => "/usr/local/zend/bin:${::path}",
        command => "${pear_binary} ${action} ${pear_module}",
        unless  => "${pear_binary} list ${pear_module}",
        require => File[$pear_binary],
      }
    }
    'latest', default : {
      $action = 'upgrade'

      exec { "pear_${action}_${pear_module}":
        path    => "/usr/local/zend/bin:${::path}",
        command => "${pear_binary} ${action} ${pear_module}",
        require => File[$pear_binary],
      }
    }
    'absent'          : {
      $action = 'uninstall'

      exec { "pear_${action}_${pear_module}":
        path    => "/usr/local/zend/bin:${::path}",
        command => "${pear_binary} ${action} ${pear_module}",
        onlyif  => "${pear_binary} list ${pear_module}",
        require => File[$pear_binary],
      }
    }
  }

}