#!/bin/bash
#Get information from the Zend Server API and output it in key value format
#This can be used by facter to display Zend Server facts

#TODO: add support for the following api calls
# * 'clusterGetServerStatus'
# * 'clusterGetServersCount'
# * 'codetracingIsEnabled'
# * 'applicationGetStatus'
# * 'libraryGetStatus'
# * 'tasksComplete'
# * 'vhostGetStatus'
# * 'tasksComplete'

FACT_PREFIX=zend_
ZEND_SERVER_API_CALLS=('getSystemInfo')

TARGET=localadmin
PATH=/usr/local/zend/bin:$PATH

if [ -f /usr/local/zend/bin/zs-client.phar ]
then
  for API_CALL in ${ZEND_SERVER_API_CALLS[@]}
  do
   /usr/local/zend/bin/zs-client.phar $API_CALL --target=$TARGET --output-format kv|sed "s/^/${FACT_PREFIX}/"
  done
fi
