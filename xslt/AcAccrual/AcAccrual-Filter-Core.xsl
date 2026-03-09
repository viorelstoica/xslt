<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/AcAccrual/AcAccrual" xmlns:batch="http://www.temenos.com/T24/event/AcAccrual/BatchAcAccrual" xmlns:c="http://www.temenos.com/T24/event/AcAccrual/MultiAcAccrual" xmlns:d="http://www.temenos.com/T24/AccountingEventsService/AcAccountAccruals" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/AcAccrual/BatchMultiAcAccrual" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:accountaccruals">
    <xsl:variable name="TotalAccr" select="format-number(sum(d:debitIntAccruals/d:accrIntAmount) + sum(d:debitInt2Accruals/d:accrIntAmount) + sum(d:creditIntAccruals/d:accrIntAmount) + sum(d:creditInt2Accruals/d:accrIntAmount),$decimalformat,'nan2zero')"/>
    <xsl:apply-templates select="self::b:accountaccruals[$TotalAccr != 0]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:accountaccruals" mode="filter-custo">
    <xsl:apply-templates select="self::b:accountaccruals" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:accountaccruals" mode="filter-final">
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