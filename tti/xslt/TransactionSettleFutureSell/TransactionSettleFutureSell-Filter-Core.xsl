<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSettleFutureSell"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSettleFutureSell" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSettleFutureSell" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSettleFutureSell" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionSettleFutureSell">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell[$opStatus != 'REVERSE-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell[b:tradeType = 'FUTURE']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter2">
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell[b:priBuySell = 'SELL']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter3">
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell[b:priSecAccGroup/b:priOpenClose = 'CLOSE']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter4">
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell[b:closeoutTradeGroup/b:closeoutTrade != '']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 - Portfolio Filter -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter5">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionSettleFutureSell'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountList/b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookList/b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeGroup/b:customerTypeList/b:customerType"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell[$checkPortfolioConditionVar = 'true']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionSettleFutureSell" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionSettleFutureSell" mode="filter-final">
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