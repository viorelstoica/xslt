<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/ChronologicalDataCAAccruedInterestsLoad" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:param name="TotalAccr" select="format-number(sum(b:accrCrAmountGroup/b:accrCrAmount)+sum(b:accrCr2AmountGroup/b:accrCr2Amount)+sum(b:accrDrAmountGroup/b:accrDrAmount)+sum(b:accrDr2AmountGroup/b:accrDr2Amount),$decimalformat,'nan2zero')"/>
  <xsl:template name="currency">
    <currency>
      <infra:code>
        <xsl:value-of select="b:currency"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="dataNature">
    <dataNature>18</dataNature>
  </xsl:template>
  <xsl:template name="instrument">
    <instrument>
      <infra:code>
        <xsl:value-of select="b:id"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="validity">
    <validity>
      <xsl:value-of select="b:accountToday"/>
    </validity>
  </xsl:template>
  <xsl:template name="value">
    <xsl:variable name="TotalAccr" select="format-number(sum(b:accrCrAmountGroup/b:accrCrAmount)+sum(b:accrCr2AmountGroup/b:accrCr2Amount)+sum(b:accrDrAmountGroup/b:accrDrAmount)+sum(b:accrDr2AmountGroup/b:accrDr2Amount),$decimalformat,'nan2zero')"/>
    <value>
      <xsl:value-of select="$TotalAccr"/>
    </value>
  </xsl:template>
  <xsl:template name="provider"/>
  <xsl:template name="valueType"/>
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
