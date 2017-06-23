# == Definition: zendserver::directive
#   Define a php configuration value (directives)
#
# Note: Due to the way puppet exposes facts, directive names are case insensitive
# in this module
#
# === Parameters
# [*directive_value*]
# Desired value for the directive. For example: on or 10M. Required.
# === Examples
#
# Boolean: 0 (off) or 1 (on)
#
#  zendserver::directive { 'allow_url_include':
#    directive_value  => '0',
#  }
#
#  zendserver::directive { 'upload_max_filesize':
#    directive_value  => '20M',
#  }
#
# Todo: paths
# Todo: other types?

define zendserver::directive (
  $directive_value,
  $target             = 'localadmin',
  $downcase_name    = downcase($name),
) {

# It looks like facts are returned all lowercase, so I use zend_directive_filevalue
# instead of zend_directive_fileValue (fileValue is the real format).

  $directive_value_fact       = getvar("::zend_directive_filevalue_${downcase_name}")

  # Check if application is deployed by using facter
  if $directive_value_fact != $directive_value {
  
    zendserver::sdk::command { "directive_change_${downcase_name}":
      target             => $target,
      api_command        => 'configurationStoreDirectives',
      additional_options => "--directives=\"${name}=${directive_value}\"",
    } ->
    zendserver::sdk::command { "directive_change_reload_${downcase_name}":
      target      => $target,
      api_command => 'restartPhp',
    }
  }
}
