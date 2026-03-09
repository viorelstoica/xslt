<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DerivativeConversion" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="market">
		<xsl:param name="TradeIndex"/>
		<market>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,//b:dxExchangeMnemonic[@index=$TradeIndex])"/>
			</infra:code>
		</market>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
