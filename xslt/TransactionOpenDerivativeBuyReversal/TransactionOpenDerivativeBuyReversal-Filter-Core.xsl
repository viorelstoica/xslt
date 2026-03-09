<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionOpenDerivativeBuyReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionOpenDerivativeBuyReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionOpenDerivativeBuyReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionOpenDerivativeBuyReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionOpenDerivativeBuyReversal">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionOpenDerivativeBuyReversal[$opStatus = 'REVERSE-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionOpenDerivativeBuyReversal" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionOpenDerivativeBuyReversal[b:priBuySell = 'BUY']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 - Portfolio Filter -->
	<xsl:template match="b:TransactionOpenDerivativeBuyReversal" mode="filter2">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionOpenDerivativeBuyReversal'"/>
				<xsl:with-param name="memoAccount" select="b:portfolioMemoJoinList/b:portfolioMemoJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookJoinList/b:dealerBookJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeJoinGroup/b:customerTypeJoinList/b:customerTypeJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionOpenDerivativeBuyReversal[$checkPortfolioConditionVar = 'true']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionOpenDerivativeBuyReversal" mode="filter3">
		<xsl:apply-templates select="self::b:TransactionOpenDerivativeBuyReversal[not(starts-with(b:syDxReference, 'SYACDC')) and not(starts-with(b:syDxReference, 'SYDCI')) and not(starts-with(b:syDxReference, 'SYIMF')) and not(starts-with(b:syDxReference, 'SYFXPT'))]"
		                     mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionOpenDerivativeBuyReversal" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionOpenDerivativeBuyReversal" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionOpenDerivativeBuyReversal" mode="filter-final">
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