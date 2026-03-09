<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DataCaptureTransactionCashDebit"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDataCaptureTransactionCashDebit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDataCaptureTransactionCashDebit" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDataCaptureTransactionCashDebit" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:DataCaptureTransactionCashDebit">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashDebit[not(b:recordStatus) or b:recordStatus != 'REVE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:DataCaptureTransactionCashDebit" mode="filter1">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashDebit[b:categoryAccountJoin &gt;= '1001' and b:categoryAccountJoin &lt;= '1998']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 - Portfolio Filter -->
	<xsl:template match="b:DataCaptureTransactionCashDebit" mode="filter2">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'DataCaptureTransactionCashDebit'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountList/b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:DealerBookList/b:DealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashDebit[$checkPortfolioConditionVar = 'true']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:DataCaptureTransactionCashDebit" mode="filter3">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashDebit[b:sign = 'D']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:DataCaptureTransactionCashDebit" mode="filter-custo">
		<xsl:apply-templates select="self::b:DataCaptureTransactionCashDebit" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:DataCaptureTransactionCashDebit" mode="filter-final">
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