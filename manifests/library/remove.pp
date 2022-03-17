# == Define: zendserver::library::remove
# Internal definition to remove a Zend Server Library. This defined type should not be called directly in a user's manifest.
#
# === Parameters
# [*target*]
# Zend Server SDK target from which to remove the library.
# [*user_lib_name*]
# Zend Server Library name to remove.
define zendserver::library::remove ($target, $user_lib_name = $name,) {
  # Check if application is deployed by using facter
  $lib_name_fact = getvar("::zend_library_name_${user_lib_name}")

  # Check if application is deployed by using facter
  if $lib_name_fact != undef {
    # Get application id from facter
    $lib_id = getvar("::zend_library_id_${user_lib_name}")
    $required_options = "--libraryIds=${lib_id}"

    zendserver::sdk::command { "libraryRemove_${name}":
      target             => $target,
      api_command        => 'libraryRemove',
      additional_options => $required_options,
    }
  } else {

  }
}
