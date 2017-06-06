# == Define: zendserver::sdk::command
# Execute a Zend Server web api function using the next generation zend server SDK (zs-client.phar)
# You can read more about the SDK at https://github.com/zend-patterns/ZendServerSDK
# === Parameters
# [*target*]
# The target which the command will be run against - zendserver::bootstrap::exec defines a target named 'localamdin' pointing to the local server
# You can define more targets using zendserver::sdk:target
# [*api_command*]
# The api command to run (Default: $name). See /usr/local/zend/bin/zs-client.phar command:all for a list of commands to run
# [*zsurl*]
# The URL for the Zend Server API (not necessary if a target is defined)
# [*zskey*]
# Zend Server API key name (not necessary if a target is defined)
# [*zssecret*]
# Zend Server API key secret hash (not necessary if a target is defined)
# [*http_timeout*]
# Timeout for accessing the Zend Server web API in seconds (Default :60)
# [*additional_options*]
# Additional options to pass to the web api client such as parameters for the call.
# [*tries*]
# Number of times to retry the request if failed. (Default: 3)
# [*try_sleep*]
# Number of seconds to sleep between retries. (Default: 5)
define zendserver::sdk::command (
  $target,
  $api_command        = $name,
  $zsurl              = undef,
  $zskey              = undef,
  $zssecret           = undef,
  $http_timeout       = 60,
  $additional_options = '',
  $tries              = 3,
  $try_sleep          = 5,
  $cwd                = undef,
  $zs_version         = $zendserver::zend_server_version,
  $onlyif             = [],
) {

if versioncmp($zs_version, '8.5') >= 0 {
    $zs_client = '/usr/local/zend/bin/zs-client.sh'
  }
  else {
    $zs_client = '/usr/local/zend/bin/zs-client.phar'
  }


  if $cwd == undef {
    exec { "zsapi_${name}":
      path      => "/usr/local/zend/bin:${::path}",
      tries     => $tries,
      try_sleep => $try_sleep,
      command   => "${zs_client} ${api_command} --target=${target} ${additional_options} ",
      logoutput => true,
      require => File['/usr/local/zend/bin/zs-client.phar'],
      onlyif => $onlyif,
    }
  } else {
    exec { "zsapi_${name}":
      path      => "/usr/local/zend/bin:${::path}",
      tries     => $tries,
      cwd       => $cwd,
      try_sleep => $try_sleep,
      command   => "${zs_client} ${api_command} --target=${target} ${additional_options} ",
      logoutput => true,
      require => File['/usr/local/zend/bin/zs-client.phar'],
    }
  }

}
