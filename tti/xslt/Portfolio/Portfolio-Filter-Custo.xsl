<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Portfolio"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolio" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolio" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolio" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->

	<!-- END of protected area  -->

	<!-- Custo placeholder -->
	<!-- BEG - JPP/AFU20241107 - filter ptf ownCompId = b:portCompId - Dealer book issue-->
	<xsl:template match="b:Portfolio" mode="filter-custo">
		<xsl:apply-templates select="self::b:Portfolio[b:ownCompId != b:portCompId]" mode="filter-final"/>
	</xsl:template>
	<!-- END - JPP/AFU20241107 - filter ptf ownCompId = b:portCompId - Dealer book issue-->

</xsl:stylesheet>