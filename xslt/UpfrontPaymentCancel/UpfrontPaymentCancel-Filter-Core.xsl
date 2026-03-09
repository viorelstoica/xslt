<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OpenUpfrontPaymentOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOpenUpfrontPaymentOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOpenUpfrontPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOpenUpfrontPaymentOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:OpenUpfrontPaymentOrder">
		<xsl:apply-templates select="self::b:OpenUpfrontPaymentOrder[b:transactionCode = 'UPS' and b:dealStatus = 'CANCELLED' and b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:OpenUpfrontPaymentOrder" mode="filter-custo">
		<xsl:apply-templates select="self::b:OpenUpfrontPaymentOrder" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:OpenUpfrontPaymentOrder" mode="filter-final">
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