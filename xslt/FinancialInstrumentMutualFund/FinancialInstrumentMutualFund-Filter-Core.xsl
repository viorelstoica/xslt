<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- BEG - For input flow FinancialInstrumentSecurity -->
	<!-- Condition 1 -->
	<xsl:template match="b:FinancialInstrumentSecurity">
		<xsl:param name="subAssetType" select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subAssetType"/>
        <xsl:param name="subAssetTypeTapInstrType" select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subAssetTypeTapInstrType"/>
		<xsl:apply-templates select="self::b:FinancialInstrumentSecurity[($g_filterBySubAssetType='Y' and $subAssetType and contains(concat(' ',$list_SubAssetType_FinancialInstrumentMutualFund,' '),concat(' ',$subAssetType,' '))) or
									($g_filterBySubAssetType != 'Y' and $subAssetTypeTapInstrType and $subAssetTypeTapInstrType='MUTUALFUND')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FinancialInstrumentSecurity" mode="filter-custo">
		<xsl:apply-templates select="self::b:FinancialInstrumentSecurity" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:FinancialInstrumentSecurity" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - For input flow FinancialInstrumentSecurity -->





	<!-- BEG - For input flow FinancialInstrumentME -->
	<!-- Condition 1 -->
	<xsl:template match="d:FinancialInstrumentME">
		<xsl:param name="subAssetType" select="../../f:CurrentEvent/d:FinancialInstrumentME/d:subAssetType"/>
        <xsl:param name="subAssetTypeTapInstrType" select="../../f:CurrentEvent/d:FinancialInstrumentME/d:subAssetTypeTapInstrType"/>
		<xsl:apply-templates select="self::d:FinancialInstrumentME[($g_filterBySubAssetType='Y' and $subAssetType and contains(concat(' ',$list_SubAssetType_FinancialInstrumentMutualFund,' '),concat(' ',$subAssetType,' '))) or
									($g_filterBySubAssetType != 'Y' and $subAssetTypeTapInstrType and $subAssetTypeTapInstrType='MUTUALFUND')]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="d:FinancialInstrumentME" mode="filter1">
		<xsl:apply-templates select="self::d:FinancialInstrumentME[not(contains(d:eventCommon/ns0:transactionStage,'INITIAL-LOAD') and (d:blockingDate and d:blockingDate != ''))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="d:FinancialInstrumentME" mode="filter-custo">
		<xsl:apply-templates select="self::d:FinancialInstrumentME" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="d:FinancialInstrumentME" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - For input flow FinancialInstrumentME -->
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