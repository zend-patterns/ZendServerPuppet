# == Definition: zendserver::application
#   Debian specific settings for Zend Server install
#
# TODO:auto require logo file and app_package
define zendserver::application (
  $ensure,
  $target,
  $app_package     = undef,
  $base_url        = 'http://<default-server>/',
  $create_vhost    = false,
  $default_server  = undef,
  $user_app_name   = $name,
  $ignore_failures = false,
  $user_params     = '',
  $version         = undef,
  $logo            = '',) {
  case $ensure {
    'present', 'deployed' : {
      zendserver::application::deploy { $name:
        target        => $target,
        app_package   => $app_package,
        base_url      => $base_url,
        create_vhost  => $create_vhost,
        user_app_name => $name,
        user_params   => $user_params,
      }
    }
    'defined'             : {
      zendserver::application::define { $name:
        target        => $target,
        base_url      => $base_url,
        version       => '1.0',
        logo          => $logo,
        user_app_name => $name,
      }
    }
    'absent'              : {
      zendserver::application::remove { $name:
        target        => $target,
        user_app_name => $user_app_name,
      }
    }
    'latest'              : {
      if defined("$::zend_application_name_${name}") {

      } else {
        zendserver::application::deploy { $name:
          target        => $target,
          app_package   => $app_package,
          base_url      => $base_url,
          create_vhost  => $create_vhost,
          user_app_name => $name,
          user_params   => $user_params,
        }
      }
    }
    default               : {
    }
  }
}