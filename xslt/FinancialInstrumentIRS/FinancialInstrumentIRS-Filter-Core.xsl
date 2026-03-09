<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSswap"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchIRSswap" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiIRSswap" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiIRSswap" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:IRSswap">
		<xsl:apply-templates select="self::b:IRSswap[b:swapType = 'IRS' or b:swapType = 'CIRS']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
		<xsl:template match="b:IRSswap">
		<xsl:apply-templates select="self::b:IRSswap[b:contractStatus = 'CUR']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:IRSswap" mode="filter2">
		<xsl:apply-templates select="self::b:IRSswap[b:portfolioNumber and not(b:cusPortIdDealerBook) and b:cusPortIdMemoAccount = 'NO']" mode="filter-custo"/>
	</xsl:template>		
	<!-- Custo placeholder -->
	<xsl:template match="b:IRSswap" mode="filter-custo">
		<xsl:apply-templates select="self::b:IRSswap" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:IRSswap" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionIRSPurchaseOpen\TransactionIRSPurchasOpenCIRS.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentFXSwapGeneric\FinancialInstrumentFXSwapGenericCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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