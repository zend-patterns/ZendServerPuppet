# == Definition: zendserver::sdk::target
# Manage an sdk target to be used for all sdk calls
# This define authenticates against the Zend Server api
# === Parameters
# [*target*]
# The target which will be managed
# [*zsurl*]
# The URL for the Zend Server API (not necessary if a target is defined)
# [*zskey*]
# Zend Server API key name (not necessary if a target is defined)
# [*zssecret*]
# Zend Server API key secret hash (not necessary if a target is defined)
# [*zsversion*]
# The version of Zend Server that this target runs - this option helps choose the correct web api calls to use

define zendserver::sdk::target ($zskey,
                                $zssecret,
                                $target=$name,
                                $zsurl="${zendserver::zsurl}",
                                $zsversion='8.0'){
  #TODO: replace the exec with a file or ini_file type
  exec {"add-target-${name}":
    command     => "/usr/local/zend/bin/php /usr/local/zend/bin/zs-client.phar addTarget --target=${target} --zskey=${zskey} --zssecret=${zssecret}",
    require     => File['/usr/local/zend/bin/zs-client.phar'],
    unless      => "/usr/local/zend/bin/php /usr/local/zend/bin/zs-client.phar getSystemInfo --target=${target}",
  }
}
