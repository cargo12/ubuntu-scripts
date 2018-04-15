#! /bin/bash 
# this script updates the dynamic ip on http://freedns.afraid.org/ using curl 
# check http://freedns.afraid.org/api/ and as weapon ASCII for the phrase in UPDATE_URL 
OLDIP_FILE="/var/lib/misc/oldip" 
CHECK_CMD="/usr/bin/curl -s http://ip.dnsexit.com/ | sed -e 's/ //'" 
UPDATE_URL="https://freedns.afraid.org/dynamic/update.php?eXZNbHJqZEdoWk5zTXkzZjZFeG8wZkdKOjE2NTY5NDUz" 
UPDATE_COMMAND="/usr/bin/curl -s $UPDATE_URL" 

echo "Getting current IP" 
CURRENTIP=`${CHECK_CMD}` 
echo "Found ${CURRENTIP}" 

if [ ! -e "${OLDIP_FILE}" ] ; then 
echo "Creating ${OLDIP_FILE}" 
echo "0.0.0.0" > "${OLDIP_FILE}" 
fi 

OLDIP=`cat ${OLDIP_FILE}` 

if [ "${CURRENTIP}" != "${OLDIP}" ] ; then 
echo "Issuing update command" 
${UPDATE_COMMAND} 
fi 

echo "Saving IP" 
echo "${CURRENTIP}" > "${OLDIP_FILE}"
