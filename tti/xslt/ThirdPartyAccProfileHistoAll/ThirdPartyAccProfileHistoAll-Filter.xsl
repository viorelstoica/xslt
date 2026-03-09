<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/ClientPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/CginventoryAll"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCginventoryAll"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCginventoryAll"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCginventoryAll" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="ThirdPartyAccProfileHistoAll-Filter-Core.xsl"/>
	<xsl:import href="ThirdPartyAccProfileHistoAll-Filter-Custo.xsl"/>
	<xsl:strip-space elements="*"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>
