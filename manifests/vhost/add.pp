# == Define: zendserver::vhost::add
# Define an existing application in Zend Server(that was not installed using Zend Server).
# This definition is for internal use, do not include it directly in your manifest - it is called by zendserver::application. 
# === Parameters
# [*target*]
# Zend Server SDK target to use for the virtual host methods. Defaults to the module's default, localadmin
# [*port*]
# Port of virtual host. Default to 80 for this module.
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

define zendserver::vhost::add (
  $target,
  $vhostname               = $vhostname,
  $port                    = $port,
  $secure                  = $secure,
  $sslCertificatePath      = $sslCertificatePath,
  $sslCertificateKeyPath   = $sslCertificateKeyPath,
  $sslCertificateChainPath = $sslCertificateChainPath,
  $template                = $template,
  $force_create            = $force_create,) {
  $required_options        = "--name=${vhostname} --port=${port}"

  $additional_options      = $required_options
  $secure_options          = "--sslCertificatePath=${sslCertificatePath} --sslCertificateKeyPath=${sslCertificateKeyPath}"

# ${name}_${port} is required to make the vhost unique. Many vhosts can have the same name if they run on different ports
  $vhost_name_fact       = getvar("::zend_vhost_name_${vhostname}_${port}")

#Debug
#  notify{ "name: ${name}": }
#  notify{ "port: ${port}": }
#  notify{ "name_port: ${name}_${port}": }
#  notify{ "vhostname: ${vhostname}": }
#  notify{ "secure: ${secure}": }
#  notify{ "target: ${target}": }

#Check if vhost exists by using facter
  if $vhost_name_fact != undef {

  } else {
    zendserver::sdk::command { "vhost_add_${vhostname}_${port}":
      target             => $target,
      api_command        => 'vhostAdd',
      additional_options => $additional_options,
      notify             => Service['zend-server'],
    }
  }
}
