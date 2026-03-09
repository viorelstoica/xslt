<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDxPrice" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select="b:valuationCcy"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapRefId and b:tapRefId != ''">
						<xsl:value-of select="b:tapRefId"/>
					</xsl:when>
					<xsl:when test="b:tapRefIdSyFxForward and b:tapRefIdSyFxForward != ''">
						<xsl:value-of select="b:tapRefIdSyFxForward"/>
					</xsl:when>
					<xsl:when test="b:tapRefIdSyAccuDecu and b:tapRefIdSyAccuDecu != ''">
						<xsl:value-of select="b:tapRefIdSyAccuDecu"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="starts-with(b:dealReference,'SYFX') and (not(b:bKnockoutIntrinsicSyFxForward) or b:bKnockoutIntrinsicSyFxForward = '') and (not(b:sKnockoutIntrinsicSyFxForward) or b:sKnockoutIntrinsicSyFxForward = '')">
								<xsl:value-of select="concat('PFWD',$COMPANY_POSTFIX_SEPARATOR,b:dealReference,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
							</xsl:when>
							<xsl:when test="starts-with(b:dealReference,'SYFX') and ((b:bKnockoutIntrinsicSyFxForward != '') or (b:sKnockoutIntrinsicSyFxForward != ''))">
								<xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:dealReference,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(b:dealReference,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="quotationDate">
		<quotationDate>
			<xsl:call-template name="xsdatetimeNoSep">
				<xsl:with-param name="date" select="translate(substring-after(b:id,'_'),'-','')"/>
			</xsl:call-template>
		</quotationDate>
	</xsl:template>
	<xsl:template name="stockExchange"/>
	<xsl:template name="value">
		<value>
			<xsl:choose>
				<xsl:when test="b:price != ''">
					<xsl:value-of select="b:price"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="starts-with(b:dealReference,'SYACDC') or starts-with(b:dealReference,'SYFX')">
							<xsl:value-of select="b:valuationAmt"/>
						</xsl:when>
						<xsl:when test="starts-with(b:dealReference,'SYDCI')">
							<xsl:value-of select="format-number((b:valuationAmt) div (b:depositAmountSYDCI),$decimalformat,'nan2zero')"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</value>
	</xsl:template>
	<xsl:template name="valueType">
		<valueType>
			<infra:code>
				<xsl:value-of select="'Close_Price'"/>
			</infra:code>
		</valueType>
	</xsl:template>
	<xsl:template name="valueTermType"/>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="mbFields"/>

	<xsl:template name="currency_PortfolioInstrumentPrice">
		<currency>
			<infra:code>
				<xsl:value-of select="b:valuationCcy"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="instrument_PortfolioInstrumentPrice">
		<instrument>
			<infra:code>
				<xsl:choose>
				<xsl:when test="b:tapRefId">
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:dxTradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
					
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="portfolio_PortfolioInstrumentPrice">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:priSecAccDxTradeGroup/b:priSecAccDxTrade"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="price_PortfolioInstrumentPrice"/>
	<xsl:template name="priceCalculationRule_PortfolioInstrumentPrice">
		<priceCalculationRule>
			<xsl:value-of select="'27'"/>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="quantity_PortfolioInstrumentPrice"/>
	<xsl:template name="quote_PortfolioInstrumentPrice">
		<quote>
			<xsl:value-of select="b:price"/>
		</quote>
	</xsl:template>
	<xsl:template name="quotedDate_PortfolioInstrumentPrice">
		<quotedDate>
			<xsl:call-template name="xsdatetimeNoSep">
				<xsl:with-param name="date" select="translate(substring-after(b:id,'_'),'-','')"/>
			</xsl:call-template>
		</quotedDate>
	</xsl:template>
	<xsl:template name="value_PortfolioInstrumentPrice">
		<xsl:if test="(not(b:price) or b:price='') and (b:valuationAmt and b:valuationAmt != '')">
			<value>
				<xsl:value-of select="b:valuationAmt"/>
			</value>
		</xsl:if>
	</xsl:template>
	<xsl:template name="mbFields_PortfolioInstrumentPrice"/>
</xsl:stylesheet>