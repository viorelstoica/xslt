<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionEntitlement">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionEntitlement"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionEntitlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" name="BatchTransactionEntitlement">
			<xsl:apply-templates select="b:TransactionEntitlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionEntitlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" name="BatchMultiTransactionEntitlement">
			<xsl:apply-templates select="c:MultiTransactionEntitlement"/>
		</xsl:element>
	</xsl:template>
	<!-- Transaction status: opStatus -->
	<xsl:param name="opStatus">
		<xsl:call-template name="operationStatus">
			<xsl:with-param name="transactionStage" select="b:TransactionEntitlement/b:eventCommon/ns0:transactionStage"/>
			<xsl:with-param name="recordStatus" select="b:TransactionEntitlement/b:recordStatus"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:template match="b:TransactionEntitlement">
		<GenericCOA>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionRightsExecution',b:diaryId)"/>
			</xsl:attribute>
			<!-- Call optionDescGroup -->
			<xsl:apply-templates select="b:optionDescGroup"/>
		</GenericCOA>
	</xsl:template>
	<!-- BEG of template OptionDescGroup -->
	<xsl:template match="b:optionDescGroup">
		<xsl:variable name="CheckAdjustmentPLCriteria">
			<xsl:call-template name="CheckAdjustmentPLCriteria"/>
		</xsl:variable>
		<xsl:variable name="CheckUpfrontPaymentCriteria">
			<xsl:call-template name="CheckUpfrontPaymentCriteria"/>
		</xsl:variable>
		<xsl:variable name="CheckBuyCriteria">
			<xsl:call-template name="CheckBuyCriteria"/>
		</xsl:variable>
		<xsl:variable name="CheckUpfrontPaymentReturnedCriteria">
			<xsl:call-template name="CheckUpfrontPaymentReturnedCriteria"/>
		</xsl:variable>
		<xsl:variable name="CheckSellorLapseCriteria">
			<xsl:call-template name="CheckSellorLapseCriteria"/>
		</xsl:variable>

		<!-- Check If satisfying Adjustment PL Criteria -->
		<xsl:if test="$CheckAdjustmentPLCriteria = 'Y' ">
			<xsl:call-template name="mappingAdjustmentPL"/>
		</xsl:if>
		<!-- Check If satisfying UpfrontPayment Criteria -->
		<xsl:if test="$CheckUpfrontPaymentCriteria = 'Y' ">
			<xsl:call-template name="mappingUpfrontPayment"/>
		</xsl:if>
		<!-- Check If satisfying Buy Criterias -->
		<xsl:if test="$CheckBuyCriteria = 'Y' ">
			<xsl:call-template name="mappingBuy"/>
		</xsl:if>
		<!-- Check If satisfying upfront payment returned Criteria -->
		<xsl:if test="$CheckUpfrontPaymentReturnedCriteria = 'Y' ">
			<xsl:call-template name="mappingUpfrontPaymentReturned"/>
		</xsl:if>
		<!-- Check If satisfying Sell or Lapse Criteria -->
		<xsl:if test="$CheckSellorLapseCriteria = 'Y' ">
			<xsl:call-template name="mappingSellorLapse"/>
		</xsl:if>
	</xsl:template>
	<!-- End of template OptionDescGroup -->

	<!-- BEG - Adjustment PL -->
	<xsl:template name="mappingAdjustmentPL">
		<DataGroup>
			<Adjustment>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionRightsExecution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_adj"/>
				<xsl:call-template name="account1CcyoldSecCcyExchangeRate_adj"/>
				<xsl:call-template name="account1NetAmount_adj"/>
				<xsl:call-template name="account2_adj"/>
				<xsl:call-template name="account2CcyoldSecCcyExchangeRate_adj"/>
				<xsl:call-template name="account2NetAmount_adj"/>
				<xsl:call-template name="account3_adj"/>
				<xsl:call-template name="account3CcyoldSecCcyExchangeRate_adj"/>
				<xsl:call-template name="account3NetAmount_adj"/>
				<xsl:call-template name="accountingCode_adj"/>
				<xsl:call-template name="accountingDate_adj"/>
				<xsl:call-template name="accruedInterestAmount_adj"/>
				<xsl:call-template name="accruedInterestCounter_adj"/>
				<xsl:call-template name="adjustmentCounter_adj"/>
				<xsl:call-template name="adjustmentNature_adj"/>
				<xsl:call-template name="adjustmentPortfolio_adj"/>
				<xsl:call-template name="cashPortfolio_adj"/>
				<xsl:call-template name="coaReference_adj"/>
				<xsl:call-template name="commonReference_adj"/>
				<xsl:call-template name="communication_adj"/>
				<xsl:call-template name="initiator_adj"/>
				<xsl:call-template name="newQuantity_adj"/>
				<xsl:call-template name="newSecurity_adj"/>
				<xsl:call-template name="newSecurityCcyPositionCcyExchangeRate_adj"/>
				<xsl:call-template name="newSecurityDepositaryAccount_adj"/>
				<xsl:call-template name="newSecurityNetAmount_adj"/>
				<xsl:call-template name="newSecurityPositionCriteria1_adj"/>
				<xsl:call-template name="newSecurityPositionCriteria2_adj"/>
				<xsl:call-template name="newSecurityPositionCriteria3_adj"/>
				<xsl:call-template name="newSecurityPositionCurrency_adj"/>
				<xsl:call-template name="notepad_adj"/>
				<xsl:call-template name="oldCcyGrossAmount_adj"/>
				<xsl:call-template name="oldCcyNetAmount_adj"/>
				<xsl:call-template name="oldCcyPortfolioCcyExchangeRate_adj"/>
				<xsl:call-template name="oldPrice_adj"/>
				<xsl:call-template name="oldQuantity_adj"/>
				<xsl:call-template name="oldSecurity_adj"/>
				<xsl:call-template name="oldSecurityDepositaryAccount_adj"/>
				<xsl:call-template name="oldSecurityPositionCriteria1_adj"/>
				<xsl:call-template name="oldSecurityPositionCriteria2_adj"/>
				<xsl:call-template name="oldSecurityPositionCriteria3_adj"/>
				<xsl:call-template name="oldSecurityPositionCurrency_adj"/>
				<xsl:call-template name="portfolio_adj"/>
				<xsl:call-template name="portfolioManager_adj"/>
				<xsl:call-template name="remark_adj"/>
				<xsl:call-template name="reversalIndicator_adj"/>
				<xsl:call-template name="reversedTransactionCode_adj"/>
				<xsl:call-template name="sourceSystemCode_adj"/>
				<xsl:call-template name="status_adj"/>
				<xsl:call-template name="subType_adj"/>
				<xsl:call-template name="supplementaryAmount_adj"/>
				<xsl:call-template name="transactionCode_adj"/>
				<xsl:call-template name="transactionDate_adj"/>
				<xsl:call-template name="transactionFeesTaxesCounter_adj"/>
				<xsl:call-template name="type_adj"/>
				<xsl:call-template name="typeInstrument_adj"/>
				<xsl:call-template name="valueDate_adj"/>
				<xsl:call-template name="userDefinedField_adj"/>
				<xsl:call-template name="mbFields_adj"/>
			</Adjustment>
		</DataGroup>
	</xsl:template>
	<!-- END - Adjustment PL -->

	<!-- BEG - UpfrontPayment -->
	<xsl:template name="mappingUpfrontPayment">
		<DataGroup>
			<Withdrawal>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionRightsExecution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>

				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_Wd"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate_Wd"/>
				<xsl:call-template name="account1NetAmount_Wd"/>
				<xsl:call-template name="account2_Wd"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate_Wd"/>
				<xsl:call-template name="account2NetAmount_Wd"/>
				<xsl:call-template name="account3_Wd"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate_Wd"/>
				<xsl:call-template name="account3NetAmount_Wd"/>
				<xsl:call-template name="accountingCode_Wd"/>
				<xsl:call-template name="accountingDate_Wd"/>
				<xsl:call-template name="accruedInterestAmount_Wd"/>
				<xsl:call-template name="accruedInterestCounter_Wd"/>
				<xsl:call-template name="cashPortfolio_Wd"/>
				<xsl:call-template name="coaReference_Wd"/>
				<xsl:call-template name="commonReference_Wd"/>
				<xsl:call-template name="communication_Wd"/>
				<xsl:call-template name="depositaryAccount_Wd"/>
				<xsl:call-template name="initiator_Wd"/>
				<xsl:call-template name="notepad_Wd"/>
				<xsl:call-template name="portfolio_Wd"/>
				<xsl:call-template name="portfolioManager_Wd"/>
				<xsl:call-template name="positionCriteria1_Wd"/>
				<xsl:call-template name="positionCriteria2_Wd"/>
				<xsl:call-template name="positionCriteria3_Wd"/>
				<xsl:call-template name="remark_Wd"/>
				<xsl:call-template name="reversalIndicator_Wd"/>
				<xsl:call-template name="reversedTransactionCode_Wd"/>
				<xsl:call-template name="security_Wd"/>
				<xsl:call-template name="sourceSystemCode_Wd"/>
				<xsl:call-template name="status_Wd"/>
				<xsl:call-template name="subType_Wd"/>
				<xsl:call-template name="supplementaryAmount_Wd"/>
				<xsl:call-template name="tradeCcyGrossAmount_Wd"/>
				<xsl:call-template name="tradeCcyNetAmount_Wd"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Wd"/>
				<xsl:call-template name="tradeCurrency_Wd"/>
				<xsl:call-template name="tradePrice_Wd"/>
				<xsl:call-template name="tradeQuantity_Wd"/>
				<xsl:call-template name="transactionCode_Wd"/>
				<xsl:call-template name="transactionDate_Wd"/>
				<xsl:call-template name="transactionFeesTaxesCounter_Wd"/>
				<xsl:call-template name="type_Wd"/>
				<xsl:call-template name="typeInstrument_Wd"/>
				<xsl:call-template name="valueDate_Wd"/>
				<xsl:call-template name="userDefinedField_Wd"/>
				<xsl:call-template name="mbFields_Wd"/>
			</Withdrawal>
		</DataGroup>
	</xsl:template>
	<!-- END - UpfrontPayment -->

	<!-- BEG - Buy -->
	<xsl:template name="mappingBuy">
		<DataGroup>
			<Buy>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionRightsExecution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_Buy"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate_Buy"/>
				<xsl:call-template name="account1NetAmount_Buy"/>
				<xsl:call-template name="account2_Buy"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate_Buy"/>
				<xsl:call-template name="account2NetAmount_Buy"/>
				<xsl:call-template name="account3_Buy"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate_Buy"/>
				<xsl:call-template name="account3NetAmount_Buy"/>
				<xsl:call-template name="accountingCode_Buy"/>
				<xsl:call-template name="accountingDate_Buy"/>
				<xsl:call-template name="accruedInterestAmount_Buy"/>
				<xsl:call-template name="accruedInterestCounter_Buy"/>
				<xsl:call-template name="cashPortfolio_Buy"/>
				<xsl:call-template name="coaReference_Buy"/>
				<xsl:call-template name="commonReference_Buy"/>
				<xsl:call-template name="communication_Buy"/>
				<xsl:call-template name="depositaryAccount_Buy"/>
				<xsl:call-template name="initiator_Buy"/>
				<xsl:call-template name="notepad_Buy"/>
				<xsl:call-template name="portfolio_Buy"/>
				<xsl:call-template name="portfolioManager_Buy"/>
				<xsl:call-template name="positionCriteria1_Buy"/>
				<xsl:call-template name="positionCriteria2_Buy"/>
				<xsl:call-template name="positionCriteria3_Buy"/>
				<xsl:call-template name="remark_Buy"/>
				<xsl:call-template name="reversalIndicator_Buy"/>
				<xsl:call-template name="reversedTransactionCode_Buy"/>
				<xsl:call-template name="security_Buy"/>
				<xsl:call-template name="securityCcyNetAmount_Buy"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Buy"/>
				<xsl:call-template name="sourceSystemCode_Buy"/>
				<xsl:call-template name="status_Buy"/>
				<xsl:call-template name="subType_Buy"/>
				<xsl:call-template name="supplementaryAmount_Buy"/>
				<xsl:call-template name="tradeCcy_Buy"/>
				<xsl:call-template name="tradeCcyGrossAmount_Buy"/>
				<xsl:call-template name="tradeCcyNetAmount_Buy"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Buy"/>
				<xsl:call-template name="tradeCurrency_Buy"/>
				<xsl:call-template name="tradeExchangeRate_Buy"/>
				<xsl:call-template name="tradePrice_Buy"/>
				<xsl:call-template name="tradeQuantity_Buy"/>
				<xsl:call-template name="transactionCode_Buy"/>
				<xsl:call-template name="transactionDate_Buy"/>
				<xsl:call-template name="transactionFeesTaxesCounter_Buy"/>
				<xsl:call-template name="type_Buy"/>
				<xsl:call-template name="typeInstrument_Buy"/>
				<xsl:call-template name="valueDate_Buy"/>
				<xsl:call-template name="userDefinedField_Buy"/>
				<xsl:call-template name="mbFields_Buy"/>
			</Buy>
		</DataGroup>
	</xsl:template>
	<!-- END - Buy -->

	<!-- BEG - UpfrontPaymentReturned -->
	<xsl:template name="mappingUpfrontPaymentReturned">
		<DataGroup>
			<Investment>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionRightsExecution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_Inv"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate_Inv"/>
				<xsl:call-template name="account1NetAmount_Inv"/>
				<xsl:call-template name="account2_Inv"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate_Inv"/>
				<xsl:call-template name="account2NetAmount_Inv"/>
				<xsl:call-template name="account3_Inv"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate_Inv"/>
				<xsl:call-template name="account3NetAmount_Inv"/>
				<xsl:call-template name="accountingCode_Inv"/>
				<xsl:call-template name="accountingDate_Inv"/>
				<xsl:call-template name="accruedInterestAmount_Inv"/>
				<xsl:call-template name="accruedInterestCounter_Inv"/>
				<xsl:call-template name="cashPortfolio_Inv"/>
				<xsl:call-template name="coaReference_Inv"/>
				<xsl:call-template name="commonReference_Inv"/>
				<xsl:call-template name="communication_Inv"/>
				<xsl:call-template name="depositaryAccount_Inv"/>
				<xsl:call-template name="initiator_Inv"/>
				<xsl:call-template name="notepad_Inv"/>
				<xsl:call-template name="portfolio_Inv"/>
				<xsl:call-template name="portfolioManager_Inv"/>
				<xsl:call-template name="positionCriteria1_Inv"/>
				<xsl:call-template name="positionCriteria2_Inv"/>
				<xsl:call-template name="positionCriteria3_Inv"/>
				<xsl:call-template name="remark_Inv"/>
				<xsl:call-template name="reversalIndicator_Inv"/>
				<xsl:call-template name="reversedTransactionCode_Inv"/>
				<xsl:call-template name="security_Inv"/>
				<xsl:call-template name="sourceSystemCode_Inv"/>
				<xsl:call-template name="status_Inv"/>
				<xsl:call-template name="subType_Inv"/>
				<xsl:call-template name="supplementaryAmount_Inv"/>
				<xsl:call-template name="tradeCcyGrossAmount_Inv"/>
				<xsl:call-template name="tradeCcyNetAmount_Inv"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Inv"/>
				<xsl:call-template name="tradeCurrency_Inv"/>
				<xsl:call-template name="tradePrice_Inv"/>
				<xsl:call-template name="tradeQuantity_Inv"/>
				<xsl:call-template name="transactionCode_Inv"/>
				<xsl:call-template name="transactionDate_Inv"/>
				<xsl:call-template name="transactionFeesTaxesCounter_Inv"/>
				<xsl:call-template name="type_Inv"/>
				<xsl:call-template name="typeInstrument_Inv"/>
				<xsl:call-template name="valueDate_Inv"/>
				<xsl:call-template name="userDefinedField_Inv"/>
				<xsl:call-template name="mbFields_Inv"/>
			</Investment>
		</DataGroup>
	</xsl:template>
	<!-- END - UpfrontPaymentReturned -->

	<!-- BEG - SellorLapse -->
	<xsl:template name="mappingSellorLapse">
		<DataGroup>
			<Sell>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionRightsExecution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_Sell"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate_Sell"/>
				<xsl:call-template name="account1NetAmount_Sell"/>
				<xsl:call-template name="account2_Sell"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate_Sell"/>
				<xsl:call-template name="account2NetAmount_Sell"/>
				<xsl:call-template name="account3_Sell"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate_Sell"/>
				<xsl:call-template name="account3NetAmount_Sell"/>
				<xsl:call-template name="accountingCode_Sell"/>
				<xsl:call-template name="accountingDate_Sell"/>
				<xsl:call-template name="accruedInterestAmount_Sell"/>
				<xsl:call-template name="accruedInterestCounter_Sell"/>
				<xsl:call-template name="cashPortfolio_Sell"/>
				<xsl:call-template name="coaReference_Sell"/>
				<xsl:call-template name="commonReference_Sell"/>
				<xsl:call-template name="communication_Sell"/>
				<xsl:call-template name="depositaryAccount_Sell"/>
				<xsl:call-template name="initiator_Sell"/>
				<xsl:call-template name="notepad_Sell"/>
				<xsl:call-template name="portfolio_Sell"/>
				<xsl:call-template name="portfolioManager_Sell"/>
				<xsl:call-template name="positionCriteria1_Sell"/>
				<xsl:call-template name="positionCriteria2_Sell"/>
				<xsl:call-template name="positionCriteria3_Sell"/>
				<xsl:call-template name="remark_Sell"/>
				<xsl:call-template name="reversalIndicator_Sell"/>
				<xsl:call-template name="reversedTransactionCode_Sell"/>
				<xsl:call-template name="security_Sell"/>
				<xsl:call-template name="securityCcyNetAmount_Sell"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Sell"/>
				<xsl:call-template name="sourceSystemCode_Sell"/>
				<xsl:call-template name="status_Sell"/>
				<xsl:call-template name="subType_Sell"/>
				<xsl:call-template name="supplementaryAmount_Sell"/>
				<xsl:call-template name="tradeCcyGrossAmount_Sell"/>
				<xsl:call-template name="tradeCcyNetAmount_Sell"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Sell"/>
				<xsl:call-template name="tradeCurrency_Sell"/>
				<xsl:call-template name="tradePrice_Sell"/>
				<xsl:call-template name="tradeQuantity_Sell"/>
				<xsl:call-template name="transactionCode_Sell"/>
				<xsl:call-template name="transactionDate_Sell"/>
				<xsl:call-template name="transactionFeesTaxesCounter_Sell"/>
				<xsl:call-template name="type_Sell"/>
				<xsl:call-template name="typeInstrument_Sell"/>
				<xsl:call-template name="valueDate_Sell"/>
				<xsl:call-template name="userDefinedField_Sell"/>
				<xsl:call-template name="mbFields_Sell"/>
			</Sell>
		</DataGroup>
	</xsl:template>
	<!-- END - SellorLapse -->
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