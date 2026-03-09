<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/EsfundTraspasoRequest"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEsfundTraspasoRequest" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEsfundTraspasoRequest" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEsfundTraspasoRequest" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	
	<!-- Filter out this flow since this is only ESP(Spain) business entity specific -->
	<xsl:template name="buySellIndicator"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="channel"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="notepad"/>
	<xsl:template name="omsOrderReference"/>
	<xsl:template name="orderMode"/>
	<xsl:template name="orderPriceType"/>
	<xsl:template name="orderStatus"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="pmsOrderReference"/>
	<xsl:template name="portfolio"/>
	<xsl:template name="priceRule"/>
	<xsl:template name="quantity"/>
	<xsl:template name="remark"/>
	<xsl:template name="security"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="subType"/>
	<xsl:template name="switchFrom"/>
	<xsl:template name="switchTo"/>
	<xsl:template name="tradeType"/>
	<xsl:template name="type"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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