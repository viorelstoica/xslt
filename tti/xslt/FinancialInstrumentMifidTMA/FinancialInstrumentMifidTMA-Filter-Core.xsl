<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MIFID"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMIFID" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMIFID" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:MIFID">
		<xsl:apply-templates select="self::b:MIFID[b:tmaRefDate and b:tmaRefDate!='']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:MIFID" mode="filter-custo">
		<xsl:apply-templates select="self::b:MIFID" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:MIFID" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>