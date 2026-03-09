<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/Price"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="b:SecurityMasterJoinPriceCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="b:securityNo"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="provider">
      <provider>
         <infra:code>
            <xsl:if test="b:SecurityMasterJoinPriceUpdateCode != ''">
               <xsl:value-of select="concat($PRICEPROV_PREFIX,b:SecurityMasterJoinPriceUpdateCode)"/>
            </xsl:if>
         </infra:code>
      </provider>
   </xsl:template>
   <xsl:template name="quotationDate">
      <xsl:if test="b:dateChange != ''">
         <quotationDate>
            <xsl:call-template name="xsdatetime">
               <xsl:with-param name="date" select="b:dateChange"/>
            </xsl:call-template>
         </quotationDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="stockExchange">
      <stockExchange>
         <infra:code>
            <xsl:if test="b:SecurityMasterJoinStockExchange != ''">
               <xsl:value-of select="concat($STOCKEXCH_PREFIX,b:SecurityMasterJoinStockExchange)"/>
            </xsl:if>
         </infra:code>
      </stockExchange>
   </xsl:template>
   <xsl:template name="value">
      <xsl:if test="b:newPriceGroup[b:newPrice!=''][last()]/b:newPrice !=''">
         <value>
            <xsl:value-of select="b:newPriceGroup[b:newPrice!=''][last()]/b:newPrice"/>
         </value>
      </xsl:if>
   </xsl:template>
   <xsl:template name="valueType">
      <valueType>
         <infra:code>Close_Price</infra:code>
      </valueType>
   </xsl:template>
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
