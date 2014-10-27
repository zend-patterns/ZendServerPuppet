# == Defined type: zendserver::extension
#   Manage php extensions. This defined type can be used to obtain, install and configure PHP extensions.
# The defined type does not manage build dependencies for Pear/Pecl extensions - you should define them yourself and "require" them.
#
# === Parameters
# [*ensure*]
# present - Install the extension if it is not present
# latest - Make sure that the extension is at it's latest version
# absent - Uninstall the extension
# [*extension_name*]
# Name of the extension to manage - defaults to the extension's name
# [*enable*]
# Should the extension be enabled in PHP's configuration (Default: true)
# [*provider*]
# built_in (Default) - the extension is already installed in the system by other means
# pear - Get the extension from pear
# pecl - Get the extension from pecl
# package - Get the extension from your distribution's package repository
#
# === Examples
# zendserver::extension { 'krb5':
#   ensure   => present,
#   provider => 'pear',
# }
#

define zendserver::extension (
  $ensure         = 'present',
  $extension_name = $name,
  $enable         = true,
  $package_name   = undef,
  $provider       = 'built_in',) {
  case $provider {
    'pear'  : {
      zendserver::extension::pear { $name:
        ensure      => $ensure,
        pear_module => $extension_name,
      }
      $require_resource = "zendserver::extension::pear[${name}]"
    }
    'pecl'  : {
      zendserver::extension::pecl { $name:
        ensure      => $ensure,
        pecl_module => $extension_name,
      }
      $require_resource = "zendserver::extension::pecl[${name}]"
    }
    'package' :{
      zendserver::extension::package { $name:
        package_name => $package_name,
      }
    }
    default : {
      $require_resource = ''
    }

  }

  case $enable {
    true    : { }
    false   : { }
    default : { }
  }

  case $provider {
    'pear'  : { }
    'pecl'  : { }
    default : { }
  }
}
