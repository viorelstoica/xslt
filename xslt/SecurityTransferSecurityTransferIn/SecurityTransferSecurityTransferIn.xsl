<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiSecurityTransfer">
		<xsl:apply-templates select="c:CurrentEvent/b:SecurityTransfer"/>
	</xsl:template>
	<xsl:template match="batch:BatchSecurityTransfer">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" name="BatchSecurityTransfer">
			<xsl:apply-templates select="b:SecurityTransfer"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiSecurityTransfer">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" name="BatchMultiSecurityTransfer">
			<xsl:apply-templates select="c:MultiSecurityTransfer"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:SecurityTransfer">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('securityTransferIn',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Security>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('SecurityTransferSecurityTransferIn.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<transferIn>
						<xsl:call-template name="account1"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account1NetAmount"/>
						<xsl:call-template name="account2"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account2NetAmount"/>
						<xsl:call-template name="account3"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account3NetAmount"/>
						<xsl:call-template name="accountingCode"/>
						<xsl:call-template name="accountingDate"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="commonReference"/>
						<xsl:call-template name="ContractNumber"/>
						<xsl:call-template name="intermediary"/>
						<xsl:call-template name="market"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="transactionFeesTaxesCounter"/>
						<xsl:call-template name="type"/>
						<xsl:call-template name="valueDate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
						<xsl:call-template name="accountCurrency"/>
						<xsl:call-template name="accruedInterestCounter"/>
						<xsl:call-template name="accruedInterests"/>
						<xsl:call-template name="boAccount"/>
				  		<xsl:call-template name="boPortfolio"/>
						<xsl:call-template name="depositaryAccount"/>
						<xsl:call-template name="histOpExchRate"/>
						<xsl:call-template name="histOpNetAmount"/>
						<xsl:call-template name="histQuote"/>
						<xsl:call-template name="initiatedBy"/>
						<xsl:call-template name="paymentDate"/>
						<xsl:call-template name="paymentStatus"/>
						<xsl:call-template name="positionCriteria1"/>
						<xsl:call-template name="positionCriteria2"/>
						<xsl:call-template name="positionCriteria3"/>
						<xsl:call-template name="quantity"/>
						<xsl:call-template name="security"/>
						<xsl:call-template name="settlementDate"/>
						<xsl:call-template name="settlementStatus"/>
				  		<xsl:call-template name="splitPortfolio"/>
						<xsl:call-template name="trader"/>
						<xsl:call-template name="transactionCcyGrossAmount"/>
						<xsl:call-template name="transactionCcyNetAmount"/>
						<xsl:call-template name="transactionCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="transactionCurrency"/>
						<xsl:call-template name="transactionDate"/>
						<xsl:call-template name="transferPrice"/>
					</transferIn>
				</Security>
			</DataGroup>
			<!-- Transfer in for an upfront paid investment fund - we map 
            - a dummy security buy to map the fees from the original upfront payment security
            - a cash transfer in which re-invests back the cash fees that had been withdrawn with the upfront payment
          -->
			<xsl:if test="b:upfrontSec and b:upfrontSec = 'Y'">
				<DataGroup>
					<Cash>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('SecurityTransferSecurityTransferIn.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<transferIn>
							<xsl:call-template name="account1_FundUpFrInvFees"/>
							<xsl:call-template name="account1CcyTradeCcyExchangeRate_FundUpFrInvFees"/>
							<xsl:call-template name="account1NetAmount_FundUpFrInvFees"/>
							<xsl:call-template name="account2_FundUpFrInvFees"/>
							<xsl:call-template name="account2CcyTradeCcyExchangeRate_FundUpFrInvFees"/>
							<xsl:call-template name="account2NetAmount_FundUpFrInvFees"/>
							<xsl:call-template name="account3_FundUpFrInvFees"/>
							<xsl:call-template name="account3CcyTradeCcyExchangeRate_FundUpFrInvFees"/>
							<xsl:call-template name="account3NetAmount_FundUpFrInvFees"/>
							<xsl:call-template name="accountingCode_FundUpFrInvFees"/>
							<xsl:call-template name="accountingDate_FundUpFrInvFees"/>
							<xsl:call-template name="cashPortfolio_FundUpFrInvFees"/>
							<xsl:call-template name="commonReference_FundUpFrInvFees"/>
							<xsl:call-template name="ContractNumber_FundUpFrInvFees"/>
							<xsl:call-template name="intermediary_FundUpFrInvFees"/>
							<xsl:call-template name="market_FundUpFrInvFees"/>
							<xsl:call-template name="notepad_FundUpFrInvFees"/>
							<xsl:call-template name="portfolio_FundUpFrInvFees"/>
							<xsl:call-template name="portfolioManager_FundUpFrInvFees"/>
							<xsl:call-template name="remark_FundUpFrInvFees"/>
							<xsl:call-template name="reversalIndicator_FundUpFrInvFees"/>
							<xsl:call-template name="reversedTransactionCode_FundUpFrInvFees"/>
							<xsl:call-template name="sourceSystemCode_FundUpFrInvFees"/>
							<xsl:call-template name="status_FundUpFrInvFees"/>
							<xsl:call-template name="subType_FundUpFrInvFees"/>
							<xsl:call-template name="transactionCode_FundUpFrInvFees"/>
							<xsl:call-template name="transactionFeesTaxesCounter_FundUpFrInvFees"/>
							<xsl:call-template name="type_FundUpFrInvFees"/>
							<xsl:call-template name="valueDate_FundUpFrInvFees"/>
							<xsl:call-template name="userDefinedField_FundUpFrInvFees"/>
							<xsl:call-template name="mbFields_FundUpFrInvFees"/>
							<xsl:call-template name="currentAccount_FundUpFrInvFees"/>
							<xsl:call-template name="quantity_FundUpFrInvFees"/>
							<xsl:call-template name="transactionCcyGrossAmount_FundUpFrInvFees"/>
							<xsl:call-template name="transactionCcyNetAmount_FundUpFrInvFees"/>
							<xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_FundUpFrInvFees"/>
							<xsl:call-template name="transactionCurrency_FundUpFrInvFees"/>
							<xsl:call-template name="transactionDate_FundUpFrInvFees"/>
						</transferIn>
					</Cash>
					<Security>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('SecurityTransferSecurityTransferIn.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<purchase>
							<xsl:call-template name="account1_upfrontTradeFees"/>
							<xsl:call-template name="account1CcyTradeCcyExchangeRate_upfrontTradeFees"/>
							<xsl:call-template name="account1NetAmount_upfrontTradeFees"/>
							<xsl:call-template name="account2_upfrontTradeFees"/>
							<xsl:call-template name="account2CcyTradeCcyExchangeRate_upfrontTradeFees"/>
							<xsl:call-template name="account2NetAmount_upfrontTradeFees"/>
							<xsl:call-template name="account3_upfrontTradeFees"/>
							<xsl:call-template name="account3CcyTradeCcyExchangeRate_upfrontTradeFees"/>
							<xsl:call-template name="account3NetAmount_upfrontTradeFees"/>
							<xsl:call-template name="accountingCode_upfrontTradeFees"/>
							<xsl:call-template name="accountingDate_upfrontTradeFees"/>
							<xsl:call-template name="cashPortfolio_upfrontTradeFees"/>
							<xsl:call-template name="commonReference_upfrontTradeFees"/>
							<xsl:call-template name="ContractNumber_upfrontTradeFees"/>
							<xsl:call-template name="intermediary_upfrontTradeFees"/>
							<xsl:call-template name="market_upfrontTradeFees"/>
							<xsl:call-template name="notepad_upfrontTradeFees"/>
							<xsl:call-template name="portfolio_upfrontTradeFees"/>
							<xsl:call-template name="portfolioManager_upfrontTradeFees"/>
							<xsl:call-template name="remark_upfrontTradeFees"/>
							<xsl:call-template name="reversalIndicator_upfrontTradeFees"/>
							<xsl:call-template name="reversedTransactionCode_upfrontTradeFees"/>
							<xsl:call-template name="sourceSystemCode_upfrontTradeFees"/>
							<xsl:call-template name="status_upfrontTradeFees"/>
							<xsl:call-template name="subType_upfrontTradeFees"/>
							<xsl:call-template name="transactionCode_upfrontTradeFees"/>
							<xsl:call-template name="transactionFeesTaxesCounter_upfrontTradeFees"/>
							<xsl:call-template name="type_upfrontTradeFees"/>
							<xsl:call-template name="valueDate_upfrontTradeFees"/>
							<xsl:call-template name="userDefinedField_upfrontTradeFees"/>
							<xsl:call-template name="mbFields_upfrontTradeFees"/>
							<xsl:call-template name="accountCurrency_upfrontTradeFees"/>
							<xsl:call-template name="accruedInterests_upfrontTradeFees"/>
							<xsl:call-template name="accruedInterestCounter_upfrontTradeFees"/>
							<xsl:call-template name="broker_upfrontTradeFees"/>
							<xsl:call-template name="compundOrderCode_upfrontTradeFees"/>
							<xsl:call-template name="compoundOrderMaster_upfrontTradeFees"/>
							<xsl:call-template name="compoundOrderSlave_upfrontTradeFees"/>
							<xsl:call-template name="contactMethod_upfrontTradeFees"/>
							<xsl:call-template name="depositaryAccount_upfrontTradeFees"/>
							<xsl:call-template name="exCoupon_upfrontTradeFees"/>
							<xsl:call-template name="executionSetCriteria_upfrontTradeFees"/>
							<xsl:call-template name="initiatedBy_upfrontTradeFees"/>
							<xsl:call-template name="initiator_upfrontTradeFees"/>
							<xsl:call-template name="limitPrice_upfrontTradeFees"/>
							<xsl:call-template name="orderType_upfrontTradeFees"/>
							<xsl:call-template name="orderValidityType_upfrontTradeFees"/>
							<xsl:call-template name="originalOrderCode_upfrontTradeFees"/>
							<xsl:call-template name="paymentOptionE_upfrontTradeFees"/>
							<xsl:call-template name="positionCriteria1_upfrontTradeFees"/>
							<xsl:call-template name="positionCriteria2_upfrontTradeFees"/>
							<xsl:call-template name="positionCriteria3_upfrontTradeFees"/>
							<xsl:call-template name="price_upfrontTradeFees"/>
							<xsl:call-template name="quantity_upfrontTradeFees"/>
							<xsl:call-template name="security_upfrontTradeFees"/>
							<xsl:call-template name="securityCcyNetAmount_upfrontTradeFees"/>
							<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_upfrontTradeFees"/>
							<xsl:call-template name="stockExchange_upfrontTradeFees"/>
							<xsl:call-template name="stopPrice_upfrontTradeFees"/>
							<xsl:call-template name="targetAmount_upfrontTradeFees"/>
							<xsl:call-template name="targetNature_upfrontTradeFees"/>
							<xsl:call-template name="targetObjective_upfrontTradeFees"/>
							<xsl:call-template name="trader_upfrontTradeFees"/>
							<xsl:call-template name="tradeCurrency_upfrontTradeFees"/>
							<xsl:call-template name="tradeCcyGrossAmount_upfrontTradeFees"/>
							<xsl:call-template name="tradeCcyNetAmount_upfrontTradeFees"/>
							<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_upfrontTradeFees"/>
							<xsl:call-template name="tradeDate_upfrontTradeFees"/>
							<xsl:call-template name="validityDate_upfrontTradeFees"/>
						</purchase>
					</Security>
				</DataGroup>
			</xsl:if>
		</TransactionPMS>
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