# == Define: zendserver::vhost::remove
# Remove a Virtual Host using the Zend Server SDK (zs-client).
# This is an internal definition, it should not be called directly in the manifest.
# === Parameters
# [*target]
# Zend Server SDK target from which to remove the application.
# [*user_vhost_name*]
# The user application's name (alias) (Default: definition name)

define zendserver::vhost::remove (
  $target,
  $vhostname               = $vhostname,
  $port                    = $port,
  $secure                  = $secure,
  $sslCertificatePath      = $sslCertificatePath,
  $sslCertificateKeyPath   = $sslCertificateKeyPath,
  $sslCertificateChainPath = $sslCertificateChainPath,
  $template                = $template,
  $force_create            = $force_create,) {

# ${name}_${port} is required to make the vhost unique. Many vhosts can have the same name if they run on different ports
  $vhost_name_fact       = getvar("::zend_vhost_name_${vhostname}_${port}")

#Debug
#  notify{ "name: ${name}": }
#  notify{ "port: ${port}": }
#  notify{ "vhost_name-fact: ${vhost_name_fact}": }
#  notify{ "vhostname: ${vhostname}": }
#  notify{ "secure: ${secure}": }
#  notify{ "target: ${target}": }



  # Check if application is deployed by using facter
  if $vhost_name_fact != undef {
    # Get application id from facter
    $vhost_id           = getvar("::zend_vhost_id_${vhostname}_${port}")

    $required_options = "--vhosts==${vhost_id}"

    zendserver::sdk::command { "vhost_remove_${vhostname}_${port}":
      target             => $target,
      api_command        => 'vhostRemove',
      additional_options => $required_options,
    } ->
    zendserver::sdk::command { "vhost_reload_${vhostname}_${port}":
      target      => $target,
      api_command => 'restartPhp',
    }

  } else {

  }
}
