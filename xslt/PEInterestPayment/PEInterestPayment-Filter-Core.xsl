<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
    <!-- Condition 1 -->
	<xsl:template match="b:PECustomerTxn">
		<xsl:variable name="isSaveEG">
		<xsl:choose>
			<xsl:when test="../../c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup">
			<xsl:for-each select="../../c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup">
				<xsl:variable name="Index" select="./@index"/>
				<xsl:if test="../../../c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup[@index = $Index][b:saveEvent = 'RETURN OF CAPITAL' and b:saveEventStatus = 'COMPLETE'] and not(../../../c:PreviousEvent/b:PECustomerTxn/b:saveEventGroup[@index = $Index][b:saveEvent = 'RETURN OF CAPITAL' and b:saveEventStatus = 'COMPLETE'])">
					<xsl:value-of select="'1'"/>
				</xsl:if>
			</xsl:for-each>
			</xsl:when>
			<xsl:when test="../../c:CurrentEvent/b:PECustomerTxn/b:eventGroup">
				<xsl:for-each select="../../c:CurrentEvent/b:PECustomerTxn/b:eventGroup">
				<xsl:variable name="Index" select="./@index"/>
				<xsl:if test="../../../c:CurrentEvent/b:PECustomerTxn/b:eventGroup[@index = $Index][b:event = 'RETURN OF CAPITAL' and b:eventStatus = 'COMPLETE'] and not(../../../c:PreviousEvent/b:PECustomerTxn/b:eventGroup[@index = $Index][b:event = 'RETURN OF CAPITAL' and b:eventStatus = 'COMPLETE'])">
					<xsl:value-of select="'1'"/>
				</xsl:if>
			</xsl:for-each>
			</xsl:when>
			</xsl:choose>

		</xsl:variable>
		<xsl:apply-templates select="self::node()[$isSaveEG != '']" mode="filter1"/>
	</xsl:template>

	<xsl:template match="b:PECustomerTxn" mode="filter1">
		<xsl:apply-templates select="self::node()[../../c:CurrentEvent/b:PECustomerTxn/b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PECustomerTxn" mode="filter-custo">
		<xsl:apply-templates select="self::node()" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PECustomerTxn" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>


	<!-- Condition 1 -->
	<xsl:template match="c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup">
		<xsl:variable name="Index" select="./@index"/>
		<xsl:apply-templates select="self::node()[../../../c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup[@index = $Index][b:saveEvent = 'RETURN OF CAPITAL' and b:saveEventStatus = 'COMPLETE'] and not(../../../c:PreviousEvent/b:PECustomerTxn/b:saveEventGroup[@index = $Index][b:saveEvent = 'RETURN OF CAPITAL' and b:saveEventStatus = 'COMPLETE'])]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup" mode="filter-custo">
		<xsl:apply-templates select="self::node()" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
    <xsl:template match="c:CurrentEvent/b:PECustomerTxn/b:saveCapCallRefPeProductJoinGroup">
	<xsl:variable name="Index" select="./@index"/>
		<xsl:apply-templates select="self::node()[../../../c:CurrentEvent/b:PECustomerTxn/b:saveCapCallRefPeProductJoinGroup[@index = $Index]/b:saveCapCallRefPeProductJoin = ../../../c:CurrentEvent/b:PECustomerTxn/b:saveEventGroup[b:saveEvent = 'CAPITAL CALL'][last()]/b:saveReference]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="c:CurrentEvent/b:PECustomerTxn/b:saveCapCallRefPeProductJoinGroup" mode="filter-custo">
		<xsl:apply-templates select="self::node()" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="c:CurrentEvent/b:PECustomerTxn/b:saveCapCallRefPeProductJoinGroup" mode="filter-final">
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