<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsGuarantees" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="historicalPrice">
      <historicalPrice>0</historicalPrice>
   </xsl:template>
   <xsl:template name="historicalInstrExchRate"/>
   <xsl:template name="initialLoadDate">
      <initialLoadDate>
         <xsl:value-of select="../b:eventCommon/ns0:today"/>
      </initialLoadDate>
   </xsl:template>
   <xsl:template name="initialLoadPrice">
      <initialLoadPrice>0</initialLoadPrice>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:dealNo"/>
            <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
            <xsl:value-of select="../b:companyMnemonic"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:cusPortId"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="positionCode">
      <positionCode>
         <xsl:value-of select="../b:dealNo"/>
         <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
         <xsl:value-of select="../b:companyMnemonic"/>
      </positionCode>
   </xsl:template>
   <xsl:template name="positionCurrency">
      <positionCurrency>
         <infra:code>
            <xsl:value-of select="../b:currency"/>
         </infra:code>
      </positionCurrency>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:choose>
            <xsl:when test="../b:contractType = 'CA'">
               <xsl:value-of select="'-'"/>
               <xsl:value-of select="b:prinBalanceJoin"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:prinBalanceJoin"/>
            </xsl:otherwise>
         </xsl:choose>
      </quantity>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="'INITLOAD'"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="accruedInterests"/>
   <xsl:template name="deposit"/>
   <xsl:template name="historicalExchangeRate"/>
   <xsl:template name="historicalNetAmount"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="positionValueDate"/>
   <xsl:template name="referenceNature"/>
   <xsl:template name="referenceOperationCode"/>
   <xsl:template name="sourceCode">
      <sourceCode>
         <xsl:value-of select="concat(../b:dealNo,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
      </sourceCode>
   </xsl:template>
   <xsl:template name="bookExchangeRate"/>
   <xsl:template name="bookPrice"/>
   <xsl:template name="bookNetAmount"/>
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