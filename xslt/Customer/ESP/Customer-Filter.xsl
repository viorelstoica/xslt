<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 t"
    version="1.0" xmlns="http://www.odcgroup.com/InfraPMS"
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
    xmlns:b="http://www.temenos.com/T24/event/TTI/Customer"
	xmlns:t="http://www.temenos.com/T24/SecuritiesEventsService/NciDetails"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomer"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomer"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../Customer-Filter-Core.xsl"/>
    <xsl:import href="../Customer-Filter-Custo.xsl"/>
	<xsl:import href="Customer-Filter-Core.xsl"/>
    <xsl:import href="Customer-Filter-Custo.xsl"/>
    <xsl:strip-space elements="*"/>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->