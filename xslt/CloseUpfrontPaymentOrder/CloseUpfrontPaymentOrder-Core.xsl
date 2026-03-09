<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CloseUpfrontPaymentOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCloseUpfrontPaymentOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCloseUpfrontPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCloseUpfrontPaymentOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="concat(b:customerNoGroup/b:cuOrderNosList/b:cuOrderNos,$COMPANY_POSTFIX_SEPARATOR,b:customerNoGroup/b:customerNo,$COMPANY_POSTFIX_SEPARATOR,b:customerNoGroup/b:custSecAcc,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
		</code>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
		<infra:code>
			<xsl:value-of select="b:custAccNoSecOpenOrderGroup/b:custAccNoSecOpenOrderSubGroup/b:custAccNoSecOpenOrder"/>
		</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
		<infra:code>
			<xsl:value-of select="b:customerNoGroup/b:custSecAcc"/>
		</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:customerNoGroup/b:cuGrossAmSec"/>
		</quantity>
	</xsl:template>
	<xsl:template name="exDate"/>
	<xsl:template name="endDate">
		<endDate>
			<xsl:value-of select="b:tradeDate"/>
		</endDate>
	</xsl:template>
	<xsl:template name="nature">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
	</xsl:template>
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