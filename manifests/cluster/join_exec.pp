# == Class: zendserver::cluster::join_exec
#   This is an internal class that joins a Zend Server cluster using a generated shell script.
#   This class should not be called directly from within the module.

class zendserver::cluster::join_exec inherits zendserver::cluster {
  file { 'join-cluster.sh':
    path    => '/usr/local/zend/bin/join-cluster.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/join-cluster.sh.erb"),
    require => File['/usr/local/zend'],
  }

  $join_cluster_output_file = '/usr/local/zend/tmp/zs-cluster.sh'

  exec { 'join-cluster':
    command => '/usr/local/zend/bin/join-cluster.sh',
    creates => $join_cluster_output_file,
    require => [
      File['/usr/local/zend/bin/zs-client.phar'],
      File['zs-puppet-common-functions.sh'],
      File['join-cluster.sh']],
  }
}
