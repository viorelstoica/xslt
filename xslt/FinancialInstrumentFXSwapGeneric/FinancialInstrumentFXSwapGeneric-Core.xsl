<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="'SW_'"/>
			<xsl:value-of select="b:swapBaseCcy"/>
			<xsl:value-of select="'/'"/>
			<xsl:if test="b:swapBaseCcy = b:currencyBought">
				<xsl:value-of select="b:currencySold"/>
			</xsl:if>
			<xsl:if test="b:swapBaseCcy != b:currencyBought">
				<xsl:value-of select="b:currencyBought"/>
			</xsl:if>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:value-of select="'SW_'"/>
			<xsl:value-of select="b:swapBaseCcy"/>
			<xsl:value-of select="'/'"/>
			<xsl:if test="b:swapBaseCcy = b:currencyBought">
				<xsl:value-of select="b:currencySold"/>
			</xsl:if>
			<xsl:if test="b:swapBaseCcy != b:currencyBought">
				<xsl:value-of select="b:currencyBought"/>
			</xsl:if>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<infra:longName>
			<xsl:value-of select="'SW_'"/>
			<xsl:value-of select="b:swapBaseCcy"/>
			<xsl:value-of select="'/'"/>
			<xsl:if test="b:swapBaseCcy = b:currencyBought">
				<xsl:value-of select="b:currencySold"/>
			</xsl:if>
			<xsl:if test="b:swapBaseCcy != b:currencyBought">
				<xsl:value-of select="b:currencyBought"/>
			</xsl:if>
		</infra:longName>
	</xsl:template>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>22</priceCalculationRule>
	</xsl:template>
	<xsl:template name="currencyReceived">
		<currencyReceived>
			<infra:code>
				<xsl:value-of select="b:swapBaseCcy"/>
			</infra:code>
		</currencyReceived>
	</xsl:template>
	<xsl:template name="currencyPaid">
		<currencyPaid>
			<infra:code>
				<xsl:if test="b:swapBaseCcy = b:currencyBought">
					<xsl:value-of select="b:currencySold"/>
				</xsl:if>
				<xsl:if test="b:swapBaseCcy != b:currencyBought">
					<xsl:value-of select="b:currencyBought"/>
				</xsl:if>
			</infra:code>
		</currencyPaid>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'FX_SW'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule">
		<valuationRule>5</valuationRule>
	</xsl:template>
	<xsl:template name="generic">
		<generic>1</generic>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="active"/>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="paidLegYieldCurve"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
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