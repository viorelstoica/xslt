<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchIRSNotionalPrinChange"
                xmlns:ns1="http://www.temenos.com/T24/SwapDetailsService/SwBalancesDetails" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSNotionalPrinChange" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b batch ns0 ns1" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:IRSNotionalPrinChange">
		<xsl:apply-templates select="self::b:IRSNotionalPrinChange[b:swapbalancesrecord/ns1:SwapBalancesList/ns1:scheduleType = 'PIN']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:IRSNotionalPrinChange" mode="filter1">
		<xsl:apply-templates select="self::b:IRSNotionalPrinChange[b:swapbalancesrecord/ns1:swapType = 'IRS']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:IRSNotionalPrinChange" mode="filter2">
		<xsl:apply-templates select="self::b:IRSNotionalPrinChange[b:swapbalancesrecord/ns1:portfolioNumber and not(b:swapbalancesrecord/ns1:dealerBook) and b:swapbalancesrecord/ns1:memoAccount = 'NO']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:IRSNotionalPrinChange" mode="filter-custo">
		<xsl:apply-templates select="self::b:IRSNotionalPrinChange" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:IRSNotionalPrinChange" mode="filter-final">
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