<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ex" version="1.0" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionContractMaster"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentExoticOptionContractMaster" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOptionContractMaster" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentExoticOptionContractMaster" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ex="http://exslt.org/dates-and-times">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/> 
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FinancialInstrumentExoticOptionContractMaster">
		<xsl:apply-templates select="self::b:FinancialInstrumentExoticOptionContractMaster[($g_filterBySubAssetType = 'Y' and b:subAssetType and contains($list_SubAssetType_FinancialInstrumentExoticOptionContractMaster,b:subAssetType)) or ($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType ='OPTION')]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:FinancialInstrumentExoticOptionContractMaster" mode="filter1">
		<xsl:apply-templates select="self::b:FinancialInstrumentExoticOptionContractMaster[contains($list_DXExoticOptionsOptionType,concat(' ',b:optionTypeList/b:optionType,' '))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FinancialInstrumentExoticOptionContractMaster" mode="filter-custo">
		<xsl:apply-templates select="self::b:FinancialInstrumentExoticOptionContractMaster" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:FinancialInstrumentExoticOptionContractMaster" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="s" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentMiniFutureTurbo\FinancialInstrumentMiniFutureTurbo.xml" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no"
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
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\FinancialInstrumentMiniFutureTurbo\FinancialInstrumentMiniFutureTurbo.xml" srcSchemaRoot="tns1:MultiFinancialInstrumentMiniFutureTurbo" AssociatedInstance="" loaderFunction="document"
			              loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="@* | node()"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->