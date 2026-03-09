<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferPtfToPtfInvReversal" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferPtfToPtfInvReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferPtfToPtfInvReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferPtfToPtfInvReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <!-- Condition 2 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal">
    <xsl:variable name="opStatus">
      <xsl:call-template name="operationStatus">
        <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
        <xsl:with-param name="recordStatus" select="b:recordStatus"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[$opStatus = 'REVERSE-AUTHORISE']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter1">
    <xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[b:secAcctFrom and b:secAcctFrom != '']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter2">
    <xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[b:secAcctTo and b:secAcctTo != '']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter3">
    <xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[b:secAcctTo != b:secAcctFrom]" mode="filter4"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter4">
    <xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[(not(b:depositoryFrom) or b:depositoryFrom = '' and (not(b:depositoryTo) or b:depositoryTo = '') or (b:depositoryFrom and b:depositoryTo and (b:depositoryFrom = b:depositoryTo)))]" mode="filter5"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter5">
	<xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[b:secAcctFromMemoAccount != 'NO' or (b:secAcctFromDealerBook and b:secAcctFromDealerBook != '') or b:secAcctFromCustomerTypeJoinList/b:secAcctFromCustomerTypeJoin != 'CUSTOMER']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 8 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter6">
	<xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[b:secAcctToMemoAccount = 'NO']" mode="filter7"/>
  </xsl:template>
  <!-- Condition 9 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter7">
	<xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[not(b:secAcctToDealerBook)]" mode="filter8"/>
  </xsl:template>
  <!-- Condition 10 -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter8">
	<xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal[b:secAcctToCustomerTypeJoinList/b:secAcctToCustomerTypeJoin = 'CUSTOMER']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter-custo">
    <xsl:apply-templates select="self::b:PositionTransferPtfToPtfInvReversal" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:PositionTransferPtfToPtfInvReversal" mode="filter-final">
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