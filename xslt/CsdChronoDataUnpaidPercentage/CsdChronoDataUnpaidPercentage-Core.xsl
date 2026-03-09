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
   <xsl:template name="dataNatureComplex">
		<dataNature>101</dataNature>
	</xsl:template>
	<xsl:template name="dataNatureLiq">
		<dataNature>102</dataNature>
	</xsl:template>
	<xsl:template name="dataNatureRisk">
		<dataNature>103</dataNature>
	</xsl:template>
	<xsl:template name="valueComplex">
		<xsl:choose>
			<xsl:when test="../b:complexity ='1'">
				<value>
					<xsl:value-of select="'1'"/>
				</value>
			</xsl:when>
			<xsl:when test="../b:complexity ='2'">
				<value>
					<xsl:value-of select="'0'"/>
				</value>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="valueLiq">
		<value>
			<xsl:value-of select="../b:csdLiqtyAlt"/>
		</value>
	</xsl:template>
	<xsl:template name="valueRisk">
		<value>
			<xsl:value-of select="../b:riskTypeIndGroup[1]/b:regRiskLevel"/>
		</value>
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
