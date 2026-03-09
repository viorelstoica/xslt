<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OpenUpfrontPaymentOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOpenUpfrontPaymentOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOpenUpfrontPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOpenUpfrontPaymentOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="UpfrontPaymentCancel-Core.xsl"/>
	<xsl:import href="UpfrontPaymentCancel-Custo.xsl"/>
	<xsl:import href="UpfrontPaymentCancel.xsl"/>

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="MaintainPortfolioValue" userelativepaths="yes" externalpreview="yes" url="..\..\..\..\..\Users\manjusha.rayudu\Downloads\20250630_112316_263_129_msgin_OpenUpfrontPaymentOrder_20ba5e0f-b82d-4cf9-883f-ea0e396d3832.xml"
		          htmlbaseurl="" outputurl="..\..\..\..\..\Users\manjusha.rayudu\Downloads\20250630_112316_263_129_msgin_OpenUpfrontPaymentOrder_MSGOUT.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
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