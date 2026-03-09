<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0"
    xmlns="http://www.temenos.com/T24/OFSML/150"
    xmlns:b="http://www.odcgroup.com/F2B_MM_FX"
    xmlns:infra="http://www.odcgroup.com/InfraPMS" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="F2B_FXSwapPurchase-Filter-Core.xsl"/>
    <xsl:import href="F2B_FXSwapPurchase-Filter-Custo.xsl"/>
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