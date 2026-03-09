<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/ChronologicalDataFixedIncome"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="currency_duration">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_duration">
      <dataNature>10</dataNature>
   </xsl:template>
   <xsl:template name="instrument_duration">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_duration">
      <value>
         <xsl:value-of select="b:duration"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_duration"/>
   <xsl:template name="provider_duration"/>
   <xsl:template name="valueType_duration"/>
   <xsl:template name="mbFields_duration"/>
   <xsl:template name="currency_durationModify">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_durationModify">
      <dataNature>4</dataNature>
   </xsl:template>
   <xsl:template name="instrument_durationModify">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_durationModify">
      <value>
         <xsl:value-of select="b:durationModify"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_durationModify"/>
   <xsl:template name="provider_durationModify"/>
   <xsl:template name="valueType_durationModify"/>
   <xsl:template name="mbFields_durationModify"/>
   <xsl:template name="currency_yieldToMat">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_yieldToMat">
      <dataNature>26</dataNature>
   </xsl:template>
   <xsl:template name="instrument_yieldToMat">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_yieldToMat">
      <value>
         <xsl:value-of select="b:yieldToMat"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_yieldToMat"/>
   <xsl:template name="provider_yieldToMat"/>
   <xsl:template name="valueType_yieldToMat"/>
   <xsl:template name="mbFields_yieldToMat"/>
   <xsl:template name="currency_currentYield">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_currentYield">
      <dataNature>24</dataNature>
   </xsl:template>
   <xsl:template name="instrument_currentYield">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_currentYield">
      <value>
         <xsl:value-of select="b:currentYield"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_currentYield"/>
   <xsl:template name="provider_currentYield"/>
   <xsl:template name="valueType_currentYield"/>
   <xsl:template name="mbFields_currentYield"/>
   <xsl:template name="currency_yieldToLife">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_yieldToLife">
      <dataNature>2</dataNature>
   </xsl:template>
   <xsl:template name="instrument_yieldToLife">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_yieldToLife">
      <value>
         <xsl:value-of select="b:yieldToLife"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_yieldToLife"/>
   <xsl:template name="provider_yieldToLife"/>
   <xsl:template name="valueType_yieldToLife"/>
   <xsl:template name="mbFields_yieldToLife"/>
   <xsl:template name="currency_convexity">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_convexity">
      <dataNature>12</dataNature>
   </xsl:template>
   <xsl:template name="instrument_convexity">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_convexity">
      <value>
         <xsl:value-of select="b:convexity"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_convexity"/>
   <xsl:template name="provider_convexity"/>
   <xsl:template name="valueType_convexity"/>
   <xsl:template name="mbFields_convexity"/>
   <xsl:template name="currency_priceEarnRatio">
      <currency>
         <infra:code>
            <xsl:value-of select="b:securityCurrency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature_priceEarnRatio">
      <dataNature>15</dataNature>
   </xsl:template>
   <xsl:template name="instrument_priceEarnRatio">
      <instrument>
         <infra:code>
            <xsl:value-of select="b:securityCode"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="value_priceEarnRatio">
      <value>
         <xsl:value-of select="b:priceEarnRatio"/>
      </value>
   </xsl:template>
   <xsl:template name="validity_priceEarnRatio"/>
   <xsl:template name="provider_priceEarnRatio"/>
   <xsl:template name="valueType_priceEarnRatio"/>
   <xsl:template name="mbFields_priceEarnRatio"/>
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
