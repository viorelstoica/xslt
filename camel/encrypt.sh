#!/bin/sh 

# -----------------------------------------------------------------------------
# Password encryption tool for the TTI Camel
# -----------------------------------------------------------------------------

echo "Usage: encrypt.sh"
echo "commands:"
echo "Usage: encrypt.sh text_to_encrypt [ master_password ]"
echo "Press any key to continue"
read

if [ "$1" != "" ] ; then
	java -jar app/tti-camel.jar encrypt $1 $2
else
	echo "Usage: encrypt.sh text_to_encrypt [ master_password ]"
	exit 1
fi