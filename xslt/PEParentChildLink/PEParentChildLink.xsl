<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PEProductEvents"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPEProductEvents" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPEProductEvents" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPEProductEvents" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPEProductEvents">
		<xsl:apply-templates select="c:CurrentEvent/b:PEProductEvents"/>
	</xsl:template>
	<xsl:template match="batch:BatchPEProductEvents">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPEProductEvents" name="BatchPEProductEvents">
			<xsl:apply-templates select="b:PEProductEvents"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPEProductEvents">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPEProductEvents" name="BatchMultiPEProductEvents">
			<xsl:apply-templates select="c:MultiPEProductEvents"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PEProductEvents">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('PEParentChildLink',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<FundShare>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('PEParentChildLink.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code_Drawdown"/>
					<xsl:call-template name="infra:synonym_Drawdown"/>
					<xsl:call-template name="infra:shortName_Drawdown"/>
					<xsl:call-template name="infra:longName_Drawdown"/>
					<xsl:call-template name="infra:multilingualLongName_Drawdown"/>
					<xsl:call-template name="infra:notepad_Drawdown"/>
					<xsl:call-template name="infra:userDefinedField_Drawdown"/>
					<xsl:call-template name="infra:mbFields_Drawdown"/>
					<xsl:call-template name="active_Drawdown"/>
					<xsl:call-template name="euroConversionDate_Drawdown"/>
					<xsl:call-template name="euroConversionRule_Drawdown"/>
					<xsl:call-template name="euroNewInstrument_Drawdown"/>
					<xsl:call-template name="mainBusinessEntity_Drawdown"/>
					<xsl:call-template name="mainStockExchange_Drawdown"/>
					<xsl:call-template name="minimumQuantity_Drawdown"/>
					<xsl:call-template name="priceCalculationRule_Drawdown"/>
					<xsl:call-template name="provider_Drawdown"/>
					<xsl:call-template name="referenceCurrency_Drawdown"/>
					<xsl:call-template name="riskCountry_Drawdown"/>
					<xsl:call-template name="riskNature_Drawdown"/>
					<xsl:call-template name="roundLotQuantity_Drawdown"/>
					<xsl:call-template name="sector_Drawdown"/>
					<xsl:call-template name="stockExchange_Drawdown"/>
					<xsl:call-template name="subType_Drawdown"/>
					<xsl:call-template name="taxCountry_Drawdown"/>
					<xsl:call-template name="tickSize_Drawdown"/>
					<xsl:call-template name="tradable_Drawdown"/>
					<xsl:call-template name="type_Drawdown"/>
					<xsl:call-template name="valuationRule_Drawdown"/>
					<xsl:call-template name="beginDate_Drawdown"/>
					<xsl:call-template name="capitalGainTax_Drawdown"/>
					<xsl:call-template name="complexity_Drawdown"/>
					<xsl:call-template name="complexityLevel_Drawdown"/>
					<xsl:call-template name="cutOffTime_Drawdown"/>
					<xsl:call-template name="cutOffTimeZone_Drawdown"/>
					<xsl:call-template name="dividendFrequencyNumber_Drawdown"/>
					<xsl:call-template name="dividendFrequencyUnit_Drawdown"/>
					<xsl:call-template name="eligibleWrapFund_Drawdown"/>
					<xsl:call-template name="faceValue_Drawdown"/>
					<xsl:call-template name="islamicCompliance_Drawdown"/>
					<xsl:call-template name="issueQuantity_Drawdown"/>
					<xsl:call-template name="issueQuote_Drawdown"/>
					<xsl:call-template name="issuer_Drawdown"/>
					<xsl:call-template name="marketDirectiveCategory_Drawdown"/>
					<xsl:call-template name="minimumTradingAmount_Drawdown"/>
					<xsl:call-template name="referenceIndex_Drawdown"/>
					<xsl:call-template name="riskCurrency_Drawdown"/>
					<xsl:call-template name="riskLevel_Drawdown"/>
					<xsl:call-template name="roundLotAmount_Drawdown"/>
					<xsl:call-template name="stpOrder_Drawdown"/>
					<xsl:call-template name="subNature_Drawdown"/>
					<xsl:call-template name="tradeNature_Drawdown"/>
					<xsl:call-template name="votingRights_Drawdown"/>
					<xsl:call-template name="witholdingTax_Drawdown"/>
					<xsl:call-template name="dividend_Drawdown"/>
					<xsl:call-template name="composition_Drawdown"/>
					<xsl:call-template name="commonReference_Drawdown"/>
					<xsl:call-template name="coolCancelF_Drawdown"/>
					<xsl:call-template name="coolPeriod_Drawdown"/>
					<xsl:call-template name="coolPeriodUnit_Drawdown"/>
					<xsl:call-template name="fundIncomeStyleE_Drawdown"/>
					<xsl:call-template name="parentInstrument_Drawdown"/>
					<xsl:call-template name="redemption_Drawdown"/>
					<xsl:call-template name="reinvestmentAllowedF_Drawdown"/>
					<xsl:call-template name="switchOrderAmt_Drawdown"/>
					<xsl:call-template name="switchOrderPerc_Drawdown"/>
					<xsl:call-template name="switchOrderUnit_Drawdown"/>
				</FundShare>
			</DataGroup>
			<DataGroup>
				<FundShare>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('PEParentChildLink.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code_CapitalCalled"/>
					<xsl:call-template name="infra:synonym_CapitalCalled"/>
					<xsl:call-template name="infra:shortName_CapitalCalled"/>
					<xsl:call-template name="infra:longName_CapitalCalled"/>
					<xsl:call-template name="infra:multilingualLongName_CapitalCalled"/>
					<xsl:call-template name="infra:notepad_CapitalCalled"/>
					<xsl:call-template name="infra:userDefinedField_CapitalCalled"/>
					<xsl:call-template name="infra:mbFields_CapitalCalled"/>
					<xsl:call-template name="active_CapitalCalled"/>
					<xsl:call-template name="euroConversionDate_CapitalCalled"/>
					<xsl:call-template name="euroConversionRule_CapitalCalled"/>
					<xsl:call-template name="euroNewInstrument_CapitalCalled"/>
					<xsl:call-template name="mainBusinessEntity_CapitalCalled"/>
					<xsl:call-template name="mainStockExchange_CapitalCalled"/>
					<xsl:call-template name="minimumQuantity_CapitalCalled"/>
					<xsl:call-template name="priceCalculationRule_CapitalCalled"/>
					<xsl:call-template name="provider_CapitalCalled"/>
					<xsl:call-template name="referenceCurrency_CapitalCalled"/>
					<xsl:call-template name="riskCountry_CapitalCalled"/>
					<xsl:call-template name="riskNature_CapitalCalled"/>
					<xsl:call-template name="roundLotQuantity_CapitalCalled"/>
					<xsl:call-template name="sector_CapitalCalled"/>
					<xsl:call-template name="stockExchange_CapitalCalled"/>
					<xsl:call-template name="subType_CapitalCalled"/>
					<xsl:call-template name="taxCountry_CapitalCalled"/>
					<xsl:call-template name="tickSize_CapitalCalled"/>
					<xsl:call-template name="tradable_CapitalCalled"/>
					<xsl:call-template name="type_CapitalCalled"/>
					<xsl:call-template name="valuationRule_CapitalCalled"/>
					<xsl:call-template name="beginDate_CapitalCalled"/>
					<xsl:call-template name="capitalGainTax_CapitalCalled"/>
					<xsl:call-template name="complexity_CapitalCalled"/>
					<xsl:call-template name="complexityLevel_CapitalCalled"/>
					<xsl:call-template name="cutOffTime_CapitalCalled"/>
					<xsl:call-template name="cutOffTimeZone_CapitalCalled"/>
					<xsl:call-template name="dividendFrequencyNumber_CapitalCalled"/>
					<xsl:call-template name="dividendFrequencyUnit_CapitalCalled"/>
					<xsl:call-template name="eligibleWrapFund_CapitalCalled"/>
					<xsl:call-template name="faceValue_CapitalCalled"/>
					<xsl:call-template name="islamicCompliance_CapitalCalled"/>
					<xsl:call-template name="issueQuantity_CapitalCalled"/>
					<xsl:call-template name="issueQuote_CapitalCalled"/>
					<xsl:call-template name="issuer_CapitalCalled"/>
					<xsl:call-template name="marketDirectiveCategory_CapitalCalled"/>
					<xsl:call-template name="minimumTradingAmount_CapitalCalled"/>
					<xsl:call-template name="referenceIndex_CapitalCalled"/>
					<xsl:call-template name="riskCurrency_CapitalCalled"/>
					<xsl:call-template name="riskLevel_CapitalCalled"/>
					<xsl:call-template name="roundLotAmount_CapitalCalled"/>
					<xsl:call-template name="stpOrder_CapitalCalled"/>
					<xsl:call-template name="subNature_CapitalCalled"/>
					<xsl:call-template name="tradeNature_CapitalCalled"/>
					<xsl:call-template name="votingRights_CapitalCalled"/>
					<xsl:call-template name="witholdingTax_CapitalCalled"/>
					<xsl:call-template name="dividend_CapitalCalled"/>
					<xsl:call-template name="composition_CapitalCalled"/>
					<xsl:call-template name="commonReference_CapitalCalled"/>
					<xsl:call-template name="coolCancelF_CapitalCalled"/>
					<xsl:call-template name="coolPeriod_CapitalCalled"/>
					<xsl:call-template name="coolPeriodUnit_CapitalCalled"/>
					<xsl:call-template name="fundIncomeStyleE_CapitalCalled"/>
					<xsl:call-template name="parentInstrument_CapitalCalled"/>
					<xsl:call-template name="redemption_CapitalCalled"/>
					<xsl:call-template name="reinvestmentAllowedF_CapitalCalled"/>
					<xsl:call-template name="switchOrderAmt_CapitalCalled"/>
					<xsl:call-template name="switchOrderPerc_CapitalCalled"/>
					<xsl:call-template name="switchOrderUnit_CapitalCalled"/>
				</FundShare>
			</DataGroup>
			<DataGroup>
				<FundShare>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('PEParentChildLink.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code_ActualPeSecurity"/>
					<xsl:call-template name="infra:synonym_ActualPeSecurity"/>
					<xsl:call-template name="infra:shortName_ActualPeSecurity"/>
					<xsl:call-template name="infra:longName_ActualPeSecurity"/>
					<xsl:call-template name="infra:multilingualLongName_ActualPeSecurity"/>
					<xsl:call-template name="infra:notepad_ActualPeSecurity"/>
					<xsl:call-template name="infra:userDefinedField_ActualPeSecurity"/>
					<xsl:call-template name="infra:mbFields_ActualPeSecurity"/>
					<xsl:call-template name="active_ActualPeSecurity"/>
					<xsl:call-template name="euroConversionDate_ActualPeSecurity"/>
					<xsl:call-template name="euroConversionRule_ActualPeSecurity"/>
					<xsl:call-template name="euroNewInstrument_ActualPeSecurity"/>
					<xsl:call-template name="mainBusinessEntity_ActualPeSecurity"/>
					<xsl:call-template name="mainStockExchange_ActualPeSecurity"/>
					<xsl:call-template name="minimumQuantity_ActualPeSecurity"/>
					<xsl:call-template name="priceCalculationRule_ActualPeSecurity"/>
					<xsl:call-template name="provider_ActualPeSecurity"/>
					<xsl:call-template name="referenceCurrency_ActualPeSecurity"/>
					<xsl:call-template name="riskCountry_ActualPeSecurity"/>
					<xsl:call-template name="riskNature_ActualPeSecurity"/>
					<xsl:call-template name="roundLotQuantity_ActualPeSecurity"/>
					<xsl:call-template name="sector_ActualPeSecurity"/>
					<xsl:call-template name="stockExchange_ActualPeSecurity"/>
					<xsl:call-template name="subType_ActualPeSecurity"/>
					<xsl:call-template name="taxCountry_ActualPeSecurity"/>
					<xsl:call-template name="tickSize_ActualPeSecurity"/>
					<xsl:call-template name="tradable_ActualPeSecurity"/>
					<xsl:call-template name="type_ActualPeSecurity"/>
					<xsl:call-template name="valuationRule_ActualPeSecurity"/>
					<xsl:call-template name="beginDate_ActualPeSecurity"/>
					<xsl:call-template name="capitalGainTax_ActualPeSecurity"/>
					<xsl:call-template name="complexity_ActualPeSecurity"/>
					<xsl:call-template name="complexityLevel_ActualPeSecurity"/>
					<xsl:call-template name="cutOffTime_ActualPeSecurity"/>
					<xsl:call-template name="cutOffTimeZone_ActualPeSecurity"/>
					<xsl:call-template name="dividendFrequencyNumber_ActualPeSecurity"/>
					<xsl:call-template name="dividendFrequencyUnit_ActualPeSecurity"/>
					<xsl:call-template name="eligibleWrapFund_ActualPeSecurity"/>
					<xsl:call-template name="faceValue_ActualPeSecurity"/>
					<xsl:call-template name="islamicCompliance_ActualPeSecurity"/>
					<xsl:call-template name="issueQuantity_ActualPeSecurity"/>
					<xsl:call-template name="issueQuote_ActualPeSecurity"/>
					<xsl:call-template name="issuer_ActualPeSecurity"/>
					<xsl:call-template name="marketDirectiveCategory_ActualPeSecurity"/>
					<xsl:call-template name="minimumTradingAmount_ActualPeSecurity"/>
					<xsl:call-template name="referenceIndex_ActualPeSecurity"/>
					<xsl:call-template name="riskCurrency_ActualPeSecurity"/>
					<xsl:call-template name="riskLevel_ActualPeSecurity"/>
					<xsl:call-template name="roundLotAmount_ActualPeSecurity"/>
					<xsl:call-template name="stpOrder_ActualPeSecurity"/>
					<xsl:call-template name="subNature_ActualPeSecurity"/>
					<xsl:call-template name="tradeNature_ActualPeSecurity"/>
					<xsl:call-template name="votingRights_ActualPeSecurity"/>
					<xsl:call-template name="witholdingTax_ActualPeSecurity"/>
					<xsl:call-template name="dividend_ActualPeSecurity"/>
					<xsl:call-template name="composition_ActualPeSecurity"/>
					<xsl:call-template name="commonReference_ActualPeSecurity"/>
					<xsl:call-template name="coolCancelF_ActualPeSecurity"/>
					<xsl:call-template name="coolPeriod_ActualPeSecurity"/>
					<xsl:call-template name="coolPeriodUnit_ActualPeSecurity"/>
					<xsl:call-template name="fundIncomeStyleE_ActualPeSecurity"/>
					<xsl:call-template name="parentInstrument_ActualPeSecurity"/>
					<xsl:call-template name="redemption_ActualPeSecurity"/>
					<xsl:call-template name="reinvestmentAllowedF_ActualPeSecurity"/>
					<xsl:call-template name="switchOrderAmt_ActualPeSecurity"/>
					<xsl:call-template name="switchOrderPerc_ActualPeSecurity"/>
					<xsl:call-template name="switchOrderUnit_ActualPeSecurity"/>
				</FundShare>
			</DataGroup>
		</FiPMS>
	</xsl:template>
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