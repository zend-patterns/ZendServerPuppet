# == Define: zendserver::sdk::target
# Manage an sdk target to be used for all sdk calls
# This define authenticates against the Zend Server api
define zendserver::zsmanage::target ($zskey, $zssecret, $target = $name, $zsurl = 'http://localhost:10081',) {
  # TODO: replace the exec with a file or ini_file type
}
