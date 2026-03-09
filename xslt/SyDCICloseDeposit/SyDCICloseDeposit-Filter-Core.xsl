<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDci" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyDci" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyDci" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyDci" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:SyDci">
    <xsl:apply-templates select="self::b:SyDci[b:contractStatus = 'MATURED']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:SyDci" mode="filter1">
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
    <xsl:apply-templates select="self::b:SyDci[number($check_MaturityDate) &gt;= number($check_toDay)]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:SyDci" mode="filter2">
    <xsl:apply-templates select="self::b:SyDci[b:portfolio != '']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 - Portfolio Filter -->
	<xsl:template match="b:SyDci" mode="filter3">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'SyDCICloseDeposit'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeList/b:customerType"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SyDci[$checkPortfolioConditionVar = 'true']" mode="filter-custo"/>
	</xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:SyDci" mode="filter-custo">
    <xsl:apply-templates select="self::b:SyDci" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:SyDci" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
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