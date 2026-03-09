<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c d e f g ns0 batch multibatch" version="1.0" 
	xmlns="http://www.odcgroup.com/TransactionPMS" 
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
	xmlns:b="http://www.temenos.com/T24/event/TTI/TPHServiceFlow" 
	xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTPHServiceFlow" 
	xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTPHServiceFlow" 
	xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTPHServiceFlow" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:d="http://www.temenos.com/T24/PaymentsEventsService/PorTransactionFull" 
	xmlns:e="http://www.temenos.com/T24/PaymentsEventsService/PorTransactionFullAdditional" 
	xmlns:f="http://www.temenos.com/T24/PaymentsEventsService/PorPostingAndConfirmation" 
	xmlns:g="http://www.temenos.com/T24/PaymentsEventsService/AccountDetails" 
	xmlns:infra="http://www.odcgroup.com/InfraPMS" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="account1"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:accountdetails/g:debitPortfolioId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="status">
		<status>
			<xsl:value-of select ="'90'"/>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat('TPH_',b:portransactionrec/d:fTNumber,'_D','_R')"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:portransactionrec/d:debitValueDate"/>
			</xsl:call-template>
		</valueDate>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:portransactionrec/d:debitMainAccount"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:portransactionrec/d:debitMainAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="originalAmount"/>
	<xsl:template name="counterpartCurrency"/>
	<xsl:template name="counterpartOriginalAmount"/>
	<xsl:template name="counterpartAccount"/>
	<xsl:template name="extBankAccOwnerName"/>
	<xsl:template name="chargedCustomer"/>
	<xsl:template name="totalChargedAmount"/>
	<xsl:template name="counterpartAmount"/>
	<xsl:template name="fxClientRate"/>
	<xsl:template name="fxMarketRate"/>
	<xsl:template name="originalNetAmount"/>
	<xsl:template name="transactionCurrency"/>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:portransactionrec/d:processingDate"/>
			</xsl:call-template>
		</transactionDate>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>
			<xsl:value-of select ="'1'"/>
		</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<reversedTransactionCode>
			<xsl:value-of select ="concat('TPH_',b:portransactionrec/d:fTNumber,'_D')"/>
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="bankFeeAmount"/>
	<xsl:template name="chargeAmount"/>
	<xsl:template name="chargeCode"/>
	<xsl:template name="commissionCode"/>
	<xsl:template name="transactionCcyGrossAmount">
		<transactionCcyGrossAmount>
			<xsl:value-of select ="b:portransactionrec/d:transactionAmount"/>
		</transactionCcyGrossAmount>
	</xsl:template>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
</xsl:stylesheet>