<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FundsTransferTransactionCashCreditReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFundsTransferTransactionCashCreditReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFundsTransferTransactionCashCreditReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFundsTransferTransactionCashCreditReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FundsTransferTransactionCashCreditReversal">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="substring(b:status, string-length(b:status) - 2)"/>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FundsTransferTransactionCashCreditReversal[(($opStatus = 'REVERSE-INPUT' or $opStatus = 'REVERSE-AUTHORISE') and (not(b:status) or b:status = ''))or ($opStatus = 'REVERSE-AUTHORISE' and $status='FWD')]"
		                     mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:FundsTransferTransactionCashCreditReversal" mode="filter1">
		<xsl:apply-templates select="self::b:FundsTransferTransactionCashCreditReversal[not(contains($FT_TRANS_TYPES_TO_EXCLUDE, concat(' ',b:transactionType,' ')))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:FundsTransferTransactionCashCreditReversal" mode="filter2">
		<xsl:apply-templates select="self::b:FundsTransferTransactionCashCreditReversal[b:categoryAccountJoin &gt;= '1001' and b:categoryAccountJoin &lt;= '1998']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 5 - Portfolio Filter -->
	<xsl:template match="b:FundsTransferTransactionCashCreditReversal" mode="filter3">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'FundsTransferTransactionCashCreditReversal'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountList/b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:DealerBookList/b:DealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FundsTransferTransactionCashCreditReversal[$checkPortfolioConditionVar = 'true']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FundsTransferTransactionCashCreditReversal" mode="filter-custo">
		<xsl:apply-templates select="self::b:FundsTransferTransactionCashCreditReversal" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:FundsTransferTransactionCashCreditReversal" mode="filter-final">
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