<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FundsTransferTransactionCashCredit" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFundsTransferTransactionCashCredit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiBatchFundsTransferTransactionCashCredit" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFundsTransferTransactionCashCredit" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:FundsTransferTransactionCashCredit">
    <xsl:variable name="opStatus">
      <xsl:call-template name="operationStatus">
        <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
        <xsl:with-param name="recordStatus" select="b:recordStatus"/>
      </xsl:call-template>
    </xsl:variable>
	<xsl:variable name="status">
		<xsl:value-of select="substring(b:status, string-length(b:status) - 2)" />
	</xsl:variable>
    <xsl:apply-templates select="self::b:FundsTransferTransactionCashCredit[(($opStatus = 'INPUT-INPUT' or $opStatus = 'INPUT-DELETE' or $opStatus = 'INPUT-AUTHORISE' or b:eventCommon/ns0:transactionStage = 'JOB-PROCESS') and (not(b:status) or b:status = ''))or (b:eventCommon/ns0:transactionStage = 'AUTHORISE' and b:status='ANORATE') or ($opStatus = 'INPUT-AUTHORISE' and $status='FWD')]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FundsTransferTransactionCashCredit" mode="filter1">
    <xsl:apply-templates select="self::b:FundsTransferTransactionCashCredit[not(contains($FT_TRANS_TYPES_TO_EXCLUDE, concat(' ',b:transactionType,' ')))]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:FundsTransferTransactionCashCredit" mode="filter2">
    <xsl:apply-templates select="self::b:FundsTransferTransactionCashCredit[b:categoryAccountJoin &gt;= '1001' and b:categoryAccountJoin &lt;= '1998']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 5 - Portfolio Filter -->
	<xsl:template match="b:FundsTransferTransactionCashCredit" mode="filter3">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'FundsTransferTransactionCashCredit'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountList/b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:DealerBookList/b:DealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FundsTransferTransactionCashCredit[$checkPortfolioConditionVar = 'true']" mode="filter-custo"/>
	</xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FundsTransferTransactionCashCredit" mode="filter-custo">
    <xsl:apply-templates select="self::b:FundsTransferTransactionCashCredit" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FundsTransferTransactionCashCredit" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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