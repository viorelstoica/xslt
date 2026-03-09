<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="dataNature_C">
		<dataNature>
			<xsl:value-of select="$pledgedCreditRate"/>
		</dataNature>
	</xsl:template>
	<xsl:template name="instrument_C">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="value_C">
		<value>
			<xsl:choose>
				<xsl:when test="b:marginRateMarginControlJoin and b:marginRateMarginControlJoin != ''">
					<xsl:value-of select="b:marginRateMarginControlJoin"/>
				</xsl:when>
				<xsl:when test="b:subAssetTypeMarginRateJoin and b:subAssetTypeMarginRateJoin != ''">
					<xsl:value-of select="b:subAssetTypeMarginRateJoin"/>
				</xsl:when>
				<xsl:when test="b:assetTypeMarginRateJoin and b:assetTypeMarginRateJoin != ''">
					<xsl:value-of select="b:assetTypeMarginRateJoin"/>
				</xsl:when>
			</xsl:choose>
		</value>
	</xsl:template>
	<xsl:template name="currency_C"/>
	<xsl:template name="validity_C"/>
	<xsl:template name="provider_C"/>
	<xsl:template name="valueType_C"/>
	<xsl:template name="mbFields_C"/>
	<xsl:template name="dataNature_D">
		<dataNature>
			<xsl:value-of select="$pledgedDebitRate"/>
		</dataNature>
	</xsl:template>
	<xsl:template name="instrument_D">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="value_D">
		<value>
			<xsl:choose>
				<xsl:when test="b:marginRateMarginControlLossJoin and b:marginRateMarginControlLossJoin != ''">
					<xsl:value-of select="b:marginRateMarginControlLossJoin"/>
				</xsl:when>
				<xsl:when test="b:subAssetTypeMarginRateJoin and b:subAssetTypeMarginRateJoin != ''">
					<xsl:value-of select="b:subAssetTypeMarginRateJoin"/>
				</xsl:when>
				<xsl:when test="b:assetTypeMarginRateJoin and b:assetTypeMarginRateJoin != ''">
					<xsl:value-of select="b:assetTypeMarginRateJoin"/>
				</xsl:when>
			</xsl:choose>
		</value>
	</xsl:template>
	<xsl:template name="currency_D"/>
	<xsl:template name="validity_D"/>
	<xsl:template name="provider_D"/>
	<xsl:template name="valueType_D"/>
	<xsl:template name="mbFields_D"/>
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