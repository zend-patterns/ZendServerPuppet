#Api Reference
##zendserver
Install, bootstrap and configure Zend Server.

### Parameters
* accept_eula - Accept Zend Server End User License Agreement (default:true)
* admin_password - Password for zend server console
* manage_repos - Should the class manage Zend Server repositories (default:true)
* webserver - Web Server to manage. Valid options:'apache','nginx' (default:'apache')
* phpversion - PHP version to install. (default:'5.5')
* license_name - Zend Server licensed user name or order number.
* license_key - Zend Server License Key
* zend_server_version - Zend Server Version (Default:8)
* join_cluster - Whether to join a Zend Server cluster(default:false)
* db_username - Mysql user for Zend Server database. If left blank then Zend Server will use sqlite. This parameter is required if join_cluster is true.
* db_password - Password for Zend Server database.
* db_schema - Schema to use for Zend Server (default:'zendserver')
* admin_api_key_name - Zend Server WebAPI key name.
* admin_api_key_secret - Zend Server 64 charachter API key to use for interfacing with Zend Server (Default:'admin')
* admin_email - Email address to which Zend Server will send administrative messages.

### Examples

```
 class {'zendserver':
  $admin_password       => 'password'
  $manage_repos         => true,
  $webserver            => 'apache',
  $phpversion           => '5.5',
  $license_name         = 'licensed_user',
  $license_key          = '42309fdfas0df90fsd',
  $zend_server_version  = '8.0',
  $join_cluster         = true,
  $db_username          = 'mysqluser',
  $db_password          = 'mysqlpassword',
  $db_schema            = 'zendserver',
  $admin_api_key_name   = 'admin',
  $admin_api_key_secret = 'caff756fd7682fa35901afa923822f63771570c25afd5368e',
  $admin_email          = 'admin@domain.tld',
  $zsurl                = 'http://localhost:10081',
}
```

##zendserver::application
Deploy or define a Zend Server application. 

###Parameters
* ensure:
 * present, deployed, latest - deploy a zpk package to the selected target.
 * absent, undeployed - remove and application from the selected target.
 * defined - define an existing application (which was deployed by other means) in Zend Server.
* target - Zend Server SDK target from which to remove the application.
* app_package - The name of the application package (zpk) to deploy.
* base_url -  Path relative to the URI (without http....) in which the application is located. F.E if app is under http://www.fqdn.tld/app then
 you should enter /app.
* create_vhost - Whether to create a web server vhost to access the app.
* user_app_name -  The user application's name (alias) (Default: resource name)
* user_params -  Optional parameters to pass to the deployment command.
* version -  The version of the application - you can manually enter your version. (Default:'1.0')
* health_check -  Optional URL that points to a health check in your application.
* logo -  Path to a local file on the server holding the apps logo (for displaying in the Zend Server console). It is advised you add a puppet "File" resource for the logo file and "require" it.

###Example
```
zendserver::application { 'sanity':
  ensure        => 'deployed',
  app_package   => '/tmp/mtrig.zpk',
  require       => [Zendserver::Sdk::Target['localadmin'],
                   File['/tmp/mtrig.zpk']],
}
```

##zendserver::extension
Manage php extensions. This defined type can be used to obtain, install and configure PHP extensions.  The defined type does not manage build dependencies for Pear/Pecl extensions - you should define them yourself and "require" them.

###Parameters

* ensure -
  * present - Install the extension if it is not present
  * latest - Make sure that the extension is at it''s latest version
  * absent - Uninstall the extension
* extension_name -  Name of the extension to manage - defaults to the extension''s name
* enable -  Should the extension be enabled in PHP''s configuration (Default: true)
* provider:
  * built_in (Default) - the extension is already installed in the system by other means
  * pear - Get the extension from pear
  * pecl - Get the extension from pecl
  * package - Get the extension from your distribution''s package repository

###Example

```
 zendserver::extension { 'krb5':
   ensure   => present,
   provider => 'pear',
 }
```


##zendserver::library
Deploy a Zend Server library. 

### Parameters

* ensure:
 * present, deployed, latest - deploy a zpk package to the selected target.
 * absent, undeployed - remove and application from the selected target.
* target - Zend Server SDK target from which to remove the application.
* lib_package - The name of the application package (zpk) to deploy.
* user_lib_name - The user librarie's name (alias) (Default: resource name)
* version - The version of the library(Optional).
* logo - Path to a local file on the server holding the library's logo (for displaying in the Zend Server console).  It is advised you add a puppet "File" resource for the logo file and "require" it.

## zendserver::sdk::target
Manage a Zend Server WebAPI sdk target. This target can be used for "zendserver::sdk::command" resources.

### Parameters
* target - The target which will be managed
* zsurl - The URL for the Zend Server API (not necessary if a target is defined)
* zskey - Zend Server API key name (not necessary if a target is defined)
* zssecret - Zend Server API key secret hash (not necessary if a target is defined)
* zsversion - The version of Zend Server that this target runs - this option helps choose the correct web api calls to use.

## zendserver::sdk::command
Execute a Zend Server WebAPI command on a target using the next generation SDK. This define is used internally. You can use it to perform operations that are not yet supported natively in this module. You can run the command ```/usr/local/zend/bin/zs-client.phar``` on your server to view a list of supported commands.  You can read more about the SDK at https://github.com/zend-patterns/ZendServerSDK
### Parameters
* target - The target which the command will be run against - zendserver::bootstrap::exec defines a target named 'localamdin' pointing to the local server
You can define more targets using zendserver::sdk:target
*api_command - The api command to run (Default: $name). See /usr/local/zend/bin/zs-client.phar command:all for a list of commands to run
* zsurl - The URL for the Zend Server API (not necessary if a target is defined)
* zskey - Zend Server API key name (not necessary if a target is defined)
* zssecret - Zend Server API key secret hash (not necessary if a target is defined)
* http_timeout - Timeout for accessing the Zend Server web API in seconds (Default :60)
* additional_options - Additional options to pass to the web api client such as parameters for the call.
* tries - Number of times to retry the request if failed. (Default: 3)
* try_sleep - Number of seconds to sleep between retries. (Default: 5)

##zendserver::zsmanage
This is defined type wraps around the zs-manage command that can be used to control Zend Server.

### Parameters
* command - The Zend Server command to run. See "/usr/local/zend/bin/zs-manage --help" for a list of available commands.
* zskey - Zend Server Web API Key name.
* zssecret - Zend Server Web API Key hash.
* http_timeout - Timeout for the remote Zend Server to respond 60 seconds).
* additional_options Additional options to pass to zs-manage. See "/usr/local/zend/bin/zs-manage --help" for a list of the relevant options for each command.
* zsurl - URL To the Zend Server web API  http://localhost:10081)

##Service[zend-server]
This service makes sure that Zend Server and apache are up. 
Notifying(refreshing) this service will restart Zend Server and apache.
