# == Definition: zendserver::library
# Deploy a Zend Server library. 
# === Parameters
# [*ensure*]
# present, deployed, latest - deploy a zpk package to the selected target.
# absent, undeployed - remove and application from the selected target.
# defined - define an existing application (which was deployed by other means) in Zend Server.
# [*target*]
# Zend Server SDK target from which to remove the application.
# [*lib_package*]
# The name of the application package (zpk) to deploy.
# [*user_lib_name*]
# The user librarie's name (alias) (Default: resource name)
# [*version*]
# The version of the library(Optional).
# [*logo*]
# Path to a local file on the server holding the library's logo (for displaying in the Zend Server console).
# It is advised you add a puppet "File" resource for the logo file and "require" it.
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