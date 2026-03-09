<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentFutureSYDX" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentFutureSYDX"
                xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c d" version="1.0">
	<xsl:template name="infra:code">
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:tapRefId and b:tapRefId != ''">
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:synonym">
		<xsl:for-each select="b:altIndNameGroup">
			<xsl:if test="b:altIndId">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:altIndId"/>
					</infra:code>
					<infra:codification>
						<xsl:value-of select="b:altIndName"/>
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="OldNewAltDerivativeSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentFutureSYDX"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',b:optionStyle)"/>
		</infra:shortName>
	</xsl:template>
    <xsl:template name="infra:longName">
        <infra:longName>
			<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',b:optionStyle)"/>	 	
		</infra:longName>
    </xsl:template>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="riskCurrency">
		<riskCurrency>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinRiskCurrency"/>
			</infra:code>
		</riskCurrency>
	</xsl:template>
	<xsl:template name="contractMaster">
		<contractMaster>
			<xsl:value-of select="b:contractCode"/>
		</contractMaster>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="mainStockExchange">
		<mainStockExchange>
			<infra:code>
				<xsl:if test="b:dxContractMasterJoinExchange != ''">
					<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:dxContractMasterJoinExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity">
		<xsl:if test="b:dxContractMasterJoinContractDps and b:dxContractMasterJoinContractDps != ''">
			<minimumQuantity>
				<xsl:value-of select="b:dxContractMasterJoinContractDps"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:value-of select="'27'"/>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry">
		<riskCountry>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinRiskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinSubAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="tickSize">
		<tickSize>
			<xsl:value-of select="b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickSize"/>
		</tickSize>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinSubAssetTypeJoinAssetType"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="cashSettlement">
		<cashSettlement>
			<xsl:choose>
				<xsl:when test="b:dxContractMasterJoinDeliveryMethod = 'PHYSICAL'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</cashSettlement>
	</xsl:template>
	<xsl:template name="contractSize">
		<contractSize>
			<xsl:value-of select="format-number(b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickValue div b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickSize,'#.###','nan2zero')"/>
		</contractSize>
	</xsl:template>
	<xsl:template name="exerciseCurrency">
		<exerciseCurrency>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:dlvCcy and b:dlvCcy != ''">
						<xsl:value-of select="b:dlvCcy"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:tradeCcy"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</exerciseCurrency>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="provider"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="roundLotQuantity"/>
	<xsl:template name="sector"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="complexity"/>
	<xsl:template name="complexityLevel"/>
	<xsl:template name="beginDate"/>
	<xsl:template name="contractNature"/>
	<xsl:template name="eventValidityDate"/>
	<xsl:template name="expirationDate">
		<expirationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
			</xsl:call-template>
		</expirationDate>
	</xsl:template>
	<xsl:template name="faceValue"/>
	<xsl:template name="riskLevel">
		<xsl:choose>
			<xsl:when test="b:dxContractMasterJoincompLevelAttribGroup/b:dxContractMasterJoincompLevelAttrib = b:coCode">
				<riskLevel>
					<xsl:value-of select="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = ../b:coCode]/b:dxContractMasterJoinRiskLevel"/>
				</riskLevel>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = '' or not(b:dxContractMasterJoincompLevelAttrib)]/b:dxContractMasterJoinRiskLevel != ''">
					<riskLevel>
						<xsl:value-of select="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = '' or not(b:dxContractMasterJoincompLevelAttrib)]/b:dxContractMasterJoinRiskLevel"/>
					</riskLevel>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="islamicCompliance">
		<xsl:if test="b:dxContractMasterJoinIslamicCompliance != ''">
			<islamicCompliance>
				<xsl:choose>
					<xsl:when test="b:dxContractMasterJoinIslamicCompliance = 'None'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:dxContractMasterJoinIslamicCompliance = 'NO'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:dxContractMasterJoinIslamicCompliance = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</islamicCompliance>
		</xsl:if>
	</xsl:template>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="lastTradeDate"/>
	<xsl:template name="stpOrder"/>
	<xsl:template name="subNature"/>
	<xsl:template name="underlying">
		<xsl:if test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'CASH' and b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'OTHER'">
			<underlying>
				<infra:code>
					<xsl:value-of select="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying"/>
				</infra:code>
			</underlying>
		</xsl:if>
	</xsl:template>
	<xsl:template name="termEvent"/>
	<xsl:template name="usageNature">
		<usageNature>
			<xsl:value-of select="'1'"/>
		</usageNature>
	</xsl:template>
</xsl:stylesheet>