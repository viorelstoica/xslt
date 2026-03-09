<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/Country"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCountry"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:value-of select="b:id"/>
      </code>
   </xsl:template>
   <xsl:template name="synonym">
      <synonym>
         <code>
            <xsl:value-of select="b:id"/>
         </code>
         <codification>ALPHA2_ISO_3166</codification>
      </synonym>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
      </shortName>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="b:countryNameList/b:countryName[@language=$boDefaultLanguage]"/>
      </longName>
   </xsl:template>
   <xsl:template name="multilingualLongName">
      <xsl:for-each select="b:countryNameList/b:countryName">
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
         <xsl:with-param name="CurrentEvent" select="./b:countryNameList/b:countryName"/>
         <xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:Country/b:countryNameList/b:countryName"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="nature">
      <nature>1</nature>
   </xsl:template>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="currency"/>
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
