<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DataCaptureTransactionCashCredit"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDataCaptureTransactionCashCredit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDataCaptureTransactionCashCredit" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDataCaptureTransactionCashCredit" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:DataCaptureTransactionCashCredit">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashCredit[not(b:recordStatus) or b:recordStatus != 'REVE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:DataCaptureTransactionCashCredit" mode="filter1">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashCredit[b:categoryAccountJoin &gt;= '1001' and b:categoryAccountJoin &lt;= '1998']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 - Portfolio Filter -->
	<xsl:template match="b:DataCaptureTransactionCashCredit" mode="filter2">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'DataCaptureTransactionCashCredit'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountList/b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookList/b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashCredit[$checkPortfolioConditionVar = 'true']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:DataCaptureTransactionCashCredit" mode="filter3">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashCredit[b:sign = 'C']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:DataCaptureTransactionCashCredit" mode="filter-custo">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashCredit" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:DataCaptureTransactionCashCredit" mode="filter-final">
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