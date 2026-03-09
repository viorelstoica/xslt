#!/bin/bash

echo "Usage: start-tti.sh"
echo "commands:"
echo "start-tti.sh  Start TTI interface"
echo "Press any key to continue"
read

if [ -z "$TEMN_TTI_HOME" ]
then
  echo "TEMN_TTI_HOME environment variable not set, exiting TTI Camel application..."
  sleep 5
  return
fi

if [ -z "$TEMN_TTI_METER_DISABLE" ]
then
  export TEMN_TTI_METER_DISABLE=true
fi

export TTI_ENCRYPTION_PASSWORD=$1;
echo "starting TTI Camel application..."
java -DTEMN_TTI_HOME=$TEMN_TTI_HOME -Dtemn.meter.disabled=$TEMN_TTI_METER_DISABLE -Djdk.xml.xpathExprGrpLimit=0 -Djdk.xml.xpathExprOpLimit=0 -Djdk.xml.xpathTotalOpLimit=0 -Dloader.path=lib,config/jms,config/properties,config -jar app/tti-camel.jar