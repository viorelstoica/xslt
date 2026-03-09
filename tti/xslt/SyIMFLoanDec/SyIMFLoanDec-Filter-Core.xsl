<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImfRollover" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyImfRollover" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyImfRollover" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyImfRollover" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:SyImfRollover">
    <xsl:variable name="loanAmount" select="b:loanAmt"/>
    <xsl:apply-templates select="self::b:SyImfRollover[../../c:PreviousEvent/b:SyImfRollover/b:loanAmt &gt; ../../c:CurrentEvent/b:SyImfRollover/b:loanAmt]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:SyImfRollover" mode="filter1">
    <xsl:apply-templates select="self::b:SyImfRollover[b:rolloverType = 'PRINCIPAL']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:SyImfRollover" mode="filter2">
    <xsl:apply-templates select="self::b:SyImfRollover[b:contractStatus = 'ACTIVE']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:SyImfRollover" mode="filter3">
    <xsl:apply-templates select="self::b:SyImfRollover[b:loanPrinAdjust != '']" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:SyImfRollover" mode="filter4">
    <xsl:variable name="check_MaturityDate">
      <xsl:choose>
        <xsl:when test="string-length(b:maturityDate) ='8'">
          <xsl:value-of select="b:maturityDate"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(translate(b:maturityDate,'-',''),1,8)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="check_toDay">
      <xsl:choose>
        <xsl:when test="string-length(b:eventCommon/ns0:today) ='8'">
          <xsl:value-of select="b:eventCommon/ns0:today"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(translate(b:eventCommon/ns0:today,'-',''),1,8)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:SyImfRollover[number($check_MaturityDate) &gt;= number($check_toDay)]" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="b:SyImfRollover" mode="filter5">
    <xsl:apply-templates select="self::b:SyImfRollover[b:portfolio != '']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="b:SyImfRollover" mode="filter6">
    <xsl:apply-templates select="self::b:SyImfRollover[b:dealerBook = '' or not(b:dealerBook)]" mode="filter7"/>
  </xsl:template>
  <!-- Condition 8 -->
  <xsl:template match="b:SyImfRollover" mode="filter7">
    <xsl:apply-templates select="self::b:SyImfRollover[b:memoAccount = 'NO']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:SyImfRollover" mode="filter-custo">
    <xsl:apply-templates select="self::b:SyImfRollover" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:SyImfRollover" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
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
