<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecuritySellReversal"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecuritySellReversal"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecuritySellReversal"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecuritySellReversal"
    xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="../TransactionSecuritySellReversal-Core.xsl"/>
    <xsl:import href="../TransactionSecuritySellReversal-Custo.xsl"/>
	<xsl:import href="TransactionSecuritySellReversal-Core.xsl"/>
    <xsl:import href="TransactionSecuritySellReversal-Custo.xsl"/>
	<xsl:import href="../TransactionSecuritySellReversal.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="..\..\sell reversal.xml" htmlbaseurl="" outputurl="..\..\sell reversalFIL.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->