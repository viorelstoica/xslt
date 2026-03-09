<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerDocument" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerDocument" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerDocument"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerDocument" xmlns:infra="http://www.odcgroup.com/InfraPMS">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<xsl:template match="b:CustomerDocument">
		<xsl:apply-templates select="self::b:CustomerDocument[(b:status != '2')]" mode="filter-custo"/>	
	</xsl:template>
	
	<!-- Custo placeholder -->
	
	<xsl:template match="b:CustomerDocument" mode="filter-custo">
		<xsl:apply-templates select="self::b:CustomerDocument" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:CustomerDocument" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>