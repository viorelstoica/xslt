<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName">
		<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'en'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'fr'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:descriptList/b:descript[@language='FR']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'de'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:descriptList/b:descript[@language='DE']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:call-template name="OldNewDenomConcatManagment">
			<xsl:with-param name="CurrentEvent" select="./b:descriptionList/b:description"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="mainStockExchange">
		<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity">
		<xsl:if test="b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="provider"/>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="roundLotQuantity"/>
	<xsl:template name="sector"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tickSize"/>
	<xsl:template name="tradable"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule"/>
	<xsl:template name="baseDate"/>
	<xsl:template name="baseValue"/>
	<xsl:template name="calculationRule"/>
	<xsl:template name="dataSecuProf">
		<xsl:if test="b:grpDeptCodeList/b:grpDeptCode != '' and b:grpDeptCodeList/b:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="b:grpDeptCodeList/b:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<xsl:template name="divisor"/>
	<xsl:template name="forex"/>
	<xsl:template name="returnRule"/>
	<xsl:template name="timeRule"/>
	<xsl:template name="composition"/>
	<!--  START BusinessEntity Compo -->
	<xsl:template name="infra:businessEntity">
			<infra:businessEntity>
				<infra:code>
					<xsl:call-template name="instrBusinessEntity">
						<xsl:with-param name="beAllowedCountry" select="."/>
					</xsl:call-template>
				</infra:code>
			</infra:businessEntity>
	</xsl:template>
	<xsl:template name="infra:mainBusinessEntity">
		<infra:mainBusinessEntity>0</infra:mainBusinessEntity>
	</xsl:template>
	<xsl:template name="infra:role"/>
	<xsl:template name="infra:type"/>
	<xsl:template name="be_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="infra:mbFields_becompo_inser"/>
	<xsl:template name="infra:mbFields_becompo_del"/>
	<!--  END BusinessEntity Compo -->
</xsl:stylesheet>