<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OpenUpfrontPaymentOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOpenUpfrontPaymentOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOpenUpfrontPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOpenUpfrontPaymentOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:custNumberGroup/b:custNumber,$COMPANY_POSTFIX_SEPARATOR,b:custNumberGroup/b:securityAccnt,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
		</code>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="linkedInstrument">
		<linkedInstrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</linkedInstrument>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:custNumberGroup/b:cuCashAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="exDate">
		<exDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="endDate"/>
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