#!/bin/bash
echo "Stopping TTI"
if [ -z "$TEMN_TTI_HOME" ]
then
  stoptti="tti-camel.jar"
  else
  stoptti=$TEMN_TTI_HOME
fi
camelPid=`ps -ef | grep "$USER" | grep $stoptti | grep -v 'grep' | awk '{print $2}'`
for pid in $camelPid;
do
  echo "Killing TTI-Camel process id $pid"
  kill -9 $pid
done

sleep 10
echo "Stopped TTI"