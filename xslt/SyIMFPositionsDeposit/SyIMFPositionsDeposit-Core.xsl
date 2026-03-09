<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImf" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="amount">
      <amount>
         <xsl:value-of select="b:depositAmt"/>
      </amount>
   </xsl:template>
   <xsl:template name="expirationDate"/>
   <xsl:template name="initialLoadDate">
      <initialLoadDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </initialLoadDate>
   </xsl:template>
   <xsl:template name="moneyMarket">
      <moneyMarket>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </moneyMarket>
   </xsl:template>
   <xsl:template name="operationDate"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="positionCode">
      <positionCode>
         <xsl:value-of select="concat(b:underlyingRefList/b:underlyingRef,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,'_DEP')"/>
      </positionCode>
   </xsl:template>
   <xsl:template name="positionCurrency">
      <positionCurrency>
         <infra:code>
            <xsl:value-of select="b:depositCcy"/>
         </infra:code>
      </positionCurrency>
   </xsl:template>
   <xsl:template name="positionExchangeRate"/>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>INITLOAD</infra:code>
      </type>
   </xsl:template>
   <xsl:template name="accruedInterests">
      <accruedInterests>
         <xsl:value-of select="'0'"/>
      </accruedInterests>
   </xsl:template>
   <xsl:template name="referenceNature">
      <referenceNature>
         <xsl:value-of select="'0'"/>
      </referenceNature>
   </xsl:template>
   <xsl:template name="sourceCode"/>
   <xsl:template name="valueDate"/>
   <xsl:template name="interestRate"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
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