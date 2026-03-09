<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="c xsi ns1 ns2 ns0 batch" version="1.0" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTaxLot" xmlns="http://www.odcgroup.com/TransactionPMS"
                xmlns:ns1="http://www.temenos.com/T24/CapitalGainsService/CgTxnBaseDets" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:c="http://www.temenos.com/T24/event/TTI/TaxLot"
                xsi:schemaLocation="http://www.temenos.com/T24/event/TTI/TaxLot TTI-TaxLot.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:ns2="http://www.temenos.com/T24/CapitalGainsService/CgTxnBaseDets"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="c:TaxLot">
		<xsl:apply-templates select="self::c:TaxLot[not(substring-after(substring-after(substring-after(c:newcgtxnbase/ns2:idCgTxnBase,'.'),'.'),'.'))]" mode="filter1"/>
	</xsl:template>
	<xsl:template match="c:TaxLot" mode="filter1">
		<xsl:choose>
			<xsl:when test="c:eventCommon/ns0:application='SECURITY.TRANSFER'">
				<xsl:apply-templates select="self::c:TaxLot[not(($g_filterBySubAssetType='Y' and (contains($list_SubAssetType_TaxLot,c:newcgtxnbase/ns2:SecSubAssetType))) or
							(ns1:SecSubAssetTypeTapInstrType and ns1:SecSubAssetTypeTapInstrType='OTHER'))]" mode="filter-custo"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::c:TaxLot[.]" mode="filter-custo"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="c:TaxLot" mode="filter-custo">
		<xsl:apply-templates select="self::c:TaxLot" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="c:TaxLot" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns2:TaxLotList">
		<xsl:choose>
			<xsl:when test="c:eventCommon/ns0:application='SECURITY.TRANSFER'">
				<xsl:apply-templates select="self::ns2:TaxLotList[not(contains($list_TxnType_TaxLot,ns2:TxnType))]" mode="filter-custo1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::ns2:TaxLotList[.]" mode="filter-custo1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="ns2:TaxLotList" mode="filter-custo1">
		<xsl:apply-templates select="self::ns2:TaxLotList" mode="filter-final1"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="ns2:TaxLotList" mode="filter-final1">
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