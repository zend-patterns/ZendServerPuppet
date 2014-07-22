define zend-server($version = "6.3", $php_version = "5.4", $db_host = "", $db_username = "", $db_password = "", $db_name = "", $admin_password, $order_number, $license_key) {
  exec { "import-zend-key":
    command => "wget http://repos.zend.com/zend.key -O- | apt-key add - ; apt-get update"
  }

  file { "zend.list":
    path   => '/etc/apt/sources.list.d/zend.list',
    mode   => 644,
    owner  => root,
    group  => root,
    content => template("zend-server/zend.list.erb"),
  }

  package { "zend-server-php-$php_version":
    ensure  => 'latest',
    require => [ File["zend.list"], Exec['import-zend-key'] ],
  }

  service { "zend-server":
    ensure    => running, 
    enable    => true,
    hasstatus => true,
    require   => Package["zend-server-php-$php_version"],
  }

  user {"www-data":
    groups  => ['ssl-cert'],
    require => Package["zend-server-php-$php_version"],
    notify  => Service['zend-server'],
    before  => File["zs-init.sh"],
  }

  user {"zend":
    groups  => ['adm'],
    require => Package["zend-server-php-$php_version"],
    notify  => Service['zend-server'],
  }
  
  file { "zs-init.sh":
    path    => '/root/zs-init.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template("zend-server/zs-init.sh.erb"),
  }
  
  exec { "zend-server-init":
    command => "/root/zs-init.sh",
    creates => "/zs-done",
    require => [ File['zs-init.sh'], Package["zend-server-php-$php_version"] ],
  }
}
