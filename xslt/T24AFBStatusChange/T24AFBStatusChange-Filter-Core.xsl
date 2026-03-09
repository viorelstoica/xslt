<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/F2B" xmlns:b="http://www.temenos.com/T24/event/TTI/T24AFBStatusChange" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchT24AFBStatusChange"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiT24AFBStatusChange" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiT24AFBStatusChange"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Filter out this flow since this is only ESP(Spain) business entity specific -->
	<xsl:template match="b:T24AFBStatusChange">
		<xsl:apply-templates select="self::b:T24AFBStatusChange[0]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:T24AFBStatusChange" mode="filter-custo">
		<xsl:apply-templates select="self::b:T24AFBStatusChange" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:T24AFBStatusChange" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
</metaInformation>
-->