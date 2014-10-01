# == Class: zendserver::service
#   Manage Zend Server services
#
class zendserver::service inherits zendserver {
  service { 'zend-server':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package[$zendserver::install::zendserverpkgname],
  }
}
