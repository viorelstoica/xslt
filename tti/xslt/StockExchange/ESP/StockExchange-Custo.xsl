<?xml version="1.0" encoding="UTF-8"?>
<!-- _@GVA$Date: 2024-05-21 18:51:04 +0200 (Tue, 21 May 2024) $@_    -->
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/StockExchange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiStockExchange" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c">

    <!-- START of protected area  -->
    
    <!-- END of protected area  -->

	<xsl:template name="synonym">
		<!-- BEG CORE -->
		<xsl:if test="b:mktIdnCode and b:mktIdnCode != ''">
			<synonym>
				<xsl:call-template name="active_Stock"/>
				<xsl:call-template name="beginDate_Stock"/>
				<code>
					<xsl:value-of select="b:mktIdnCode"/>
				</code>
				<codification>
					<xsl:value-of select="'PCK_MB_EUR_MIC_CODE'"/>
				</codification>
				<xsl:call-template name="endDate_Stock"/>
				<xsl:call-template name="status_Stock"/>
				<xsl:call-template name="mbFields_Stock"/>
			</synonym>
		</xsl:if>
		<!-- END CORE -->

		<!-- BEG - JPP20240529 - add FIX_CODIF_MARKET codif -->
		<synonym>
			<code>
				<xsl:value-of select="b:id"/>
			</code>
			<codification>FIX_CODIF_MARKET</codification>
		</synonym>
		<!-- END - JPP20240529 - add FIX_CODIF_MARKET codif -->
	</xsl:template>
	
</xsl:stylesheet>