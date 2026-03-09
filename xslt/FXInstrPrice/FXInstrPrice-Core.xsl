<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/FxValuation" xmlns:b="http://www.temenos.com/T24/event/TTI/generateFxPositions" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">

	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:choose>
					<xsl:when test="ns1:tapRefId and ns1:tapRefId != ''">
						<xsl:value-of select="ns1:tapRefId"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select="ns1:SecurityCcy"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="value">
		<xsl:param name="quotationCode1"/>
		<xsl:param name="PowResult">	
		<xsl:call-template name="Pow">
			<xsl:with-param name="Base" select="10"/>
			<xsl:with-param name="Exponent" select="$quotationCode1"/>
			<xsl:with-param name="powerofn" select="1"/>
			<!-- Always set to 1 when Pow() function is used. -->
		</xsl:call-template>
		</xsl:param>
		<xsl:param name="quotationCode2"/>
		<xsl:param name="PowResult2">	
		<xsl:call-template name="Pow">
			<xsl:with-param name="Base" select="10"/>
			<xsl:with-param name="Exponent" select="$quotationCode2"/>
			<xsl:with-param name="powerofn" select="1"/>
			<!-- Always set to 1 when Pow() function is used. -->
		</xsl:call-template>
		</xsl:param>
		<xsl:param name="quotationCode" select="format-number($PowResult2 div $PowResult,$decimalformat,'nan2zero')"/>
		<value>
			<xsl:value-of select="ns1:marketPrice"/>
		</value>
	</xsl:template>

	<xsl:template name="Pow">
		<xsl:param name="Base"/>
		<xsl:param name="Exponent"/>
		<xsl:param name="powerofn"/>
		<xsl:choose>
			<xsl:when test="$Exponent = 0">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="$Exponent = 1">
				<xsl:value-of select="$powerofn * $Base"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Pow">
					<xsl:with-param name="Base" select="$Base"/>
					<xsl:with-param name="Exponent" select="$Exponent - 1"/>
					<xsl:with-param name="powerofn" select="$powerofn * $Base"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="quotationDate">
		<xsl:if test="../../b:eventCommon/ns0:today and ../../b:eventCommon/ns0:today != ''">
			<quotationDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="../../b:eventCommon/ns0:today"/>
				</xsl:call-template>
			</quotationDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stockExchange"/>
	<xsl:template name="valueType"/>
	<xsl:template name="valueTermType"/>
	<xsl:template name="priceCalculationRule"/>
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