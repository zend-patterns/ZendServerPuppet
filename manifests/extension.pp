# == Definition: zendserver::extension
#   Enable or disable a Zend Server extension. 
#
# Note: Due to the way puppet exposes facts, extension names are case insensitive
# in this module.
#
# === Parameters
# [*enabled*]
# true or false, required.
# [*target*]
# Zend Server SDK target to use for the virtual host methods. Defaults to the module's default, localadmin
# === Examples
#
# Enable
#
#  zendserver::extension { 'sqlite':
#  enabled         => 'true',
#  }
#
# Disable
#
#  zendserver::extension { 'sqlite':
#  enabled         => 'false',
#  }
# 

define zendserver::extension (
  $enabled,
  $target                   = 'localadmin',
) {

  $downcase_name = downcase($name)

  case $enabled {
    true : {
      zendserver::extension::enable { $downcase_name:
        target                  => $target,
      }
    }

    false : {
      zendserver::extension::disable { $downcase_name:
        target        => $target,
      }
    }
    default                : {
    fail ("enabled can only be true or false for ${name}.")
    }
  }
}
