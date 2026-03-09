<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchIRSNotionalPrinChange"
                xmlns:ns1="http://www.temenos.com/T24/SwapDetailsService/SwBalancesDetails" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSNotionalPrinChange" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b batch ns0 ns1" version="1.0">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="IRSPIN-Core.xsl"/>
	<xsl:import href="IRSPIN-Custo.xsl"/>
	<xsl:import href="IRSPIN.xsl"/>

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="IRSPIN" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\IRSPIN\IRSPIN.xml" htmlbaseurl="" outputurl="..\..\TestFiles\IRSPIN\IRSPINGWP.xml" processortype="jaxp" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
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