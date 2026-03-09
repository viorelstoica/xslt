<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentIndex"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentIndex"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="b:recId"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName">
      <xsl:if test="b:descriptionList/b:description[@language='GB'] != ''">
         <infra:multilingualLongName>
            <infra:language>
               <xsl:value-of select="'en'"/>
            </infra:language>
            <infra:longName>
               <xsl:for-each select="b:descriptionList/b:description[@language='GB']">
                  <xsl:value-of select="concat(.,' ')"/>
               </xsl:for-each>
            </infra:longName>
         </infra:multilingualLongName>
      </xsl:if>
      <xsl:if test="b:descriptionList/b:description[@language='FR'] != ''">
         <infra:multilingualLongName>
            <infra:language>
               <xsl:value-of select="'fr'"/>
            </infra:language>
            <infra:longName>
               <xsl:for-each select="b:descriptionList/b:description[@language='FR']">
                  <xsl:value-of select="concat(.,' ')"/>
               </xsl:for-each>
            </infra:longName>
         </infra:multilingualLongName>
      </xsl:if>
      <xsl:if test="b:descriptionList/b:description[@language='DE'] != ''">
         <infra:multilingualLongName>
            <infra:language>
               <xsl:value-of select="'de'"/>
            </infra:language>
            <infra:longName>
               <xsl:for-each select="b:descriptionList/b:description[@language='DE']">
                  <xsl:value-of select="concat(.,' ')"/>
               </xsl:for-each>
            </infra:longName>
         </infra:multilingualLongName>
      </xsl:if>
      <xsl:call-template name="OldNewDenomConcatManagment">
         <xsl:with-param name="CurrentEvent" select="./b:descriptionList/b:description"/>
         <xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:FinancialInstrumentIndex/b:descriptionList/b:description"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:value-of select="'1'"/>
      </active>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
	<xsl:template name="infra:notepad-custo"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="minimumQuantity"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="provider"/>
   <xsl:template name="referenceCurrency"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="roundLotQuantity"/>
   <xsl:template name="sector"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tickSize"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="baseDate"/>
   <xsl:template name="baseValue"/>
   <xsl:template name="calculationRule"/>
   <xsl:template name="divisor"/>
   <xsl:template name="forex"/>
   <xsl:template name="returnRule"/>
   <xsl:template name="timeRule"/>
   <xsl:template name="composition"/>
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
