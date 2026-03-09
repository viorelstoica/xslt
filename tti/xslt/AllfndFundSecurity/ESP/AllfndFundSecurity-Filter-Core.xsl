<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AllfndFundSecurity"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAllfndFundSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAllfndFundSecurity" xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAllfndFundSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:AllfndFundSecurity">
		<xsl:apply-templates select="self::b:AllfndFundSecurity[($g_filterBySubAssetType='Y' and b:subAssetType and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:subAssetType))
		                                                          or
		                                                          ($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='MUTUALFUND') 
		                                                       ]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:AllfndFundSecurity" mode="filter-custo">
		<xsl:apply-templates select="self::b:AllfndFundSecurity" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:AllfndFundSecurity" mode="filter-final">
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