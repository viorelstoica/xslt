@echo off
REM --------------------------------------------------------------------------------
REM - Stop TTI Application
REM --------------------------------------------------------------------------------
wmic process where (commandline like "%%tti-camel-app-DEV.0.0-SNAPSHOT%%" and not name="wmic.exe") delete