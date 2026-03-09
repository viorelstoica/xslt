<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentFutureSYDX" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentFutureSYDX"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentFutureSYDX" xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentFutureSYDX" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch d" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FinancialInstrumentFutureSYDX">
		<xsl:apply-templates select="self::b:FinancialInstrumentFutureSYDX[($g_filterBySubAssetType='Y' and b:subAssetType and contains($list_SubAssetType_FinancialInstrumentFutureSYDX,b:subAssetType)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='FUTURE')]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:FinancialInstrumentFutureSYDX" mode="filter1">
		<xsl:apply-templates select="self::b:FinancialInstrumentFutureSYDX[b:dxContractMasterJoinPriceSetGroup/b:dxContractMasterJoinPriceSet = 'INTERFACE']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:FinancialInstrumentFutureSYDX" mode="filter2">
		<xsl:apply-templates select="self::b:FinancialInstrumentFutureSYDX[not(b:optionType)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:FinancialInstrumentFutureSYDX" mode="filter3">
		<xsl:variable name="check_MaturityDate">
			<xsl:call-template name="formatDateForMaturityComparison">
				<xsl:with-param name="dateToFormat" select="b:maturityDate"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="check_toDay">
			<xsl:call-template name="formatDateForMaturityComparison">
				<xsl:with-param name="dateToFormat" select="b:eventCommon/d:today"/>
			</xsl:call-template>
		</xsl:variable>
	<xsl:apply-templates select="self::b:FinancialInstrumentFutureSYDX[number($check_MaturityDate) &gt;= number($check_toDay)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FinancialInstrumentFutureSYDX" mode="filter-custo">
		<xsl:apply-templates select="self::b:FinancialInstrumentFutureSYDX" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:FinancialInstrumentFutureSYDX" mode="filter-final">
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