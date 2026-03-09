<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/NdDeal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchNdDeal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiNdDeal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiNdDeal" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="NdForwardSaleOpening-Core.xsl"/>
	<xsl:import href="NdForwardSaleOpening-Custo.xsl"/>
	<xsl:import href="NdForwardSaleOpening.xsl"/>

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="NdForwardSaleOpening" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\NdForwardSaleOpening\NdForwardSaleOpeningPostFilter.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\NdForwardSaleOpening\NdForwardSaleOpening_gwp.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
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