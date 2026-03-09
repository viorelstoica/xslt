<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/InfraPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/AAProductSubType"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAAProductSubType"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAAProductSubType"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAAProductSubType" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="AAProductSubType-Core.xsl"/>
    <xsl:import href="AAProductSubType-Custo.xsl"/>
	<xsl:import href="AAProductSubType.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>
