<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FuturePosition" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFuturePosition"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFuturePosition" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFuturePosition"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FuturePosition">
		<xsl:apply-templates select="self::b:FuturePosition[b:portfolio and b:portfolio != '']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:FuturePosition" mode="filter1">
		<xsl:apply-templates select="self::b:FuturePosition[not(b:optionTypeGroup/b:optionType)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:FuturePosition" mode="filter2">
		<xsl:variable name="check_MaturityDate">
			<xsl:call-template name="formatDateForMaturityComparison">
				<xsl:with-param name="dateToFormat" select="b:maturityDate"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="check_toDay">
			<xsl:call-template name="formatDateForMaturityComparison">
				<xsl:with-param name="dateToFormat" select="b:eventCommon/ns0:today"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FuturePosition[number($check_MaturityDate) &gt;= number($check_toDay)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:FuturePosition" mode="filter3">
		<xsl:apply-templates select="self::b:FuturePosition[($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FuturePosition,b:subAssetTypeJoin)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='FUTURE')]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:FuturePosition" mode="filter4">
		<xsl:apply-templates select="self::b:FuturePosition[b:memoSecAccMasterJoin = 'NO']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:FuturePosition" mode="filter5">
		<xsl:apply-templates select="self::b:FuturePosition[not(b:dealerBookSecAccMasterJoin)]" mode="filter6"/>
	</xsl:template>
	<!-- Condition 7 -->
	<xsl:template match="b:FuturePosition" mode="filter6">
		<xsl:apply-templates select="self::b:FuturePosition[b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FuturePosition" mode="filter-custo">
		<xsl:apply-templates select="self::b:FuturePosition" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:FuturePosition" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- Condition 1 -->
	<xsl:template match="b:transactionIdsGroup">
		<xsl:apply-templates select="self::b:transactionIdsGroup[b:txLots != '0']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:transactionIdsGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:transactionIdsGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:transactionIdsGroup" mode="filter-final">
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