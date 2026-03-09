<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0"
    version="1.0" xmlns="http://www.odcgroup.com/F2B"
	xmlns:infra="http://www.odcgroup.com/InfraPMS"
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
    xmlns:b="http://www.temenos.com/T24/event/TTI/DXT24StatusChange"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXT24StatusChange"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXT24StatusChange"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXT24StatusChange" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="DXT24StatusChange-Core.xsl"/>
    <xsl:import href="DXT24StatusChange-Custo.xsl"/>
	<xsl:import href="DXT24StatusChange.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>
