<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentOptionDxCo" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentOptionDxCo" xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c d" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="mainStockExchange">
		<xsl:param name="index"/>
		<mainStockExchange>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX, b:dxExchangeMnemonic)"/>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
