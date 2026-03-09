<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DxStockExchange" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<!-- START of protected area  -->
	<!-- END of protected area  -->
	<xsl:template name="code">
		<!-- BEG - JPP20240904 - TSR-881979 - FIX_CODIF_MARKET with mnemonic for DX -->
		<code>
			<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:mnemonic)"/>
		</code>
		<!-- END - JPP20240904 - TSR-881979 - FIX_CODIF_MARKET with mnemonic for DX -->
	</xsl:template>
	<xsl:template name="synonym">
		<!-- BEG - JPP20240904 - TSR-881979 - FIX_CODIF_MARKET with mnemonic for DX -->
		<synonym>
			<code>
				<xsl:value-of select="b:mnemonic"/>
			</code>
			<codification>FIX_CODIF_MARKET</codification>
		</synonym>
		<!-- END - JPP20240904 - TSR-881979 - FIX_CODIF_MARKET with mnemonic for DX -->
	</xsl:template>
	<xsl:template name="dayTrade">
		<dayTrade>
			<xsl:choose>
				<xsl:when test="b:dayTrade = 'YES'">1</xsl:when>
				<xsl:when test="b:dayTrade = 'NO'">2</xsl:when>
			</xsl:choose>
		</dayTrade>
	</xsl:template>
	<xsl:template name="dataSecuProf">
		<dataSecuProf>
			<code>
				<xsl:value-of select="'DEF_DATA_SECU_PROF'"/>
			</code>
		</dataSecuProf>
	</xsl:template>
</xsl:stylesheet>
