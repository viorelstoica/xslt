<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentLombardWeightsDX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:template name="dataNature_C">
    <dataNature>
      <xsl:value-of select="$pledgedCreditRate"/>
    </dataNature>
  </xsl:template>
  <xsl:template name="instrument_C">
    <xsl:variable name="Var_Barrier" select="substring-after(substring-after(b:id,':'),':')"/>
    <xsl:variable name="securityNo">
      <xsl:choose>
        <xsl:when test="$Var_Barrier">
          <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType,'/',$Var_Barrier)"/>
        </xsl:when>
        <xsl:when test="$Var_Barrier='' and b:optionTypeList/b:optionType">
          <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <instrument>
      <infra:code>
        <xsl:value-of select="$securityNo"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="value_C">
    <value>
      <xsl:choose>
        <xsl:when test="b:dxMarketRateCredit and b:dxMarketRateCredit !=''">
          <xsl:value-of select="b:dxMarketRateCredit"/>
        </xsl:when>
        <xsl:when test="b:subMarginRateCredit and b:subMarginRateCredit !=''">
          <xsl:value-of select="b:subMarginRateCredit"/>
        </xsl:when>
        <xsl:when test="b:assetMarginRateCredit and b:assetMarginRateCredit !=''">
          <xsl:value-of select="b:assetMarginRateCredit"/>
        </xsl:when>
      </xsl:choose>
    </value>
  </xsl:template>
  <xsl:template name="currency_C"/>
  <xsl:template name="validity_C"/>
  <xsl:template name="provider_C"/>
  <xsl:template name="valueType_C"/>
  <xsl:template name="mbFields_C"/>
  <xsl:template name="dataNature_D">
    <dataNature>
      <xsl:value-of select="$pledgedDebitRate"/>
    </dataNature>
  </xsl:template>
  <xsl:template name="instrument_D">
    <xsl:variable name="Var_Barrier" select="substring-after(substring-after(b:id,':'),':')"/>
    <xsl:variable name="securityNo">
      <xsl:choose>
        <xsl:when test="$Var_Barrier">
          <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType,'/',$Var_Barrier)"/>
        </xsl:when>
        <xsl:when test="$Var_Barrier='' and b:optionTypeList/b:optionType">
          <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <instrument>
      <infra:code>
        <xsl:value-of select="$securityNo"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="value_D">
    <value>
      <xsl:choose>
        <xsl:when test="b:dxMarketRateDebit and b:dxMarketRateDebit !=''">
          <xsl:value-of select="b:dxMarketRateDebit"/>
        </xsl:when>
        <xsl:when test="b:subMarginRateDebit and b:subMarginRateDebit !=''">
          <xsl:value-of select="b:subMarginRateDebit"/>
        </xsl:when>
        <xsl:when test="b:assetMarginRateDebit and b:assetMarginRateDebit !=''">
          <xsl:value-of select="b:assetMarginRateDebit"/>
        </xsl:when>
      </xsl:choose>
    </value>
  </xsl:template>
  <xsl:template name="currency_D"/>
  <xsl:template name="validity_D"/>
  <xsl:template name="provider_D"/>
  <xsl:template name="valueType_D"/>
  <xsl:template name="mbFields_D"/>
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
