<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/IndexPrice"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="b:recId"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="quotationDate">
      <quotationDate>
         <xsl:call-template name="xsdatetime">
            <xsl:with-param name="date" select="b:date"/>
         </xsl:call-template>
      </quotationDate>
   </xsl:template>
   <xsl:template name="value">
      <value>
         <xsl:value-of select="b:rate"/>
      </value>
   </xsl:template>
   <xsl:template name="valueType">
      <valueType>
         <infra:code>Close_Price</infra:code>
      </valueType>
   </xsl:template>
   <xsl:template name="currency"/>
   <xsl:template name="provider"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="valueTermType"/>
   <xsl:template name="priceCalculationRule"/>
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
