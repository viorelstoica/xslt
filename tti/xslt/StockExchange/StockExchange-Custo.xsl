<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/StockExchange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiStockExchange" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c">
	<!-- START of protected area  -->
	<!-- END of protected area  -->
	<xsl:template name="synonym">
		<!-- BEG - JPP20240703 - add FIX_CODIF_MARKET codif for non MB-->
		<synonym>
			<code>
				<xsl:value-of select="b:id"/>
			</code>
			<codification>FIX_CODIF_MARKET</codification>
		</synonym>
		<!-- END - JPP20240703 - add FIX_CODIF_MARKET codif for non MB -->
	</xsl:template>
	<xsl:template name="dataSecuProf">
		<dataSecuProf>
			<code>
				<xsl:value-of select="'DEF_DATA_SECU_PROF'"/>
			</code>
		</dataSecuProf>
	</xsl:template>
</xsl:stylesheet>
