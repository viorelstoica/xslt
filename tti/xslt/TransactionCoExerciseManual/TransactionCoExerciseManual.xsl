<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionCoExerciseManual"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionCoExerciseManual" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionCoExerciseManual" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoExerciseManual" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionCoExerciseManual">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionCoExerciseManual"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionCoExerciseManual">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionCoExerciseManual" name="BatchTransactionCoExerciseManual">
			<xsl:apply-templates select="b:TransactionCoExerciseManual"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionCoExerciseManual">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoExerciseManual" name="BatchMultiTransactionCoExerciseManual">
			<xsl:apply-templates select="c:MultiTransactionCoExerciseManual"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionCoExerciseManual">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionCoExerciseManual',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:for-each select="b:closeoutIdList/b:closeoutId">
				<xsl:variable name="index" select="@index"/>
					<Derivative>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionCoExerciseManual.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
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