<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PECustomerTxn">
		<xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:tapRefId = '' or not(../../c:CurrentEvent/b:PECustomerTxn/b:tapRefId)]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PECustomerTxn" mode="filter1">
		<xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:commitmentStatus = 'FINAL' and (../../c:PreviousEvent/b:PECustomerTxn/b:commitmentStatus = 'PROVISIONAL' or not (../../c:PreviousEvent/b:PECustomerTxn/b:commitmentStatus))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PECustomerTxn" mode="filter2">
		<xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:memoAccountSecurityMasterJoin = 'NO']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PECustomerTxn" mode="filter3">
		<xsl:apply-templates select="self::b:PECustomerTxn[not(../../c:CurrentEvent/b:PECustomerTxn/b:dealerBookSecurityAccountMasterJoin)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PECustomerTxn" mode="filter-custo">
		<xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PECustomerTxn" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->