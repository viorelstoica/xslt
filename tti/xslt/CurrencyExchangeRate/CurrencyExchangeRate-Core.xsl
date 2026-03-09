<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/CurrencyExchangeRate" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="dix-exp-x">
      <xsl:param name="first" select="true()"/>
      <xsl:param name="x" select="0"/>
      <xsl:if test="$first">
         <xsl:text>1</xsl:text>
      </xsl:if>
      <xsl:if test="$x &gt; 0">
         <xsl:text>0</xsl:text>
         <xsl:call-template name="dix-exp-x">
            <xsl:with-param name="x" select="$x - 1"/>
            <xsl:with-param name="first" select="false()"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   <xsl:template name="currency_midRevalRate">
      <currency>
         <code>
            <xsl:value-of select="substring(../b:currencyCode,1,3)"/>
         </code>
      </currency>
   </xsl:template>
   <xsl:template name="datetime_midRevalRate">
      <datetime>
         <xsl:choose>
            <xsl:when test="$USE_FIXING_DATE ='YES'">
               <xsl:value-of select="concat(../b:fixingDate,'T00:00:00')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(../b:eventCommon/ns0:today,'T00:00:00')"/>
            </xsl:otherwise>
         </xsl:choose>
      </datetime>
   </xsl:template>
   <xsl:template name="market_midRevalRate">
      <market>
         <code>
            <xsl:if test="b:currencyMarket != ''">
               <xsl:value-of select="concat($CCYMARKET_PREFIX,b:currencyMarket)"/>
            </xsl:if>
         </code>
      </market>
   </xsl:template>
   <xsl:template name="rate_midRevalRate">
      <rate>
        <xsl:variable name="rateToUse">
            <xsl:choose>    
                <xsl:when test="b:revalRate">
                    <xsl:value-of select="b:revalRate"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="b:midRevalRate"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
         <xsl:choose>
            <xsl:when test="not(../b:quotationCode)">
               <xsl:variable name="factor" select="'UNDEFINED'"/>
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '1'">
                     <xsl:value-of select="$rateToUse"/>
                  </xsl:when>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(1 div $rateToUse,$decimalformat,'nan2zero')"/>
                  </xsl:when>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="factor">
                  <xsl:call-template name="dix-exp-x">
                     <xsl:with-param name="x" select="../b:quotationCode"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '1'">
                     <xsl:value-of select="format-number(1 div ($rateToUse div $factor),$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number($rateToUse div $factor,$decimalformat,'nan2zero')"/>
                  </xsl:when>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </rate>
   </xsl:template>
   <xsl:template name="type_midRevalRate">
      <type>
         <code>Medium_Price</code>
      </type>
   </xsl:template>
   <xsl:template name="underlyCurrency_midRevalRate">
      <underlyCurrency>
         <code>
            <xsl:value-of select="../b:companyLocalCurrency"/>
         </code>
      </underlyCurrency>
   </xsl:template>
   <xsl:template name="provider_midRevalRate"/>
   <xsl:template name="quoteFactor_midRevalRate"/>
   <xsl:template name="inverseFlag_midRevalRate"/>
   <xsl:template name="exchangeRateInverseFlag_midRevalRate"/>
   <xsl:template name="mbFields_midRevalRate"/>
   <xsl:template name="currency_buyRate">
      <currency>
         <code>
            <xsl:value-of select="substring(../b:currencyCode,1,3)"/>
         </code>
      </currency>
   </xsl:template>
   <xsl:template name="datetime_buyRate">
      <datetime>
         <xsl:choose>
            <xsl:when test="$USE_FIXING_DATE ='YES'">
               <xsl:value-of select="concat(../b:fixingDate,'T00:00:00')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(../b:eventCommon/ns0:today,'T00:00:00')"/>
            </xsl:otherwise>
         </xsl:choose>
      </datetime>
   </xsl:template>
   <xsl:template name="market_buyRate">
      <market>
         <code>
            <xsl:if test="b:currencyMarket != ''">
               <xsl:value-of select="concat($CCYMARKET_PREFIX,b:currencyMarket)"/>
            </xsl:if>
         </code>
      </market>
   </xsl:template>
   <xsl:template name="rate_buyRate">
      <rate>
         <xsl:choose>
            <xsl:when test="not(../b:quotationCode)">
               <xsl:variable name="factor" select="'UNDEFINED'"/>
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '1'">
                     <xsl:value-of select="b:buyRate"/>
                  </xsl:when>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(1 div b:buyRate,$decimalformat,'nan2zero')"/>
                  </xsl:when>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="factor">
                  <xsl:call-template name="dix-exp-x">
                     <xsl:with-param name="x" select="../b:quotationCode"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '1'">
                     <xsl:value-of select="format-number(1 div (b:buyRate div $factor),$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(b:buyRate div $factor,$decimalformat,'nan2zero')"/>
                  </xsl:when>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </rate>
   </xsl:template>
   <xsl:template name="type_buyRate">
      <type>
         <code>Bid_Price</code>
      </type>
   </xsl:template>
   <xsl:template name="underlyCurrency_buyRate">
      <underlyCurrency>
         <code>
            <xsl:value-of select="../b:companyLocalCurrency"/>
         </code>
      </underlyCurrency>
   </xsl:template>
   <xsl:template name="provider_buyRate"/>
   <xsl:template name="quoteFactor_buyRate"/>
   <xsl:template name="inverseFlag_buyRate"/>
   <xsl:template name="exchangeRateInverseFlag_buyRate"/>
   <xsl:template name="mbFields_buyRate"/>
   <xsl:template name="currency_sellRate">
      <currency>
         <code>
            <xsl:value-of select="substring(../b:currencyCode,1,3)"/>
         </code>
      </currency>
   </xsl:template>
   <xsl:template name="datetime_sellRate">
      <datetime>
         <xsl:choose>
            <xsl:when test="$USE_FIXING_DATE ='YES'">
               <xsl:value-of select="concat(../b:fixingDate,'T00:00:00')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(../b:eventCommon/ns0:today,'T00:00:00')"/>
            </xsl:otherwise>
         </xsl:choose>
      </datetime>
   </xsl:template>
   <xsl:template name="market_sellRate">
      <market>
         <code>
            <xsl:if test="b:currencyMarket != ''">
               <xsl:value-of select="concat($CCYMARKET_PREFIX,b:currencyMarket)"/>
            </xsl:if>
         </code>
      </market>
   </xsl:template>
   <xsl:template name="rate_sellRate">
      <rate>
         <xsl:choose>
            <xsl:when test="not(../b:quotationCode)">
               <xsl:variable name="factor" select="'UNDEFINED'"/>
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '1'">
                     <xsl:value-of select="b:sellRate"/>
                  </xsl:when>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(1 div b:sellRate,$decimalformat,'nan2zero')"/>
                  </xsl:when>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="factor">
                  <xsl:call-template name="dix-exp-x">
                     <xsl:with-param name="x" select="../b:quotationCode"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '1'">
                     <xsl:value-of select="format-number(1 div (b:sellRate div $factor),$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(b:sellRate div $factor,$decimalformat,'nan2zero')"/>
                  </xsl:when>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </rate>
   </xsl:template>
   <xsl:template name="type_sellRate">
      <type>
         <code>Ask_Price</code>
      </type>
   </xsl:template>
   <xsl:template name="underlyCurrency_sellRate">
      <underlyCurrency>
         <code>
            <xsl:value-of select="../b:companyLocalCurrency"/>
         </code>
      </underlyCurrency>
   </xsl:template>
   <xsl:template name="provider_sellRate"/>
   <xsl:template name="quoteFactor_sellRate"/>
   <xsl:template name="inverseFlag_sellRate"/>
   <xsl:template name="exchangeRateInverseFlag_sellRate"/>
   <xsl:template name="mbFields_sellRate"/>
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