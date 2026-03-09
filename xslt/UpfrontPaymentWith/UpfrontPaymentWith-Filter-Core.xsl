<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/UpfrontPaymentWith" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchUpfrontPaymentWith" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiUpfrontPaymentWith" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiUpfrontPaymentWith" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b" version="1.0">
    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:UpfrontPaymentWith">
		<xsl:apply-templates select="self::b:UpfrontPaymentWith[b:transactionCode = 'UPS' and b:dealStatus = 'TRANSMITTED' and (not(b:orderStatus) or b:orderStatus != 'Cancellation Requested')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:UpfrontPaymentWith" mode="filter-custo">
		<xsl:apply-templates select="self::b:UpfrontPaymentWith" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:UpfrontPaymentWith" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
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