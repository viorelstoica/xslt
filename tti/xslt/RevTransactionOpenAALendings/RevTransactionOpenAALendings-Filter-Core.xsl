<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec"
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="c:aaarecord">
        <xsl:apply-templates select="self::c:aaarecord[d:activity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL' or 
                          d:activity = 'LENDING-CAPITALISE-SCHEDULE' or 
                          (d:activity = 'LENDING-AUTO.DISBURSE-COMMITMENT' and ../c:aatxncontext/b:aaArrStatus = 'AUTH') or
                          (d:activity = 'LENDING-NEW-ARRANGEMENT' and (../c:aatxncontext/b:aaArrStatus = 'AUTH-FWD' or ../c:aatxncontext/b:aaArrStatus = 'AUTH') and  $AA_INTERFACE_INPUT_DEALS = 'Y' )
                          
                          ]" mode="filter1"/>
    </xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="c:aaarecord" mode="filter1">
		<xsl:apply-templates select="self::c:aaarecord[../c:aatxncontext/b:aaActivityStatus = 'REV']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="c:aaarecord" mode="filter2">
		<xsl:apply-templates select="self::c:aaarecord[../c:accountrecord/g:portfolioId != '']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="c:aaarecord" mode="filter-custo">
		<xsl:apply-templates select="self::c:aaarecord" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="c:aaarecord" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter.xml" htmlbaseurl="" outputurl="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter_Pavan.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
			<SourceSchema srcSchemaPath="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter.xml" srcSchemaRoot="AAAFlow" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/"></template>
			<template name="mappingFinancialInstrumentAADepositAndLoan"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->