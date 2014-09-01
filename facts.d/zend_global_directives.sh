#!/bin/bash
if [ -f /usr/local/zend/etc/conf.d/ZendGlobalDirectives.ini ]
then
  for fact in `sed 's/[ \t]//g' /usr/local/zend/etc/conf.d/ZendGlobalDirectives.ini | grep -v -e "^;"| grep zend| sort -u`
  do
    echo $fact
  done
fi
