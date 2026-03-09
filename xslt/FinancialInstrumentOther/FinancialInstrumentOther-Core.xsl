<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">

	<!-- BEG - For input flow FinancialInstrumentSecurity -->
	<xsl:template name="code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="nature">
		<nature>
			<xsl:value-of select="'17'"/>
		</nature>
	</xsl:template>
	<xsl:template name="synonym"/>
	<xsl:template name="shortName">
		<xsl:if test="b:shortNameList/b:shortName[@language='GB'] != ''">
			<infra:shortName>
				<xsl:value-of select="b:shortNameList/b:shortName[@language='GB']"/>
			</infra:shortName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="longName">
		<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="mainStockExchange">
		<xsl:if test="b:stockExchange != ''">
			<mainStockExchange>
				<infra:code>
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</infra:code>
			</mainStockExchange>
		</xsl:if>
	</xsl:template>
	<xsl:template name="provider">
		<xsl:if test="b:priceUpdateCode != ''">
			<provider>
				<infra:code>
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</infra:code>
			</provider>
		</xsl:if>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:choose>
				<xsl:when test="b:blockingDate and b:blockingDate != ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor and b:nominalFactor != ''">
					<xsl:value-of select="'6'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceTypeJoinPercentage = 'Y'">
							<xsl:value-of select="'5'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'1'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="minimumQuantity"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="roundLotQuantity"/>
	<xsl:template name="sector"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tickSize"/>
	<xsl:template name="tradable"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="accrualRule"/>
	<xsl:template name="accruedInterestRoundingRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="accruedInterestCalculation"/>
	<xsl:template name="capitalGainTax"/>
	<xsl:template name="complexity"/>
	<xsl:template name="complexityLevel"/>
	<xsl:template name="contractSize"/>
	<xsl:template name="couponFrequencyNumber"/>
	<xsl:template name="couponFrequencyUnit"/>
	<xsl:template name="dataSecuProf">
		<xsl:if test="b:grpDeptCodeList/b:grpDeptCode != '' and b:grpDeptCodeList/b:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="b:grpDeptCodeList/b:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<xsl:template name="effectiveMaturityDate"/>
	<xsl:template name="eomConversion"/>
	<xsl:template name="faceValue"/>
	<xsl:template name="firstCouponDate"/>
	<xsl:template name="firstExDate"/>
	<xsl:template name="interestAccrualDate"/>
	<xsl:template name="interestRate"/>
	<xsl:template name="islamicCompliance"/>
	<xsl:template name="issuedAmount"/>
	<xsl:template name="issueDate"/>
	<xsl:template name="issuedPrice"/>
	<xsl:template name="issuer"/>
	<xsl:template name="lastCouponDate"/>
	<xsl:template name="lastTradeDate"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="maturityDate"/>
	<xsl:template name="maturityPrice"/>
	<xsl:template name="subNature"/>
	<xsl:template name="witholdingTax"/>
	<xsl:template name="votingRights"/>
	<xsl:template name="composition"/>
	<xsl:template name="coupon"/>
	<xsl:template name="dividend"/>
	<xsl:template name="interestSchedule"/>
	<xsl:template name="rating"/>
	<xsl:template name="risklevel"/>
	<xsl:template name="yieldCurve"/>
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
	<!-- END - For input flow FinancialInstrumentSecurity -->





	<!-- BEG - For input flow FinancialInstrumentME -->
	<xsl:template name="code_MultiEntity">
		<infra:code>
			<xsl:value-of select="d:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_MultiEntity">
		<active>
			<xsl:choose>
				<xsl:when test="d:blockingDate != ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="dataSecuProf_MultiEntity">
		<xsl:if test="d:grpDeptCodeList/d:grpDeptCode != '' and d:grpDeptCodeList/d:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="d:grpDeptCodeList/d:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<xsl:template name="nature_MultiEntity">
		<nature>
			<xsl:value-of select="'17'"/>
		</nature>
	</xsl:template>
	<xsl:template name="synonym_MultiEntity"/>
	<xsl:template name="shortName_MultiEntity"/>
	<xsl:template name="longName_MultiEntity"/>
	<xsl:template name="multilingualLongName_MultiEntity"/>
	<xsl:template name="notepad_MultiEntity"/>
	<xsl:template name="notepad-custo_MultiEntity"/>
	<xsl:template name="userDefinedField_MultiEntity"/>
	<xsl:template name="userDefinedField-custo_MultiEntity"/>
	<xsl:template name="mbFields_MultiEntity"/>
	<xsl:template name="euroConversionDate_MultiEntity"/>
	<xsl:template name="euroConversionRule_MultiEntity"/>
	<xsl:template name="euroNewInstrument_MultiEntity"/>
	<xsl:template name="mainBusinessEntity_MultiEntity"/>
	<xsl:template name="mainStockExchange_MultiEntity"/>
	<xsl:template name="minimumQuantity_MultiEntity"/>
	<xsl:template name="priceCalculationRule_MultiEntity"/>
	<xsl:template name="provider_MultiEntity"/>
	<xsl:template name="referenceCurrency_MultiEntity"/>
	<xsl:template name="riskCountry_MultiEntity"/>
	<xsl:template name="riskNature_MultiEntity"/>
	<xsl:template name="roundLotQuantity_MultiEntity"/>
	<xsl:template name="sector_MultiEntity"/>
	<xsl:template name="stockExchange_MultiEntity"/>
	<xsl:template name="subType_MultiEntity"/>
	<xsl:template name="taxCountry_MultiEntity"/>
	<xsl:template name="tickSize_MultiEntity"/>
	<xsl:template name="tradable_MultiEntity"/>
	<xsl:template name="type_MultiEntity"/>
	<xsl:template name="valuationRule_MultiEntity"/>
	<xsl:template name="accrualRule_MultiEntity"/>
	<xsl:template name="accruedInterestRoundingRule_MultiEntity"/>
	<xsl:template name="accruedInterestRoundingUnit_MultiEntity"/>
	<xsl:template name="accruedInterestUnitaryRounding_MultiEntity"/>
	<xsl:template name="accruedInterestCalculation_MultiEntity"/>
	<xsl:template name="capitalGainTax_MultiEntity"/>
	<xsl:template name="complexity_MultiEntity"/>
	<xsl:template name="complexityLevel_MultiEntity"/>
	<xsl:template name="contractSize_MultiEntity"/>
	<xsl:template name="couponFrequencyNumber_MultiEntity"/>
	<xsl:template name="couponFrequencyUnit_MultiEntity"/>
	<xsl:template name="effectiveMaturityDate_MultiEntity"/>
	<xsl:template name="eomConversion_MultiEntity"/>
	<xsl:template name="faceValue_MultiEntity"/>
	<xsl:template name="firstCouponDate_MultiEntity"/>
	<xsl:template name="firstExDate_MultiEntity"/>
	<xsl:template name="interestAccrualDate_MultiEntity"/>
	<xsl:template name="interestRate_MultiEntity"/>
	<xsl:template name="islamicCompliance_MultiEntity"/>
	<xsl:template name="issuedAmount_MultiEntity"/>
	<xsl:template name="issueDate_MultiEntity"/>
	<xsl:template name="issuedPrice_MultiEntity"/>
	<xsl:template name="issuer_MultiEntity"/>
	<xsl:template name="lastCouponDate_MultiEntity"/>
	<xsl:template name="lastTradeDate_MultiEntity"/>
	<xsl:template name="marketDirectiveCategory_MultiEntity"/>
	<xsl:template name="maturityDate_MultiEntity"/>
	<xsl:template name="maturityPrice_MultiEntity"/>
	<xsl:template name="subNature_MultiEntity"/>
	<xsl:template name="witholdingTax_MultiEntity"/>
	<xsl:template name="votingRights_MultiEntity"/>
	<xsl:template name="composition_MultiEntity"/>
	<xsl:template name="coupon_MultiEntity"/>
	<xsl:template name="dividend_MultiEntity"/>
	<xsl:template name="interestSchedule_MultiEntity"/>
	<xsl:template name="rating_MultiEntity"/>
	<xsl:template name="risklevel_MultiEntity"/>
	<xsl:template name="yieldCurve_MultiEntity"/>
	<!-- END - For input flow FinancialInstrumentME -->
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