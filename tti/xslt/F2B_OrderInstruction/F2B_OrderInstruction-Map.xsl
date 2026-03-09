<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:t="http://www.odcgroup.com/F2B_FORMAT" xmlns:dxorder="http://www.temenos.com/T24/dxorder"
                xmlns:dxtrade="http://www.temenos.com/T24/dxtrade" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:adjustmentorder="http://www.temenos.com/T24/adjustmentorder" xmlns:secopenorder1="http://www.temenos.com/T24/secopenorder1"
                xmlns:secopenorder2="http://www.temenos.com/T24/secopenorder2" xmlns:secopenorder3="http://www.temenos.com/T24/secopenorder3" xmlns:secopenorder4="http://www.temenos.com/T24/secopenorder4" xmlns:sectrade="http://www.temenos.com/T24/sectrade"
                xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer"
                xmlns:securitytransfer2="http://www.temenos.com/T24/securitytransfer2" exclude-result-prefixes="b t" version="1.0">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../GlobalLibrary/OrderFeesAndTaxes-Core.xsl"/>
	<xsl:import href="../GlobalLibrary/OrderFeesAndTaxes-Custo.xsl"/>
	<xsl:import href="../GlobalLibrary/DxOrderFeesAndTaxes-Core.xsl"/>
	<xsl:import href="../GlobalLibrary/DxOrderFeesAndTaxes-Custo.xsl"/>
	<xsl:import href="F2B_OrderInstruction-Core.xsl"/>
	<xsl:import href="F2B_OrderInstruction-Custo.xsl"/>
	<xsl:import href="F2B_OrderInstruction.xsl"/>

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="F2B_OrderInstruction" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\F2B_OrderInstruction\F2B_OrderInstruction.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\F2B_OrderInstruction\F2B_OrderInstructionT24.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="F2B_TaxLots" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\F2B_OrderInstruction\F2B_TaxLots.xml" htmlbaseurl="" outputurl="..\..\TestFiles\F2B_OrderInstruction\F2B_TaxLotsT24.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
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
		<scenario default="yes" name="4562_msgin" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\F2B_OrderInstruction\4562_msginFilter.xml" htmlbaseurl="" outputurl="..\..\TestFiles\F2B_OrderInstruction\4562_adapterIn.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
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