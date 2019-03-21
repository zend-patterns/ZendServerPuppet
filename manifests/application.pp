# == Definition: zendserver::application
#   Deploy or define a Zend Server application.
# 
# Note: Due to the way puppet exposes facts, application names are case insensitive
# Therefore, if you try to create two applications: potato and Potato, Puppet
# will tell you there is a duplicate
#
# === Parameters
# [*ensure*]
# present, deployed, latest - deploy a zpk package to the selected target. - not tested
# absent, undeployed - remove and application from the selected target.
# defined - define an existing application (which was deployed by other means) in Zend Server.
# [*target*]
# Zend Server SDK target from which to remove the application.
# [*app_package*]
# The name of the application package (zpk) to deploy.
# [*base_url*]
# Path relative to the URI (without http....) in which the application is located. F.E if app is under http://www.fqdn.tld/app then
# you should enter /app.
# [*create_vhost*]
# Whether to create a web server vhost to access the app.
# [*user_app_name*]
# The user application's name (alias) (Default: resource name).
# [*user_params*]
# Optional parameters to pass to the deployment command.
# [*version*]
# The version of the application - you can manually enter your version (Default:'1.0').
# [*health_check*]
# Optional URL that points to a health check in your application.
# [*logo*]
# Path to a local file on the server holding the apps logo (for displaying in the Zend Server console).
# Required in some versions of the API
# === Examples
# Define:
#
#  zendserver::application { 'potato':
#    ensure   => 'defined',
#    base_url => "http://potato.com",
#    version  => "2",
#    logo     => '/usr/share/pixmaps/poweredby.png',
#    }
#
# Remove (undefine):
#
#  zendserver::application { 'tomato':
#    ensure   => 'absent',
#    base_url => 'http://tomato.com',
#    version  => "3",
#    logo     => '/usr/share/pixmaps/poweredby.png',
#    }

define zendserver::application (
  $ensure,
  $target        = 'localadmin',
  $app_package   = undef,
  $base_url      = '/',
  $create_vhost  = false,
  $user_app_name = downcase($name),
  $user_params   = '',
  $version       = undef,
  $health_check  = undef,
  $logo          = '',
  $cwd           = undef,
) {

  case $ensure {
    'present', 'deployed'  : {
      zendserver::application::deploy { $user_app_name:
        target        => $target,
        app_package   => $app_package,
        base_url      => $base_url,
        create_vhost  => $create_vhost,
        user_app_name => $user_app_name,
        user_params   => $user_params,
        cwd           => $cwd,
      }
    }
    'defined'              : {
      zendserver::application::define { $user_app_name:
        target        => $target,
        base_url      => $base_url,
        version       => '1.0',
        logo          => $logo,
        user_app_name => $user_app_name,
        health_check  => $health_check,
      }
    }
    'absent', 'undeployed' : {
      zendserver::application::remove { $user_app_name:
        target        => $target,
        user_app_name => $user_app_name,
      }
    }
    'latest'               : {
      $app_name_fact = getvar("::zend_application_name_${user_app_name}")

      if $app_name_fact != undef {
        zendserver::application::update { $user_app_name:
          target        => $target,
          app_package   => $app_package,
          user_app_name => $user_app_name,
          user_params   => $user_params,
        }
      } else {
        zendserver::application::deploy { $user_app_name:
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
      fail ("ensure can only be present, deployed, defined, absent, undeployed, or latest for ${name}")
    }
  }
}
