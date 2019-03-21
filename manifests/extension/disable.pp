# == Define: zendserver::extension::disable
# Disables a Zend Server extension

define zendserver::extension::disable (
  $target                   = 'localadmin',
) {

  $extension_status_fact       = getvar("::zend_extension_status_${name}")

  if $name == 'phar' {
    fail("Do not disable Phar extension or you will break the Zend Server API, required for this module, in ${name}")
  }

  # Check if application is deployed by using facter
  if $extension_status_fact == 'Loaded' {

    zendserver::sdk::command { "extension_disable_${name}":
      target             => $target,
      api_command        => 'configurationExtensionsOff',
      additional_options => "--extensions=\"${name}\"",
    }
    -> zendserver::sdk::command { "extension_disable_reload_${name}":
      target      => $target,
      api_command => 'restartPhp',
    }

  }

}
