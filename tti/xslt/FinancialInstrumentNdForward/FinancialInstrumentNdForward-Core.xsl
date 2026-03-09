<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/NdDeal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchNdDeal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiNdDeal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiNdDeal" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<infra:code>
			<xsl:choose>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != ''">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" 'NDF' "/>
					<xsl:value-of select=" '-' "/>
					<xsl:value-of select="b:dealCurrency"/>
					<xsl:value-of select=" '-' "/>
					<xsl:value-of select="b:settlementCcy"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'"/>
			<xsl:otherwise>
		         <xsl:value-of select=" 'NDF' "/>
		         <xsl:value-of select=" '-' "/>
		         <xsl:value-of select="b:dealCurrency"/>
		         <xsl:value-of select=" '-' "/>
		         <xsl:value-of select="b:settlementCcy"/>
			</xsl:otherwise>
	  </xsl:choose>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<infra:longName>
			<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'"/>
	   		<xsl:otherwise>
		         <xsl:value-of select=" 'NDF' "/>
		         <xsl:value-of select=" '-' "/>
		         <xsl:value-of select="b:dealCurrency"/>
		         <xsl:value-of select=" '-' "/>
		         <xsl:value-of select="b:settlementCcy"/>
		 	</xsl:otherwise>
	   </xsl:choose>
		</infra:longName>
	</xsl:template>
	<xsl:template name="active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:settlementCcy"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="underlyingCurrency">
		<underlyingCurrency>
			<infra:code>
				<xsl:value-of select="b:dealCurrency"/>
			</infra:code>
		</underlyingCurrency>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField">
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
		<xsl:if test="$PCK_GL_FWD_TEMPLATE = '1' and b:valueDate and b:valueDate != ''">
			<infra:userDefinedField>
				<infra:name>end_d</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="translate(b:valueDate,'-','')"/>
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
	<xsl:template name="type"/>
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

	<xsl:template name="physicalDelivery">
		<physicalDelivery>0</physicalDelivery>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="yieldCurve"/>
</xsl:stylesheet>