<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/FxValuation" xmlns:b="http://www.temenos.com/T24/event/TTI/generateFxPositions" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- BEG - Filter for Whole record -->
	<!-- Condition 1 -->
	<xsl:template match="b:generateFxPositions">
		<xsl:apply-templates select="self::b:generateFxPositions[$PCK_GL_FWD_TEMPLATE = '1']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:generateFxPositions" mode="filter-custo">
		<xsl:apply-templates select="self::b:generateFxPositions" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:generateFxPositions" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter for Whole record -->
</xsl:stylesheet>