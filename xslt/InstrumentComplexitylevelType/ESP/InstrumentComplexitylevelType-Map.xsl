<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookup"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEBLookup" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookup" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookup"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="InstrumentComplexitylevelType-Core.xsl"/>
	<xsl:import href="InstrumentComplexitylevelType-Custo.xsl"/>
	<xsl:import href="InstrumentComplexitylevelType.xsl"/>

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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