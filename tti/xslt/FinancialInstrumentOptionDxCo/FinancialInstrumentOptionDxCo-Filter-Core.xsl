<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentOptionDxCo" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentOptionDxCo" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentOptionDxCo" xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentOptionDxCo" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <xsl:template match="b:FinancialInstrumentOptionDxCo">
    <xsl:variable name="isPrimaryClient">
      <xsl:for-each select="b:tradesJoinDxTradePriSecAccGroup/b:tradesJoinDxTradePriSecAccSubGroup/b:tradesJoinDxTradePriSecAccGroup">
        <xsl:if test="../../../b:portfolio = b:tradesJoinDxTradePriSecAcc">1</xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test=" $isPrimaryClient !='' ">
      <xsl:copy>
        <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  <!-- Condition 1 -->
  <xsl:template match="b:dxMarketPriceJoinIdList/b:dxMarketPriceJoinId">
    <xsl:variable name="index" select="./@index"/>
    <xsl:variable name="list_PriceSet">
      <xsl:call-template name="priceSetTranslation">
        <xsl:with-param name="priceSet" select="'CLOSING'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="self::node()[contains(concat(' ',$list_PriceSet,' '),concat(' ',../../b:dxMarketPriceJoinPriceSetList/b:dxMarketPriceJoinPriceSet[@index = $index],' '))]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:dxMarketPriceJoinIdList/b:dxMarketPriceJoinId" mode="filter1">
    <xsl:variable name="index" select="./@index"/>
    <xsl:apply-templates select="self::node()[not(../../b:dxMarketPriceJoinOptionTypeList/b:dxMarketPriceJoinOptionType[@index = $index])]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:dxMarketPriceJoinIdList/b:dxMarketPriceJoinId" mode="filter2">
    <xsl:variable name="index" select="./@index"/>
    <xsl:apply-templates select="self::node()[($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentOptionDxCo, ../../b:dxMarketPriceJoinDxContractMasterJoinSubAssetTypeList/b:dxMarketPriceJoinDxContractMasterJoinSubAssetType[@index = $index])) or
								($g_filterBySubAssetType != 'Y' and ../../b:subAssetTypeTapInstrType and ../../b:subAssetTypeTapInstrType='OPTION')]" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:dxMarketPriceJoinIdList/b:dxMarketPriceJoinId" mode="filter3">
    <xsl:variable name="index" select="./@index"/>
    <xsl:variable name="check_toDay">
      <xsl:choose>
        <xsl:when test="string-length(../../b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate[1]) ='8'">
          <xsl:value-of select="translate(b:eventCommon/d:today,'-','')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(translate(../../b:eventCommon/d:today,'-',''),1,6)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::node()[( (string-length(../../b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate[@index = $index]) ='8' and            (../../b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate[@index = $index] &gt;            $check_toDay)          )          or           ( string-length(../../b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate[@index = $index]) != '8' and            (substring(translate(../../b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate[@index = $index],'-',''),1,6) &gt;           $check_toDay)          )         )]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:dxMarketPriceJoinIdList/b:dxMarketPriceJoinId" mode="filter-custo">
    <xsl:apply-templates select="self::node()" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:dxMarketPriceJoinIdList/b:dxMarketPriceJoinId" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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