<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/PositionPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="accruedInterests">
      <accruedInterests>
         <xsl:value-of select="'0'"/>
      </accruedInterests>
   </xsl:template>
   <xsl:template name="amount">
      <amount>
         <xsl:value-of select="b:amount"/>
      </amount>
   </xsl:template>
   <xsl:template name="expirationDate"/>
   <xsl:template name="initialLoadDate">
      <initialLoadDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </initialLoadDate>
   </xsl:template>
   <xsl:template name="moneyMarket">
      <moneyMarket>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </moneyMarket>
   </xsl:template>
   <xsl:template name="operationDate">
      <operationDate>
         <xsl:choose>
            <xsl:when test="string-length(b:orderDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:orderDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:orderDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </operationDate>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:cusPortId"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="positionCode">
      <positionCode>
         <xsl:value-of select="concat(b:id,'_IL',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </positionCode>
   </xsl:template>
   <xsl:template name="positionCurrency">
      <positionCurrency>
         <infra:code>
            <xsl:value-of select="b:currencyCode"/>
         </infra:code>
      </positionCurrency>
   </xsl:template>
   <xsl:template name="positionExchangeRate"/>
   <xsl:template name="referenceNature">
       <referenceNature>0</referenceNature>
   </xsl:template>
   <xsl:template name="sourceCode"/>
   <xsl:template name="status">
      <status>
         <xsl:choose>
            <xsl:when test="b:orderStatus = 'FWD'">
               <xsl:value-of select="$FD_UNPLACED_ORDER_STATUS"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="statusTranslation">
                  <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="'FD_INIT'"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </valueDate>
   </xsl:template>
   <xsl:template name="interestRate"/>
   <xsl:template name="userDefinedField"/>
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
