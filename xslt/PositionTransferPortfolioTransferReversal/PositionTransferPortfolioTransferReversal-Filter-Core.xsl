<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferPortfolioTransferReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferPortfolioTransferReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferPortfolioTransferReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferPortfolioTransferReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<!-- Condition 2 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[$opStatus = 'REVERSE-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter1">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctFrom and b:secAcctFrom != '']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter2">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctTo and b:secAcctTo != '']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter3">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctTo != b:secAcctFrom]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter4">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctFromMemoAccount = 'NO']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 7 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter5">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[not(b:secAcctFromDealerBook)]" mode="filter6"/>
	</xsl:template>
	<!-- Condition 8 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter6">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctFromCustomerTypeJoinList/b:secAcctFromCustomerTypeJoin = 'CUSTOMER']" mode="filter7"/>
	</xsl:template>
	<!-- Condition 9 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter7">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctToMemoAccount = 'NO']" mode="filter8"/>
	</xsl:template>
	<!-- Condition 10 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter8">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[not(b:secAcctToDealerBook)]" mode="filter9"/>
	</xsl:template>
	<!-- Condition 11 -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter9">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal[b:secAcctToCustomerTypeJoinList/b:secAcctToCustomerTypeJoin = 'CUSTOMER']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionTransferPortfolioTransferReversal" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionTransferPortfolioTransferReversal" mode="filter-final">
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