<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/CurrencyMarket"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCurrencyMarket"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:if test=". != ''">
            <xsl:value-of select="concat($CCYMARKET_PREFIX,b:id)"/>
         </xsl:if>
      </code>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
      </shortName>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="concat('Currency Market: ',b:descriptionList/b:description[@language=$boDefaultLanguage])"/>
      </longName>
   </xsl:template>
   <xsl:template name="multilingualLongName">
      <xsl:for-each select="b:descriptionList/b:description">
         <multilingualLongName>
            <language>
               <xsl:call-template name="languageTranslation">
                  <xsl:with-param name="boLanguage" select="@language"/>
               </xsl:call-template>
            </language>
            <longName>
               <xsl:value-of select="."/>
            </longName>
         </multilingualLongName>
      </xsl:for-each>
      <xsl:call-template name="OldNewDenomManagment">
         <xsl:with-param name="CurrentEvent" select="./b:descriptionList/b:description"/>
         <xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:CurrencyMarket/b:descriptionList/b:description"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="calendar"/>
   <xsl:template name="closeTime"/>
   <xsl:template name="currency"/>
   <xsl:template name="marketVenueType"/>
   <xsl:template name="referenceIndex"/>
   <xsl:template name="residGeo"/>
   <xsl:template name="type"/>
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