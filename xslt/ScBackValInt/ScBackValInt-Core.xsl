<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" 
    xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScBackValInt" 
    xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="../b:currency"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature">
      <dataNature>18</dataNature>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="../b:accountNumber"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="validity">
      <validity>
         <xsl:choose>
            <xsl:when test="string-length(b:foValidityDate) &lt; 9">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:foValidityDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:foValidityDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </validity>
   </xsl:template>
   <xsl:template name="value">
      <value>
         <xsl:value-of select="b:accruedInterest"/>
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