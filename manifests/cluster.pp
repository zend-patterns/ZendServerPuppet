class zendserver::cluster inherits zendserver {
  if $join_cluster {
    include zendserver::cluster::join_exec
  }
}