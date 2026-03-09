<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/CginventoryAll"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCginventoryAll" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCginventoryAll" 
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCginventoryAll" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:CginventoryAll">
		<xsl:apply-templates select="self::b:CginventoryAll[not(b:ownCompId)]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:CginventoryAll" mode="filter1">
		<xsl:variable name="assetType" select="substring-after(substring-after(b:id,'.'),'.')"/>
		<xsl:apply-templates select="self::b:CginventoryAll[((starts-with($assetType,'S-')) or (starts-with($assetType,'A-')) or (starts-with($assetType,'ALL')))]" mode="filter2"/>
	</xsl:template>
	<xsl:template match="b:CginventoryAll" mode="filter2">
		<xsl:variable name="cgMethod" select="b:cgMethodGroup[@index=1]/b:cgMethod"/>
		<xsl:apply-templates select="self::b:CginventoryAll[($cgMethod = 'AVERAGE' or $cgMethod = 'FIFO' or $cgMethod = 'LIFO' or $cgMethod = 'HIGHEST.COST' or $cgMethod = 'LOWEST.COST' or $cgMethod = 'MAX.GAIN' or $cgMethod = 'MIN.GAIN')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:CginventoryAll" mode="filter-custo">
		<xsl:apply-templates select="self::b:CginventoryAll" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:CginventoryAll" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>