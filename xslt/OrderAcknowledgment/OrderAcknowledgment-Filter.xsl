<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OrderAcknowledgment"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOrderAcknowledgment" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderAcknowledgment" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOrderAcknowledgment" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="OrderAcknowledgment-Filter-Core.xsl"/>
	<xsl:import href="OrderAcknowledgment-Filter-Custo.xsl"/>
	<xsl:strip-space elements="*"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="OrderAcknowledgment" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\OrderAcknowledgment\OrderAcknowledgmentT24.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\OrderAcknowledgment\OrderAcknowledgment.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->