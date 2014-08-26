# == Definition: zendserver::sdk::target
# Manage an sdk target to be used for all sdk calls
# This define authenticates against the Zend Server api
/*
 * [dave]
 * zsurl = "http://localhost:10081"
 * zskey = "admin"
 * zssecret = "10ff69b840e87ab4a8bdb793309a6d9363c0d3ad6702d9474b470d1888e6f370"
 * zsversion = "6.1"
 */

define zendserver::zsmanage::target ($zskey, $zssecret, $target = $name, $zsurl = 'http://localhost:10081',) {
  # TODO: replace the exec with a file or ini_file type
}