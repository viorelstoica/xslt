<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/ForwardPurchaseClosing"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchForwardPurchaseClosing" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiForwardPurchaseClosing" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiForwardPurchaseClosing" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:ForwardPurchaseClosing">
		<xsl:apply-templates select="self::b:ForwardPurchaseClosing[b:eventCommon/ns0:application = 'FX.MATURITY.EXTRACT']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:ForwardPurchaseClosing" mode="filter1">
		<xsl:apply-templates select="self::b:ForwardPurchaseClosing[b:dealType = 'FW']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:ForwardPurchaseClosing" mode="filter2">
		<xsl:apply-templates select="self::b:ForwardPurchaseClosing[(b:tapOperNature = '2') or ( not(b:tapOperNature) and b:baseCcy = b:currencyBought)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:ForwardPurchaseClosing" mode="filter3">
		<xsl:apply-templates select="self::b:ForwardPurchaseClosing[not(b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin) and not(b:dealerBookSecAccMasterHistJoinList/b:dealerBookSecAccMasterHistJoin)]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:ForwardPurchaseClosing" mode="filter4">
		<xsl:apply-templates select="self::b:ForwardPurchaseClosing[b:memoAccountSecAccMasterJoinList/b:memoAccountSecAccMasterJoin[@index=1] = 'NO' or b:memoAccountSecAccMasterHistJoinList/b:memoAccountSecAccMasterHistJoin[@index=1] = 'NO']"
		                     mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:ForwardPurchaseClosing" mode="filter-custo">
		<xsl:apply-templates select="self::b:ForwardPurchaseClosing" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:ForwardPurchaseClosing" mode="filter-final">
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