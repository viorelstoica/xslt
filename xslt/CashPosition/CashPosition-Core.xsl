<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CashPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="balance">
      <balance>
         <xsl:choose>
            <xsl:when test="$VALUE_DATED_ACCOUNTING = 'Y'">
                <xsl:value-of select="b:compTdBalance"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="b:onlineActualBal"/>                
            </xsl:otherwise>
         </xsl:choose>
      </balance>
   </xsl:template>
   <xsl:template name="cashAccount">
      <cashAccount>
         <infra:code>
            <xsl:value-of select="b:id"/>
         </infra:code>
      </cashAccount>
   </xsl:template>
   <xsl:template name="initialLoadDate">
      <initialLoadDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </initialLoadDate>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
		 	<xsl:choose>
				<xsl:when test="b:idSecAccMasterJoinList/b:idSecAccMasterJoin">
					<xsl:value-of select="b:idSecAccMasterJoinList/b:idSecAccMasterJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:idSecAccMasterHistJoin"/>
				</xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="positionCode">
      <positionCode>
         <xsl:value-of select="concat(b:id,'INIT')"/>
      </positionCode>
   </xsl:template>
   <xsl:template name="positionCurrency">
      <positionCurrency>
         <infra:code>
            <xsl:value-of select="b:currency"/>
         </infra:code>
      </positionCurrency>
   </xsl:template>
   <xsl:template name="sourceCode">
      <sourceCode>
         <xsl:value-of select="b:id"/>
      </sourceCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>INITLOAD</infra:code>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="historicalExchangeRate"/>
   <xsl:template name="valueDate"/>
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