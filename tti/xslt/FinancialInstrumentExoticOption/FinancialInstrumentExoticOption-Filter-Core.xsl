<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOption" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentExoticOption" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOption" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentExoticOption" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:FinancialInstrumentExoticOption">
    <xsl:variable name="list_PriceSet">
      <xsl:call-template name="priceSetTranslation">
        <xsl:with-param name="priceSet" select="'CLOSING'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="self::b:FinancialInstrumentExoticOption[contains(concat(' ',$list_PriceSet,' '),concat(' ',b:priceSet,' '))]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FinancialInstrumentExoticOption" mode="filter1">
    <xsl:apply-templates select="self::b:FinancialInstrumentExoticOption[contains($list_DXExoticOptionsOptionType,concat(' ',b:optionTypeList/b:optionType,' '))]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:FinancialInstrumentExoticOption" mode="filter2">
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
    <xsl:apply-templates select="self::b:FinancialInstrumentExoticOption[number($check_MaturityDate) &gt;= number($check_toDay)]" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:FinancialInstrumentExoticOption" mode="filter3">
    <xsl:apply-templates select="self::b:FinancialInstrumentExoticOption[($g_filterBySubAssetType = 'Y' and b:subAssetType and contains($list_SubAssetType_FinancialInstrumentExoticOption,b:subAssetType)) or ($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType ='OPTION')]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FinancialInstrumentExoticOption" mode="filter-custo">
    <xsl:apply-templates select="self::b:FinancialInstrumentExoticOption" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FinancialInstrumentExoticOption" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\FinancialInstrumentMiniFutureTurbo\FinancialInstrumentMiniFutureTurbo.xml" srcSchemaRoot="tns1:MultiFinancialInstrumentMiniFutureTurbo" AssociatedInstance="" loaderFunction="document"
			              loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="@* | node()"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->