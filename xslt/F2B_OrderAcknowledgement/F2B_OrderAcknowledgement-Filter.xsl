<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="http://www.odcgroup.com/Request" 
	xmlns:a="http://www.odcgroup.com/Request" 
	xmlns:b="http://www.temenos.com/T24/OFSML/150" 
	xmlns:infra="http://www.odcgroup.com/InfraPMS" 
	exclude-result-prefixes="b" 
	version="1.0">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="F2B_OrderAcknowledgement-Filter-Core.xsl"/>
    <xsl:import href="F2B_OrderAcknowledgement-Filter-Custo.xsl"/>
    <xsl:strip-space elements="*"/>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>
