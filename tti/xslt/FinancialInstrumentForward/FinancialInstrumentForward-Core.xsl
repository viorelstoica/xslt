<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentForex"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentForex" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<infra:code>
			<xsl:choose>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != ''">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$UnderlyCurrency"/>
					<xsl:value-of select="'-'"/>
					<xsl:value-of select="$ReferenceCurrency"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<infra:shortName>
			<xsl:choose>
		<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'"/>
		<xsl:otherwise>
			<xsl:value-of select="'FORWARD_'"/>
			<xsl:value-of select="$UnderlyCurrency"/>
			<xsl:value-of select="'_'"/>
			<xsl:value-of select="$ReferenceCurrency"/>
		</xsl:otherwise>
	</xsl:choose>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<infra:longName>
			<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'"/>
		<xsl:otherwise>
			<xsl:value-of select="'FORWARD_'"/>
			<xsl:value-of select="$UnderlyCurrency"/>
			<xsl:value-of select="'_'"/>
			<xsl:value-of select="$ReferenceCurrency"/>
		</xsl:otherwise>
	</xsl:choose>    
		</infra:longName>
	</xsl:template>
	<xsl:template name="active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="referenceCurrency">
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="$ReferenceCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="underlyingCurrency">
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<underlyingCurrency>
			<infra:code>
				<xsl:value-of select="$UnderlyCurrency"/>
			</infra:code>
		</underlyingCurrency>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField">
		<xsl:param name="valueDateBuy">
			<xsl:call-template name="formatDateForComparison">
				<xsl:with-param name="dateToFormat" select="b:valueDateBuy"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="valueDateSell">
			<xsl:call-template name="formatDateForComparison">
				<xsl:with-param name="dateToFormat" select="b:valueDateSell"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="endDate">
			<xsl:choose>
				<xsl:when test="number($valueDateBuy) &lt; number($valueDateSell)">
					<xsl:value-of select="$valueDateBuy"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$valueDateSell"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1' and b:dealDate and b:dealDate != ''">
			<infra:userDefinedField>
				<infra:name>begin_d</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="translate(b:dealDate,'-','')"/>
					</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1' and string-length($endDate) = '8'">
			<infra:userDefinedField>
				<infra:name>end_d</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="$endDate"/>
					</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1'">
			<infra:userDefinedField>
				<infra:name>usage_nature_e</infra:name>
				<infra:value>
					<xsl:value-of select="'0'"/>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<infra:userDefinedField>
			<infra:name>generic_f</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'1'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="accrualRule"/>
	<xsl:template name="accruedInterestCalculation"/>
	<xsl:template name="accruedInterestRoundingRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="priceCalculationRule">
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1'">
			<priceCalculationRule>
				<xsl:value-of select="'1'"/>
			</priceCalculationRule>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'FX_FW'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule">
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1'">
			<valuationRule>
				<xsl:value-of select="'1'"/>
			</valuationRule>
		</xsl:if>
	</xsl:template>
	<xsl:template name="subNature">
		<subNature>
			<xsl:choose>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
					<xsl:value-of select="'122'"/>
				</xsl:when>
			</xsl:choose>
		</subNature>
	</xsl:template>

	<xsl:template name="physicalDelivery"/>
	<xsl:template name="provider"/>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="infra:code_S">
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<infra:code>
			<xsl:choose>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != ''">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$UnderlyCurrency"/>
					<xsl:value-of select="'-'"/>
					<xsl:value-of select="$ReferenceCurrency"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName_S">
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<infra:shortName>
			<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'"/>
		<xsl:otherwise>
	      <xsl:value-of select="'FORWARD_'"/>
	      <xsl:value-of select="$UnderlyCurrency"/>
	      <xsl:value-of select="'_'"/>
	      <xsl:value-of select="$ReferenceCurrency"/>
		</xsl:otherwise>
	</xsl:choose>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_S">
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<infra:longName>
			<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'"/>
		<xsl:otherwise>
		      <xsl:value-of select="'FORWARD_'"/>
		      <xsl:value-of select="$UnderlyCurrency"/>
		      <xsl:value-of select="'_'"/>
		      <xsl:value-of select="$ReferenceCurrency"/>
		</xsl:otherwise>
	</xsl:choose>
		</infra:longName>
	</xsl:template>
	<xsl:template name="active_S">
		<active>1</active>
	</xsl:template>
	<xsl:template name="referenceCurrency_S">
		<xsl:variable name="ReferenceCurrency">
			<xsl:value-of select="b:currencySold"/>
		</xsl:variable>
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="$ReferenceCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="underlyingCurrency_S">
		<xsl:variable name="UnderlyCurrency">
			<xsl:value-of select="b:currencyBought"/>
		</xsl:variable>
		<underlyingCurrency>
			<infra:code>
				<xsl:value-of select="$UnderlyCurrency"/>
			</infra:code>
		</underlyingCurrency>
	</xsl:template>
	<xsl:template name="infra:synonym_S"/>
	<xsl:template name="infra:multilingualLongName_S"/>
	<xsl:template name="infra:notepad_S"/>
	<xsl:template name="infra:userDefinedField_S">
		<xsl:param name="valueDateBuy">
			<xsl:call-template name="formatDateForComparison">
				<xsl:with-param name="dateToFormat" select="b:valueDateBuy"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="valueDateSell">
			<xsl:call-template name="formatDateForComparison">
				<xsl:with-param name="dateToFormat" select="b:valueDateSell"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="endDate">
			<xsl:choose>
				<xsl:when test="number($valueDateBuy) &lt; number($valueDateSell)">
					<xsl:value-of select="$valueDateBuy"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$valueDateSell"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1' and b:dealDate and b:dealDate != ''">
			<infra:userDefinedField>
				<infra:name>begin_d</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="translate(b:dealDate,'-','')"/>
					</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1' and string-length($endDate) = '8'">
			<infra:userDefinedField>
				<infra:name>end_d</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="$endDate"/>
					</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1'">
			<infra:userDefinedField>
				<infra:name>usage_nature_e</infra:name>
				<infra:value>
					<xsl:value-of select="'0'"/>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<infra:userDefinedField>
			<infra:name>generic_f</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'1'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo_S"/>
	<xsl:template name="infra:mbFields_S"/>
	<xsl:template name="accrualRule_S"/>
	<xsl:template name="accruedInterestCalculation_S"/>
	<xsl:template name="accruedInterestRoundingRule_S"/>
	<xsl:template name="accruedInterestRoundingUnit_S"/>
	<xsl:template name="accruedInterestUnitaryRounding_S"/>
	<xsl:template name="euroConversionDate_S"/>
	<xsl:template name="euroConversionRule_S"/>
	<xsl:template name="euroNewInstrument_S"/>
	<xsl:template name="mainBusinessEntity_S"/>
	<xsl:template name="priceCalculationRule_S">
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1'">
			<priceCalculationRule>
				<xsl:value-of select="'1'"/>
			</priceCalculationRule>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskCountry_S"/>
	<xsl:template name="riskNature_S"/>
	<xsl:template name="subType_S"/>
	<xsl:template name="taxCountry_S"/>
	<xsl:template name="tradable_S"/>
	<xsl:template name="type_S">
		<type>
			<infra:code>
				<xsl:value-of select="'FX_FW'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_S">
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1'">
			<valuationRule>
				<xsl:value-of select="'1'"/>
			</valuationRule>
		</xsl:if>
	</xsl:template>
	<xsl:template name="subNature_S">
		<subNature>
			<xsl:choose>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
					<xsl:value-of select="'122'"/>
				</xsl:when>
			</xsl:choose>
		</subNature>
	</xsl:template>

	<xsl:template name="physicalDelivery_S"/>
	<xsl:template name="provider_S"/>
	<xsl:template name="yieldCurve_S"/>
</xsl:stylesheet>