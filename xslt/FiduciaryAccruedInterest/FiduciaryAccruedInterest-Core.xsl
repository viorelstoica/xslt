<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrderCob"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b ns0"
                version="1.0">
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="b:currencyCode"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature">
      <dataNature>18</dataNature>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="validity">
      <validity>
         <!--  the dates application is cycles early in the COB, we always map the previous day to get the 'evening' date  -->
         <xsl:choose>
            <xsl:when test="string-length(b:coCodeDatesLastWorkingDay) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:coCodeDatesLastWorkingDay"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:coCodeDatesLastWorkingDay"/>
            </xsl:otherwise>
         </xsl:choose>            
      </validity>
   </xsl:template>
   <xsl:template name="value">
      <value>
         <xsl:choose>
            <xsl:when test="b:fdBalancesOtsInterest = '' or not(b:fdBalancesOtsInterest)">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:fdBalancesOtsInterest"/>
            </xsl:otherwise>
         </xsl:choose>
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