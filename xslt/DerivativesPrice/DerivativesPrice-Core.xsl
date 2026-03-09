<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DerivativesPrice" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b ns0" version="1.0">
  <xsl:template name="currency">
    <currency>
      <infra:code>
        <xsl:value-of select="b:priceCcy"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="instrument">
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
  <xsl:template name="quotationDate">
    <xsl:if test="b:priceDate">
      <quotationDate>
        <xsl:call-template name="xsdatetime">
          <xsl:with-param name="date" select="b:priceDate"/>
        </xsl:call-template>
      </quotationDate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="value">
    <value>
      <xsl:value-of select="b:price"/>
    </value>
  </xsl:template>
  <xsl:template name="valueType">
    <valueType>
      <infra:code>Close_Price</infra:code>
    </valueType>
  </xsl:template>
  <xsl:template name="provider"/>
  <xsl:template name="stockExchange"/>
  <xsl:template name="valueTermType"/>
  <xsl:template name="priceCalculationRule"/>
  <xsl:template name="mbFields"/>
  <xsl:template name="userDefinedField"/>
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