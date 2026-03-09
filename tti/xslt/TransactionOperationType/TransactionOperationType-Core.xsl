<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionOperationType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionOperationType" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
  <xsl:template name="code">
    <code>
      <xsl:choose>
        <xsl:when test="$POSTFIX_TROPTYPE = 'Y' ">
          <xsl:value-of select="concat('TR_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('TR_',b:id)"/>
        </xsl:otherwise>
      </xsl:choose>
    </code>
  </xsl:template>
  <xsl:template name="shortName">
    <shortName>
      <xsl:value-of select="b:narrativeList/b:narrative[@language=$boDefaultLanguage]"/>
    </shortName>
  </xsl:template>
  <xsl:template name="multilingualLongName">
    <xsl:for-each select="b:narrativeList/b:narrative">
      <xsl:variable name="currentLanguage" select="@language"/>
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
      <xsl:with-param name="CurrentEvent" select="./b:narrativeList/b:narrative"/>
      <xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:TransactionOperationType/b:narrativeList/b:narrative"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="attribute">
    <attribute>type_id</attribute>
  </xsl:template>
  <xsl:template name="nature">
    <nature>0</nature>
  </xsl:template>
  <xsl:template name="synonym"/>
  <xsl:template name="longName"/>
  <xsl:template name="notepad"/>
  <xsl:template name="userDefinedField"/>
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
