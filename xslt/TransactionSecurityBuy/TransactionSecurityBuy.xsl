<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecurityBuy" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecurityBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecurityBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecurityBuy" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionSecurityBuy">
      <xsl:apply-templates select="c:CurrentEvent/b:TransactionSecurityBuy"/>
   </xsl:template>
   <xsl:template match="batch:BatchTransactionSecurityBuy">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionSecurityBuy" name="BatchTransactionSecurityBuy">
         <xsl:apply-templates select="b:TransactionSecurityBuy"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiTransactionSecurityBuy">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecurityBuy" name="BatchMultiTransactionSecurityBuy">
         <xsl:apply-templates select="c:MultiTransactionSecurityBuy"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:TransactionSecurityBuy">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('transactionSecurityBuy',b:id1)"/>
         </xsl:attribute>
         <xsl:for-each select="b:customerNoGroup/b:custSecAcc"><!--  exchange rates  -->
            <xsl:variable name="index" select="../@index"/>
			<xsl:variable name="ccyAccXRate">
               <xsl:choose>
                  <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                     <xsl:value-of select="format-number(../b:cuAmountDue div ../b:cuNetAmTrd, $decimalformat, 'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="format-number(../b:cuNetAmTrd div ../b:cuAmountDue, $decimalformat, 'nan2zero')"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable>
            <xsl:variable name="ccyInstrXRate">
               <xsl:choose>
                  <xsl:when test="../../b:securityCurrency = ../../b:tradeCcy and ../b:cuRefCcy = ../b:cuAccountCcy">
                     <xsl:value-of select="$ccyAccXRate"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:choose>
                        <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                           <xsl:value-of select="format-number(../../b:grBkCostRefCcyJoin div ../b:cuGrossAmSec, $decimalformat, 'nan2zero')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="format-number(../b:cuGrossAmSec div ../../b:grBkCostRefCcyJoin, $decimalformat, 'nan2zero')"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable>
            <xsl:variable name="ccyOpXRate">
               <xsl:choose>
                  <xsl:when test="../b:cuRefCcy = ../b:cuAccountCcy">
                     <xsl:value-of select="$ccyAccXRate"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:choose>
                        <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                           <xsl:value-of select="format-number(../../b:grBkCostRefCcyJoin div ../b:cuGrossAmTrd, $decimalformat, 'nan2zero')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="format-number(../b:cuGrossAmTrd div ../../b:grBkCostRefCcyJoin, $decimalformat, 'nan2zero')"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable><!-- The interest amount, which may be present or not. Make sure a reliable variable exists -->
            <xsl:variable name="intrAmount">
               <xsl:choose>
                  <xsl:when test="../b:custIntrAmt">
                     <xsl:value-of select="../b:custIntrAmt"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="0"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable><!-- Amounts to be debited to acc1 and acc2 -->
            <xsl:variable name="acc2Amount"><!-- T24 provides seggregated buy amount as negative value, we need positive -->
               <xsl:value-of select="- ../b:cuIncomeAmt"/>
            </xsl:variable>
            <xsl:variable name="acc1Amount">
               <xsl:choose>
                  <xsl:when test="../b:cuIncomeAmt">
                     <xsl:value-of select="format-number(../b:cuAmountDue - (- ../b:cuIncomeAmt),$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="../b:cuAmountDue"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:variable>
            <DataGroup>
               <Security>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionSecurityBuy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <purchase>
                     <xsl:call-template name="account1"/>
                     <xsl:call-template name="account1CcyTradeCcyExchangeRate">
                        <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                     </xsl:call-template>
                     <xsl:call-template name="account1NetAmount">
                        <xsl:with-param name="acc1Amount" select="$acc1Amount"/>
                     </xsl:call-template>
                     <xsl:call-template name="account2">
                        <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                        <xsl:with-param name="acc2Amount" select="$acc2Amount"/>
                     </xsl:call-template>
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
                     <xsl:call-template name="accruedInterests">
                        <xsl:with-param name="intrAmount" select="$intrAmount"/>
                     </xsl:call-template>
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
                     <xsl:call-template name="securityCcyPortfolioCcyExchangeRate">
                        <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                        <xsl:with-param name="ccyInstrXRate" select="$ccyInstrXRate"/>
                     </xsl:call-template>
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
                     <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate">
                        <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                        <xsl:with-param name="ccyOpXRate" select="$ccyOpXRate"/>
                     </xsl:call-template>
                     <xsl:call-template name="tradeDate"/>
                     <xsl:call-template name="validityDate"/>
					 <xsl:call-template name="coolCancelEndDate"/>
					 <xsl:call-template name="referenceNature"/>

                  </purchase>
               </Security>
            </DataGroup><!-- Corrections for cash booking for income/cap seggration: Book cash to income ptf if income account present and this is not 
            a fund upfront payment
            -->
            <xsl:if test="((not(../../b:originalSec) or ../../b:originalSec = '') and ../b:cuIncomeAcc and (../b:cuIncomeAmt and number(../b:cuIncomeAmt) != '0') 
                         and (../../b:segregIncomeJoinList/b:segregIncomeJoin = 'YES' or ../../b:segregChargeJoinList/b:segregChargeJoin = 'YES') 
                         and (not(../b:cuIncomeAcc = ../b:cuSubsAccount)) 
                         and (../../b:securityCodeIpoStartDate = '' or not(../../b:securityCodeIpoStartDate) or (../b:cuChargeTaxTypeSubGroup/b:cuChargeTaxAmt or  ../../b:scStdSecTradeChargeTime = 'EXECUTION')) and (not(../../b:custAccNoPortfolioNoGroup[@index=$index]/b:custAccNoPortfolioNoList/b:custAccNoPortfolioNo = ../../b:portfolioNoJoinGroup[@index=$index]/b:portfolioNoJoinList/b:portfolioNoJoin)) and ../../b:exclIncValuationScParameterJoin = 'YES')">
               <DataGroup>
                  <Cash>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecurityBuy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
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
                        <xsl:call-template name="portfolio_transferIn"/>
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
                        <xsl:call-template name="quantity_transferIn">
                           <xsl:with-param name="acc2Amount" select="$acc2Amount"/>
                        </xsl:call-template>
                        <xsl:call-template name="transactionCcyGrossAmount_transferIn"/>
                        <xsl:call-template name="transactionCcyNetAmount_transferIn"/>
                        <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_transferIn"/>
                        <xsl:call-template name="transactionCurrency_transferIn"/>
                        <xsl:call-template name="transactionDate_transferIn"/>
                     </transferIn>
                  </Cash>
               </DataGroup>
               <DataGroup>
                  <Cash>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecurityBuy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
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
                        <xsl:call-template name="quantity_transferOut">
                           <xsl:with-param name="acc2Amount" select="$acc2Amount"/>
                        </xsl:call-template>
                        <xsl:call-template name="transactionCcyGrossAmount_transferOut"/>
                        <xsl:call-template name="transactionCcyNetAmount_transferOut"/>
                        <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_transferOut"/>
                        <xsl:call-template name="transactionCurrency_transferOut"/>
                        <xsl:call-template name="transactionDate_transferOut"/>
                     </transferOut>
                  </Cash>
               </DataGroup>
            </xsl:if><!-- Additional fee transactions for intra fund switches with fees -->
            <xsl:if test="../b:cuIncomeAcc != '' and (../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory)">
               <DataGroup>
                  <Security>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecurityBuy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <purchase>
                        <xsl:call-template name="account1_switchfee"/>
                        <xsl:call-template name="account1CcyTradeCcyExchangeRate_switchfee">
                           <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                        </xsl:call-template>
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
						<xsl:call-template name="paymentOptionE_switchfee"/>
                        <xsl:call-template name="positionCriteria1_switchfee"/>
                        <xsl:call-template name="positionCriteria2_switchfee"/>
                        <xsl:call-template name="positionCriteria3_switchfee"/>
                        <xsl:call-template name="price_switchfee"/>
                        <xsl:call-template name="quantity_switchfee"/>
                        <xsl:call-template name="security_switchfee"/>
                        <xsl:call-template name="securityCcyNetAmount_switchfee"/>
                        <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_switchfee">
                           <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                           <xsl:with-param name="ccyInstrXRate" select="$ccyInstrXRate"/>
                        </xsl:call-template>
                        <xsl:call-template name="stockExchange_switchfee"/>
                        <xsl:call-template name="stopPrice_switchfee"/>
						<xsl:call-template name="targetAmount_switchfee"/>
						<xsl:call-template name="targetNature_switchfee"/>
						<xsl:call-template name="targetObjective_switchfee"/>
                        <xsl:call-template name="trader_switchfee"/>
                        <xsl:call-template name="tradeCurrency_switchfee"/>
                        <xsl:call-template name="tradeCcyGrossAmount_switchfee"/>
                        <xsl:call-template name="tradeCcyNetAmount_switchfee"/>
                        <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_switchfee">
                           <xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
                           <xsl:with-param name="ccyOpXRate" select="$ccyOpXRate"/>
                        </xsl:call-template>
                        <xsl:call-template name="tradeDate_switchfee"/>
                        <xsl:call-template name="validityDate_switchfee"/>
                        <xsl:call-template name="coolCancelEndDate_switchfee"/>
                        <xsl:call-template name="referenceNature_switchfee"/>
                     </purchase>
                  </Security>
               </DataGroup>
            </xsl:if>
			<xsl:if test="../../b:originalSec and ../../b:originalSec != ''">
				<DataGroup>
                  <Cash>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecurityBuy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <transferOut>
                        <xsl:call-template name="account1_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account1CcyTradeCcyExchangeRate_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account1NetAmount_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account2_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account2CcyTradeCcyExchangeRate_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account2NetAmount_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account3_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account3CcyTradeCcyExchangeRate_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="account3NetAmount_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="accountingCode_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="accountingDate_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="cashPortfolio_fundUpfrontPayBookFees"/>
						<xsl:call-template name="commonReference_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="ContractNumber_fundUpfrontPayBookFees"/>
						<xsl:call-template name="intermediary_fundUpfrontPayBookFees"/>
						<xsl:call-template name="market_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="notepad_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="portfolio_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="portfolioManager_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="remark_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="reversalIndicator_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="reversedTransactionCode_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="sourceSystemCode_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="status_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="subType_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionCode_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionFeesTaxesCounter_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="type_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="valueDate_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="userDefinedField_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="mbFields_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="currentAccount_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="quantity_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionCcyGrossAmount_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionCcyNetAmount_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionCurrency_fundUpfrontPayBookFees"/>
                        <xsl:call-template name="transactionDate_fundUpfrontPayBookFees"/>
                     </transferOut>
                  </Cash>
               </DataGroup>
            </xsl:if>
			<xsl:if test="../b:custTransCode = 'UPS' and ../b:cuOrderNosList/b:cuOrderNos !=''">
			<DataGroup>
                  <Cash>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionSecurityBuy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <transferIn>
                        <xsl:call-template name="account1_UpfrontPayInve"/>
                        <xsl:call-template name="account1CcyTradeCcyExchangeRate_UpfrontPayInve"/>
                        <xsl:call-template name="account1NetAmount_UpfrontPayInve"/>
                        <xsl:call-template name="account2_UpfrontPayInve"/>
                        <xsl:call-template name="account2CcyTradeCcyExchangeRate_UpfrontPayInve"/>
                        <xsl:call-template name="account2NetAmount_UpfrontPayInve"/>
                        <xsl:call-template name="account3_UpfrontPayInve"/>
                        <xsl:call-template name="account3CcyTradeCcyExchangeRate_UpfrontPayInve"/>
                        <xsl:call-template name="account3NetAmount_UpfrontPayInve"/>
                        <xsl:call-template name="accountingCode_UpfrontPayInve"/>
                        <xsl:call-template name="accountingDate_UpfrontPayInve"/>
                        <xsl:call-template name="cashPortfolio_UpfrontPayInve"/>
						<xsl:call-template name="commonReference_UpfrontPayInve"/>
                        <xsl:call-template name="ContractNumber_UpfrontPayInve"/>
						<xsl:call-template name="intermediary_UpfrontPayInve"/>
						<xsl:call-template name="market_UpfrontPayInve"/>
                        <xsl:call-template name="notepad_UpfrontPayInve"/>
                        <xsl:call-template name="portfolio_UpfrontPayInve"/>
                        <xsl:call-template name="portfolioManager_UpfrontPayInve"/>
                        <xsl:call-template name="remark_UpfrontPayInve"/>
                        <xsl:call-template name="reversalIndicator_UpfrontPayInve"/>
                        <xsl:call-template name="reversedTransactionCode_UpfrontPayInve"/>
                        <xsl:call-template name="sourceSystemCode_UpfrontPayInve"/>
                        <xsl:call-template name="status_UpfrontPayInve"/>
                        <xsl:call-template name="subType_UpfrontPayInve"/>
                        <xsl:call-template name="transactionCode_UpfrontPayInve"/>
                        <xsl:call-template name="transactionFeesTaxesCounter_UpfrontPayInve"/>
                        <xsl:call-template name="type_UpfrontPayInve"/>
                        <xsl:call-template name="valueDate_UpfrontPayInve"/>
                        <xsl:call-template name="userDefinedField_UpfrontPayInve"/>
                        <xsl:call-template name="mbFields_UpfrontPayInve"/>
                        <xsl:call-template name="currentAccount_UpfrontPayInve"/>
                        <xsl:call-template name="quantity_UpfrontPayInve"/>
                        <xsl:call-template name="transactionCcyGrossAmount_UpfrontPayInve"/>
                        <xsl:call-template name="transactionCcyNetAmount_UpfrontPayInve"/>
                        <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_UpfrontPayInve"/>
                        <xsl:call-template name="transactionCurrency_UpfrontPayInve"/>
                        <xsl:call-template name="transactionDate_UpfrontPayInve"/>
                     </transferIn>
                  </Cash>
               </DataGroup>
			</xsl:if>
         </xsl:for-each>
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