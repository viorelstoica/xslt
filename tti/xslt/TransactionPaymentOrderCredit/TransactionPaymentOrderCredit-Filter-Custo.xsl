<?xml version="1.0"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPaymentOrder"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrder"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrder"
    xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--RNJ-MIR - Filter out TRAILERFEE Investment operations-->			
	<xsl:template match="b:PaymentOrder" mode="filter-custo">
		<xsl:apply-templates select="self::b:PaymentOrder[(b:paymentOrderProduct != 'TRAILERFEE' and b:paymentOrderProduct != 'EAMOTHERDR' and b:paymentOrderProduct != 'EAMOTHERCR' and b:paymentOrderProduct !='EAMSIC' and b:paymentOrderProduct !='EAMEUROSIC' and b:paymentOrderProduct !='EAMSEPA' and b:paymentOrderProduct !='EAMSWIFT')]" mode="filter-custo1"/>
	</xsl:template>
    
	<!-- BEG - JPP20240705 - filter if quantity is null -->
	<xsl:template match="b:PaymentOrder" mode="filter-custo1">
		<xsl:apply-templates select="self::b:PaymentOrder[b:creditAmount and b:creditAmount!='']" mode="filter-final"/>
	</xsl:template>
	<!-- END - JPP20240705 - filter if quantity is null -->

</xsl:stylesheet>
