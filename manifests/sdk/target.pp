# == Definition: zendserver::sdk::target
# Manage an sdk target to be used for all sdk calls
# This define authenticates against the Zend Server api

#TODO: use params class pattern
define zendserver::sdk::target ($zskey,
                                $zssecret,
                                $target=$name,
                                $zsurl='http://localhost:10081',
                                $zsversion='6.1'){
  #TODO: replace the exec with a file or ini_file type
  exec {"add-target-${name}":
    command     => "/usr/local/zend/bin/php /usr/local/zend/bin/zs-client.phar addTarget --target=${target} --zskey=${zskey} --zssecret=${zssecret}",
    require     => File['/usr/local/zend/bin/zs-client.phar'],
    unless      => "/usr/local/zend/bin/php /usr/local/bin/zs-client.phar getSystemInfo --target=${target}",
  }
}
