#!/bin/bash

# Get today's date
TODAY_DATE=$(date '+%Y-%m-%d')

IP_HOST="10.0.2.15/24"
RESTCONF_USERNAME="cisco"
RESTCONF_PASSWORD="cisco123!"
DATA_FORMAT="application/yang-data+json"
LOOPBACK_INTERFACE="lo"
LOOPBACK_IP="127.0.0.1"

api_url_put="https://${IP_HOST}/restconf/data/ietf-interfaces:interfaces/interface=${LOOPBACK_INTERFACE}"
api_url_get="https://${IP_HOST}/restconf/data/ietf-interfaces:interfaces"
headers="-H 'Accept: ${DATA_FORMAT}' -H 'Content-type: ${DATA_FORMAT}'"
basicauth="-u ${RESTCONF_USERNAME}:${RESTCONF_PASSWORD}"
yangConfig='{
  "ietf-interfaces:interface": {
     "name": "'${LOOPBACK_INTERFACE}'",
     "description": "RESTCONF => '${LOOPBACK_INTERFACE}'",
     "type": "iana-if-type:softwareLoopback",
     "enabled": true,
     "ietf-ip:ipv4": {
         "address": [
             {
                 "ip": "'${LOOPBACK_IP}'",
                 "netmask": "255.0.0.0"
             }
         ]
     }
 }
}'

# Output today's date
echo ${TODAY_DATE} >> check_restconf_api.txt

# Output 'START REST API CALL'
echo 'START REST API CALL' >> check_restconf_api.txt
echo '============' >> check_restconf_api.txt

# Output 'FIRST API CALL'
echo 'FIRST API CALL' >> check_restconf_api.txt
echo '============' >> check_restconf_api.txt

# Perform the first API call and redirect the output to the file
(curl -X PUT -d "${yangConfig}" ${headers} ${basicauth} ${api_url_put} -w 'Status Code: %{http_code}\n' -v -s; echo '============') >> check_restconf_api.txt

# Output 'SECOND API CALL'
echo 'SECOND API CALL' >> check_restconf_api.txt
echo '============' >> check_restconf_api.txt

# Perform the second API call and append the output to the file
(curl -k -X GET ${headers} ${basicauth} ${api_url_get} -s; echo '============') >> check_restconf_api.txt

# Output 'END REST API CALL'
echo 'END REST API CALL' >> check_restconf_api.txt
