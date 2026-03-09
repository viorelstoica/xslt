<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/F2B"
    xmlns:b="http://www.temenos.com/T24/event/TTI/OrderAdjustStatus"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOrderAdjustStatus"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderAdjustStatus"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOrderAdjustStatus" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<xsl:template match="b:OrderAdjustStatus">
		<xsl:apply-templates select="self::b:OrderAdjustStatus[b:tapRefId and b:tapRefId != '']" mode="filter-custo"/>
	</xsl:template> 

	<!-- Custo placeholder -->
	<xsl:template match="b:OrderAdjustStatus" mode="filter-custo">
		<xsl:apply-templates select="self::b:OrderAdjustStatus" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:OrderAdjustStatus" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
