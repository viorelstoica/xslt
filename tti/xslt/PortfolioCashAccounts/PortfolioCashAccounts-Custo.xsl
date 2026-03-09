<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PortfolioCashAccounts"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolioCashAccounts" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolioCashAccounts" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioCashAccounts" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->

	<!-- END of protected area  -->

	<!-- BEG - JPB/JPP20240827 - add type for _CAPITAL - Type missing when the cash account is created by PortfolioCashAccount and not CashAccount-->
	<xsl:template name="t1-type">
    	<xsl:variable name="index" select="./@index"/>
	    <type>
	        <infra:code>
	            <xsl:value-of select="../b:accountNosCategoryJoinList/b:accountNosCategoryJoin[@index=number($index)]"/>
	        </infra:code>
	    </type>
	</xsl:template>
	<!-- END - JPB/JPP20240827 - add type for _CAPITAL - Type missing when the cash account is created by PortfolioCashAccount and not CashAccount-->


</xsl:stylesheet>
