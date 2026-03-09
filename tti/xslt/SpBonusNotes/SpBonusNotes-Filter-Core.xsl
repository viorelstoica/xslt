<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
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
		<xsl:apply-templates select="self::b:FinancialInstrumentSecurity[($g_filterBySubAssetType='Y' and $subAssetType and contains(concat(' ',$list_SubAssetType_SpBonusNotes,' '),concat(' ',$subAssetType,' '))) or
						($g_filterBySubAssetType != 'Y' and $subAssetTypeTapInstrType and ($subAssetTypeTapInstrType='BONUSNOTES'))]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:FinancialInstrumentSecurity" mode="filter1">
		<xsl:param name="companyNameGB" select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:companyNameList/b:companyName[@language='GB']"/>
		<xsl:apply-templates select="self::b:FinancialInstrumentSecurity[not($companyNameGB) or $companyNameGB != 'New - to be updated by BO']" mode="filter-custo"/>
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
		<xsl:apply-templates select="self::d:FinancialInstrumentME[$g_filterBySubAssetType='Y' and $subAssetType and contains(concat(' ',$list_SubAssetType_SpBonusNotes,' '),concat(' ',$subAssetType,' '))
		                              or
		                                 ($g_filterBySubAssetType != 'Y' and $subAssetTypeTapInstrType and ($subAssetTypeTapInstrType='BONUSNOTES'))
	
		                              ]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="d:FinancialInstrumentME" mode="filter1">
		<xsl:apply-templates select="self::d:FinancialInstrumentME[not(contains(d:eventCommon/ns0:transactionStage,'INITIAL-LOAD') and (d:blockingDate and d:blockingDate != ''))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="d:FinancialInstrumentME" mode="filter2">
		<xsl:param name="companyNameGB" select="../../f:CurrentEvent/d:FinancialInstrumentSecurity/d:companyNameList/d:companyName[@language='GB']"/>
		<xsl:apply-templates select="self::d:FinancialInstrumentME[not($companyNameGB) or $companyNameGB != 'New - to be updated by BO']" mode="filter-custo"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\FinancialInstrumentFixedIncome\FinancialInstrumentFixedIncome.xml" srcSchemaRoot="MultiFinancialInstrumentFixedIncome" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="b:FinancialInstrumentFixedIncome">
				<block path="FiPMS/xsl:attribute[1]/xsl:value-of" x="196" y="54"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[1]" x="236" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[2]" x="156" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[3]" x="116" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[4]" x="76" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[5]" x="36" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[6]" x="236" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[7]" x="156" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[8]" x="116" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[9]" x="76" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[10]" x="36" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[11]" x="196" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[12]" x="236" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[13]" x="156" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[14]" x="116" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[15]" x="76" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[16]" x="36" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[17]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[18]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[19]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[20]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[21]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[22]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[23]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[24]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[25]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[26]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[27]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[28]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[29]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[30]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[31]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[32]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[33]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[34]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[35]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[36]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[37]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[38]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[39]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[40]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[41]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[42]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[43]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[44]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[45]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[46]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[47]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[48]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[49]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[50]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[51]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[52]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[53]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[54]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[55]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[56]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[57]" x="196" y="90"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->