@echo off

if not defined TEMN_TTI_HOME (
    echo "TEMN_TTI_HOME environment variable not set, exiting TTI Camel application."
    timeout 1 /NOBREAK > NUL 2>&1
	exit /B
)

if not defined TEMN_TTI_CLASSPATH set TEMN_TTI_CLASSPATH=lib,config,config/jms

java -DTEMN_TTI_HOME=%TEMN_TTI_HOME% -Dtemn.meter.disabled=%TEMN_TTI_METER_DISABLE% -Djdk.xml.xpathExprGrpLimit=0 -Djdk.xml.xpathExprOpLimit=0 -Djdk.xml.xpathTotalOpLimit=0 -Dloader.path=%TEMN_TTI_CLASSPATH% -jar app/tti-camel.jar