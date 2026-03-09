<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0"
    version="1.0" xmlns="http://www.odcgroup.com/Request"
    xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransferUpdate"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransferUpdate"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransferUpdate"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransferUpdate" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../SecurityTransferCancelRejected-Core.xsl"/>
    <xsl:import href="../SecurityTransferCancelRejected-Custo.xsl"/>
    <xsl:import href="SecurityTransferCancelRejected-Core.xsl"/>
    <xsl:import href="SecurityTransferCancelRejected-Custo.xsl"/>
	<xsl:import href="SecurityTransferCancelRejected.xsl"/>
    
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\supdate.xml" htmlbaseurl="" outputurl="..\..\supdate1.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->