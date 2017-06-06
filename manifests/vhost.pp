# == Definition: zendserver::vhost
#   Deploy or define a Zend Server virtual host. 
# === Parameters
# [*ensure*]
# present or absent, required.
# [*vhostname*]
# The real name of the vhost.  For example, if you want to have an application at http://myapp.com, the
# value for vhostname will be myapp.com. Required. We could not simply take the resource name because, 
# in some cases, one may need to configure a vhost that listens to more than one port, making the
# resources names non-unique, which puppet refuses. Required.
# [*target*]
# Zend Server SDK target to use for the virtual host methods. Defaults to the module's default, localadmin
# [*port*]
# Port of virtual host. Defaults to 80 for this module.
# [*secure*]
# True if to be served over https. Defaults to false.
# [*sslCertificatePath*]
# secure-specific.  File path to locate the SSL certificate file.
# [*sslCertificateKeyPath*]
# secure-specific.  File path to locate the SSL private key file.
# [*sslCertificateChainPath*]
# secure-specific.  File path to the SSL chain file.
# [*template*]
# Template of the virtual host settings according to the web server configuration options.
# Or an absolute path to a local template vhost file.
# A local template vhost file is a file that should be present on the machine where zs-client is running.
# [*force_create*]
# Force the creation of a virtual host, even if it fails syntax validation. Default: FALSE
# === Examples
#
# Minimalist
#
#  zendserver::vhost { 'vhost1':
#    ensure     => 'present',
#    vhostname  => 'vhost1',
#  }
#
# Delete a vhost
#
#  zendserver::vhost { 'vhost1':
#    ensure     => 'absent',
#    vhostname  => 'vhost1',
#  }
# 
# Please note that you cannot edit a vhost with this module
# You must edit it from the Zend Server interface or
# delete and re-create the vhost using this module
#
# Complex - http
#
# If you have a vhosts that listens to different
# ports, make sure you use distinct names like these:
#
#   zendserver::vhost { 'vhost1test_90':
#     ensure     => 'present',
#     vhostname  => 'vhost1test',
#     port       => '90',
#  }
#
#  zendserver::vhost { 'vhosttest_89':
#    ensure     => 'present',
#    vhostname  => 'vhost1test',
#    port       => '89',
#  }
# 
# Using a specific template
# Note: the template must already exist on the puppet client
#
#  zendserver::vhost { 'vhost2':
#    ensure        => 'present',
#    vhostname     => 'vhost2',
#    template      => '/usr/local/zend/share/vhost_puppet_test.tpl',
#  }

define zendserver::vhost (
  $ensure,
  $vhostname,
  $target                   = 'localadmin',
  $port                     = 80,
  $secure                   = false,
  $sslCertificatePath       = undef,
  $sslCertificateKeyPath    = undef,
  $sslCertificateChainPath  = undef,
  $template                 = undef,
  $force_create             = false,
) {

  case $ensure {
    'present' : {
      zendserver::vhost::add { $name:
        target                  => $target,
        port                    => $port,
        vhostname               => $vhostname,
        secure                  => $secure,
        sslCertificatePath      => $sslCertificatePath,
        sslCertificateKeyPath   => $sslCertificateKeyPath,
        sslCertificateChainPath => $sslCertificateChainPath,
        template                => $template,
        force_create            => $force_create,
      }
    }
    'absent' : {
      zendserver::vhost::remove { $name:
        target        => $target,
        port          => $port,
        vhostname     => $vhostname,
      }
    }
    default                : {
    }
  }
}
