class zendserver::repo::debian {

  if $caller_module_name != $module_name {
    warning("${name} should not be directly included in the manifest.")
  }

  apt::key { 'zend':
    key_source => 'http://repos.zend.com/zend.key',
  }

}