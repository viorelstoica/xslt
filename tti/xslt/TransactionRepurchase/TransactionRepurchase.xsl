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
			<!-- Header -->
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CoaRepurchase',b:diaryId)"/>
			</xsl:attribute>
			<!-- call template for selected optionDescGroup -->
			<xsl:apply-templates select="b:optionDescGroup"/>
		</GenericCOA>
	</xsl:template>
	<!-- Template optionDescGroup for all having an optionNom -->
	<xsl:template match="b:optionDescGroup[b:optionNom != 0]">
		<!-- variables for evaluating the different cases -->
		<!--   exchange against aother security -->
		<xsl:variable name="RepurchaseExchangeAgainstSecurityCriteria">
			<xsl:call-template name="repurchaseExchangeAgainstSecurityCriteria"/>
		</xsl:variable>
		<!--   sell -->
		<xsl:variable name="RepurchaseSellCriteria">
			<xsl:call-template name="repurchaseSellCriteria"/>
		</xsl:variable>
		<!--   no action -->
		<xsl:variable name="RepurchaseNoActionCriteria">
			<xsl:call-template name="repurchaseNoActionCriteria"/>
		</xsl:variable>
		<!--   custo, if other action is needed -->
		<xsl:variable name="RepurchaseCusto1Criteria">
			<xsl:call-template name="repurchaseCusto1Criteria"/>
		</xsl:variable>
		<!-- Choose the action -->
		<xsl:choose>
			<!-- sell -->
			<xsl:when test="$RepurchaseSellCriteria = 'true'">
				<DataGroup>
					<Sell>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionRepurchase.xsl+', name(../../*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
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
						<xsl:call-template name="accruedInterestAmount"/>
						<xsl:call-template name="accruedInterestCounter"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="coaReference"/>
						<xsl:call-template name="commonReference"/>
						<xsl:call-template name="communication"/>
						<xsl:call-template name="depositaryAccount"/>
						<xsl:call-template name="exDate"/>
						<xsl:call-template name="initiator"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="positionCriteria1"/>
						<xsl:call-template name="positionCriteria2"/>
						<xsl:call-template name="positionCriteria3"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="security"/>
						<xsl:call-template name="securityCcyNetAmount"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="splitPortfolio"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="supplementaryAmount"/>
						<xsl:call-template name="tradeCcyGrossAmount"/>
						<xsl:call-template name="tradeCcyNetAmount"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="tradeCurrency"/>
						<xsl:call-template name="tradePrice"/>
						<xsl:call-template name="tradeQuantity"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="transactionDate"/>
						<xsl:call-template name="transactionFeesTaxesCounter"/>
						<xsl:call-template name="type"/>
						<xsl:call-template name="typeInstrument"/>
						<xsl:call-template name="valueDate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
					</Sell>
				</DataGroup>
			</xsl:when>
			<!-- exchange against other security -->
			<xsl:when test="$RepurchaseExchangeAgainstSecurityCriteria = 'true'">
				<DataGroup>
					<Adjustment>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionRepurchase.xsl+', name(../../*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_Adj"/>
						<xsl:call-template name="account1CcyoldSecCcyExchangeRate_Adj"/>
						<xsl:call-template name="account1NetAmount_Adj"/>
						<xsl:call-template name="account2_Adj"/>
						<xsl:call-template name="account2CcyoldSecCcyExchangeRate_Adj"/>
						<xsl:call-template name="account2NetAmount_Adj"/>
						<xsl:call-template name="account3_Adj"/>
						<xsl:call-template name="account3CcyoldSecCcyExchangeRate_Adj"/>
						<xsl:call-template name="account3NetAmount_Adj"/>
						<xsl:call-template name="accountingCode_Adj"/>
						<xsl:call-template name="accountingDate_Adj"/>
						<xsl:call-template name="accruedInterestAmount_Adj"/>
						<xsl:call-template name="accruedInterestCounter_Adj"/>
						<xsl:call-template name="adjustmentCounter_Adj"/>
						<xsl:call-template name="adjustmentNature_Adj"/>
						<xsl:call-template name="adjustmentPortfolio_Adj"/>
						<xsl:call-template name="cashPortfolio_Adj"/>
						<xsl:call-template name="coaReference_Adj"/>
						<xsl:call-template name="commonReference_Adj"/>
						<xsl:call-template name="communication_Adj"/>
						<xsl:call-template name="exDate_Adj"/>
						<xsl:call-template name="initiator_Adj"/>
						<xsl:call-template name="newQuantity_Adj"/>
						<xsl:call-template name="newSecurity_Adj"/>
						<xsl:call-template name="newSecurityCcyPositionCcyExchangeRate_Adj"/>
						<xsl:call-template name="newSecurityDepositaryAccount_Adj"/>
						<xsl:call-template name="newSecurityNetAmount_Adj"/>
						<xsl:call-template name="newSecurityPositionCriteria1_Adj"/>
						<xsl:call-template name="newSecurityPositionCriteria2_Adj"/>
						<xsl:call-template name="newSecurityPositionCriteria3_Adj"/>
						<xsl:call-template name="newSecurityPositionCurrency_Adj"/>
						<xsl:call-template name="notepad_Adj"/>
						<xsl:call-template name="oldCcyGrossAmount_Adj"/>
						<xsl:call-template name="oldCcyNetAmount_Adj"/>
						<xsl:call-template name="oldCcyPortfolioCcyExchangeRate_Adj"/>
						<xsl:call-template name="oldPrice_Adj"/>
						<xsl:call-template name="oldQuantity_Adj"/>
						<xsl:call-template name="oldSecurity_Adj"/>
						<xsl:call-template name="oldSecurityDepositaryAccount_Adj"/>
						<xsl:call-template name="oldSecurityPositionCriteria1_Adj"/>
						<xsl:call-template name="oldSecurityPositionCriteria2_Adj"/>
						<xsl:call-template name="oldSecurityPositionCriteria3_Adj"/>
						<xsl:call-template name="oldSecurityPositionCurrency_Adj"/>
						<xsl:call-template name="portfolio_Adj"/>
						<xsl:call-template name="portfolioManager_Adj"/>
						<xsl:call-template name="remark_Adj"/>
						<xsl:call-template name="reversalIndicator_Adj"/>
						<xsl:call-template name="reversedTransactionCode_Adj"/>
						<xsl:call-template name="sourceSystemCode_Adj"/>
						<xsl:call-template name="splitPortfolio_Adj"/>
						<xsl:call-template name="status_Adj"/>
						<xsl:call-template name="subType_Adj"/>
						<xsl:call-template name="supplementaryAmount_Adj"/>
						<xsl:call-template name="transactionCode_Adj"/>
						<xsl:call-template name="transactionDate_Adj"/>
						<xsl:call-template name="transactionFeesTaxesCounter_Adj"/>
						<xsl:call-template name="type_Adj"/>
						<xsl:call-template name="typeInstrument_Adj"/>
						<xsl:call-template name="valueDate_Adj"/>
						<xsl:call-template name="userDefinedField_Adj"/>
						<xsl:call-template name="mbFields_Adj"/>
					</Adjustment>
				</DataGroup>
			</xsl:when>
			<!-- take no action -->
			<xsl:when test="$RepurchaseNoActionCriteria = 'true' ">
				<DataGroup/>
			</xsl:when>
			<!-- full custo -->
			<xsl:when test="$RepurchaseCusto1Criteria = 'true' ">
				<DataGroup/>
			</xsl:when>
			<!-- otherwise -->
			<xsl:otherwise>
				<DataGroup/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Default template for optionDescGroup -->
	<xsl:template match="b:optionDescGroup"/>
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