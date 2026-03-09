<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferScSettlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferScSettlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferScSettlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../GlobalLibrary/PositionTransferFeesAndTaxes-Core.xsl"/>
	<xsl:import href="../GlobalLibrary/PositionTransferFeesAndTaxes-Custo.xsl"/>
	<xsl:import href="PTPortfolioTransferActualSettlement-Core.xsl"/>
	<xsl:import href="PTPortfolioTransferActualSettlement-Custo.xsl"/>
	<xsl:import href="PTPortfolioTransferActualSettlement.xsl"/>

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="PTPortfolioTransferActualSettlement" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\PTPortfolioTransferActualSettlement\PTPortfolioTransferActualSettlement.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PTPortfolioTransferActualSettlement\PTPortfolioTransferActualSettlementGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->