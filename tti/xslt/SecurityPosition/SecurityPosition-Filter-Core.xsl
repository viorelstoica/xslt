<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityPosition"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityPosition" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityPosition" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SecurityPosition">
		<xsl:apply-templates select="self::b:SecurityPosition[b:customerTypeJoinList/b:customerTypeJoin = 'CUSTOMER']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SecurityPosition" mode="filter1">
		<xsl:apply-templates select="self::b:SecurityPosition[b:portfolioMemoJoin = 'NO']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SecurityPosition" mode="filter2">
		<xsl:apply-templates select="self::b:SecurityPosition[not(b:dealerBookJoin)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:SecurityPosition" mode="filter3">
		<xsl:apply-templates select="self::b:SecurityPosition[b:closingBalNoNom !='0']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:SecurityPosition" mode="filter4">
		<xsl:apply-templates select="self::b:SecurityPosition[($g_filterBySubAssetType='Y' and b:subAssetTypeJoin and contains($list_SubAssetType_SecurityPosition,b:subAssetTypeJoin)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or 
									 b:subAssetTypeTapInstrType='CONVBOND' or b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or
									 b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or 
									 b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or b:subAssetTypeTapInstrType='REVCONVEQLK' or 
									 b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SecurityPosition" mode="filter-custo">
		<xsl:apply-templates select="self::b:SecurityPosition" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:SecurityPosition" mode="filter-final">
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