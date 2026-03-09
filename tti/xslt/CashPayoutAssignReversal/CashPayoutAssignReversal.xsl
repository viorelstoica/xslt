<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAssignExpiryOptionSellCloseOutRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionSellCloseOutRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAssignExpiryOptionSellCloseOutRev"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionSellCloseOutRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionAssignExpiryOptionSellCloseOutRev">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionAssignExpiryOptionSellCloseOutRev"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionAssignExpiryOptionSellCloseOutRev">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionSellCloseOutRev" name="BatchTransactionAssignExpiryOptionSellCloseOutRev">
			<xsl:apply-templates select="b:TransactionAssignExpiryOptionSellCloseOutRev"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionAssignExpiryOptionSellCloseOutRev">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionSellCloseOutRev" name="BatchMultiTransactionAssignExpiryOptionSellCloseOutRev">
			<xsl:apply-templates select="c:MultiTransactionAssignExpiryOptionSellCloseOutRev"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionAssignExpiryOptionSellCloseOutRev">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionAssignExpiryOptionSellCloseOutRev',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Derivative>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionAssignExpiryOptionSellCloseOutRev.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<purchase>
						<xsl:call-template name="account1_purchase"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate_purchase"/>
						<xsl:call-template name="account1NetAmount_purchase"/>
						<xsl:call-template name="account2_purchase"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate_purchase"/>
						<xsl:call-template name="account2NetAmount_purchase"/>
						<xsl:call-template name="account3_purchase"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate_purchase"/>
						<xsl:call-template name="account3NetAmount_purchase"/>
						<xsl:call-template name="accountingCode_purchase"/>
						<xsl:call-template name="accountingDate_purchase"/>
						<xsl:call-template name="cashPortfolio_purchase"/>
						<xsl:call-template name="commonReference_purchase"/>
						<xsl:call-template name="ContractNumber_purchase"/>
						<xsl:call-template name="intermediary_purchase"/>
						<xsl:call-template name="market_purchase"/>
						<xsl:call-template name="notepad_purchase"/>
						<xsl:call-template name="portfolio_purchase"/>
						<xsl:call-template name="portfolioManager_purchase"/>
						<xsl:call-template name="remark_purchase"/>
						<xsl:call-template name="reversalIndicator_purchase"/>
						<xsl:call-template name="reversedTransactionCode_purchase"/>
						<xsl:call-template name="sourceSystemCode_purchase"/>
						<xsl:call-template name="status_purchase"/>
						<xsl:call-template name="subType_purchase"/>
						<xsl:call-template name="transactionCode_purchase"/>
						<xsl:call-template name="transactionFeesTaxesCounter_purchase"/>
						<xsl:call-template name="type_purchase"/>
						<xsl:call-template name="valueDate_purchase"/>
						<xsl:call-template name="userDefinedField-custo_purchase"/>
						<xsl:call-template name="userDefinedField_purchase"/>
						<xsl:call-template name="mbFields_purchase"/>
						<xsl:call-template name="accountCurrency_purchase"/>
						<xsl:call-template name="accuredInterest_purchase"/>
						<xsl:call-template name="accuredInterestCounter_purchase"/>
						<xsl:call-template name="boAccount_purchase"/>
						<xsl:call-template name="boPortfolio_purchase"/>
						<xsl:call-template name="broker_purchase"/>
						<xsl:call-template name="compoundOrderCode_purchase"/>
						<xsl:call-template name="compoundOrderMaster_purchase"/>
						<xsl:call-template name="compoundOrderSlave_purchase"/>
						<xsl:call-template name="contactMethod_purchase"/>
						<xsl:call-template name="depositaryAccount_purchase"/>
						<xsl:call-template name="exCoupon_purchase"/>
						<xsl:call-template name="executionSetCriteria_purchase"/>
						<xsl:call-template name="hierOperNature_purchase"/>
						<xsl:call-template name="initiatedBy_purchase"/>
						<xsl:call-template name="initiator_purchase"/>
						<xsl:call-template name="limitPrice_purchase"/>
						<xsl:call-template name="orderType_purchase"/>
						<xsl:call-template name="orderValidityType_purchase"/>
						<xsl:call-template name="originalOrderCode_purchase"/>
						<xsl:call-template name="paymentDate_purchase"/>
						<xsl:call-template name="paymentStatus_purchase"/>
						<xsl:call-template name="paymentOptionE_purchase"/>
						<xsl:call-template name="positionCriteria1_purchase"/>
						<xsl:call-template name="positionCriteria2_purchase"/>
						<xsl:call-template name="positionCriteria3_purchase"/>
						<xsl:call-template name="price_purchase"/>
						<xsl:call-template name="quantity_purchase"/>
						<xsl:call-template name="security_purchase"/>
						<xsl:call-template name="securityCcyNetAmount_purchase"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_purchase"/>
						<xsl:call-template name="settlementDate_purchase"/>
						<xsl:call-template name="settlementStatus_purchase"/>
						<xsl:call-template name="splitPortfolio_purchase"/>
						<xsl:call-template name="stockExchange_purchase"/>
						<xsl:call-template name="stopPrice_purchase"/>
						<xsl:call-template name="targetAmount_purchase"/>
						<xsl:call-template name="targetNature_purchase"/>
						<xsl:call-template name="targetObjective_purchase"/>
						<xsl:call-template name="trader_purchase"/>
						<xsl:call-template name="tradeCurrency_purchase"/>
						<xsl:call-template name="tradeCcyGrossAmount_purchase"/>
						<xsl:call-template name="tradeCcyNetAmount_purchase"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_purchase"/>
						<xsl:call-template name="tradeDate_purchase"/>
						<xsl:call-template name="validityDate_purchase"/>
						<xsl:call-template name="orderTypeD_purchase"/>
						<xsl:call-template name="referenceNature_purchase"/>
						<xsl:call-template name="referenceTransactionCode_purchase"/>
					</purchase>
				</Derivative>
			</DataGroup>
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