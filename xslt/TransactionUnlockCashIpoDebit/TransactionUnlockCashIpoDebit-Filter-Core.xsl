<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecOpenOrder"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SecOpenOrder">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecOpenOrder[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SecOpenOrder" mode="filter1">
		<xsl:apply-templates select="self::b:SecOpenOrder[b:securityMasterBlockType = 'DEBIT' and b:securityMasterDebitTime = 'BOOKCLOSURE']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SecOpenOrder" mode="filter2">
		<xsl:apply-templates select="self::b:SecOpenOrder[b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin = '' or not(b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:SecOpenOrder" mode="filter3">
		<xsl:apply-templates select="self::b:SecOpenOrder[b:memoAccountSecAccMasterJoinList/b:memoAccountSecAccMasterJoin = 'NO']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:SecOpenOrder" mode="filter4">
		<xsl:apply-templates select="self::b:SecOpenOrder[b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:SecOpenOrder" mode="filter5">
		<xsl:apply-templates select="self::b:SecOpenOrder[b:eventCommon/ns0:application = 'SC.IPO.ORDER.ACCTG']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SecOpenOrder" mode="filter-custo">
		<xsl:apply-templates select="self::b:SecOpenOrder" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SecOpenOrder" mode="filter-final">
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