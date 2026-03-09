<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSettleOptionSell"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSettleOptionSell" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSettleOptionSell" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSettleOptionSell" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionSettleOptionSell">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[$opStatus != 'REVERSE-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[b:tradeType = 'OPTION']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter2">
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[b:priBuySell = 'SELL']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter3">
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[b:priSecAccGroup/b:priOpenClose='CLOSE']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter4">
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[not(starts-with(b:syDxReference, 'SYACDC')) and not(starts-with(b:syDxReference, 'SYDCI')) and not(starts-with(b:syDxReference, 'SYIMF')) and not(starts-with(b:syDxReference, 'SYFXPT'))]"
		                     mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter5">
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[b:closeoutTradeGroup/b:closeoutTrade != '' or not (b:closeoutTradeGroup/b:closeoutTrade)]" mode="filter6"/>
	</xsl:template>
	<!-- Condition 7 - Portfolio Filter -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter6">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionSettleOptionSell'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountList/b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookList/b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeGroup/b:customerTypeList/b:customerType"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell[$checkPortfolioConditionVar = 'true']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionSettleOptionSell" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionSettleOptionSell" mode="filter-final">
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