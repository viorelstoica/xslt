<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/STBuyActualSettlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSTBuyActualSettlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSTBuyActualSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSTBuyActualSettlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:STBuyActualSettlement">
    <xsl:variable name="opStatus">
      <xsl:call-template name="operationStatus">
        <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
        <xsl:with-param name="recordStatus" select="b:recordStatus"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="self::b:STBuyActualSettlement[$opStatus = 'INPUT-AUTHORISE' or $opStatus = 'AUTHORISE' or $opStatus = 'JOB-PROCESS']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:STBuyActualSettlement" mode="filter1">
    <xsl:apply-templates select="self::b:STBuyActualSettlement[contains($securityTransferInSupportedTypes,b:transactionType)]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:STBuyActualSettlement" mode="filter2">
    <xsl:apply-templates select="self::b:STBuyActualSettlement[b:deliveryInstr = 'DAP']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:STBuyActualSettlement" mode="filter-custo">
    <xsl:apply-templates select="self::b:STBuyActualSettlement" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:STBuyActualSettlement" mode="filter-final">
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