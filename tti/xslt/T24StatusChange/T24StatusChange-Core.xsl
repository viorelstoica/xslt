<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/T24StatusChange"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchT24StatusChange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiT24StatusChange" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiT24StatusChange" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="amountOrderIndicator">
		<amountOrderIndicator>1</amountOrderIndicator>
	</xsl:template>
	<xsl:template name="omsOrderReference">
		<omsOrderReference>
			<xsl:value-of select="b:id"/>
		</omsOrderReference>
	</xsl:template>
	<xsl:template name="orderStatus">
		<orderStatus>
			<xsl:choose>
				<xsl:when test="b:dealStatus = 'TRANSMITTED'">
					<xsl:value-of select="'70'"/>
				</xsl:when>
				<xsl:when test="b:dealStatus = 'CANCELLED'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
			</xsl:choose>
		</orderStatus>
	</xsl:template>
	<xsl:template name="pmsOrderReference">
		<pmsOrderReference>
			<xsl:value-of select="b:tapRefId"/>
		</pmsOrderReference>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:secAccNoGroup/b:secAccNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<infra:name>account</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:tapSleeveAcc and b:tapSleeveAcc != ''">
						<xsl:value-of select="b:tapSleeveAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:custAccNoGroup/b:custAccNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
			<infra:type>string</infra:type>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="mbFields"/>
	<xsl:template name="amountOrder"/>
	<xsl:template name="buySellIndicator"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="channel"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="notepad"/>
	<xsl:template name="orderMode"/>
	<xsl:template name="orderPriceType"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="priceRule"/>
	<xsl:template name="quantity"/>
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