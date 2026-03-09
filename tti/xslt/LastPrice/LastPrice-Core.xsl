<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/LastPrice"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="b:priceCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="b:id"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="provider">
      <provider>
         <infra:code>
            <xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
         </infra:code>
      </provider>
   </xsl:template>
   <xsl:template name="quotationDate">
      <xsl:if test="b:dateLastPrice != ''">
         <quotationDate>
            <xsl:call-template name="xsdatetime">
               <xsl:with-param name="date" select="b:dateLastPrice"/>
            </xsl:call-template>
         </quotationDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="stockExchange">
      <stockExchange>
         <infra:code>
            <xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
         </infra:code>
      </stockExchange>
   </xsl:template>
   <xsl:template name="value">
      <value>
         <xsl:choose>
            <xsl:when test="b:priceType='DISCO' or b:priceType='YIELD'">
               <xsl:value-of select="b:discYldPerc"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:lastPrice"/>
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
   <xsl:template name="priceCalculationRule">
        <priceCalculationRule>
         <xsl:choose>
            <xsl:when test="b:factorGroup[b:factor != '']/b:factor != ''">4</xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:priceType = 'BOND'">2</xsl:when>
                  <xsl:when test="b:priceType = '0'">1</xsl:when>
                  <xsl:when test="b:priceType = 'DBOND'">2</xsl:when>
                  <xsl:when test="b:priceType = 'DISCO'">8</xsl:when>
                  <xsl:when test="b:priceType = 'UNIT'">1</xsl:when>
                  <xsl:when test="b:priceType = 'YIELD'">21</xsl:when>
                  <xsl:otherwise>1</xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
       </priceCalculationRule>
   </xsl:template>
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
