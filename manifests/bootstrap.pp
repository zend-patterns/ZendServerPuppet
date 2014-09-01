# == Class: zendserver::bootstrap
#  Bootstrap single server if the fact zend_gui.completed is not true
class zendserver::bootstrap inherits zendserver {
  if $::zend_gui_completed != 'true' {
    include zendserver::bootstrap::exec
  }
}
