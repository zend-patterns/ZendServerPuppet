#Zend Server Puppet Module

####Table of Contents

1. [Overview](#Overview)
2. [Module Description](#Module Description)
3. [Setup](#Setup)
    * [Components affected by this module](#Components affected by this module)
    * [Setup requirements](#Setup requirements)
    * [Getting started](#Getting Started)
    * [Module Installation](#Module Installation)
4. [Usage](#Usage)
5. [Further Reference](#Further Reference)
5. [Limitations](#Limitations)
6. [Contributing to this module](#Contributing to this module)

##Overview
The zendserver module allows you to easily manage Zend Server with Puppet.

##Module Description
This module installs, "bootstraps" and manages a cluster (or single machine) running Zend Server. Zend Server is an integrated PHP application server for mobile and web apps. Zend Server will also install a web server (apache/nginx) if it is not already installed on your system. Check http://www.zend.com for more information about Zend Server.

##Setup

###Components affected by this module
The module downloads and installs:

 * Zend Server using the distro's package manager (apt/yum). 
 * Zend Framework (as a library in Zend Server)
 * Symphony php framework (as a library in Zend Server)
 * A web server (either apache or nginx) using the distro's package manager (apt/yum). 
 * Zend Server next generation SDK - (See https://github.com/zend-patterns/ZendServerSDK for details)

The module modifies files under the following directories (and sub directories):

 * /usr/local/zend (and all sub-directories).
 * Apache configuration (/etc/apache2 or /etc/httpd depending on distro).
 * Nginx configuration (if relevant).
 
###Setup Requirements
Operating System:

* RHEL/Centos >=6
* Debian >= 6
* Ubuntu >= 10.04

Puppet dependencies:

 * Puppet version >= 3.4
 * The following puppet-forge modules:
    * puppetlabs/stdlibs
    * puppetlabs/apt

For a cluster environment also access to a mysql server.
    
###Getting started
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

###Module installation

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

##Usage
For reference about the module's public API (classes and resources that should be used) check:
[Module API reference](doc/API_REFERENCE.md)

You can check the comments in the code for further information.

##Further reference
You can check [Zend Server's online help zend-online-help](http://files.zend.com/help/Zend-Server/zend-server.htm) for instructions and more information.
[R10K Instructions](http://terrarum.net/blog/puppet-infrastructure-with-r10k.html)

##Limitations
The module is still under testing - please try it on a non-production system first.

  * It is recommended you do not use the module to manage a Zend Server system that was not installed with this module(Such a setup might work but is untested).
  * You should make sure that no other PHP installation is present on the system (such as the distros' php or manually installed versions).
The module does not add /usr/local/zend/bin to the search path - you might want to do it yourself.
  * Zend Server version >=7.0 (older versions are untested). Default version is 8.0.
  * Support for apache (2.2/2.4) web server (nginx support is untested).
  * The module is not compatible with the puppetlabs/apache module. Do not use both modules to manage the same node (=server). puppetlabs/apache can be used to manage other nodes.

##Contributing to this module
If you wish to help our efforts you can open issues in the github repository or contribute code.
To contribute, please fork the repository and send us a pull-request with your changes using github.
You can email cloud-paas-dev@zend.com for further questions.

