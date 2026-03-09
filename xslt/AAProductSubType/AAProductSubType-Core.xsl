<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/AAProductSubType"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAAProductSubType"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:choose>
            <xsl:when test="$POSTFIX_AAGRPSUBTYPE = 'Y' ">
               <xsl:value-of select="concat(b:product,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:product"/>
            </xsl:otherwise>
         </xsl:choose>
      </code>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:descriptionList/b:description"/>
      </shortName>
   </xsl:template>
   <xsl:template name="language">
      <language>
         <xsl:call-template name="languageTranslation">
            <xsl:with-param name="boLanguage" select="@language"/>
         </xsl:call-template>
      </language>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="."/>
      </longName>
   </xsl:template>
   <xsl:template name="oldNewDenom">
      <xsl:call-template name="OldNewDenomManagment">
         <xsl:with-param name="CurrentEvent" select="./b:descriptionList/b:description"/>
         <xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:AAProductSubType/b:descriptionList/b:description"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="longName_insType"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="attribute">
      <attribute>subtype_id</attribute>
   </xsl:template>
   <xsl:template name="nature">
      <nature>5</nature>
   </xsl:template>
   <xsl:template name="parentType">
      <parentType>
         <code>
            <xsl:choose>
               <xsl:when test="$POSTFIX_AAGRPTYPE = 'Y' ">
                  <xsl:value-of select="concat(b:productGroup,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:productGroup"/>
               </xsl:otherwise>
            </xsl:choose>
         </code>
      </parentType>
   </xsl:template>
   <xsl:template name="parentTypeAttribute">
      <parentTypeAttribute>type_id</parentTypeAttribute>
   </xsl:template>
   <xsl:template match="b:descriptionList/b:description">
      <multilingualLongName>
         <xsl:call-template name="language"/>
         <xsl:call-template name="longName"/>
      </multilingualLongName>
   </xsl:template>
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