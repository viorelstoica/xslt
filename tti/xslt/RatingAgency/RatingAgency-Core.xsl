<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/RatingAgency"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiRatingAgency"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:value-of select="b:id"/>
      </code>
   </xsl:template>
   <xsl:template name="entity">
      <entity>
         <xsl:value-of select="'rating'"/>
      </entity>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="b:agencyDescList/b:agencyDesc"/>
      </longName>
   </xsl:template>
   <xsl:template name="multilingualLongname">
      <xsl:for-each select="b:agencyDescList/b:agencyDesc">
         <multilingualLongname>
            <language>
               <xsl:call-template name="languageTranslation">
                  <xsl:with-param name="boLanguage" select="@language"/>
                  <xsl:with-param name="defaultReturn" select="'en'"/>
               </xsl:call-template>
            </language>
            <longName>
               <xsl:value-of select="."/>
            </longName>
         </multilingualLongname>
      </xsl:for-each>
      <xsl:call-template name="OldNewDenomManagment2">
         <xsl:with-param name="CurrentEvent" select="./b:agencyDescList/b:agencyDesc"/>
         <xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:RatingAgency/b:agencyDescList/b:agencyDesc"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:agencyNameList/b:agencyName"/>
      </shortName>
   </xsl:template>
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
