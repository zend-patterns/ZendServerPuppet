# == Class: zendserver::sdk::install
#   Install the next generation Zend SDK
#   Content was taken from https://github.com/zend-patterns/ZendServerSDK
#   Don't replace an existing copy of the SDK
class zendserver::sdk::install {
  file { '/usr/local/zend/bin/zs-client.phar':
    ensure  => present,
    mode    => '0755',
    source  => "puppet:///modules/${module_name}/zs-client.phar",
    replace => false,
    require => File['/usr/local/zend/bin'],
  }
}