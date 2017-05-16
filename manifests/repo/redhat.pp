# == Class: zendserver::repo::redhat
#  Manage Zend Server rpm repositories
#
class zendserver::repo::redhat inherits zendserver {
  if $caller_module_name != $module_name {
    warning("${name} should not be directly included in the manifest.")
  }

unless ($::osfamily == 'RedHat') and (versioncmp($::operatingsystemrelease, '6.0') >= 0) {
    fail("OS family ${::osfamily}-${::operatingsystemrelease} is not supported. Only RedHat >= 6 is suppported. RHEL 5 is EOL")
  }

  $rpmdir = $::operatingsystemrelease ? {
    /^5.*$/ => 'rpm',
    /^6.*$/ => 'rpm',
    /^7.*$/ => 'rpm_apache2.4',
  }
    

  yumrepo { 'Zend':
    baseurl  => "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/${rpmdir}/${::architecture}",
    descr    => 'Zend Server',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://repos.zend.com/zend.key',
  }

  yumrepo { 'Zend_noarch':
    baseurl  => "http://repos.zend.com/zend-server/${zendserver::zend_server_version}/${rpmdir}/noarch",
    descr    => 'Zend Server',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://repos.zend.com/zend.key',
  }
}
