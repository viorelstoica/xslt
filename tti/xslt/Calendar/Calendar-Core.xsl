<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Calendar" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:param name="holidayCode" select="substring(b:holidayCode,1,4)"/>
  <xsl:template name="CalendarDate">
    <xsl:param name="mthTable"/>
    <xsl:param name="mthCount"/>
    <xsl:if test="$mthTable !=''">
      <xsl:variable name="nodes" select="//node()"/>
      <xsl:variable name="year" select="substring(b:holidayCode,5,4)"/>
      <xsl:for-each select="$nodes[position() &lt;=31]">
        <xsl:variable name="wh" select="substring($mthTable,position(),1)"/>
        <xsl:if test="$wh !='X'">
          <calendarDate>
            <date>
			  <xsl:value-of select="$year"/>
              <xsl:text>-</xsl:text>
              <xsl:number format="01" value="$mthCount"/>
              <xsl:text>-</xsl:text>
              <xsl:number format="01" value="position()"/>
            </date>
            <nature>
              <xsl:choose>
                <xsl:when test="$wh ='W'">1</xsl:when>
                <xsl:when test="$wh ='H'">2</xsl:when>
              </xsl:choose>
            </nature>
          </calendarDate>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="code">
    <xsl:variable name="holidayCode" select="substring(b:holidayCode,1,4)"/>
    <code>
      <xsl:value-of select="$holidayCode"/>
    </code>
  </xsl:template>
  <xsl:template name="shortName">
    <xsl:variable name="holidayCode" select="substring(b:holidayCode,1,4)"/>
    <shortName>
      <xsl:value-of select="$holidayCode"/>
    </shortName>
  </xsl:template>
  <xsl:template name="longName">
    <xsl:variable name="holidayCode" select="substring(b:holidayCode,1,4)"/>
    <longName>
      <xsl:value-of select="$holidayCode"/>
    </longName>
  </xsl:template>
  <xsl:template name="calendarDate">
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth01Table"/>
      <xsl:with-param name="mthCount" select="01"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth02Table"/>
      <xsl:with-param name="mthCount" select="02"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth03Table"/>
      <xsl:with-param name="mthCount" select="03"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth04Table"/>
      <xsl:with-param name="mthCount" select="04"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth05Table"/>
      <xsl:with-param name="mthCount" select="05"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth06Table"/>
      <xsl:with-param name="mthCount" select="06"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth07Table"/>
      <xsl:with-param name="mthCount" select="07"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth08Table"/>
      <xsl:with-param name="mthCount" select="08"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth09Table"/>
      <xsl:with-param name="mthCount" select="09"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth10Table"/>
      <xsl:with-param name="mthCount" select="10"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth11Table"/>
      <xsl:with-param name="mthCount" select="11"/>
    </xsl:call-template>
    <xsl:call-template name="CalendarDate">
      <xsl:with-param name="mthTable" select="b:mth12Table"/>
      <xsl:with-param name="mthCount" select="12"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="addDaysNumber"/>
  <xsl:template name="businessDateRule"/>
  <xsl:template name="nextBusinessDateRule"/>
  <xsl:template name="multilingualLongName"/>
  <xsl:template name="calendarConvention"/>
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
