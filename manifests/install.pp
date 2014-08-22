# == Class: zendserver::install
#   Install Zend Server
#
class zendserver::install{
  case $::osfamily {
    'Debian': {    
      include zendserver::install::debian
    }
    'RedHat': {
      include zendserver::install::redhat
    }
  }   
  #TODO:if api_key was not specified then save Zend Server API key as a fact.
  package {"zend-server-php-${zendserver::phpversion}":
    ensure  => 'latest',  
  }
}
