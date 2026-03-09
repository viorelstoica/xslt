<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/UpfrontPaymentWith" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchUpfrontPaymentWith" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiUpfrontPaymentWith" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiUpfrontPaymentWith" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:tradeDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:id"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:custNumberGroup/b:custNumber,$COMPANY_POSTFIX_SEPARATOR,b:custNumberGroup/b:securityAccnt,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter1"/>
   <xsl:template name="transactionFeesTaxesCounter2"/>
   <xsl:template name="type">
	<type>
		<infra:code>
			<xsl:value-of select="concat('SC_',b:transactionCode)"/>
		</infra:code>
	</type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="currentAccount">
      <currentAccount>
         <infra:code>
            <xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
           <xsl:value-of select="b:custNumberGroup/b:cuCashAmount"/>
      </quantity>
   </xsl:template>
   <xsl:template name="transactionCcyGrossAmount"/>
   <xsl:template name="transactionCcyNetAmount"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="transactionCurrency"/>
   <xsl:template name="transactionDate"/>
</xsl:stylesheet>