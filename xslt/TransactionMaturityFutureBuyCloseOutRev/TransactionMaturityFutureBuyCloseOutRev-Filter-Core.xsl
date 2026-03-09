<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionMaturityFutureBuyCloseOutRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionMaturityFutureBuyCloseOutRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionMaturityFutureBuyCloseOutRev" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionMaturityFutureBuyCloseOutRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[b:memoAccountList/b:memoAccount = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[not(b:dealerBookList/b:dealerBook)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter2">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[b:customerTypeGroup/b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter3">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[$opStatus = 'REVERSE-AUTHORISE']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter4">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[b:tradeType = 'FUTURE']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter5">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[b:priBuySellJoinList/b:priBuySellJoin = 'BUY']" mode="filter6"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter6">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[b:type = 'MATURITY']" mode="filter7"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter7">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev[b:creation = 'MANUAL']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureBuyCloseOutRev" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionMaturityFutureBuyCloseOutRev" mode="filter-final">
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