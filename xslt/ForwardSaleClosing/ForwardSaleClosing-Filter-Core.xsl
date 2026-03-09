<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/ForwardSaleClosing" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchForwardSaleClosing"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiForwardSaleClosing" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiForwardSaleClosing"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:ForwardSaleClosing">
		<xsl:apply-templates select="self::b:ForwardSaleClosing[b:eventCommon/ns0:application = 'FX.MATURITY.EXTRACT']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:ForwardSaleClosing" mode="filter1">
		<xsl:apply-templates select="self::b:ForwardSaleClosing[b:dealType = 'FW']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:ForwardSaleClosing" mode="filter2">
		<xsl:apply-templates select="self::b:ForwardSaleClosing[(b:tapOperNature = '1') or ( not(b:tapOperNature) and b:baseCcy = b:currencySold )]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:ForwardSaleClosing" mode="filter3">
		<xsl:apply-templates select="self::b:ForwardSaleClosing[not(b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin) and not(b:dealerBookSecAccMasterHistJoinList/b:dealerBookSecAccMasterHistJoin)]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:ForwardSaleClosing" mode="filter4">
		<xsl:apply-templates select="self::b:ForwardSaleClosing[b:memoAccountSecAccMasterJoinList/b:memoAccountSecAccMasterJoin[@index=1] = 'NO' or b:memoAccountSecAccMasterHistJoinList/b:memoAccountSecAccMasterHistJoin[@index=1] = 'NO']"
		                     mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:ForwardSaleClosing" mode="filter-custo">
		<xsl:apply-templates select="self::b:ForwardSaleClosing" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:ForwardSaleClosing" mode="filter-final">
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