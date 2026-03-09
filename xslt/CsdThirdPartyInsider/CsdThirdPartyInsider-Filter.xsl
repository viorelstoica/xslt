<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdThirdPartyInsider" exclude-result-prefixes="b ns0" version="1.0">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="CsdThirdPartyInsider-Filter-Core.xsl"/>
    <xsl:import href="CsdThirdPartyInsider-Filter-Custo.xsl"/>
    <xsl:strip-space elements="*"/>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>

