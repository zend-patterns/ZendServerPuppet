 Server Puppet Module

## Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Components affected by this module](#components-affected-by-this-module)
    * [Setup requirements](#setup-requirements)
    * [Getting started](#getting-started)
    * [Module Installation](#module-installation)
4. [Usage](#usage)
5. [Further Reference](#further-reference)
5. [Limitations](#limitations)
6. [Contributing to this module](#contributing-to-this-module)

## Overview
The zendserver module allows you to easily manage Zend Server with Puppet.

## Module Description
On the first run, this module:
* Installs Zend Server
* Installs the desired web server (httpd or nginx), if not already installed
* Deploys an SDK client (zs-client.phar)
  * Will be discontinued in the future as all supported Zend Server Versions already install it by default, in another location)
  * The usage of `/usr/local/zend/bin/zs-client.sh` will probably replace the call to the phar
* "bootstraps" the installation
  * Deploys a file (`/usr/local/zend/bin/zs-puppet-common-functions.sh`), that contains functions for the bootstrap
  * Sets the license
  * Sets the admin and (optional) developer password for the web admin interface
  * Creates a target
    * A target is an API key/hash pair that is saved in a file, that allow one to do API calls using only the name of the target (does not send the key/hash pair on the network
    * The target info (key/hash) is saved in a file, typically $home/.zsapi.ini. However, when using puppet,there is no $HOME, so the file is in /.zsapi.ini (at the root).  This may change in the future.
* Configures  a cluster (or single machine) running Zend Server.
  * Sets up a database for the cluster
* Creates puppet facts about Zend Server
  * The Zend Server-related facts are managed every puppet run

It can also:

* Define, deploy, remove or update an application
* Deploy or remove a library
* Install/enable/configure a 3rd-party extension (pear, pecl, OS package)
* Do an API call with the SDK client
  * See https://github.com/zend-patterns/ZendServerSDK for details
* Execute commands with zs-manage (Using the SDK client should be preferred)
* Create a target (most likely useless by itself, but used by the bootstrap process)

Zend Server is an integrated PHP application server for mobile and web apps. Zend Server will also install a web server (apache/nginx) if it is not already installed on your system. Check http://www.zend.com for more information about Zend Server.

## Setup

### Components affected by this module

The module modifies files under the following directories (and sub directories):

 * /usr/local/zend (and all sub-directories).
 * Apache configuration (/etc/apache2 or /etc/httpd depending on distro).
 * Nginx configuration (if relevant).
 
### Setup Requirements

Typically, only vendor-supported (LTS, if applicable) versions are supported and tested with this module.

* Operating System. Currently vendor-supported version:

  * [RHEL](https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates) 6+
  * [Centos](https://wiki.centos.org/About/Product) 6+
  * [Debian](https://wiki.debian.org/DebianReleases) 7+
  * [Ubuntu](https://www.ubuntu.com/info/release-end-of-life) 12.04+

* Zend Server
Only the [currently supported Zend Server versions](http://www.zend.com/en/support-center/support/php-long-term-support) are supported and tested. Currently:
  * 7.0
  * 8.5
  * 9.1

Puppet dependencies:

 * Puppet version >= 3.4
 * The following puppet-forge modules:
    * puppetlabs/stdlibs
    * puppetlabs/apt (for Debian and Ubuntu)

For a cluster environment, access to a mysql server is required.
    
### Getting started
If you want to get started quickly you can checkout our [Vagrant testing box](https://github.com/davidl-zend/zendserverpuppet-vagrant). 

This code will:

 1. Install a machine running Ubuntu/Centos/Debian (depending on choice).
 2. Install the latest stable puppet version from puppet labs' repository.
 3. Obtain the puppet module and its dependencies using R10K.
 4. Pass parameters to the Zend Server module using hiera.
 5. Download and install Zend Server onto that machine.
 6. Install mysql.
 7. Bootstrap and join Zend Server on the machine to a cluster (using the local mysql database).
 8. Deploy a sample application to the cluster.

You can also use the testing box as a reference for using puppet in your environment.
You can view and modify the following files to customize the vagrant setup:

 * /data/common.yaml  - This files contains parameters to be passed to puppet on the Vagrant box (using hiera).
 * /manifests/site.pp - Example puppet manifest which uses the zendserver module.

### Module installation

To manually install the module:

  1. Install the dependent modules using the command (puppetlabs/stdlib will be automatically installed as a dependency):
  ```sudo puppet module install puppetlabs/apt```
  2. Clone the module into your module dir (usually /etc/puppet/modules):

  ```git clone https://github.com/zend-patterns/ZendServerPuppet /etc/puppet/modules/zendserver``` 

  If your puppet module dir is a git working copy then define the above repo as a git sub-moudle instead of cloning it.
  3. Check your installation using the command:
    ```sudo puppet module list```

  Example output:

```
  /etc/puppet/modules
  ├── puppetlabs-apt (v1.6.0)
  ├── puppetlabs-stdlib (v4.3.2)
  └── zend-zendserver (v0.2.0)
```
Alternatively you can use R10K to install the module and dependencies (see the puppet file in the above Vagrant test box for reference.

## Usage
For reference about the module's public API (classes and resources that should be used) check:
[Module API reference](doc/API_REFERENCE.md) or [SDK code on Github](https://github.com/zend-patterns/ZendServerSDK/). The [Zend Server documentation section about the API](http://files.zend.com/help/Zend-Server/content/introduction2.htm may also be useful).

You can check the comments in the code for further information.

## Further reference
You can check [Zend Server's online help zend-online-help](http://files.zend.com/help/Zend-Server/zend-server.htm) for instructions and more information.
[R10K Instructions](http://terrarum.net/blog/puppet-infrastructure-with-r10k.html)

## Limitations
The module is still under testing - please try it on a non-production system first.

  * It is recommended you do not use the module to manage a Zend Server system that was not installed with this module(Such a setup might work but is untested).
  * You should make sure that no other PHP installation is present on the system (such as the distros' php or manually installed versions).
  * Before installing Zend Server for use with Nginx, define the nginx repository: http://nginx.org/en/linux_packages.html#stable. (Without this installation of zend server will fail)
  * The module does not add /usr/local/zend/bin to the search path - you might want to do it yourself.
  * The module is not compatible with the puppetlabs/apache module. Do not use both modules to manage the same node (=server). puppetlabs/apache can be used to manage other nodes.

## Contributing to this module
If you wish to help our efforts you can open issues in the github repository or contribute code.
To contribute, please fork the repository and send us a pull-request with your changes using github.
You can email cloud-paas-dev@zend.com for further questions.
