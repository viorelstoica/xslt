<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/NdDeal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchNdDeal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiNdDeal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiNdDeal" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:NdDeal">
		<xsl:apply-templates select="self::b:NdDeal[contains($list_Status_NdForwardPurchaseOpening,concat(' ',b:status,' '))]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:NdDeal" mode="filter1">
		<xsl:variable name="portfolio" select="concat(b:counterparty,'-',b:portfolioNumber)"/>
		<xsl:variable name="portfolio1" select="b:counterparty"/>
		<xsl:variable name="portfolio2" select="b:portfolioNumber"/>
		<xsl:apply-templates select="self::b:NdDeal[$portfolio and $portfolio1 and $portfolio2]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:NdDeal" mode="filter2">
		<xsl:apply-templates select="self::b:NdDeal[b:memoAccount = 'NO']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:NdDeal" mode="filter3">
		<xsl:apply-templates select="self::b:NdDeal[not(b:dealerBook)]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:NdDeal" mode="filter4">
		<xsl:apply-templates select="self::b:NdDeal[b:buySellInd = 'SELL' ]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:NdDeal" mode="filter-custo">
		<xsl:apply-templates select="self::b:NdDeal" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:NdDeal" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->