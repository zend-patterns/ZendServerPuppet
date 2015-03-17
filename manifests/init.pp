# == Class: zendserver
#   Install and configure Zend Server
#
# === Parameters
#[*accept_eula*]
# Accept Zend Server End User License Agreement (default:true)
#[*admin_password*]
# Password for zend server console
#[*manage_repos*]
# Should the class manage Zend Server repositories (default:true)
#[*webserver*]
# Web Server to manage. Valid options:'apache','nginx' (default:'apache')
#[*phpversion*]
# PHP version to install. (default:'5.5')
#[*license_name*]
# Zend Server licensed user name or order number.
#[*license_key*]
# Zend Server License Key
#[*zend_server_version*]
# Zend Server Version (Default:7)
#[*join_cluster*]
# Whether to join a Zend Server cluster(default:false)
#[*db_username*]
# Mysql user for Zend Server database.
# If left blank then Zend Server will use sqlite.
# This parameter is required if join_cluster is true.
#[*db_password*]
# Password for Zend Server database.
#[*db_schema*]
# Schema to use for Zend Server (default:'zendserver')
#[*admin_api_key_name*]
# Zend Server 64 charachter API key to use for interfacing with Zend Server (Default:'admin')
#[*admin_api_key_secret*]
#  = 'caff756fd7682fa35901afa923822f63771570c25afd5368eaa659f2f71d4d6f',
#[*admin_email*]
# Email address to which Zend Server will send administrative messages.
# === Examples
#
# class {'zendserver':
#  $admin_password       => 'password'
#  $manage_repos         => true,
#  $webserver            => 'apache',
#  $phpversion           => '5.5',
#  $license_name         = 'licensed_user',
#  $license_key          = '42309fdfas0df90fsd',
#  $zend_server_version  = '8.0',
#  $join_cluster         = true,
#  $db_username          = 'mysqluser',
#  $db_password          = 'mysqlpassword',
#  $db_schema            = 'zendserver',
#  $admin_api_key_name   = 'admin',
#  $admin_api_key_secret = 'caff756fd7682fa35901afa923822f63771570c25afd5368e',
#  $admin_email          = 'admin@domain.tld',
#  $zsurl                = 'http://localhost:10081',
#}
#
# === Authors
#
# David Lowes <david.l@zend.com>
# Michael Krieg
class zendserver (
  $accept_eula           = $zendserver::params::accept_eula,
  $admin_password        = $zendserver::params::admin_password,
  $manage_repos          = $zendserver::params::manage_repos,
  $webserver             = $zendserver::params::webserver,
  $phpversion            = $zendserver::params::phpversion,
  $package_lsbrelease    = $zendserver::params::package_lsbrelease,
  $license_name          = $zendserver::params::license_name,
  $license_key           = $zendserver::params::license_key,
  $zend_server_version   = $zendserver::params::zend_server_version,
  $join_cluster          = $zendserver::params::join_cluster,
  $db_username           = undef,
  $db_password           = undef,
  $db_schema             = undef,
  $db_host               = undef,
  $admin_api_key_name    = $zendserver::params::admin_api_key_name,
  $admin_api_key_secret  = $zendserver::params::admin_api_key_secret,
  $admin_api_target_neme = $zendserver::params::admin_api_target_name,
  $create_facts          = $zendserver::params::create_facts,
  $admin_email           = $zendserver::params::admin_email,
  $zsurl                 = $zendserver::params::zsurl,
  $default_server        = undef,
  $external_url          = undef,) inherits zendserver::params {
  validate_bool($manage_repos)
  validate_re($webserver, ['\Aapache|nginx\Z',], 'Only apache or nginx are supported.')
  validate_re($phpversion, ['\A5.3|5.4|5.5\Z',], 'Only versions 5.4 or 5.5 are supported.')
  # TODO: api_key_name + web_api_key_secret are required if join_cluster=true
  anchor { 'zendserver::begin': } ->
  class { '::zendserver::requirements': } ->
  class { '::zendserver::install': } ->
  class { '::zendserver::sdk::install': } ->
  class { '::zendserver::bootstrap': } ~>
  class { '::zendserver::cluster': } ~>
  class { '::zendserver::service': } ->
  anchor { 'zendserver::end': }
  notify{ "zendserversetup key {$admin_api_key_name}": }
  notify{ "zendserversetup secret {$admin_api_key_secret}": }
  notify{ "zendserversetup hash ${zend_api_key_hash}":
      require => [
        Service['zend-server'],
        Class['zendserver::bootstrap'],
      ]
  }
}
