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
				<xsl:value-of select="concat('CoaOddlotEvent',b:diaryId)"/>
			</xsl:attribute>
			<xsl:for-each select="b:optionDescGroup[b:optionInd = 'BUYA']/b:newSecuritySubGroup[b:nominal &gt; '0']/b:newSecurity">
				<DataGroup>
					<Buy>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionOddlotEvent.xsl+', name(/*), '+', ../../../b:eventCommon/ns0:eventId, '+', ../../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_COAPurchase"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate_COAPurchase"/>
						<xsl:call-template name="account1NetAmount_COAPurchase"/>
						<xsl:call-template name="account2_COAPurchase"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate_COAPurchase"/>
						<xsl:call-template name="account2NetAmount_COAPurchase"/>
						<xsl:call-template name="account3_COAPurchase"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate_COAPurchase"/>
						<xsl:call-template name="account3NetAmount_COAPurchase"/>
						<xsl:call-template name="accountingCode_COAPurchase"/>
						<xsl:call-template name="accountingDate_COAPurchase"/>
						<xsl:call-template name="accruedInterestAmount_COAPurchase"/>
						<xsl:call-template name="accruedInterestCounter_COAPurchase"/>
						<xsl:call-template name="cashPortfolio_COAPurchase"/>
						<xsl:call-template name="coaReference_COAPurchase"/>
						<xsl:call-template name="commonReference_COAPurchase"/>
						<xsl:call-template name="communication_COAPurchase"/>
						<xsl:call-template name="depositaryAccount_COAPurchase"/>
						<xsl:call-template name="exDate_COAPurchase"/>
						<xsl:call-template name="initiator_COAPurchase"/>
						<xsl:call-template name="notepad_COAPurchase"/>
						<xsl:call-template name="portfolio_COAPurchase"/>
						<xsl:call-template name="portfolioManager_COAPurchase"/>
						<xsl:call-template name="positionCriteria1_COAPurchase"/>
						<xsl:call-template name="positionCriteria2_COAPurchase"/>
						<xsl:call-template name="positionCriteria3_COAPurchase"/>
						<xsl:call-template name="remark_COAPurchase"/>
						<xsl:call-template name="reversalIndicator_COAPurchase"/>
						<xsl:call-template name="reversedTransactionCode_COAPurchase"/>
						<xsl:call-template name="security_COAPurchase"/>
						<xsl:call-template name="securityCcyNetAmount_COAPurchase"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_COAPurchase"/>
						<xsl:call-template name="sourceSystemCode_COAPurchase"/>
						<xsl:call-template name="splitPortfolio_COAPurchase"/>
						<xsl:call-template name="status_COAPurchase"/>
						<xsl:call-template name="subType_COAPurchase"/>
						<xsl:call-template name="supplementaryAmount_COAPurchase"/>
						<xsl:call-template name="tradeCcyGrossAmount_COAPurchase"/>
						<xsl:call-template name="tradeCcyNetAmount_COAPurchase"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_COAPurchase"/>
						<xsl:call-template name="tradeCurrency_COAPurchase"/>
						<xsl:call-template name="tradePrice_COAPurchase"/>
						<xsl:call-template name="tradeQuantity_COAPurchase"/>
						<xsl:call-template name="transactionCode_COAPurchase"/>
						<xsl:call-template name="transactionDate_COAPurchase"/>
						<xsl:call-template name="transactionFeesTaxesCounter_COAPurchase"/>
						<xsl:call-template name="type_COAPurchase"/>
						<xsl:call-template name="typeInstrument_COAPurchase"/>
						<xsl:call-template name="valueDate_COAPurchase"/>
						<xsl:call-template name="userDefinedField_COAPurchase"/>
						<xsl:call-template name="mbFields_COAPurchase"/>	
					</Buy>
				</DataGroup>
			</xsl:for-each>
			<xsl:for-each select="b:optionDescGroup[b:optionInd = 'SLLE']/b:newSecuritySubGroup[b:nominal &gt; '0']/b:newSecurity">
				<DataGroup>
					<Sell>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionOddlotEvent.xsl+', name(/*), '+', ../../../b:eventCommon/ns0:eventId, '+', ../../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_COASale"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate_COASale"/>
						<xsl:call-template name="account1NetAmount_COASale"/>
						<xsl:call-template name="account2_COASale"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate_COASale"/>
						<xsl:call-template name="account2NetAmount_COASale"/>
						<xsl:call-template name="account3_COASale"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate_COASale"/>
						<xsl:call-template name="account3NetAmount_COASale"/>
						<xsl:call-template name="accountingCode_COASale"/>
						<xsl:call-template name="accountingDate_COASale"/>
						<xsl:call-template name="accruedInterestAmount_COASale"/>
						<xsl:call-template name="accruedInterestCounter_COASale"/>
						<xsl:call-template name="cashPortfolio_COASale"/>
						<xsl:call-template name="coaReference_COASale"/>
						<xsl:call-template name="commonReference_COASale"/>
						<xsl:call-template name="communication_COASale"/>
						<xsl:call-template name="depositaryAccount_COASale"/>
						<xsl:call-template name="exDate_COASale"/>
						<xsl:call-template name="initiator_COASale"/>
						<xsl:call-template name="notepad_COASale"/>
						<xsl:call-template name="portfolio_COASale"/>
						<xsl:call-template name="portfolioManager_COASale"/>
						<xsl:call-template name="positionCriteria1_COASale"/>
						<xsl:call-template name="positionCriteria2_COASale"/>
						<xsl:call-template name="positionCriteria3_COASale"/>
						<xsl:call-template name="remark_COASale"/>
						<xsl:call-template name="reversalIndicator_COASale"/>
						<xsl:call-template name="reversedTransactionCode_COASale"/>
						<xsl:call-template name="security_COASale"/>
						<xsl:call-template name="securityCcyNetAmount_COASale"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_COASale"/>
						<xsl:call-template name="sourceSystemCode_COASale"/>
						<xsl:call-template name="splitPortfolio_COASale"/>
						<xsl:call-template name="status_COASale"/>
						<xsl:call-template name="subType_COASale"/>
						<xsl:call-template name="supplementaryAmount_COASale"/>
						<xsl:call-template name="tradeCcyGrossAmount_COASale"/>
						<xsl:call-template name="tradeCcyNetAmount_COASale"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_COASale"/>
						<xsl:call-template name="tradeCurrency_COASale"/>
						<xsl:call-template name="tradePrice_COASale"/>
						<xsl:call-template name="tradeQuantity_COASale"/>
						<xsl:call-template name="transactionCode_COASale"/>
						<xsl:call-template name="transactionDate_COASale"/>
						<xsl:call-template name="transactionFeesTaxesCounter_COASale"/>
						<xsl:call-template name="type_COASale"/>
						<xsl:call-template name="typeInstrument_COASale"/>
						<xsl:call-template name="valueDate_COASale"/>
						<xsl:call-template name="userDefinedField_COASale"/>
						<xsl:call-template name="mbFields_COASale"/>	
					</Sell>
				</DataGroup>
			</xsl:for-each>
		</GenericCOA>
	</xsl:template>
	<!-- End of TransactionEntitlement -->
</xsl:stylesheet>