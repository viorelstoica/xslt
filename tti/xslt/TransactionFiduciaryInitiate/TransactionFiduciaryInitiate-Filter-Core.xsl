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
  <!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:FdFidOrder">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionFiduciaryInitiate'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeList/b:customerType[@index='1']"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FdFidOrder[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FdFidOrder" mode="filter1">
    <xsl:apply-templates select="self::b:FdFidOrder[(../../c:CurrentEvent/b:FdFidOrder/b:poolingStatus = 'OPEN' and not(../../c:CurrentEvent/b:FdFidOrder/b:tapRefId)) or (../../c:CurrentEvent/b:FdFidOrder/b:poolingStatus = 'APPROVED')]" mode="filter-custo"/>
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