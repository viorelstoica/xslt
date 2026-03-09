<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrderNotification"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPaymentOrderNotification" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrderNotification" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrderNotification" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--RNJ-MIR - Filter out EAMOTHERDR, EAMOTHERCR, TRAILERFEE  Investment operations-->	
		<xsl:template match="b:PaymentOrderNotification" mode="filter-custo">
			<xsl:apply-templates select="self::b:PaymentOrderNotification[ b:paymentOrderProduct != 'TRAILERFEE' and b:paymentOrderProduct != 'EAMOTHERDR' and b:paymentOrderProduct !='EAMOTHERCR' and b:paymentOrderProduct !='EAMSIC' and b:paymentOrderProduct !='EAMEUROSIC' and b:paymentOrderProduct !='EAMSEPA' and b:paymentOrderProduct !='EAMSWIFT']" mode="filter-final"/>
		</xsl:template>				
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->