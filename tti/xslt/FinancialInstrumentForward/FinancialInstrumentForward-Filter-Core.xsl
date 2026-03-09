<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentForex"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentForex" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FinancialInstrumentForex">
		<xsl:apply-templates select="self::b:FinancialInstrumentForex[substring(b:dealType,1,2) = 'FW']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<!-- if PCK_GL_FWD_TEMPLATE=1 is true, then pass record only if baseCurrency = currencySold(buy) or  baseCurrency = currencyBought (sell) -->
	<xsl:template match="b:FinancialInstrumentForex" mode="filter1">
		<xsl:apply-templates select="self::b:FinancialInstrumentForex[not($PCK_GL_FWD_TEMPLATE=1 and (not(b:baseCcy = b:currencySold) and not(b:baseCcy = b:currencyBought)))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FinancialInstrumentForex" mode="filter-custo">
		<xsl:apply-templates select="self::b:FinancialInstrumentForex" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:FinancialInstrumentForex" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>