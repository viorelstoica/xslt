<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentOptionDxCo"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentOptionDxCo"
                xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c d"
                version="1.0">
   <xsl:template name="infra:code">
      <xsl:param name="index"/>
      <infra:code>
         <xsl:value-of select="concat(               b:dxMarketPriceJoinContractCodeList/b:dxMarketPriceJoinContractCode,'/',                b:dxMarketPriceJoinTradeCcyList/b:dxMarketPriceJoinTradeCcy,'/',                b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate,'/',                b:dxMarketPriceJoinCallPutList/b:dxMarketPriceJoinCallPut,'/',                b:dxMarketPriceJoinStrikeList/b:dxMarketPriceJoinStrike,'/',                b:dxMarketPriceJoinDeliveryCcyList/b:dxMarketPriceJoinDeliveryCcy,'/',                b:dxMarketPriceJoinOptionStyleList/b:dxMarketPriceJoinOptionStyle)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <xsl:param name="index"/>
      <infra:shortName>
         <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinShortNameGroup/b:dxMarketPriceJoinDxContractMasterJoinShortNameList/b:dxMarketPriceJoinDxContractMasterJoinShortName"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <xsl:param name="index"/>
      <infra:longName>
         <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinDescriptGroup/b:dxMarketPriceJoinDxContractMasterJoinDescriptList/b:dxMarketPriceJoinDxContractMasterJoinDescript"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="contractMaster">
      <xsl:param name="index"/>
      <contractMaster>
         <xsl:value-of select="b:dxMarketPriceJoinContractCodeList/b:dxMarketPriceJoinContractCode"/>
      </contractMaster>
   </xsl:template>
   <xsl:template name="faceValue">
      <xsl:param name="index"/>
      <faceValue>
         <xsl:choose>
            <xsl:when test="b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinTickSize = 0">
               <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinTickValue"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="format-number(b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinTickSize                   div                   b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinTickValue,$decimalformat,'nan2zero')"/>
            </xsl:otherwise>
         </xsl:choose>
      </faceValue>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:value-of select="1"/>
      </active>
   </xsl:template>
   <xsl:template name="mainStockExchange">
      <xsl:param name="index"/>
      <mainStockExchange>
         <infra:code>
            <xsl:if test="b:dxMarketPriceJoinDxContractMasterJoinExchangeList/b:dxMarketPriceJoinDxContractMasterJoinExchange != ''">
               <xsl:value-of select="concat($DXSTOCKEXCH_PREFIX, b:dxMarketPriceJoinDxContractMasterJoinExchangeList/b:dxMarketPriceJoinDxContractMasterJoinExchange)"/>
            </xsl:if>
         </infra:code>
      </mainStockExchange>
   </xsl:template>
   <xsl:template name="minimumQuantity">
      <xsl:param name="index"/>
      <xsl:if test="b:dxMarketPriceJoinDxContractMasterJoinDpsList/b:dxMarketPriceJoinDxContractMasterJoinDps            and b:dxMarketPriceJoinDxContractMasterJoinDpsList/b:dxMarketPriceJoinDxContractMasterJoinDps != ''">
         <minimumQuantity>
            <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinDpsList/b:dxMarketPriceJoinDxContractMasterJoinDps"/>
         </minimumQuantity>
      </xsl:if>
   </xsl:template>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select="'1'"/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <xsl:param name="index"/>
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:dxMarketPriceJoinTradeCcyList/b:dxMarketPriceJoinTradeCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry">
      <xsl:param name="index"/>
      <riskCountry>
         <infra:code>
            <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinRiskCountryList/b:dxMarketPriceJoinDxContractMasterJoinRiskCountry"/>
         </infra:code>
      </riskCountry>
   </xsl:template>
   <xsl:template name="subType">
      <xsl:param name="index"/>
      <subType>
         <infra:code>
            <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinSubAssetTypeList/b:dxMarketPriceJoinDxContractMasterJoinSubAssetType"/>
         </infra:code>
      </subType>
   </xsl:template>
   <xsl:template name="tickSize">
      <xsl:param name="index"/>
      <tickSize>
         <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinTickSize"/>
      </tickSize>
   </xsl:template>
   <xsl:template name="type">
      <xsl:param name="index"/>
      <type>
         <infra:code>
            <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinSubAssetTypeJoinAssetTypeList/b:dxMarketPriceJoinDxContractMasterJoinSubAssetTypeJoinAssetType"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="callPutIndicator">
      <xsl:param name="index"/>
      <xsl:if test="b:dxMarketPriceJoinCallPutList/b:dxMarketPriceJoinCallPut and             b:dxMarketPriceJoinCallPutList/b:dxMarketPriceJoinCallPut != ''">
         <callPutIndicator>
            <xsl:choose>
               <xsl:when test="b:dxMarketPriceJoinCallPutList/b:dxMarketPriceJoinCallPut = 'CALL'">
                  <xsl:value-of select="1"/>
               </xsl:when>
               <xsl:when test="b:dxMarketPriceJoinCallPutList/b:dxMarketPriceJoinCallPut = 'PUT'">
                  <xsl:value-of select="2"/>
               </xsl:when>
            </xsl:choose>
         </callPutIndicator>
      </xsl:if>
   </xsl:template>
   <xsl:template name="cashSettlement">
      <xsl:param name="index"/>
      <cashSettlement>
         <xsl:choose>
            <xsl:when test="b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethodList/b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethod = 'PHYSICAL'">
               <xsl:value-of select="1"/>
            </xsl:when>
            <xsl:when test="b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethodList/b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethod != 'PHYSICAL' and               b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethodList/b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethod and               b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethodList/b:dxMarketPriceJoinDxContractMasterJoinDeliveryMethod  != ''">
               <xsl:value-of select="0"/>
            </xsl:when>
         </xsl:choose>
      </cashSettlement>
   </xsl:template>
   <xsl:template name="contractSize">
      <xsl:param name="index"/>
      <contractSize>
         <xsl:value-of select="format-number(b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup/b:dxMarketPriceJoinDxContractMasterJoinTickValue div b:dxMarketPriceJoinDxContractMasterJoinTickSizeGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSizeSubGroup/b:dxMarketPriceJoinDxContractMasterJoinTickSize,'#.###','nan2zero')"/>
      </contractSize>
   </xsl:template>
   <xsl:template name="exerciseCurrency">
      <xsl:param name="index"/>
      <exerciseCurrency>
         <infra:code>
            <xsl:choose>
               <xsl:when test="b:dxMarketPriceJoinDeliveryCcyList/b:dxMarketPriceJoinDeliveryCcy and b:dxMarketPriceJoinDeliveryCcyList/b:dxMarketPriceJoinDeliveryCcy != ''">
                  <xsl:value-of select="b:dxMarketPriceJoinDeliveryCcyList/b:dxMarketPriceJoinDeliveryCcy"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:dxMarketPriceJoinDeliveryCcyList/b:dxMarketPriceJoinDeliveryCcy"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </exerciseCurrency>
   </xsl:template>
   <xsl:template name="exerciseType">
      <xsl:param name="index"/>
      <exerciseType>
         <xsl:choose>
            <xsl:when test="b:dxMarketPriceJoinOptionStyleList/b:dxMarketPriceJoinOptionStyle = 'A'">
               <xsl:value-of select="1"/>
            </xsl:when>
            <xsl:when test="b:dxMarketPriceJoinOptionStyleList/b:dxMarketPriceJoinOptionStyle = 'E'">
               <xsl:value-of select="2"/>
            </xsl:when>
            <xsl:when test="b:dxMarketPriceJoinOptionStyleList/b:dxMarketPriceJoinOptionStyle = 'C'">
               <xsl:value-of select="3"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="0"/>
            </xsl:otherwise>
         </xsl:choose>
      </exerciseType>
   </xsl:template>
   <xsl:template name="strikePrice">
      <xsl:param name="index"/>
      <xsl:if test="b:dxMarketPriceJoinStrikeList/b:dxMarketPriceJoinStrike and b:dxMarketPriceJoinStrikeList/b:dxMarketPriceJoinStrike  != ''">
         <strikePrice>
            <xsl:value-of select="b:dxMarketPriceJoinStrikeList/b:dxMarketPriceJoinStrike "/>
         </strikePrice>
      </xsl:if>
   </xsl:template>
   <xsl:template name="underlying">
      <xsl:param name="index"/>
      <xsl:if test="b:dxMarketPriceJoinDxContractMasterJoinUnderlyingGroup/b:dxMarketPriceJoinDxContractMasterJoinUnderlyingSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinUnderlying != 'CASH'             and b:dxMarketPriceJoinDxContractMasterJoinUnderlyingGroup/b:dxMarketPriceJoinDxContractMasterJoinUnderlyingSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinUnderlying != 'OTHER'">
         <underlying>
            <infra:code>
               <xsl:value-of select="b:dxMarketPriceJoinDxContractMasterJoinUnderlyingGroup/b:dxMarketPriceJoinDxContractMasterJoinUnderlyingSubGroup[1]/b:dxMarketPriceJoinDxContractMasterJoinUnderlying"/>
            </infra:code>
         </underlying>
      </xsl:if>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="provider"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="roundLotQuantity"/>
   <xsl:template name="sector"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="beginDate"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="complexity"/>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="expirationDate">
      <expirationDate>
         <xsl:choose>
            <xsl:when test="string-length(b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate) ='8'">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date"
                                  select="b:dxMarketPriceJoinMaturityDateList/b:dxMarketPriceJoinMaturityDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:dxMarketPriceJoinDxContractsDatesJoinDecDateList/b:dxMarketPriceJoinDxContractsDatesJoinDecDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </expirationDate>
   </xsl:template>
   <xsl:template name="instrumentClass"/>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="issuer"/>
   <xsl:template name="lastTradeDate"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="parentInstrument"/>
   <xsl:template name="riskLevel"/>
   <xsl:template name="subNature"/>
   <xsl:template name="underlyingQuantity"/>
   <xsl:template name="termEvent"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="category"/>
   <xsl:template name="fixingDate"/>
   <xsl:template name="barrier"/>
   <xsl:template name="barrierNature"/>
   <xsl:template name="lowBarrierP"/>
   <xsl:template name="paymentFrequency"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="upperBarrier"/>
   <xsl:template name="upperBarrierNature"/>
   <xsl:template name="upperBarrierP"/>
   <xsl:template name="usageNature"/>
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