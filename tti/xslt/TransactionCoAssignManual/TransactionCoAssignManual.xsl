<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionCoAssignManual"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionCoAssignManual" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionCoAssignManual" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoAssignManual" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionCoAssignManual">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionCoAssignManual"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionCoAssignManual">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionCoAssignManual" name="BatchTransactionCoAssignManual">
			<xsl:apply-templates select="b:TransactionCoAssignManual"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionCoAssignManual">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoAssignManual" name="BatchMultiTransactionCoAssignManual">
			<xsl:apply-templates select="c:MultiTransactionCoAssignManual"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionCoAssignManual">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionCoAssignManual',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:for-each select="b:closeoutIdList/b:closeoutId">
				<xsl:variable name="index" select="@index"/>
					<Derivative>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionCoAssignManual.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:choose>
							<xsl:when test="((../../b:coPgmList/b:coPgm[@index=$index] and ../../b:coPgmList/b:coPgm[@index=$index] !='DX.XO.INSTANT.CASHPAYOUT') or not(../../b:coPgmList/b:coPgm)) and ((../../b:settlementMethodList/b:settlementMethod[@index=$index] and ../../b:settlementMethodList/b:settlementMethod[@index=$index]!='CASH') or not(../../b:settlementMethodList/b:settlementMethod[@index=$index])) ">
								<bookValueAdjust>
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
									<xsl:call-template name="userDefinedField-custo"/>
									<xsl:call-template name="userDefinedField"/>
									<xsl:call-template name="mbFields"/>
									<xsl:call-template name="adjustmentNature"/>
									<xsl:call-template name="coaReference"/>
									<xsl:call-template name="depositaryAccount"/>
									<xsl:call-template name="initiatedBy"/>
									<xsl:call-template name="initiator"/>
									<xsl:call-template name="newInstrumentQuantity"/>
									<xsl:call-template name="originalDepositaryAccount"/>
									<xsl:call-template name="originalInstrumentQuantity"/>
									<xsl:call-template name="originalPositionCriteria1"/>
									<xsl:call-template name="originalPositionCriteria2"/>
									<xsl:call-template name="originalPositionCriteria3"/>
									<xsl:call-template name="originalSecurity"/>
									<xsl:call-template name="originalSecurityPositionCurrency"/>
									<xsl:call-template name="PositionCriteria1"/>
									<xsl:call-template name="positionCriteria2"/>
									<xsl:call-template name="positionCriteria3"/>
									<xsl:call-template name="positionCurrency"/>
									<xsl:call-template name="profitLossCounter"/>
									<xsl:call-template name="quote"/>
									<xsl:call-template name="referenceNature"/>
									<xsl:call-template name="referenceOperationCode"/>
									<xsl:call-template name="security"/>
									<xsl:call-template name="supplementAmount"/>
									<xsl:call-template name="trader"/>
									<xsl:call-template name="transactionDate"/>
								</bookValueAdjust>
							</xsl:when>
							<xsl:when test="(../../b:coPgmList/b:coPgm[@index=$index] and ../../b:coPgmList/b:coPgm[@index=$index]='DX.XO.INSTANT.CASHPAYOUT')or (../../b:settlementMethodList/b:settlementMethod[@index=$index] and ../../b:settlementMethodList/b:settlementMethod[@index=$index]='CASH')">
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
							</xsl:when>
						</xsl:choose>
					</Derivative>
				</xsl:for-each>
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