# == Define: zendserver::extension::enable
# Enables a Zend Server extension
define zendserver::extension::enable (
  $target                   = 'localadmin',
) {

  $extension_status_fact       = getvar("::zend_extension_status_${name}")

  # Check if application is deployed by using facter
  if $extension_status_fact != 'Loaded' {

    zendserver::sdk::command { "extension_enable_${name}":
      target             => $target,
      api_command        => 'configurationExtensionsOn',
      additional_options => "--extensions=\"${name}\"",
    }
    -> zendserver::sdk::command { "extension_enable_reload_${name}":
      target      => $target,
      api_command => 'restartPhp',
    }

  }

}
