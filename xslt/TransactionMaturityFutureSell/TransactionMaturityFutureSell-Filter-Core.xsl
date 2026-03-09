<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionMaturityFutureSell"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionMaturityFutureSell" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionMaturityFutureSell" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionMaturityFutureSell" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionMaturityFutureSell">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionMaturityFutureSell[$opStatus != 'REVERSE-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionMaturityFutureSell" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureSell[b:unauthAuth = 'AUTHORISED']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionMaturityFutureSell" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionMaturityFutureSell" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionMaturityFutureSell" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- Condition 1 -->
	<xsl:template match="b:closeoutIdList/b:closeoutId">
		<xsl:apply-templates select="self::node()[./@index = ../../b:portfolioList/b:portfolio/@index]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter1">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::node()[../../b:buySellList/b:buySell[@index=$index] = 'SELL']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter2">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::node()[../../b:memoAccountList/b:memoAccount[@index=$index] = 'NO']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter3">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::node()[not(../../b:dealerBookList/b:dealerBook[@index=$index])]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter4">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::node()[../../b:customerTypeGroup[@index=$index]/b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter5">
		<xsl:apply-templates select="self::node()[not(../../@ownCompId) or ../../@ownCompId = '' or ../../b:ownCompIdList/b:ownCompId[@index=current()/@index] = ../../@ownCompId]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter-custo">
		<xsl:apply-templates select="self::node()" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:closeoutIdList/b:closeoutId" mode="filter-final">
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