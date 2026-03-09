<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecOpenOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiSecOpenOrder">
		<xsl:apply-templates select="c:CurrentEvent/b:SecOpenOrder"/>
	</xsl:template>
	<xsl:template match="batch:BatchSecOpenOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder" name="BatchSecOpenOrder">
			<xsl:apply-templates select="b:SecOpenOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiSecOpenOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder" name="BatchMultiSecOpenOrder">
			<xsl:apply-templates select="c:MultiSecOpenOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:SecOpenOrder">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionSecOpenOrder',b:id)"/>
			</xsl:attribute>
			<!-- security purchase Buy -->
			<xsl:if test="contains(concat('',$list_TransCode_TransactionSecurityBuy,''),concat('',b:transactionCode,''))">
			<DataGroup>
				<Security>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionSecOpenOrder.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<purchase>
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
						<xsl:call-template name="accruedInterests"/>			
						<xsl:call-template name="accruedInterestCounter"/>
						<xsl:call-template name="boAccount"/>
						<xsl:call-template name="boPortfolio"/>
						<xsl:call-template name="broker"/>
						<xsl:call-template name="compoundOrderCode"/>
						<xsl:call-template name="compoundOrderMaster"/>
						<xsl:call-template name="compoundOrderSlave"/>
						<xsl:call-template name="contactMethod"/>
						<xsl:call-template name="depositaryAccount"/>
						<xsl:call-template name="exCoupon"/>
						<xsl:call-template name="executionSetCriteria"/>
						<xsl:call-template name="hierOperNature"/>
						<xsl:call-template name="initiatedBy"/>
						<xsl:call-template name="initiator"/>
						<xsl:call-template name="limitPrice"/>
						<xsl:call-template name="orderType"/>
						<xsl:call-template name="orderValidityType"/>
						<xsl:call-template name="originalOrderCode"/>
						<xsl:call-template name="paymentDate"/>
						<xsl:call-template name="paymentStatus"/>
						<xsl:call-template name="paymentOptionE"/>
						<xsl:call-template name="positionCriteria1"/>
						<xsl:call-template name="positionCriteria2"/>
						<xsl:call-template name="positionCriteria3"/>
						<xsl:call-template name="price"/>
						<xsl:call-template name="quantity"/>
						<xsl:call-template name="security"/>
						<xsl:call-template name="securityCcyNetAmount"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>	
						<xsl:call-template name="settlementDate"/>
						<xsl:call-template name="settlementStatus"/>
						<xsl:call-template name="stockExchange"/>
						<xsl:call-template name="stopPrice"/>
						<xsl:call-template name="targetAmount"/>
						<xsl:call-template name="targetNature"/>
						<xsl:call-template name="targetObjective"/>
						<xsl:call-template name="trader"/>
						<xsl:call-template name="tradeCurrency"/>
						<xsl:call-template name="tradeCcyGrossAmount"/>
						<xsl:call-template name="tradeCcyNetAmount"/>
						<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="tradeDate"/>
						<xsl:call-template name="validityDate"/>
						<xsl:call-template name="coolCancelEndDate"/>
						<xsl:call-template name="referenceNature"/>
						<xsl:call-template name="boRoutingBusinessEntityId"/>
					</purchase>
				</Security>
			</DataGroup>
			</xsl:if>
			<!-- security purchase Sell -->
			<xsl:if test="contains(concat('',$list_TransCode_TransactionSecuritySell,''),concat('',b:transactionCode,''))">
			<DataGroup>
				<Security>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionSecOpenOrder.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
						<xsl:call-template name="userDefinedField_sale"/>
						<xsl:call-template name="mbFields_sale"/>
						<xsl:call-template name="accountCurrency_sale"/>
						<xsl:call-template name="accruedInterests_sale"/>			
						<xsl:call-template name="accruedInterestCounter_sale"/>
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
						<xsl:call-template name="coolCancelEndDate_sale"/>
						<xsl:call-template name="referenceNature_sale"/>
						<xsl:call-template name="boRoutingBusinessEntityId"/>
					</sale>
				</Security>
			</DataGroup>
			</xsl:if>
		</TransactionPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\TransactionSecurityBuy\TransactionSecurityBuy.xml" srcSchemaRoot="TransactionSecurityBuy" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="c:MultiTransactionSecurityBuy"></template>
			<template match="b:TransactionSecurityBuy">
				<block path="TransactionPMS/xsl:attribute[1]/xsl:value-of" x="535" y="54"/>
				<block path="TransactionPMS/xsl:for-each" x="575" y="72"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/xsl:attribute/xsl:value-of" x="575" y="108"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/xsl:attribute/xsl:value-of/name[1]" x="529" y="130"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/xsl:attribute[1]/xsl:call-template" x="535" y="126"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template" x="495" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[1]" x="455" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[2]" x="415" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[3]" x="375" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[4]" x="335" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[5]" x="295" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[6]" x="255" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[7]" x="215" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[8]" x="175" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[9]" x="135" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[10]" x="95" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[11]" x="55" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[12]" x="15" y="144"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[13]" x="495" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[14]" x="455" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[15]" x="415" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[16]" x="375" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[17]" x="335" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[18]" x="295" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[19]" x="255" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[20]" x="215" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[21]" x="175" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[22]" x="135" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[23]" x="95" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[24]" x="55" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[25]" x="15" y="104"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[26]" x="495" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[27]" x="455" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[28]" x="415" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[29]" x="375" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[30]" x="335" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[31]" x="295" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[32]" x="255" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[33]" x="215" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[34]" x="175" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[35]" x="135" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[36]" x="95" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[37]" x="55" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[38]" x="15" y="64"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[39]" x="575" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[40]" x="495" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[41]" x="455" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[42]" x="415" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[43]" x="375" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[44]" x="335" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[45]" x="295" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[46]" x="255" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[47]" x="215" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[48]" x="175" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[49]" x="135" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[50]" x="95" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[51]" x="55" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[52]" x="15" y="24"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[53]" x="575" y="184"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[54]" x="495" y="184"/>
				<block path="TransactionPMS/xsl:for-each/DataGroup/Security/purchase/xsl:call-template[55]" x="455" y="184"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/and[0]" x="489" y="160"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/and[0]/=[0]" x="443" y="154"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if" x="535" y="162"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/xsl:attribute/xsl:value-of" x="535" y="198"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/xsl:attribute/xsl:value-of/name[1]" x="489" y="220"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/xsl:attribute[1]/xsl:call-template" x="575" y="216"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template" x="495" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[1]" x="455" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[2]" x="415" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[3]" x="375" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[4]" x="335" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[5]" x="295" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[6]" x="255" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[7]" x="215" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[8]" x="175" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[9]" x="135" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[10]" x="95" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[11]" x="55" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[12]" x="15" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[13]" x="415" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[14]" x="375" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[15]" x="335" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[16]" x="295" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[17]" x="255" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[18]" x="215" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[19]" x="175" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[20]" x="135" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[21]" x="95" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[22]" x="55" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[23]" x="15" y="194"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[24]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[25]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[26]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[27]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[28]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[29]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[30]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[31]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[32]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup/Cash/transferIn/xsl:call-template[33]" x="535" y="234"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/xsl:attribute/xsl:value-of" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/xsl:attribute/xsl:value-of/name[1]" x="489" y="166"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/xsl:attribute[1]/xsl:call-template" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[1]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[2]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[3]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[4]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[5]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[6]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[7]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[8]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[9]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[10]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[11]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[12]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[13]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[14]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[15]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[16]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[17]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[18]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[19]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[20]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[21]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[22]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[23]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[24]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[25]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[26]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[27]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[28]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[29]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[30]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[31]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[32]" x="535" y="144"/>
				<block path="TransactionPMS/xsl:for-each/xsl:if/DataGroup[1]/Cash/transferOut/xsl:call-template[33]" x="535" y="144"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->