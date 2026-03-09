<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionsForex"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionsForex"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionsForex">
		<xsl:apply-templates select="self::b:TransactionsForex[b:dealType = 'SP']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionsForex" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionsForex[(b:tapOperNature = '2' and b:tapRefId) or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionsForex" mode="filter2">
		<xsl:apply-templates select="self::b:TransactionsForex[not(b:dealerBookSecAccMasterJoin) and not(b:dealerBookSecAccMasterHistJoinList/b:dealerBookSecAccMasterHistJoin) ]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionsForex" mode="filter3">
		<xsl:apply-templates select="self::b:TransactionsForex[b:memoAccountSecAccMasterJoinList/b:memoAccountSecAccMasterJoin[@index=1] = 'NO' or b:memoAccountSecAccMasterHistJoinList/b:memoAccountSecAccMasterHistJoin[@index=1] = 'NO' ]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionsForex" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionsForex" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:TransactionsForex" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="ForexSpotSale" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\ForexSpotSale\ForexSpotSale.xml" htmlbaseurl="" outputurl="..\..\TestFiles\ForexSpotSale\ForexSpotSaleCusto.xml" processortype="saxon8"
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->