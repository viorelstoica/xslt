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
				<xsl:value-of select="concat('TransactionOffMarketBuyback',b:diaryId)"/>
			</xsl:attribute>
			<DataGroup>
				<Sell>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionOffMarketBuyback.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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