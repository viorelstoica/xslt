<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
  <xsl:template match="/">
    <xsl:apply-templates select="/*[contains(local-name(),'Batch')]"/>
  </xsl:template>
  <xsl:template match="/*[contains(local-name(),'Batch')]">
    <xsl:variable name="FirstNodeName" select="name(*[1])"/>
    <xsl:element name="{$FirstNodeName}">
      <xsl:apply-templates select="./*[1]/@*"/>
      <xsl:copy-of select="./*[1]/namespace::*"/>
       <xsl:choose>
	   			<xsl:when test="./*[local-name()='MBE']">
					<xsl:apply-templates select="./*[local-name()='MBE']"/>
				</xsl:when>
				<xsl:when test="./*[local-name()='generic']">
					<xsl:apply-templates select="./*[local-name()='generic']"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="child::node()/*[local-name()='DataGroup']"/>
				</xsl:otherwise>
			</xsl:choose>
    </xsl:element>
  </xsl:template>
  <xsl:template match="//*[local-name()='DataGroup']">
    <xsl:element name="DataGroup" namespace="{namespace-uri()}">
      <xsl:copy-of select="*"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="//*[local-name()='MBE']">
			<xsl:copy-of select="*"/>
	</xsl:template>
	<xsl:template match="//*[local-name()='generic']">
			<xsl:copy-of select="*"/>
	</xsl:template>
  <xsl:template match="@*">
    <xsl:attribute name="{name(.)}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="PostBatchProcess" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PostBatchProcess\TransactionConversionGWP.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PostBatchProcess\TransactionConversionGWPRearranged.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="PostBatchProcess2" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PostBatchProcess\TransactionWarrantExercise.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PostBatchProcess\TransactionWarrantExerciseGWPRearranged.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="PostBatchProcess3" userelativepaths="yes" externalpreview="no" url="..\DMSI-8053\T24_CustomisedDataGWP.xml" htmlbaseurl="" outputurl="..\DMSI-8053\T24_CustomisedDataGWPPOST.xml" processortype="jaxp" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="PostProcess4" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PostBatchProcess\FinancialInstrumentStock.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PostBatchProcess\FinancialInstrumentStockGWPRearranged.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="postBatchProcess5" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\TaxLotIL\TaxLotILOut.xml" htmlbaseurl="" outputurl="..\..\TestFiles\TaxLotIL\TaxLotILGWP.xml" processortype="jaxp" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="yes" name="PostBatchProcessScPosAsset" userelativepaths="yes" externalpreview="yes" url="..\..\TestFiles\ScPosAssetIL\ScPosAssetILPostProcess.xml" htmlbaseurl="" outputurl="..\..\TestFiles\ScPosAssetIL\ScPosAssetILmsgout.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\gwpackSchemas\GenericCOA.xsd" destSchemaRoot="GenericCOA" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\PostBatchProcess\TransactionConversionGWP.xml" srcSchemaRoot="BatchTransactionConversion" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/"></template>
			<template match="a:GenericCOA/a:DataGroup/a:Locking"></template>
			<template match="/*[contains(local-name(),'Batch')]">
				<block path="xsl:element/xsl:apply-templates" x="218" y="0"/>
				<block path="xsl:element/xsl:apply-templates[1]" x="218" y="0"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext>
			<template match="/*[contains(local-name(),'Batch')]" mode="" srcContextPath="/BatchTransactionConversion/GenericCOA/@xmlns:infra" srcContextFile="file:///x:/TTI/TestFiles/PostBatchProcess/TransactionConversionGWP.xml" targetContextPath=""
			          targetContextFile=""/>
		</TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->