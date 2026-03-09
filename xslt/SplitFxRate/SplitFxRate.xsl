<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/FxValuation" xmlns:b="http://www.temenos.com/T24/event/TTI/generateFxPositions" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="batch:BatchgenerateFxPositions">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions" name="BatchgenerateFxPositions">
			<xsl:apply-templates select="b:generateFxPositions"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:generateFxPositions">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('SplitFxRate',b:fxValuationRec/ns1:portfolioId)"/>
			</xsl:attribute>

			<xsl:for-each select="b:fxValuationRec/ns1:fxValuesList">
				<xsl:choose>
					<xsl:when test="ns1:baseCcy = ns1:currencySold and ns1:dealType='FW' and ns1:currencyBought = ns1:SecurityCcy">
						<xsl:variable name="fxContractId" select="ns1:fxContractId"/>
						<xsl:variable name="index" select="ns1:index"/>
							<DataGroup>
								<ForexForward>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('SplitFxRate.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="mapping_purchaseOpening"/>
								</ForexForward>
							</DataGroup>
					</xsl:when>
					<xsl:when test="ns1:baseCcy = ns1:currencyBought and ns1:dealType='FW' and ns1:currencySold = ns1:SecurityCcy">
						<xsl:variable name="fxContractId" select="ns1:fxContractId"/>
						<xsl:variable name="index" select="ns1:index"/>
							<DataGroup>
								<ForexForward>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('SplitFxRate.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="mapping_SaleOpening"/>
								</ForexForward>
							</DataGroup>
					</xsl:when>
					<xsl:when test="ns1:buySellInd='SELL' and ns1:portfolioNumber != '' and ns1:dealType ='ND' and ns1:dealCurrency != ns1:SecurityCcy">
						<xsl:variable name="fxContractId" select="ns1:fxContractId"/>
						<xsl:variable name="index" select="ns1:index"/>
							<DataGroup>
								<ForexForward>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('SplitFxRate.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="mapping_nd_PurchaseOpening"/>
								</ForexForward>
							</DataGroup>
					</xsl:when>
					<xsl:when test="ns1:buySellInd='BUY' and ns1:portfolioNumber != '' and ns1:dealType ='ND' and ns1:dealCurrency != ns1:SecurityCcy">
						<xsl:variable name="fxContractId" select="ns1:fxContractId"/>
						<xsl:variable name="index" select="ns1:index"/>
							<DataGroup>
								<ForexForward>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('SplitFxRate.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="mapping_nd_saleOpening"/>
								</ForexForward>
							</DataGroup>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</TransactionPMS>
	</xsl:template>

	<!-- BEG - Mapping for node record -->
	<xsl:template name="mapping_purchaseOpening">
		<forwardPurchaseOpening>
			<xsl:call-template name="account2_purchase"/>
			<xsl:call-template name="account2CcyTradeCcyExchangeRate_purchase"/>
			<xsl:call-template name="account2NetAmount_purchase"/>
			<xsl:call-template name="account3_purchase"/>
			<xsl:call-template name="account3CcyTradeCcyExchangeRate_purchase"/>
			<xsl:call-template name="account3NetAmount_purchase"/>
			<xsl:call-template name="accountingCode_purchase"/>
			<xsl:call-template name="accountingDate_purchase"/>
			<xsl:call-template name="cashPortfolio_purchase"/>
			<xsl:call-template name="commonRefernce_purchase"/>
			<xsl:call-template name="contractNumber_purchase"/>
			<xsl:call-template name="initiatedBy_purchase"/>
			<xsl:call-template name="initiator_purchase"/>
			<xsl:call-template name="notepad_purchase"/>
			<xsl:call-template name="portfolio_purchase"/>
			<xsl:call-template name="portfolioManager_purchase"/>
			<xsl:call-template name="currentAccountCcyPortfolioCcyExchangeRate_purchase"/>
			<xsl:call-template name="remark_purchase"/>
			<xsl:call-template name="reversalIndicator_purchase"/>
			<xsl:call-template name="reversedTransactionCode_purchase"/>
			<xsl:call-template name="sourceSystemCode_purchase"/>
			<xsl:call-template name="status_purchase"/>
			<xsl:call-template name="subType_purchase"/>
			<xsl:call-template name="trader_purchase"/>
			<xsl:call-template name="transactionFeesTaxesCounter_purchase"/>
			<xsl:call-template name="type_purchase"/>
			<xsl:call-template name="userDefinedField_purchase"/>
			<xsl:call-template name="mbFields_purchase"/>
			<xsl:call-template name="account1CcyTradeCcyExchangeRate_purchase"/>
			<xsl:call-template name="autoClosing_purchase"/>
			<xsl:call-template name="contractReferenceCode_purchase"/>
			<xsl:call-template name="expirationDate_purchase"/>
			<xsl:call-template name="forwardContract_purchase"/>
			<xsl:call-template name="forwardExchangeRate_purchase"/>
			<xsl:call-template name="fxClientRate_purchase"/>
			<xsl:call-template name="fxMarketRate_purchase"/>
			<xsl:call-template name="fxMargin_purchase"/>
			<xsl:call-template name="fxMarginP_purchase"/>
			<xsl:call-template name="fxRateDirection_purchase"/>
			<xsl:call-template name="initiationDate_purchase"/>
			<xsl:call-template name="operationAmount_purchase"/>
			<xsl:call-template name="purchasedQuantity_purchase"/>
			<xsl:call-template name="soldCcyCurrentAccount_purchase"/>
			<xsl:call-template name="soldCcyNetAmount_purchase"/>
			<xsl:call-template name="spotExchangeRate_purchase"/>
			<xsl:call-template name="startingDate_purchase"/>
			
			<xsl:call-template name="custoDefinitions_purchase"/>
			<xsl:call-template name="mbCustoDefinitions_purchase"/>
		</forwardPurchaseOpening>
	</xsl:template>

	<xsl:template name="mapping_SaleOpening">
		<forwardSaleOpening>
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
			<xsl:call-template name="contractNumber_sale"/>
			<xsl:call-template name="initiatedBy_sale"/>
			<xsl:call-template name="initiator_sale"/>
			<xsl:call-template name="notepad_sale"/>
			<xsl:call-template name="portfolio_sale"/>
			<xsl:call-template name="portfolioManager_sale"/>
			<xsl:call-template name="currentAccountCcyPortfolioCcyExchangeRate_sale"/>
			<xsl:call-template name="remark_sale"/>
			<xsl:call-template name="reversalIndicator_sale"/>
			<xsl:call-template name="reversedTransactionCode_sale"/>
			<xsl:call-template name="sourceSystemCode_sale"/>
			<xsl:call-template name="status_sale"/>
			<xsl:call-template name="subType_sale"/>
			<xsl:call-template name="trader_sale"/>
			<xsl:call-template name="transactionFeesTaxesCounter_sale"/>
			<xsl:call-template name="type_sale"/>
			<xsl:call-template name="userDefinedField_sale"/>
			<xsl:call-template name="mbFields_sale"/>
			<xsl:call-template name="account1CcyTradeCcyExchangeRate_sale"/>
			<xsl:call-template name="autoClosing_sale"/>
			<xsl:call-template name="contractReferenceCode_sale"/>
			<xsl:call-template name="expirationDate_sale"/>
			<xsl:call-template name="forwardContract_sale"/>
			<xsl:call-template name="forwardExchangeRate_sale"/>
			<xsl:call-template name="fxClientRate_sale"/>
			<xsl:call-template name="fxMargin_sale"/>
			<xsl:call-template name="fxMarginP_sale"/>
			<xsl:call-template name="fxMarketRate_sale"/>
			<xsl:call-template name="fxRateDirection_sale"/>
			<xsl:call-template name="initiationDate_sale"/>
			<xsl:call-template name="operationAmount_sale"/>
			<xsl:call-template name="operationGrossAmount_sale"/>
			<xsl:call-template name="priceCalculationRule_sale"/>
			<xsl:call-template name="purchasedCcyCurrentAccount_sale"/>
			<xsl:call-template name="purchasedCcyNetAmount_sale"/>
			<xsl:call-template name="soldQuantity_sale"/>
			<xsl:call-template name="spotExchangeRate_sale"/>
			<xsl:call-template name="startingDate_sale"/>
			
			<xsl:call-template name="custoDefinitions_sale"/>
			<xsl:call-template name="mbCustoDefinitions_sale"/>
		</forwardSaleOpening>
	</xsl:template>

	<xsl:template name="mapping_nd_PurchaseOpening">
		<forwardPurchaseOpening>
			<xsl:call-template name="account2_nd_purchase"/>
			<xsl:call-template name="account2CcyTradeCcyExchangeRate_nd_purchase"/>
			<xsl:call-template name="account2NetAmount_nd_purchase"/>
			<xsl:call-template name="account3_nd_purchase"/>
			<xsl:call-template name="account3CcyTradeCcyExchangeRate_nd_purchase"/>
			<xsl:call-template name="account3NetAmount_nd_purchase"/>
			<xsl:call-template name="accountingCode_nd_purchase"/>
			<xsl:call-template name="accountingDate_nd_purchase"/>
			<xsl:call-template name="cashPortfolio_nd_purchase"/>
			<xsl:call-template name="commonRefernce_nd_purchase"/>
			<xsl:call-template name="contractNumber_nd_purchase"/>
			<xsl:call-template name="initiatedBy_nd_purchase"/>
			<xsl:call-template name="initiator_nd_purchase"/>
			<xsl:call-template name="notepad_nd_purchase"/>
			<xsl:call-template name="portfolio_nd_purchase"/>
			<xsl:call-template name="portfolioManager_nd_purchase"/>
			<xsl:call-template name="currentAccountCcyPortfolioCcyExchangeRate_nd_purchase"/>
			<xsl:call-template name="remark_nd_purchase"/>
			<xsl:call-template name="reversalIndicator_nd_purchase"/>
			<xsl:call-template name="reversedTransactionCode_nd_purchase"/>
			<xsl:call-template name="sourceSystemCode_nd_purchase"/>
			<xsl:call-template name="status_nd_purchase"/>
			<xsl:call-template name="subType_nd_purchase"/>
			<xsl:call-template name="trader_nd_purchase"/>
			<xsl:call-template name="transactionFeesTaxesCounter_nd_purchase"/>
			<xsl:call-template name="type_nd_purchase"/>
			<xsl:call-template name="userDefinedField_nd_purchase"/>
			<xsl:call-template name="mbFields_nd_purchase"/>
			<xsl:call-template name="account1CcyTradeCcyExchangeRate_nd_purchase"/>
			<xsl:call-template name="autoClosing_nd_purchase"/>
			<xsl:call-template name="contractReferenceCode_nd_purchase"/>
			<xsl:call-template name="expirationDate_nd_purchase"/>
			<xsl:call-template name="fixingDate_nd_purchase"/>
			<xsl:call-template name="forwardContract_nd_purchase"/>
			<xsl:call-template name="forwardExchangeRate_nd_purchase"/>
			<xsl:call-template name="fxClientRate_nd_purchase"/>
			<xsl:call-template name="fxMarketRate_nd_purchase"/>
			<xsl:call-template name="fxMargin_nd_purchase"/>
			<xsl:call-template name="fxMarginP_nd_purchase"/>
			<xsl:call-template name="fxRateDirection_nd_purchase"/>
			<xsl:call-template name="initiationDate_nd_purchase"/>
			<xsl:call-template name="operationAmount_nd_purchase"/>
			<xsl:call-template name="purchasedQuantity_nd_purchase"/>
			<xsl:call-template name="soldCcyCurrentAccount_nd_purchase"/>
			<xsl:call-template name="soldCcyNetAmount_nd_purchase"/>
			<xsl:call-template name="spotExchangeRate_nd_purchase"/>
			<xsl:call-template name="startingDate_nd_purchase"/>
			<xsl:call-template name="code_nd_purchase"/>
			
			<xsl:call-template name="custoDefinitions_nd_purchase"/>
			<xsl:call-template name="mbCustoDefinitions_nd_purchase"/>
		</forwardPurchaseOpening>
	</xsl:template>

	<xsl:template name="mapping_nd_saleOpening">
		<forwardSaleOpening>
			<xsl:call-template name="account2_nd_sale"/>
			<xsl:call-template name="account2CcyTradeCcyExchangeRate_nd_sale"/>
			<xsl:call-template name="account2NetAmount_nd_sale"/>
			<xsl:call-template name="account3_nd_sale"/>
			<xsl:call-template name="account3CcyTradeCcyExchangeRate_nd_sale"/>
			<xsl:call-template name="account3NetAmount_nd_sale"/>
			<xsl:call-template name="accountingCode_nd_sale"/>
			<xsl:call-template name="accountingDate_nd_sale"/>
			<xsl:call-template name="cashPortfolio_nd_sale"/>
			<xsl:call-template name="commonReference_nd_sale"/>
			<xsl:call-template name="contractNumber_nd_sale"/>
			<xsl:call-template name="initiatedBy_nd_sale"/>
			<xsl:call-template name="initiator_nd_sale"/>
			<xsl:call-template name="notepad_nd_sale"/>
			<xsl:call-template name="portfolio_nd_sale"/>
			<xsl:call-template name="portfolioManager_nd_sale"/>
			<xsl:call-template name="currentAccountCcyPortfolioCcyExchangeRate_nd_sale"/>
			<xsl:call-template name="remark_nd_sale"/>
			<xsl:call-template name="reversalIndicator_nd_sale"/>
			<xsl:call-template name="reversedTransactionCode_nd_sale"/>
			<xsl:call-template name="sourceSystemCode_nd_sale"/>
			<xsl:call-template name="status_nd_sale"/>
			<xsl:call-template name="subType_nd_sale"/>
			<xsl:call-template name="trader_nd_sale"/>
			<xsl:call-template name="transactionFeesTaxesCounter_nd_sale"/>
			<xsl:call-template name="type_nd_sale"/>
			<xsl:call-template name="userDefinedField_nd_sale"/>
			<xsl:call-template name="mbFields_nd_sale"/>
			<xsl:call-template name="account1CcyTradeCcyExchangeRate_nd_sale"/>
			<xsl:call-template name="autoClosing_nd_sale"/>
			<xsl:call-template name="contractReferenceCode_nd_sale"/>
			<xsl:call-template name="expirationDate_nd_sale"/>
			<xsl:call-template name="fixingDate_nd_sale"/>
			<xsl:call-template name="forwardContract_nd_sale"/>
			<xsl:call-template name="forwardExchangeRate_nd_sale"/>
			<xsl:call-template name="fxClientRate_nd_sale"/>
			<xsl:call-template name="fxMargin_nd_sale"/>
			<xsl:call-template name="fxMarginP_nd_sale"/>
			<xsl:call-template name="fxMarketRate_nd_sale"/>
			<xsl:call-template name="fxRateDirection_nd_sale"/>
			<xsl:call-template name="initiationDate_nd_sale"/>
			<xsl:call-template name="operationAmount_nd_sale"/>
			<xsl:call-template name="operationGrossAmount_nd_sale"/>
			<xsl:call-template name="priceCalculationRule_nd_sale"/>
			<xsl:call-template name="purchasedCcyCurrentAccount_nd_sale"/>
			<xsl:call-template name="purchasedCcyNetAmount_nd_sale"/>
			<xsl:call-template name="soldQuantity_nd_sale"/>
			<xsl:call-template name="spotExchangeRate_nd_sale"/>
			<xsl:call-template name="startingDate_nd_sale"/>
			<xsl:call-template name="code_nd_sale"/>
			
			<xsl:call-template name="custoDefinitions_nd_sale"/>
			<xsl:call-template name="mbCustoDefinitions_nd_sale"/>
		</forwardSaleOpening>
	</xsl:template>
	<!-- END - Mapping for node record -->
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