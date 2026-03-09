<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/AcAccrual/AcAccrual" xmlns:d="http://www.temenos.com/T24/AccountingEventsService/AcAccountAccruals" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="d:accountCcy"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="dataNature">
      <dataNature>18</dataNature>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="d:accountId"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="validity">
      <validity>
         <xsl:choose>
            <xsl:when test="string-length(d:acrrualDate) &lt; 9">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="d:acrrualDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="d:acrrualDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </validity>
   </xsl:template>
   <xsl:template name="value">
      <xsl:param name="TotalAccr"/>
      <value>
         <xsl:value-of select="$TotalAccr"/>
      </value>
   </xsl:template>
   <xsl:template name="provider"/>
   <xsl:template name="valueType"/>
   <xsl:template name="mbFields"/>
   <xsl:template match="b:accountaccruals">
      <xsl:variable name="TotalAccr" select="format-number(sum(d:debitIntAccruals/d:accrIntAmount) + sum(d:debitInt2Accruals/d:accrIntAmount) + sum(d:creditIntAccruals/d:accrIntAmount) + sum(d:creditInt2Accruals/d:accrIntAmount),$decimalformat,'nan2zero')"/>
      <DataGroup>
         <ChronologicalData>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('AcAccrual-Core.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="currency"/>
            <xsl:call-template name="dataNature"/>
            <xsl:call-template name="instrument"/>
            <xsl:call-template name="validity"/>
            <xsl:call-template name="value">
               <xsl:with-param name="TotalAccr" select="$TotalAccr"/>
            </xsl:call-template>
            <xsl:call-template name="provider"/>
            <xsl:call-template name="valueType"/>
            <xsl:call-template name="mbFields"/>
         </ChronologicalData>
      </DataGroup>
   </xsl:template>
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