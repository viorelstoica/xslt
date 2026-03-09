<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFiduciary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFiduciary" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFiduciary" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="infra:code">
		<xsl:variable name="index" select="@index"/>
		<infra:code>
			<xsl:value-of select="concat(../b:orderNosGroup[@index=$index]/b:orderNos,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="accrualRule">
		<xsl:variable name="ACCRUAL" select="../b:intDayBasis"/>
		<accrualRule>
			<xsl:choose>
				<xsl:when test="$ACCRUAL = 'A' or $ACCRUAL = 'A1' or $ACCRUAL = 'A2' or $ACCRUAL = 'A3'">
					<xsl:value-of select="24"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'B'">
					<xsl:value-of select="31"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'C'">
					<xsl:value-of select="19"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'C2'">
					<xsl:value-of select="20"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'D'">
					<xsl:value-of select="13"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'E'">
					<xsl:value-of select="29"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'E1'">
					<xsl:value-of select="30"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'F'">
					<xsl:value-of select="26"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'F1'">
					<xsl:value-of select="26"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'F2'">
					<xsl:value-of select="26"/>
				</xsl:when>
				<xsl:when test="$ACCRUAL = 'G' or $ACCRUAL = 'S'">
					<xsl:value-of select="0"/>
				</xsl:when>
			</xsl:choose>
		</accrualRule>
	</xsl:template>
	<xsl:template name="accruedInterestCalculation">
		<accruedInterestCalculation>
			<xsl:value-of select=" '1' "/>
		</accruedInterestCalculation>
	</xsl:template>
	<xsl:template name="active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="noticeDay">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="string-length(../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index]) &lt; 8">
			<noticeDay>
				<xsl:value-of select="../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index]"/>
			</noticeDay>
		</xsl:if>
	</xsl:template>
	<xsl:template name="closingDate">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="string-length(../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index]) &gt;= 8">
			<closingDate>
				<xsl:choose>
					<xsl:when test="string-length(../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index]) = 8">
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index]"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index]"/>
					</xsl:otherwise>
				</xsl:choose>
			</closingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="interestRate">
		<interestRate>
			<xsl:value-of select="../b:interestRate"/>
		</interestRate>
	</xsl:template>
	<xsl:template name="openingDate">
		<xsl:variable name="index" select="@index"/>
		<openingDate>
			<xsl:choose>
				<xsl:when test="string-length(../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]) = 8">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]"/>
				</xsl:otherwise>
			</xsl:choose>
		</openingDate>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:shortName">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="not(../b:fdFidOrderTapRefIdList/b:fdFidOrderTapRefId[@index=$index])">
			<infra:shortName>
				<xsl:value-of select="concat('FD',$COMPANY_POSTFIX_SEPARATOR, ../b:fdFidOrderFidTypeList/b:fdFidOrderFidType[@index=$index],     $COMPANY_POSTFIX_SEPARATOR, ../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index])"/>
			</infra:shortName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:longName">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="not(../b:fdFidOrderTapRefIdList/b:fdFidOrderTapRefId[@index=$index])">
			<infra:longName>
				<xsl:value-of select="concat('FD',$COMPANY_POSTFIX_SEPARATOR, ../b:fdFidOrderFidTypeList/b:fdFidOrderFidType[@index=$index],     $COMPANY_POSTFIX_SEPARATOR, ../b:fdFidOrderMaturityDateList/b:fdFidOrderMaturityDate[@index=$index])"/>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="accruedInterestRoundingRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="referenceCurrency">
		<xsl:variable name="index" select="@index"/>
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="../b:fdFidOrderCurrencyList/b:fdFidOrderCurrency[@index=$index]"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature">
		<riskNature>
			<xsl:value-of select=" '2' "/>
		</riskNature>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
    <xsl:template name="type"/>
	<xsl:template name="valuationRule">
		<valuationRule>
			<xsl:value-of select="'3'"/>
		</valuationRule>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="portfolio"/>
	<xsl:template name="issuer">
		<issuer>
			<infra:code>
				<xsl:value-of select="../b:fidBank"/>
			</infra:code>
		</issuer>
   </xsl:template>
	<xsl:template name="nextPayDay"/>
	<xsl:template name="paymentFrequency"/>
	<xsl:template name="paymentFrequencyDay"/>
	<xsl:template name="paymentFrequencyUnit"/>
	<xsl:template name="subNature">
		<subNature>
			<xsl:choose>
				<xsl:when test="../b:fidType = 'NOTICE'">
					<xsl:value-of select="'116'"/>
				</xsl:when>
				<xsl:when test="../b:fidType = 'FIXED'">
					<xsl:value-of select="'117'"/>
				</xsl:when>
			</xsl:choose>
		</subNature>
   </xsl:template>
	<xsl:template name="tenorFrequency"/>
	<xsl:template name="tenorFrequencyUnit"/>
	<xsl:template name="usageNature"/>
</xsl:stylesheet>