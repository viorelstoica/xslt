<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferFromToDeposit"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferFromToDeposit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferFromToDeposit" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferFromToDeposit" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionTransferFromToDeposit">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter1">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[(b:secAcctFrom and b:secAcctFrom != '' and b:secAcctTo and b:secAcctTo != '' and b:secAcctTo = b:secAcctFrom) or ((not(b:secAcctFrom) or b:secAcctFrom = '') or (not(b:secAcctTo) or b:secAcctTo = ''))]"
		                     mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter2">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[b:depositoryFrom and b:depositoryFrom != '']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter3">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[b:depositoryTo and b:depositoryTo != '']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter4">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[not(b:depositoryTo = b:depositoryFrom) or ((b:depositoryTo = b:depositoryFrom) and not(subAcctTo=subAccFrom))]" mode="filter5"/>
	</xsl:template>
    <xsl:template match="b:PositionTransferFromToDeposit" mode="filter5">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[not(contains($sectPendTransNamesInSupportedTypes,b:transTypeCr))]" mode="filter6"/>
	</xsl:template>
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter6">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit[b:secHoldSettle = 'NO' or b:secHoldSettle = '' or not(b:secHoldSettle)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionTransferFromToDeposit" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionTransferFromToDeposit" mode="filter-final">
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