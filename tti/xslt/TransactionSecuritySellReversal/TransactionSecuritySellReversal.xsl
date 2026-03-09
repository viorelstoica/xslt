<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecuritySellReversal" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecuritySellReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecuritySellReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecuritySellReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionSecuritySellReversal">
      <xsl:apply-templates select="c:CurrentEvent/b:TransactionSecuritySellReversal"/>
   </xsl:template>
   <xsl:template match="batch:BatchTransactionSecuritySellReversal">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionSecuritySellReversal" name="BatchTransactionSecuritySellReversal">
         <xsl:apply-templates select="b:TransactionSecuritySellReversal"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiTransactionSecuritySellReversal">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecuritySellReversal" name="BatchMultiTransactionSecuritySellReversal">
         <xsl:apply-templates select="c:MultiTransactionSecuritySellReversal"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:TransactionSecuritySellReversal">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('transactionSecuritySellReversal',b:id)"/>
         </xsl:attribute>
         <xsl:for-each select="b:customerNoGroup/b:custSecAcc">
            <xsl:variable name="index" select="../@index"/>
            <xsl:variable name="ccyAccXRate">
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(../b:cuAmountDue div ../b:cuNetAmTrd,$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="format-number(../b:cuNetAmTrd div ../b:cuAmountDue,$decimalformat,'nan2zero')"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable><!--TransactionSecuritySellReversal-->
            <DataGroup>
               <Security>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionSecuritySellReversal.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <sale>
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
                     <xsl:call-template name="positionCriteria1"/>
                     <xsl:call-template name="positionCriteria2"/>
                     <xsl:call-template name="positionCriteria3"/>
                     <xsl:call-template name="price"/>
                     <xsl:call-template name="quantity"/>
                     <xsl:call-template name="security"/>
                     <xsl:call-template name="securityCcyNetAmount"/>
                     <xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
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
                  </sale>
               </Security>
            </DataGroup><!-- Reversal of seggregation related adjustment operations -->
            <xsl:if test="../b:cuIncomeAcc and (../b:cuIncomeAmt and number(../b:cuIncomeAmt) != '0') and (../../b:segregIncomeJoinList[$index]/b:segregIncomeJoin = 'YES' and ../b:custIntrAmt) and (not(../../b:custAccNoPortfolioNoGroup[@index=$index]/b:custAccNoPortfolioNoList/b:custAccNoPortfolioNo = ../../b:portfolioNoJoinGroup[@index=$index]/b:portfolioNoJoinList/b:portfolioNoJoin)) and ../../b:exclIncValuationScParameterJoin = 'YES'">
               <DataGroup>
                  <Cash>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecuritySellReversal.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <transferOut>
                        <xsl:call-template name="account1_transferOut"/>
                        <xsl:call-template name="account1CcyTradeCcyExchangeRate_transferOut"/>
                        <xsl:call-template name="account1NetAmount_transferOut"/>
                        <xsl:call-template name="account2_transferOut"/>
                        <xsl:call-template name="account2CcyTradeCcyExchangeRate_transferOut"/>
                        <xsl:call-template name="account2NetAmount_transferOut"/>
                        <xsl:call-template name="account3_transferOut"/>
                        <xsl:call-template name="account3CcyTradeCcyExchangeRate_transferOut"/>
                        <xsl:call-template name="account3NetAmount_transferOut"/>
                        <xsl:call-template name="accountingCode_transferOut"/>
                        <xsl:call-template name="accountingDate_transferOut"/>
                        <xsl:call-template name="cashPortfolio_transferOut"/>
                        <xsl:call-template name="commonReference_transferOut"/>
                        <xsl:call-template name="ContractNumber_transferOut"/>
						<xsl:call-template name="intermediary_transferOut"/>
						<xsl:call-template name="market_transferOut"/>
                        <xsl:call-template name="notepad_transferOut"/>
                        <xsl:call-template name="portfolio_transferOut"/>
                        <xsl:call-template name="portfolioManager_transferOut"/>
                        <xsl:call-template name="remark_transferOut"/>
                        <xsl:call-template name="reversalIndicator_transferOut"/>
                        <xsl:call-template name="reversedTransactionCode_transferOut"/>
                        <xsl:call-template name="sourceSystemCode_transferOut"/>
                        <xsl:call-template name="status_transferOut"/>
                        <xsl:call-template name="subType_transferOut"/>
                        <xsl:call-template name="transactionCode_transferOut"/>
                        <xsl:call-template name="transactionFeesTaxesCounter_transferOut"/>
                        <xsl:call-template name="type_transferOut"/>
                        <xsl:call-template name="valueDate_transferOut"/>
                        <xsl:call-template name="userDefinedField_transferOut"/>
                        <xsl:call-template name="mbFields_transferOut"/>
                        <xsl:call-template name="currentAccount_transferOut"/>
                        <xsl:call-template name="quantity_transferOut"/>
                        <xsl:call-template name="transactionCcyGrossAmount_transferOut"/>
                        <xsl:call-template name="transactionCcyNetAmount_transferOut"/>
                        <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_transferOut"/>
                        <xsl:call-template name="transactionCurrency_transferOut"/>
                        <xsl:call-template name="transactionDate_transferOut"/>
                     </transferOut>
                  </Cash>
               </DataGroup>
               <DataGroup>
                  <Cash>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecuritySellReversal.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <transferIn>
                        <xsl:call-template name="account1_transferIn"/>
                        <xsl:call-template name="account1CcyTradeCcyExchangeRate_transferIn"/>
                        <xsl:call-template name="account1NetAmount_transferIn"/>
                        <xsl:call-template name="account2_transferIn"/>
                        <xsl:call-template name="account2CcyTradeCcyExchangeRate_transferIn"/>
                        <xsl:call-template name="account2NetAmount_transferIn"/>
                        <xsl:call-template name="account3_transferIn"/>
                        <xsl:call-template name="account3CcyTradeCcyExchangeRate_transferIn"/>
                        <xsl:call-template name="account3NetAmount_transferIn"/>
                        <xsl:call-template name="accountingCode_transferIn"/>
                        <xsl:call-template name="accountingDate_transferIn"/>
                        <xsl:call-template name="cashPortfolio_transferIn"/>
                        <xsl:call-template name="commonReference_transferIn"/>
                        <xsl:call-template name="ContractNumber_transferIn"/>
						<xsl:call-template name="intermediary_transferIn"/>
						<xsl:call-template name="market_transferIn"/>
                        <xsl:call-template name="notepad_transferIn"/>
                        <xsl:call-template name="portfolio_transferIn">
                           <xsl:with-param name="index" select="$index"/>
                        </xsl:call-template>
                        <xsl:call-template name="portfolioManager_transferIn"/>
                        <xsl:call-template name="remark_transferIn"/>
                        <xsl:call-template name="reversalIndicator_transferIn"/>
                        <xsl:call-template name="reversedTransactionCode_transferIn"/>
                        <xsl:call-template name="sourceSystemCode_transferIn"/>
                        <xsl:call-template name="status_transferIn"/>
                        <xsl:call-template name="subType_transferIn"/>
                        <xsl:call-template name="transactionCode_transferIn"/>
                        <xsl:call-template name="transactionFeesTaxesCounter_transferIn"/>
                        <xsl:call-template name="type_transferIn"/>
                        <xsl:call-template name="valueDate_transferIn"/>
                        <xsl:call-template name="userDefinedField_transferIn"/>
                        <xsl:call-template name="mbFields_transferIn"/>
                        <xsl:call-template name="currentAccount_transferIn"/>
                        <xsl:call-template name="quantity_transferIn"/>
                        <xsl:call-template name="transactionCcyGrossAmount_transferIn"/>
                        <xsl:call-template name="transactionCcyNetAmount_transferIn"/>
                        <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_transferIn"/>
                        <xsl:call-template name="transactionCurrency_transferIn"/>
                        <xsl:call-template name="transactionDate_transferIn"/>
                     </transferIn>
                  </Cash>
               </DataGroup>
            </xsl:if><!-- Reversal of additional fee transactions for intra fund switches with fees -->
            <xsl:if test="../b:cuIncomeAcc != '' and (../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory)">
               <DataGroup>
                  <Security>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecuritySellReversal.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <sale>
                        <xsl:call-template name="account1_switchfee"/>
                        <xsl:call-template name="account1CcyTradeCcyExchangeRate_switchfee"/>
                        <xsl:call-template name="account1NetAmount_switchfee"/>
                        <xsl:call-template name="account2_switchfee"/>
                        <xsl:call-template name="account2CcyTradeCcyExchangeRate_switchfee"/>
                        <xsl:call-template name="account2NetAmount_switchfee"/>
                        <xsl:call-template name="account3_switchfee"/>
                        <xsl:call-template name="account3CcyTradeCcyExchangeRate_switchfee"/>
                        <xsl:call-template name="account3NetAmount_switchfee"/>
                        <xsl:call-template name="accountingCode_switchfee"/>
                        <xsl:call-template name="accountingDate_switchfee"/>
                        <xsl:call-template name="cashPortfolio_switchfee"/>
                        <xsl:call-template name="commonReference_switchfee"/>
                        <xsl:call-template name="ContractNumber_switchfee"/>
						<xsl:call-template name="intermediary_switchfee"/>
						<xsl:call-template name="market_switchfee"/>
                        <xsl:call-template name="notepad_switchfee"/>
                        <xsl:call-template name="portfolio_switchfee"/>
                        <xsl:call-template name="portfolioManager_switchfee"/>
                        <xsl:call-template name="remark_switchfee"/>
                        <xsl:call-template name="reversalIndicator_switchfee"/>
                        <xsl:call-template name="reversedTransactionCode_switchfee"/>
                        <xsl:call-template name="sourceSystemCode_switchfee"/>
                        <xsl:call-template name="status_switchfee"/>
                        <xsl:call-template name="subType_switchfee"/>
                        <xsl:call-template name="transactionCode_switchfee"/>
                        <xsl:call-template name="transactionFeesTaxesCounter_switchfee"/>
                        <xsl:call-template name="type_switchfee"/>
                        <xsl:call-template name="valueDate_switchfee"/>
                        <xsl:call-template name="userDefinedField_switchfee"/>
                        <xsl:call-template name="mbFields_switchfee"/>
                        <xsl:call-template name="accountCurrency_switchfee"/>
                        <xsl:call-template name="accruedInterests_switchfee"/>
                        <xsl:call-template name="accruedInterestCounter_switchfee"/>
                        <xsl:call-template name="broker_switchfee"/>
                        <xsl:call-template name="compoundOrderCode_switchfee"/>
						<xsl:call-template name="compoundOrderMaster_switchfee"/>
						<xsl:call-template name="compoundOrderSlave_switchfee"/>
                        <xsl:call-template name="contactMethod_switchfee"/>
                        <xsl:call-template name="depositaryAccount_switchfee"/>
                        <xsl:call-template name="exCoupon_switchfee"/>
                        <xsl:call-template name="executionSetCriteria_switchfee"/>
                        <xsl:call-template name="initiatedBy_switchfee"/>
                        <xsl:call-template name="initiator_switchfee"/>
                        <xsl:call-template name="limitPrice_switchfee"/>
                        <xsl:call-template name="orderType_switchfee"/>
                        <xsl:call-template name="orderValidityType_switchfee"/>
                        <xsl:call-template name="originalOrderCode_switchfee"/>
                        <xsl:call-template name="positionCriteria1_switchfee"/>
                        <xsl:call-template name="positionCriteria2_switchfee"/>
                        <xsl:call-template name="positionCriteria3_switchfee"/>
                        <xsl:call-template name="price_switchfee"/>
                        <xsl:call-template name="quantity_switchfee"/>
                        <xsl:call-template name="security_switchfee"/>
                        <xsl:call-template name="securityCcyNetAmount_switchfee"/>
                        <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_switchfee"/>
                        <xsl:call-template name="stockExchange_switchfee"/>
                        <xsl:call-template name="stopPrice_switchfee"/>
						<xsl:call-template name="targetAmount_switchfee"/>
						<xsl:call-template name="targetNature_switchfee"/>
						<xsl:call-template name="targetObjective_switchfee"/>
                        <xsl:call-template name="trader_switchfee"/>
                        <xsl:call-template name="tradeCurrency_switchfee"/>
                        <xsl:call-template name="tradeCcyGrossAmount_switchfee"/>
                        <xsl:call-template name="tradeCcyNetAmount_switchfee"/>
                        <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_switchfee"/>
                        <xsl:call-template name="tradeDate_switchfee"/>
                        <xsl:call-template name="validityDate_switchfee"/>
                     </sale>
                  </Security>
               </DataGroup>
            </xsl:if>
         </xsl:for-each>
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