<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c d e f g ns0 batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS"
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
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTPHServiceFlow">
		<xsl:apply-templates select="c:CurrentEvent/b:TPHServiceFlow"/>
	</xsl:template>
	<xsl:template match="batch:BatchTPHServiceFlow">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTPHServiceFlow" name="BatchTPHServiceFlow">
			<xsl:apply-templates select="b:TPHServiceFlow"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTPHServiceFlow">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTPHServiceFlow" name="BatchMultiTPHServiceFlow">
			<xsl:apply-templates select="c:MultiTPHServiceFlow"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TPHServiceFlow">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionPaymentIncomingRevTPH',b:portransactionrec/d:fTNumber)"/>
			</xsl:attribute>
			<DataGroup>
				<Cash>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionPaymentIncomingRevTPH.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<transferIn>
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
						<xsl:call-template name="bankFeeAmount"/>
						<xsl:call-template name="chargeAmount"/>
						<xsl:call-template name="chargeCode"/>
						<xsl:call-template name="chargedCustomer"/>
						<xsl:call-template name="counterpartAccount"/>
						<xsl:call-template name="counterpartAmount"/>
						<xsl:call-template name="counterpartCurrency"/>
						<xsl:call-template name="counterpartOriginalAmount"/>
						<xsl:call-template name="commissionCode"/>
						<xsl:call-template name="currentAccount"/>
						<xsl:call-template name="extBankAccOwnerName"/>
						<xsl:call-template name="fxClientRate"/>
						<xsl:call-template name="fxMarketRate"/>
						<xsl:call-template name="originalAmount"/>
						<xsl:call-template name="originalNetAmount"/>
						<xsl:call-template name="quantity"/>
						<xsl:call-template name="totalChargedAmount"/>
						<xsl:call-template name="transactionCcyGrossAmount"/>
						<xsl:call-template name="transactionCcyNetAmount"/>
						<xsl:call-template name="transactionCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="transactionCurrency"/>
						<xsl:call-template name="transactionDate"/>
					</transferIn>
				</Cash>
			</DataGroup>
		</TransactionPMS>
	</xsl:template>
</xsl:stylesheet>