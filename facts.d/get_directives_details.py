#!/usr/bin/python

import json
import os.path
import re
import subprocess

zs_api_config_file = '/.zsapi.ini'
zs_api_target = 'localadmin'

if os.path.isfile("/usr/local/zend/bin/zs-client.sh"):

  directives_details = subprocess.check_output(["/usr/local/zend/bin/zs-client.sh", "configurationDirectivesList", "--target=localadmin", "--output-format=json"])

  ## Strip the PHP notices from the json
  directives_details = re.sub("Notice:.*\n", "", directives_details)
  ## Strip the newlines from the json
  directives_details = re.sub("\n", "", directives_details)

  f1=open('/tmp/puppet_zend_directives.txt', 'w')
  f1.write(directives_details)

  arr = json.loads(directives_details)

  for directive in arr[u"responseData"][u"directives"]:
    name = directive["name"]
    for key, value in directive.iteritems():
      if value and not isinstance(value, list) and not isinstance(value,dict):
        print ('zend_directive_' + key + '_' + name + '=' + value)
