#!/usr/bin/python

import json
import os.path
import re
import subprocess

zs_api_config_file = '/.zsapi.ini'
zs_api_target = 'localadmin'

if os.path.isfile("/usr/local/zend/bin/zs-client.sh"):

  extensions_details = subprocess.check_output(["/usr/local/zend/bin/zs-client.sh", "configurationExtensionsList", "--target=localadmin", "--output-format=json"])

  ## Strip the PHP notices from the json
  extensions_details = re.sub("Notice:.*\n", "", extensions_details)
  ## Strip the newlines from the json
  extensions_details = re.sub("\n", "", extensions_details)

  arr = json.loads(extensions_details)

  for extension in arr[u"responseData"][u"extensions"]:
    name = extension["name"]
    for key, value in extension.iteritems():
      if not isinstance(value, list):
        print ('zend_extension_' + key + '_' + name + '=' + value)
