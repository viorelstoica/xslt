<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/BasicInterest" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:template name="currency">
    <xsl:variable name="id" select="substring(b:id,1,string-length(b:id)-8)"/>
    <currency>
      <infra:code>
        <xsl:value-of select="substring($id,string-length($id)-2)"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="instrument">
    <xsl:variable name="id" select="substring(b:id,1,string-length(b:id)-8)"/>
    <instrument>
      <infra:code>
        <xsl:value-of select="concat($id,'F')"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="provider"/>
  <xsl:template name="quotationDate">
    <quotationDate>
      <xsl:call-template name="xsdatetimeNoSep">
        <xsl:with-param name="date" select="substring(b:id,string-length(b:id)-7)"/>
      </xsl:call-template>
    </quotationDate>
  </xsl:template>
  <xsl:template name="stockExchange"/>
  <xsl:template name="value">
    <value>
        <xsl:choose>
            <xsl:when test="b:interestRate">
                <xsl:value-of select="b:interestRate"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="b:negIntRate"/>
            </xsl:otherwise>
        </xsl:choose>      
    </value>
  </xsl:template>
  <xsl:template name="valueType">
    <valueType>
      <infra:code>Close_Price</infra:code>
    </valueType>
  </xsl:template>
  <xsl:template name="valueTermType"/>
  <xsl:template name="priceCalculationRule"/>
  <xsl:template name="mbFields"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="currency"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
