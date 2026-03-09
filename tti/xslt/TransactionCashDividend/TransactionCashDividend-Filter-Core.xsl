<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionEntitlement">
        <xsl:variable name="coaToProcess">CASH.DIVIDENDS</xsl:variable>
		<xsl:choose>
			<xsl:when test="$g_filterCOAUsingGlobalTemplateFunction = 'Y'">
				<xsl:variable name="list_EventType">
					<xsl:call-template name="diaryTypeTranslation">
						<xsl:with-param name="diaryType" select="$coaToProcess"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:apply-templates select="self::b:TransactionEntitlement[contains(concat(' ',$list_EventType,' '),concat(' ',b:eventType,' '))]" mode="filter1"/>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::b:TransactionEntitlement[b:eventTypeTapCoaType and b:eventTypeTapCoaType = $coaToProcess]" mode="filter1"/>	
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Condition 2 - Portfolio Filter -->
	<xsl:template match="b:TransactionEntitlement" mode="filter1">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionCashDividend'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountSecAccMasterJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookSecAccMasterJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeList/b:customerType"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionEntitlement[$checkPortfolioConditionVar = 'true']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionEntitlement" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionEntitlement" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionEntitlement" mode="filter-final">
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