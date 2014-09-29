# == Definition: zendserver::library
#   Debian specific settings for Zend Server install
#
# TODO:auto require lib_package
# TODO:automatically repair broken libraries (according to status and notifications)
define zendserver::library (
  $ensure,
  $target          = 'localadmin',
  $lib_package     = undef,
  $user_lib_name   = $name,
  $ignore_failures = false,
  $version         = undef,
  $logo            = '',) {
  case $ensure {
    'present', 'deployed'  : {
      $lib_name_fact = getvar("::zend_library_name_${user_lib_name}")

      if $lib_name_fact != undef {

      } else {
        zendserver::library::deploy { $name:
          target      => $target,
          lib_package => $lib_package,
        }
      }
    }
    'absent', 'undeployed' : {
      zendserver::library::remove { $name:
        target        => $target,
        user_lib_name => $user_lib_name,
      }
    }
    'latest'               : {
      zendserver::library::deploy { $name:
        target      => $target,
        lib_package => $lib_package,
      }
    }
    default                : {
    }
  }
}