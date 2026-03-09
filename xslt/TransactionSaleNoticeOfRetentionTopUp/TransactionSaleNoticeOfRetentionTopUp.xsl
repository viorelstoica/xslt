<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
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
	<xsl:template match="b:TransactionEntitlement">
		<GenericCOA>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CoaSaleNotice',b:diaryId)"/>
			</xsl:attribute>
			<xsl:if test="b:finalSubscrQty &gt; '0' and b:optStatus = 'COMPLETED'">
				<DataGroup>
					<Buy>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionSaleNoticeOfRetentionTopUp.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_Purchase"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate_Purchase"/>
						<xsl:call-template name="account1NetAmount_Purchase"/>
						<xsl:call-template name="account2_Purchase"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate_Purchase"/>
						<xsl:call-template name="account2NetAmount_Purchase"/>
						<xsl:call-template name="account3_Purchase"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate_Purchase"/>
						<xsl:call-template name="account3NetAmount_Purchase"/>
						<xsl:call-template name="accountingCode_Purchase"/>
						<xsl:call-template name="accountingDate_Purchase"/>
						<xsl:call-template name="accruedInterestAmount_Purchase"/>
						<xsl:call-template name="accruedInterestCounter_Purchase"/>
						<xsl:call-template name="cashPortfolio_Purchase"/>
						<xsl:call-template name="coaReference_Purchase"/>
						<xsl:call-template name="commonReference_Purchase"/>
						<xsl:call-template name="communication_Purchase"/>
						<xsl:call-template name="depositaryAccount_Purchase"/>
						<xsl:call-template name="exDate_Purchase"/>
						<xsl:call-template name="initiator_Purchase"/>
						<xsl:call-template name="notepad_Purchase"/>
						<xsl:call-template name="portfolio_Purchase"/>
						<xsl:call-template name="portfolioManager_Purchase"/>
						<xsl:call-template name="positionCriteria1_Purchase"/>
						<xsl:call-template name="positionCriteria2_Purchase"/>
						<xsl:call-template name="positionCriteria3_Purchase"/>
						<xsl:call-template name="remark_Purchase"/>
						<xsl:call-template name="reversalIndicator_Purchase"/>
						<xsl:call-template name="reversedTransactionCode_Purchase"/>
						<xsl:call-template name="security_Purchase"/>
						<xsl:call-template name="securityCcyNetAmount_Purchase"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Purchase"/>
						<xsl:call-template name="sourceSystemCode_Purchase"/>
						<xsl:call-template name="splitPortfolio_Purchase"/>
						<xsl:call-template name="status_Purchase"/>
						<xsl:call-template name="subType_Purchase"/>
						<xsl:call-template name="supplementaryAmount_Purchase"/>
						<xsl:call-template name="tradeCcyGrossAmount_Purchase"/>
						<xsl:call-template name="tradeCcyNetAmount_Purchase"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Purchase"/>
						<xsl:call-template name="tradeCurrency_Purchase"/>
						<xsl:call-template name="tradePrice_Purchase"/>
						<xsl:call-template name="tradeQuantity_Purchase"/>
						<xsl:call-template name="transactionCode_Purchase"/>
						<xsl:call-template name="transactionDate_Purchase"/>
						<xsl:call-template name="transactionFeesTaxesCounter_Purchase"/>
						<xsl:call-template name="type_Purchase"/>
						<xsl:call-template name="typeInstrument_Purchase"/>
						<xsl:call-template name="valueDate_Purchase"/>
						<xsl:call-template name="userDefinedField_Purchase"/>
						<xsl:call-template name="mbFields_Purchase"/>
					</Buy>
				</DataGroup>
			</xsl:if>
			<xsl:if test="b:upfrontPaymentDiaryJoin ='YES'">
				<xsl:choose>
					<xsl:when test="b:optStatus = 'PAID'">
						<DataGroup>
							<Withdrawal>
								<xsl:attribute name="description">
									<xsl:value-of select="concat('TransactionSaleNoticeOfRetentionTopUp.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
								</xsl:attribute>
								<xsl:attribute name="sequenceNumber">
									<xsl:call-template name="calcSeqNum">
										<xsl:with-param name="creationTime">
											<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="account1_withdrawal"/>
								<xsl:call-template name="account1CcyTradeCcyExchangeRate_withdrawal"/>
								<xsl:call-template name="account1NetAmount_withdrawal"/>
								<xsl:call-template name="account2_withdrawal"/>
								<xsl:call-template name="account2CcyTradeCcyExchangeRate_withdrawal"/>
								<xsl:call-template name="account2NetAmount_withdrawal"/>
								<xsl:call-template name="account3_withdrawal"/>
								<xsl:call-template name="account3CcyTradeCcyExchangeRate_withdrawal"/>
								<xsl:call-template name="account3NetAmount_withdrawal"/>
								<xsl:call-template name="accountingCode_withdrawal"/>
								<xsl:call-template name="accountingDate_withdrawal"/>
								<xsl:call-template name="accruedInterestAmount_withdrawal"/>
								<xsl:call-template name="accruedInterestCounter_withdrawal"/>
								<xsl:call-template name="cashPortfolio_withdrawal"/>
								<xsl:call-template name="coaReference_withdrawal"/>
								<xsl:call-template name="commonReference_withdrawal"/>
								<xsl:call-template name="communication_withdrawal"/>
								<xsl:call-template name="depositaryAccount_withdrawal"/>
								<xsl:call-template name="exDate_withdrawal"/>
								<xsl:call-template name="initiator_withdrawal"/>
								<xsl:call-template name="notepad_withdrawal"/>
								<xsl:call-template name="portfolio_withdrawal"/>
								<xsl:call-template name="portfolioManager_withdrawal"/>
								<xsl:call-template name="positionCriteria1_withdrawal"/>
								<xsl:call-template name="positionCriteria2_withdrawal"/>
								<xsl:call-template name="positionCriteria3_withdrawal"/>
								<xsl:call-template name="remark_withdrawal"/>
								<xsl:call-template name="reversalIndicator_withdrawal"/>
								<xsl:call-template name="reversedTransactionCode_withdrawal"/>
								<xsl:call-template name="security_withdrawal"/>
								<xsl:call-template name="sourceSystemCode_withdrawal"/>
								<xsl:call-template name="splitPortfolio_withdrawal"/>
								<xsl:call-template name="status_withdrawal"/>
								<xsl:call-template name="subType_withdrawal"/>
								<xsl:call-template name="supplementaryAmount_withdrawal"/>
								<xsl:call-template name="tradeCcyGrossAmount_withdrawal"/>
								<xsl:call-template name="tradeCcyNetAmount_withdrawal"/>
								<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_withdrawal"/>
								<xsl:call-template name="tradeCurrency_withdrawal"/>
								<xsl:call-template name="tradePrice_withdrawal"/>
								<xsl:call-template name="tradeQuantity_withdrawal"/>
								<xsl:call-template name="transactionCode_withdrawal"/>
								<xsl:call-template name="transactionDate_withdrawal"/>
								<xsl:call-template name="transactionFeesTaxesCounter_withdrawal"/>
								<xsl:call-template name="type_withdrawal"/>
								<xsl:call-template name="typeInstrument_withdrawal"/>
								<xsl:call-template name="valueDate_withdrawal"/>
								<xsl:call-template name="userDefinedField_withdrawal"/>
								<xsl:call-template name="mbFields_withdrawal"/>
							</Withdrawal>
						</DataGroup>
					</xsl:when>
					<xsl:when test="b:optStatus = 'COMPLETED' and b:finalSubscrQty &gt; '0'">
						<DataGroup>
							<Investment>
								<xsl:attribute name="description">
									<xsl:value-of select="concat('TransactionSaleNoticeOfRetentionTopUp.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
								</xsl:attribute>
								<xsl:attribute name="sequenceNumber">
									<xsl:call-template name="calcSeqNum">
										<xsl:with-param name="creationTime">
											<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="account1_Investment"/>
								<xsl:call-template name="account1CcyTradeCcyExchangeRate_Investment"/>
								<xsl:call-template name="account1NetAmount_Investment"/>
								<xsl:call-template name="account2_Investment"/>
								<xsl:call-template name="account2CcyTradeCcyExchangeRate_Investment"/>
								<xsl:call-template name="account2NetAmount_Investment"/>
								<xsl:call-template name="account3_Investment"/>
								<xsl:call-template name="account3CcyTradeCcyExchangeRate_Investment"/>
								<xsl:call-template name="account3NetAmount_Investment"/>
								<xsl:call-template name="accountingCode_Investment"/>
								<xsl:call-template name="accountingDate_Investment"/>
								<xsl:call-template name="accruedInterestAmount_Investment"/>
								<xsl:call-template name="accruedInterestCounter_Investment"/>
								<xsl:call-template name="cashPortfolio_Investment"/>
								<xsl:call-template name="coaReference_Investment"/>
								<xsl:call-template name="commonReference_Investment"/>
								<xsl:call-template name="communication_Investment"/>
								<xsl:call-template name="depositaryAccount_Investment"/>
								<xsl:call-template name="exDate_Investment"/>
								<xsl:call-template name="initiator_Investment"/>
								<xsl:call-template name="notepad_Investment"/>
								<xsl:call-template name="portfolio_Investment"/>
								<xsl:call-template name="portfolioManager_Investment"/>
								<xsl:call-template name="positionCriteria1_Investment"/>
								<xsl:call-template name="positionCriteria2_Investment"/>
								<xsl:call-template name="positionCriteria3_Investment"/>
								<xsl:call-template name="remark_Investment"/>
								<xsl:call-template name="reversalIndicator_Investment"/>
								<xsl:call-template name="reversedTransactionCode_Investment"/>
								<xsl:call-template name="security_Investment"/>
								<xsl:call-template name="sourceSystemCode_Investment"/>
								<xsl:call-template name="splitPortfolio_Investment"/>
								<xsl:call-template name="status_Investment"/>
								<xsl:call-template name="subType_Investment"/>
								<xsl:call-template name="supplementaryAmount_Investment"/>
								<xsl:call-template name="tradeCcyGrossAmount_Investment"/>
								<xsl:call-template name="tradeCcyNetAmount_Investment"/>
								<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Investment"/>
								<xsl:call-template name="tradeCurrency_Investment"/>
								<xsl:call-template name="tradePrice_Investment"/>
								<xsl:call-template name="tradeQuantity_Investment"/>
								<xsl:call-template name="transactionCode_Investment"/>
								<xsl:call-template name="transactionDate_Investment"/>
								<xsl:call-template name="transactionFeesTaxesCounter_Investment"/>
								<xsl:call-template name="type_Investment"/>
								<xsl:call-template name="typeInstrument_Investment"/>
								<xsl:call-template name="valueDate_Investment"/>
								<xsl:call-template name="userDefinedField_Investment"/>
								<xsl:call-template name="mbFields_Investment"/>
							</Investment>
						</DataGroup>
					</xsl:when>
				</xsl:choose>
			</xsl:if>

			<xsl:if test="b:finalDebitQty &gt; '0'">
				<xsl:if test="b:optStatus = 'COMPLETED'">
					<DataGroup>
						<Sell>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('TransactionSaleNoticeOfRetentionTopUp.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
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
							<xsl:call-template name="exDate_Sell"/>
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
							<xsl:call-template name="splitPortfolio_Sell"/>
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
				</xsl:if>
			</xsl:if>
		</GenericCOA>
	</xsl:template>
	<!-- End of TransactionEntitlement -->
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