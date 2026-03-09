<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAssignExpiryOptionBuyCloseOutRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionBuyCloseOutRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAssignExpiryOptionBuyCloseOutRev"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionBuyCloseOutRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionAssignExpiryOptionBuyCloseOutRev">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionAssignExpiryOptionBuyCloseOutRev"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionAssignExpiryOptionBuyCloseOutRev">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionBuyCloseOutRev" name="BatchTransactionAssignExpiryOptionBuyCloseOutRev">
			<xsl:apply-templates select="b:TransactionAssignExpiryOptionBuyCloseOutRev"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionAssignExpiryOptionBuyCloseOutRev">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionBuyCloseOutRev" name="BatchMultiTransactionAssignExpiryOptionBuyCloseOutRev">
			<xsl:apply-templates select="c:MultiTransactionAssignExpiryOptionBuyCloseOutRev"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionAssignExpiryOptionBuyCloseOutRev">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionAssignExpiryOptionBuyCloseOutRev',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Derivative>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionAssignExpiryOptionBuyCloseOutRev.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<sale>
						<xsl:call-template name="account1_sale"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate_sale"/>
						<xsl:call-template name="account1NetAmount_sale"/>
						<xsl:call-template name="account2_sale"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate_sale"/>
						<xsl:call-template name="account2NetAmount_sale"/>
						<xsl:call-template name="account3_sale"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate_sale"/>
						<xsl:call-template name="account3NetAmount_sale"/>
						<xsl:call-template name="accountingCode_sale"/>
						<xsl:call-template name="accountingDate_sale"/>
						<xsl:call-template name="cashPortfolio_sale"/>
						<xsl:call-template name="commonReference_sale"/>
						<xsl:call-template name="ContractNumber_sale"/>
						<xsl:call-template name="intermediary_sale"/>
						<xsl:call-template name="market_sale"/>
						<xsl:call-template name="notepad_sale"/>
						<xsl:call-template name="portfolio_sale"/>
						<xsl:call-template name="portfolioManager_sale"/>
						<xsl:call-template name="remark_sale"/>
						<xsl:call-template name="reversalIndicator_sale"/>
						<xsl:call-template name="reversedTransactionCode_sale"/>
						<xsl:call-template name="sourceSystemCode_sale"/>
						<xsl:call-template name="status_sale"/>
						<xsl:call-template name="subType_sale"/>
						<xsl:call-template name="transactionCode_sale"/>
						<xsl:call-template name="transactionFeesTaxesCounter_sale"/>
						<xsl:call-template name="type_sale"/>
						<xsl:call-template name="valueDate_sale"/>
						<xsl:call-template name="userDefinedField-custo_sale"/>
						<xsl:call-template name="userDefinedField_sale"/>
						<xsl:call-template name="mbFields_sale"/>
						<xsl:call-template name="accountCurrency_sale"/>
						<xsl:call-template name="accuredInterest_sale"/>
						<xsl:call-template name="accuredInterestCounter_sale"/>
						<xsl:call-template name="boAccount_sale"/>
						<xsl:call-template name="boPortfolio_sale"/>
						<xsl:call-template name="broker_sale"/>
						<xsl:call-template name="compoundOrderCode_sale"/>
						<xsl:call-template name="compoundOrderMaster_sale"/>
						<xsl:call-template name="compoundOrderSlave_sale"/>
						<xsl:call-template name="contactMethod_sale"/>
						<xsl:call-template name="depositaryAccount_sale"/>
						<xsl:call-template name="exCoupon_sale"/>
						<xsl:call-template name="executionSetCriteria_sale"/>
						<xsl:call-template name="hierOperNature_sale"/>
						<xsl:call-template name="initiatedBy_sale"/>
						<xsl:call-template name="initiator_sale"/>
						<xsl:call-template name="limitPrice_sale"/>
						<xsl:call-template name="orderType_sale"/>
						<xsl:call-template name="orderValidityType_sale"/>
						<xsl:call-template name="originalOrderCode_sale"/>
						<xsl:call-template name="paymentDate_sale"/>
						<xsl:call-template name="paymentStatus_sale"/>
						<xsl:call-template name="paymentOptionE_sale"/>
						<xsl:call-template name="positionCriteria1_sale"/>
						<xsl:call-template name="positionCriteria2_sale"/>
						<xsl:call-template name="positionCriteria3_sale"/>
						<xsl:call-template name="price_sale"/>
						<xsl:call-template name="quantity_sale"/>
						<xsl:call-template name="security_sale"/>
						<xsl:call-template name="securityCcyNetAmount_sale"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_sale"/>
						<xsl:call-template name="settlementDate_sale"/>
						<xsl:call-template name="settlementStatus_sale"/>
						<xsl:call-template name="splitPortfolio_sale"/>
						<xsl:call-template name="stockExchange_sale"/>
						<xsl:call-template name="stopPrice_sale"/>
						<xsl:call-template name="targetAmount_sale"/>
						<xsl:call-template name="targetNature_sale"/>
						<xsl:call-template name="targetObjective_sale"/>
						<xsl:call-template name="trader_sale"/>
						<xsl:call-template name="tradeCurrency_sale"/>
						<xsl:call-template name="tradeCcyGrossAmount_sale"/>
						<xsl:call-template name="tradeCcyNetAmount_sale"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_sale"/>
						<xsl:call-template name="tradeDate_sale"/>
						<xsl:call-template name="validityDate_sale"/>
						<xsl:call-template name="orderTypeD_sale"/>
						<xsl:call-template name="referenceNature_sale"/>
						<xsl:call-template name="referenceTransactionCode_sale"/>
					</sale>
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