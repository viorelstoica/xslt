<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Currency" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCurrency" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
  <xsl:template name="code_Currency">
    <code>
      <xsl:value-of select="b:currencyCode"/>
    </code>
  </xsl:template>
  <xsl:template name="synonym_Currency">
    <xsl:if test="b:numericCcyCode and b:numericCcyCode !=''">
      <synonym>
        <code>
          <xsl:value-of select="b:numericCcyCode"/>
        </code>
        <codification>NUM_ISO_4217</codification>
      </synonym>
    </xsl:if>
    <xsl:variable name="currentEvent" select="."/>
    <xsl:if test="../../c:PreviousEvent/b:Currency/b:numericCcyCode and ($currentEvent/b:numericCcyCode= '' or not($currentEvent/b:numericCcyCode) )">
      <synonym mode="delete">
        <code>
          <xsl:value-of select="../../c:PreviousEvent/b:Currency/b:numericCcyCode"/>
        </code>
        <codification>NUM_ISO_4217</codification>
      </synonym>
    </xsl:if>
  </xsl:template>
  <xsl:template name="shortName_Currency">
    <shortName>
      <xsl:value-of select="b:ccyNameList/b:ccyName[@language=$boDefaultLanguage]"/>
    </shortName>
  </xsl:template>
  <xsl:template name="longName_Currency">
    <longName>
      <xsl:value-of select="b:ccyNameList/b:ccyName[@language=$boDefaultLanguage]"/>
    </longName>
  </xsl:template>
  <xsl:template name="multilingualLongName_Currency">
    <xsl:for-each select="b:ccyNameList/b:ccyName">
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
      <xsl:with-param name="CurrentEvent" select="./b:ccyNameList/b:ccyName"/>
      <xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:Currency/b:ccyNameList/b:ccyName"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="country_Currency">
    <country>
      <code>
        <xsl:value-of select="b:countryCode"/>
      </code>
    </country>
  </xsl:template>
  <xsl:template name="euroConvertionDate_Currency">
    <xsl:variable name="EUROINRate">
      <xsl:call-template name="euroinRate">
        <xsl:with-param name="ISOcurrency" select="b:currencyCode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="b:companyLocalCurrency = 'EUR' and $EUROINRate != ''">
      <euroConvertionDate>
        <xsl:call-template name="euroinDate">
          <xsl:with-param name="ISOcurrency" select="b:currencyCode"/>
        </xsl:call-template>
      </euroConvertionDate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="euroExchangeRate_Currency">
    <xsl:variable name="EUROINRate">
      <xsl:call-template name="euroinRate">
        <xsl:with-param name="ISOcurrency" select="b:currencyCode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="b:companyLocalCurrency = 'EUR' and $EUROINRate != ''">
      <euroExchangeRate>
        <xsl:call-template name="euroinRate">
          <xsl:with-param name="ISOcurrency" select="b:currencyCode"/>
        </xsl:call-template>
      </euroExchangeRate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="rank_Currency">
    <rank>
      <xsl:value-of select="b:rank"/>
    </rank>
  </xsl:template>
  <xsl:template name="roundingRule_Currency">
    <roundingRule>
      <xsl:value-of select="b:minRoundType"/>
    </roundingRule>
  </xsl:template>
  <xsl:template name="roundingUnit_Currency">
    <roundingUnit>
      <xsl:call-template name="roundingunitTranslation">
        <xsl:with-param name="boRoundingunit" select="b:noOfDecimals"/>
      </xsl:call-template>
    </roundingUnit>
  </xsl:template>
  <xsl:template name="notepad_Currency"/>
  <xsl:template name="userDefinedField_Currency"/>
  <xsl:template name="mbFields_Currency"/>
  <xsl:template name="code_Country">
    <code>
      <xsl:value-of select="b:countryCode"/>
    </code>
  </xsl:template>
  <xsl:template name="userDefinedField_Country"/>
  <xsl:template name="mbFields_Country"/>
  <xsl:template name="currency_Country">
    <currency>
      <code>
        <xsl:value-of select="b:currencyCode"/>
      </code>
    </currency>
  </xsl:template>
  <xsl:template name="nature_Country">
    <nature>1</nature>
  </xsl:template>
  <xsl:template name="synonym_Country"/>
  <xsl:template name="shortName_Country"/>
  <xsl:template name="longName_Country"/>
  <xsl:template name="multilingualLongName_Country"/>
  <xsl:template name="notepad_Country"/>
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
