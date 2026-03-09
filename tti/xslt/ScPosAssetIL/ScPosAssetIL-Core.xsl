<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScPosAsset"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScPosAsset" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScPosAsset" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScPosAsset"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	
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

	<xsl:template name="code">
		<xsl:param name="index" select="@index"/>
		<xsl:param name="tapRefId" select="../b:tapRefIdList/b:tapRefId[@index = $index]"/>
		<xsl:param name="companyMnenomic" select="../b:companyMnenomicList/b:companyMnenomic[@index = $index]"/>
		<attribute name="code">
			<xsl:choose>
				<xsl:when test="$tapRefId and $tapRefId != ''">
					<xsl:value-of select="$tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:securityNo,$COMPANY_POSTFIX_SEPARATOR,$companyMnenomic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</attribute>
	</xsl:template>
	<xsl:template name="splitFxRateAndCurrency">
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
		<xsl:param name="costPrice" select="format-number(b:costPrice,$decimalformat,'nan2zero')"/>
		<attribute name="split_fx_rate_n">
			<xsl:choose>
				<xsl:when test="$quotationCode2 = '0'">
					<xsl:value-of select="format-number($costPrice * $quotationCode,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$costPrice"/>
				</xsl:otherwise>
			</xsl:choose>
		</attribute>
		<attribute name="split_currency_code">
			<xsl:value-of select="b:securityCcy"/>
		</attribute>
	</xsl:template>
	<xsl:template name="splitFxRate1AndCurrency1">
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
		<xsl:param name="securityNo" select="b:securityNo"/>
		<xsl:param name="index" select="@index"/>
		<xsl:param name="index2" select="../b:securityNoGroup[@index &lt; $index and b:securityNo = $securityNo]/@index"/>
		<xsl:param name="costPrice" select="format-number(../b:securityNoGroup[@index = $index2]/b:costPrice,$decimalformat,'nan2zero')"/>
		<xsl:param name="securityCcy" select="../b:securityNoGroup[@index = $index2]/b:securityCcy"/>
		<attribute name="split_fx_rate1_n">
			<xsl:choose>
				<xsl:when test="$quotationCode2 = '0'">
					<xsl:value-of select="format-number($costPrice * $quotationCode,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$costPrice"/>
				</xsl:otherwise>
			</xsl:choose>
		</attribute>
		<attribute name="split_currency1_code">
			<xsl:value-of select="$securityCcy"/>
		</attribute>
	</xsl:template>
	<xsl:template name="custoDefinitions"/>
	<xsl:template name="mbCustoDefinitions"/>
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