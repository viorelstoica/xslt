<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrderCob" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrderCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrderCob" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrderCob" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:FdFidOrderCob">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'FinInstrumentCloseFiduciaryCob'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeList/b:customerType[@index='1']"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FdFidOrderCob[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FdFidOrderCob" mode="filter1">
    <xsl:apply-templates select="self::b:FdFidOrderCob[b:fidType = 'NOTICE']" mode="filter2"/>
  </xsl:template>

  <!-- Condition 3-->
  <xsl:template match="b:FdFidOrderCob" mode="filter2">
    <xsl:apply-templates select="self::b:FdFidOrderCob[b:orderStatus = 'LIQ']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FdFidOrderCob" mode="filter-custo">
    <xsl:apply-templates select="self::b:FdFidOrderCob" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FdFidOrderCob" mode="filter-final">
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