# == Definition: zendserver::directive
#   Define a php configuration value (directives)
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
  $target                   = 'localadmin',
) {

  zendserver::sdk::command { "directive_${name}":
    target             => $target,
    api_command        => 'configurationStoreDirectives',
    additional_options => "--directives=\"${name}=${directive_value}\"",
    onlyif             => "/usr/local/zend/bin/zs-client.sh configurationDirectivesList --target=${target} --filter=${name} | grep fileValue | grep -qiv \'\[CDATA\[${directive_value}\]\]\'",
  } ->
  zendserver::sdk::command { "directive_reload_${name}":
    target      => $target,
    api_command => 'restartPhp',
    onlyif      => "/usr/local/zend/bin/zs-client.sh configurationDirectivesList --target=${target} --filter=${name} | grep fileValue | grep -qiv \'\[CDATA\[${directive_value}\]\]\'",
  }

}
