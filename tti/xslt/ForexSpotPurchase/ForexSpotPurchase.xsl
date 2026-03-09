<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionsForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionsForex" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionsForex">
      <xsl:apply-templates select="c:CurrentEvent/b:TransactionsForex"/>
   </xsl:template>
   <xsl:template match="batch:BatchTransactionsForex">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionsForex" name="BatchTransactionsForex">
         <xsl:apply-templates select="b:TransactionsForex"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiTransactionsForex">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionsForex" name="BatchMultiTransactionsForex">
         <xsl:apply-templates select="c:MultiTransactionsForex"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:TransactionsForex">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('forexSpotPurchase',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <ForexForward>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('ForexSpotPurchase.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <forexSpotPurchase>
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
                  <xsl:call-template name="contractNumber"/>
                  <xsl:call-template name="initiatedBy"/>
                  <xsl:call-template name="initiator"/>
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="portfolioManager"/>
                  <xsl:call-template name="currentAccountCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="remark"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="sourceSystemCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="trader"/>
                  <xsl:call-template name="transactionFeesTaxesCounter"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="fxClientRate"/>
				  <xsl:call-template name="fxMarginN"/>
				  <xsl:call-template name="fxMarginP"/>
                  <xsl:call-template name="fxMarketRate"/>
                  <xsl:call-template name="fxRateDirection"/>
                  <xsl:call-template name="purchasedCcyCurrentAccount"/>
                  <xsl:call-template name="quantity"/>
                  <xsl:call-template name="soldCurrencyCurrentAccount"/>
                  <xsl:call-template name="soldCurrencyNetAmount"/>
                  <xsl:call-template name="spotExchangeRate"/>
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionDate"/>
                  <xsl:call-template name="valueDate"/>
				  <xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
               </forexSpotPurchase>
            </ForexForward>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet>