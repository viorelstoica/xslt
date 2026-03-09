<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferFromToDepositReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferFromToDepositReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferFromToDepositReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferFromToDepositReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionTransferFromToDepositReversal">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferFromToDepositReversal[$opStatus = 'REVERSE-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionTransferFromToDepositReversal" mode="filter1">
		<xsl:apply-templates select="self::b:PositionTransferFromToDepositReversal[(b:secAcctFrom and b:secAcctFrom != '' and b:secAcctTo and b:secAcctTo != '' and b:secAcctTo = b:secAcctFrom) or ((not(b:secAcctFrom) or b:secAcctFrom = '') or (not(b:secAcctTo) or b:secAcctTo = ''))]"
		                     mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionTransferFromToDepositReversal" mode="filter2">
		<xsl:apply-templates select="self::b:PositionTransferFromToDepositReversal[b:depositoryTo and b:depositoryTo != '']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionTransferFromToDepositReversal" mode="filter3">
		<xsl:apply-templates select="self::b:PositionTransferFromToDepositReversal[b:depositoryFrom and b:depositoryFrom != '']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionTransferFromToDepositReversal" mode="filter4">
		<xsl:apply-templates select="self::b:PositionTransferFromToDepositReversal[not(b:depositoryFrom = b:depositoryTo)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionTransferFromToDepositReversal" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionTransferFromToDepositReversal" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionTransferFromToDepositReversal" mode="filter-final">
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