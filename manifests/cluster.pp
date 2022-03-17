# == Class: zendserver::cluster
#   This is an internal class that causes the module to join a cluster if necessary.
#   This class should not be called directly.
class zendserver::cluster inherits zendserver {
  if $zendserver::join_cluster {
    include zendserver::cluster::join_exec
  }
}
