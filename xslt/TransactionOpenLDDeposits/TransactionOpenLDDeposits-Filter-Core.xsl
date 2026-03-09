<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDepositsOldNew" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLdLoansAndDepositsOldNew" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDepositsOldNew" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLdLoansAndDepositsOldNew" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew">
    <xsl:variable name="Previous">
      <xsl:choose>
        <xsl:when test="not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:id) or ../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:id=''">
          <xsl:value-of select="'N'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'Y'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[$Previous = 'N']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter1">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:cusPortId != '']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter2">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:memoAccount = 'NO']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter3">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:dealerBook = '' or not(b:dealerBook)]" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter4">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter5">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:status = 'CUR']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter6">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[('21001' &lt;= b:category and b:category &lt;= '21039') or ('21045' &lt;= b:category and b:category &lt;= '21049')]" mode="filter-custo"/>
  </xsl:template>
  <!-- Conditon 8 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew">
    <xsl:variable name="Flag">
      <xsl:value-of select="'F'"/>
    </xsl:variable>
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[$Flag = 'T']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:LdLoansAndDepositsOldNew" mode="filter-custo">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:LdLoansAndDepositsOldNew" mode="filter-final">
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
