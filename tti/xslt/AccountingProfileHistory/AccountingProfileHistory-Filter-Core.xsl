<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Cginventory"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCginventory" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCginventory" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCginventory" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:Cginventory">
		<xsl:apply-templates select="self::b:Cginventory[(b:ownCompId and b:ownCompId !='')]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:Cginventory" mode="filter1">
		<xsl:variable name="assetType" select="substring-after(substring-after(b:id,'.'),'.')"/>
		<xsl:apply-templates select="self::b:Cginventory[((starts-with($assetType,'S-')) or (starts-with($assetType,'A-')) or (starts-with($assetType,'ALL')))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:Cginventory" mode="filter2">
		<xsl:variable name="portId" select="substring-before(substring-after(b:id,'.'),'.')"/>
		<xsl:apply-templates select="self::b:Cginventory[$portId != 'ALL']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:Cginventory" mode="filter-custo">
		<xsl:apply-templates select="self::b:Cginventory" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:Cginventory" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>