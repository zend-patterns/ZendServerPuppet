#!/bin/sh
#Create web_api_key facts if required
function create_facts () {
  FACTS_DIR=/etc/facter/facts.d
  local _return=1
  if [ $WEB_API_KEY -a $WEB_API_KEY_HASH ]
  then
    mkdir -p $FACTS_DIR && \
      echo "zend_api_key_name=$WEB_API_KEY" > $FACTS_DIR/zend_api_key_name.txt
    echo "zend_api_key_hash=$WEB_API_KEY_HASH" > $FACTS_DIR/zend_api_key_hash.txt
    _return=$?
  fi
  return $_return
}

#Bootstrap Zend Server in single server mode using zs-manage
function zs_manage_bootstrap_single () {
  set -o pipefail
  OUTPUT="$(/usr/local/zend/bin/zs-manage bootstrap-single-server -p $ADMIN_PASSWORD -o $ORDER_NUMBER -l $LICENSE_KEY -a TRUE 2>&1 > /usr/local/zend/tmp/zs-done)"
  RESULT="$?"
  if [ "$RESULT" -ne 0 ]; then
    # check for existing bootstrap
    grep -q "already bootstrapped" <<< "$OUTPUT"
    if [ "$?" -eq 0 ]; then
      echo "$OUTPUT"
      echo "Retreiving and setting admin api key from current installation"
      API_KEY=$(sqlite3 /usr/local/zend/var/db/gui.db "select HASH from GUI_WEBAPI_KEYS where NAME='admin';")
      echo "admin   $API_KEY" > /usr/local/zend/tmp/zs-done 
      RESULT=0 # allow puppet to continue
    else
      echo "$OUTPUT"
      echo "Bootstrap command failed, removing invalid /usr/local/zend/tmp/zs-done"
      rm /usr/local/zend/tmp/zs-done
    fi
  fi
  set +o pipefail
  return $RESULT
}

function zs_manage_join_cluster () {
  if [[ $DB_HOST != "" && $DB_USERNAME != "" && $DB_PASSWORD != "" && $DB_SCHEMA != "" ]]; then
    /usr/local/zend/bin/zs-manage server-add-to-cluster -n <%= @hostname %> \
      -i <%= @ipaddress_eth0 %> -o $DB_HOST -u $DB_USERNAME -p $DB_PASSWORD \
      -d $DB_SCHEMA -N $WEB_API_KEY -K $WEB_API_KEY_HASH >> $JOIN_CLUSTER_OUT_FILE
    eval `cat $JOIN_CLUSTER_OUTPUT_FILE`
  else
    return 1
  fi
}

function zs_client_join_cluster () {
 /usr/local/zend/bin/zs-client.phar serverAddToCluster --serverName=$HOSTNAME --dbHost=$DB_HOST --dbUsername=$DB_USERNAME --dbPassword=$DB_PASSWORD --nodeIp=$NODE_IP --dbName=$DB_SCHEMA --target=$TARGET_NAME --output-format=kv
}


function create_zs_client_target () {
  local _return=1
  if [ $WEB_API_KEY -a $WEB_API_KEY_HASH ]
  then
    /usr/local/zend/bin/php /usr/local/zend/bin/zs-client.phar addTarget --target=$TARGET_NAME --zskey=$WEB_API_KEY --zssecret=$WEB_API_KEY_HASH
    local _return=$?
  fi  
  return $_return
}

function get_web_api_key_from_file {
  if [ -f $BOOTSTRAP_OUTPUT_FILE ]
  then
    WEB_API_KEY=`head -1 $BOOTSTRAP_OUTPUT_FILE | tr "[:blank:]" " " | tr -s "[:blank:]" | cut -d' ' -f1`
    WEB_API_KEY_HASH=`head -1 $BOOTSTRAP_OUTPUT_FILE | tr "[:blank:]" " " | tr -s "[:blank:]" | cut -d' ' -f2`
  fi

  #Check if web api key was actually created
  if [ $WEB_API_KEY -a $WEB_API_KEY_HASH ] 
  then
    return 0
  else 
    return 1
  fi
}

function create_web_api_key_wrapper_script {
  if [ $WEB_API_KEY -a $WEB_API_KEY_HASH ]
  then
    echo WEB_API_KEY=$WEB_API_KEY > /usr/local/zend/etc/zs-webapi-key.sh
    echo WEB_API_KEY_HASH=$WEB_API_KEY_HASH >> /usr/local/zend/etc/zs-webapi-key.sh
    return $?
  else
    return 1
  fi
}

