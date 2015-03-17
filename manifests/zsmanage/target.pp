# == Define: zendserver::sdk::target
# Manage an sdk target to be used for all sdk calls
# This define authenticates against the Zend Server api
define zendserver::zsmanage::target (
  $zskey,
  $zssecret,
  $target = $name,
  $zsurl = "${zendserver::zsurl}",) {
  # TODO: replace the exec with a file or ini_file type
}
