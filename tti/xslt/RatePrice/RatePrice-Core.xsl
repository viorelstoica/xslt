<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/RatePrice" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:template name="currency_ask">
    <currency>
      <infra:code>
        <xsl:value-of select="substring(../../b:refCcyDate,'3','3')"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="instrument_ask">
    <instrument>
      <infra:code>
        <xsl:value-of select="concat(substring(../../b:refCcyDate,'1','5'),../b:restPeriod)"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="quotationDate_ask">
    <quotationDate>
      <xsl:variable name="refCcyDateLenght" select="string-length(../../b:refCcyDate)"/>
      <xsl:call-template name="xsdatetimeNoSep">
        <xsl:with-param name="date" select="substring(../../b:refCcyDate,$refCcyDateLenght   - 7,'8')"/>
      </xsl:call-template>
    </quotationDate>
  </xsl:template>
  <xsl:template name="value_ask">
    <value>
      <xsl:value-of select="b:offerRate"/>
    </value>
  </xsl:template>
  <xsl:template name="valueType_ask">
    <valueType>
      <infra:code>Ask_Price</infra:code>
    </valueType>
  </xsl:template>
  <xsl:template name="provider_ask"/>
  <xsl:template name="stockExchange_ask"/>
  <xsl:template name="valueTermType_ask"/>
  <xsl:template name="priceCalculationRule_ask"/>
  <xsl:template name="mbFields_ask"/>
  <xsl:template name="currency_bid">
    <currency>
      <infra:code>
        <xsl:value-of select="substring(../../b:refCcyDate,'3','3')"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="instrument_bid">
    <instrument>
      <infra:code>
        <xsl:value-of select="concat(substring(../../b:refCcyDate,'1','5'),../b:restPeriod)"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="quotationDate_bid">
    <quotationDate>
      <xsl:variable name="refCcyDateLenght" select="string-length(../../b:refCcyDate)"/>
      <xsl:call-template name="xsdatetimeNoSep">
        <xsl:with-param name="date" select="substring(../../b:refCcyDate,$refCcyDateLenght   - 7,'8')"/>
      </xsl:call-template>
    </quotationDate>
  </xsl:template>
  <xsl:template name="value_bid">
    <value>
      <xsl:value-of select="b:bidRate"/>
    </value>
  </xsl:template>
  <xsl:template name="valueType_bid">
    <valueType>
      <infra:code>Bid_Price</infra:code>
    </valueType>
  </xsl:template>
  <xsl:template name="provider_bid"/>
  <xsl:template name="stockExchange_bid"/>
  <xsl:template name="valueTermType_bid"/>
  <xsl:template name="priceCalculationRule_bid"/>
  <xsl:template name="mbFields_bid"/>
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
