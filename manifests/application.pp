# == Definition: zendserver::application
#   Debian specific settings for Zend Server install
#
# TODO:auto require logo file and app_package
# TODO:automatically repair broken apps (according to status and notifications)
define zendserver::application (
  $ensure,
  $target          = 'localadmin',
  $app_package     = undef,
  $base_url        = '/',
  $create_vhost    = false,
  $default_server  = undef,
  $user_app_name   = $name,
  $ignore_failures = false,
  $user_params     = '',
  $version         = undef,
  $logo            = '',) {
  
  case $ensure {
    'present', 'deployed'  : {
      zendserver::application::deploy { $name:
        target        => $target,
        app_package   => $app_package,
        base_url      => $base_url,
        create_vhost  => $create_vhost,
        user_app_name => $user_app_name,
        user_params   => $user_params,
      }
    }
    'defined'              : {
      zendserver::application::define { $name:
        target        => $target,
        base_url      => $base_url,
        version       => '1.0',
        logo          => $logo,
        user_app_name => $user_app_name,
      }
    }
    'absent', 'undeployed' : {
      zendserver::application::remove { $name:
        target        => $target,
        user_app_name => $user_app_name,
      }
    }
    'latest'               : {
      $app_name_fact = getvar("::zend_application_name_${user_app_name}")
      if $app_name_fact != undef {
        zendserver::application::update { $name:
          target        => $target,
          app_package   => $app_package,
          user_app_name => $user_app_name,
          user_params   => $user_params,
        }
      } else {
        zendserver::application::deploy { $name:
          target        => $target,
          app_package   => $app_package,
          base_url      => $base_url,
          create_vhost  => $create_vhost,
          user_app_name => $user_app_name,
          user_params   => $user_params,
        }
      }
    }
    default                : {
    }
  }
}
