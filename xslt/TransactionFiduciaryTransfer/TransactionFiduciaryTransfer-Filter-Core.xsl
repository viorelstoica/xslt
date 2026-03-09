<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrder" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrder" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!--<xsl:template match="c:CurrentEvent/b:FdFidOrder">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FdFidOrder[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>a
	</xsl:template>-->
  <!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:FdFidOrder">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionFiduciaryTransfer'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeList/b:customerType[@index='1']"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FdFidOrder[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FdFidOrder" mode="filter1">
    <xsl:apply-templates select="self::b:FdFidOrder[((../../c:PreviousEvent/b:FdFidOrder/b:transferToPort = '' or not(../../c:PreviousEvent/b:FdFidOrder/b:transferToPort)) and ../../c:CurrentEvent/b:FdFidOrder/b:transferToPort != '') or 
													(../../c:PreviousEvent/b:FdFidOrder/b:transferToPort != '' and (../../c:CurrentEvent/b:FdFidOrder/b:transferToPort = '' or not(../../c:CurrentEvent/b:FdFidOrder/b:transferToPort)) and ../../c:CurrentEvent/b:FdFidOrder/b:eventCommon/ns0:today != ../../c:PreviousEvent/b:FdFidOrder/b:transferEffDate) or 
													(../../c:PreviousEvent/b:FdFidOrder/b:transferToPort != '' and (../../c:CurrentEvent/b:FdFidOrder/b:transferToPort = '' or not(../../c:CurrentEvent/b:FdFidOrder/b:transferToPort)) and ../../c:CurrentEvent/b:FdFidOrder/b:eventCommon/ns0:today = ../../c:PreviousEvent/b:FdFidOrder/b:transferEffDate)]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FdFidOrder" mode="filter-custo">
    <xsl:apply-templates select="self::b:FdFidOrder" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FdFidOrder" mode="filter-final">
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