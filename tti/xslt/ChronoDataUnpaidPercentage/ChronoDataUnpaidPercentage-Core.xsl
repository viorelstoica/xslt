<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/ChronoDataUnpaidPercentage"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature">
      <dataNature>28</dataNature>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:id"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="validity">
      <validity>
         <xsl:value-of select="b:cpnDate"/>
      </validity>
   </xsl:template>
   <xsl:template name="value">
      <value>
         <xsl:value-of select="format-number(100 * (1 - (b:factor)),$decimalformat,'nan2zero')"/>
      </value>
   </xsl:template>
   <xsl:template name="provider"/>
   <xsl:template name="valueType"/>
   <xsl:template name="mbFields"/>
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
