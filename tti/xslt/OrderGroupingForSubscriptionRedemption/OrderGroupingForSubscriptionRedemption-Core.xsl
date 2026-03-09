<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/OrderGroupingForSubscriptionRedemption"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderGroupingForSubscriptionRedemption" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0"
                version="1.0">
	<xsl:template name="infra:code">
		<infra:code>
			<xsl:choose>
				<xsl:when test="contains(b:id, '*')">
					<xsl:value-of select="substring-before(b:id,'*')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="infra:synonym-custo"/>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:shortName"/>
	<xsl:template name="infra:longName"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad-custo"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField">
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionBuy) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_subs_d'"/>
				</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
	        			<xsl:with-param name="date" select="b:cutOffDate"/>
	     			</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionBuy) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_time_subs_d'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="string-length(b:cutOffTime) = '5'">
							<xsl:value-of select="concat(b:cutOffTime,':00')"/>
						</xsl:when>
						<xsl:when test="string-length(b:cutOffTime) = '8'">
							<xsl:value-of select="b:cutOffTime"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionRed) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_red_d'"/>
				</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
        				<xsl:with-param name="date" select="b:cutOffDate"/>
     				</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionRed) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_time_red_d'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="string-length(b:cutOffTime) = '5'">
							<xsl:value-of select="concat(b:cutOffTime,':00')"/>
						</xsl:when>
						<xsl:when test="string-length(b:cutOffTime) = '8'">
							<xsl:value-of select="b:cutOffTime"/>
						</xsl:when>
				</xsl:choose>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="mainStockExchange"/>
	<xsl:template name="minimumQuantity"/>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="provider"/>
	<xsl:template name="referenceCurrency"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="roundLotQuantity"/>
	<xsl:template name="sector-custo"/>
	<xsl:template name="sector"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tickSize"/>
	<xsl:template name="tradable"/>
	<xsl:template name="type"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="beginDate"/>
	<xsl:template name="capitalGainTax"/>
	<xsl:template name="complexity"/>
	<xsl:template name="complexityLevel"/>
	<xsl:template name="cutOffTime"/>
	<xsl:template name="cutOffTimeZone"/>
	<xsl:template name="dividendFrequencyNumber"/>
	<xsl:template name="dividendFrequencyUnit"/>
	<xsl:template name="eligibleWrapFund"/>
	<xsl:template name="faceValue"/>
	<xsl:template name="islamicCompliance"/>
	<xsl:template name="issueQuantity"/>
	<xsl:template name="issueQuote"/>
	<xsl:template name="issuer"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="minimumTradingAmount"/>
	<xsl:template name="referenceIndex"/>
	<xsl:template name="riskCurrency"/>
	<xsl:template name="riskLevel"/>
	<xsl:template name="roundLotAmount"/>
	<xsl:template name="stpOrder"/>
	<xsl:template name="subNature"/>
	<xsl:template name="tradeNature"/>
	<xsl:template name="votingRights"/>
	<xsl:template name="witholdingTax"/>
	<xsl:template name="dividend"/>
	<xsl:template name="composition"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="coolCancelF"/>
	<xsl:template name="coolPeriod"/>
	<xsl:template name="coolPeriodUnit"/>
	<xsl:template name="fundIncomeStyleE"/>
	<xsl:template name="parentInstrument"/>
	<xsl:template name="redemption"/>
	<xsl:template name="reinvestmentAllowedF"/>
	<xsl:template name="switchOrderAmt"/>
	<xsl:template name="switchOrderPerc"/>
	<xsl:template name="switchOrderUnit"/>
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