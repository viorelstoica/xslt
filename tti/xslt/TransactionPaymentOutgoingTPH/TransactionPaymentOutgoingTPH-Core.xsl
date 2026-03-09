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
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:portransactionrec/d:debitMainAccount"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<xsl:choose>
		   <xsl:when test="b:porpostingandconfirmationrec[f:PorPdFeeType[contains(., 'VAT')]]">
			<account1NetAmount>
				<xsl:value-of select ="format-number(b:portransactionadditionalrec/e:postingChargeAmountDebit + b:portransactionadditionalrec/e:postingVATAmountDebit,$decimalformat,'nan2zero')"/>
			</account1NetAmount>
		   </xsl:when>
		   <xsl:otherwise>
			 <account1NetAmount>
				<xsl:value-of select="format-number(b:portransactionadditionalrec/e:postingMainAmountDebit - b:portransactionrec/d:debitMainAmount,$decimalformat,'nan2zero')"/>
			 </account1NetAmount>
		   </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="accountingCode">
		<accountingCode>
			<xsl:value-of select="b:portransactionrec/d:fTNumber"/>
		</accountingCode>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</accountingDate>
	</xsl:template>
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
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:portransactionrec/d:fTNumber"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<xsl:variable name="boStatus">
			<xsl:value-of select="b:portransactionrec/d:statusCode"/>
		</xsl:variable>
		<status>
			<xsl:choose>
				<xsl:when test="$boStatus = '999' or $boStatus = '677'">
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$boStatus = '997'">
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'CANCELLED'"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat('TPH_',b:portransactionrec/d:fTNumber,'_D')"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:choose>
						<xsl:when test="(b:portransactionrec/d:paymentDirection = 'O' or b:portransactionrec/d:paymentDirection = 'B') and b:porpostingandconfirmationrec[f:PorPdFeeType[contains(., 'VAT')]]">
								<xsl:value-of select ="format-number(b:portransactionadditionalrec/e:postingChargeAmountDebit + b:portransactionadditionalrec/e:postingVATAmountDebit,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:when test="b:portransactionrec/d:paymentDirection = 'O' or b:portransactionrec/d:paymentDirection = 'B'">
								<xsl:value-of select ="format-number(b:portransactionadditionalrec/e:postingMainAmountDebit - b:portransactionrec/d:debitMainAmount,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select ="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</amount>
				<currency>
					<infra:code>
							<xsl:if test="b:portransactionrec/d:paymentDirection = 'O' or b:portransactionrec/d:paymentDirection = 'B'">
								<xsl:value-of select="b:portransactionrec/d:debitMainAccountCurrencyCode"/>
							</xsl:if>
					</infra:code>
				</currency>
				<type>
					<infra:code>CASH_OP_TOT_CHARGES</infra:code>
				</type>
			</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:portransactionrec/d:paymentDirection = 'O'">
						<xsl:choose>
							<xsl:when test="b:portransactionrec/d:outputChannel='LORO' or b:portransactionrec/d:outputChannel='NOSTRO'">
								<xsl:value-of select="'TPH_CRSB'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'TPH_CLR'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="b:portransactionrec/d:paymentDirection = 'B'">
						<xsl:choose>
							<xsl:when test="b:portransactionrec/d:outputChannel='LEDGER'">
								<xsl:value-of select="'TPH_AC'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</type>
	</xsl:template>
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
			<xsl:choose>
				<xsl:when test="b:portransactionrec/d:statusCode != '998' and b:portransactionrec/d:statusCode != '997'">
					<xsl:value-of select="b:portransactionrec/d:debitMainAmount"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:portransactionrec/d:transactionAmount"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="originalAmount">
		<originalAmount>
			<xsl:value-of select="b:portransactionrec/d:transactionAmount"/>
		</originalAmount>
	</xsl:template>
	<xsl:template name="counterpartCurrency">
		<counterpartCurrency>
			<infra:code>
				<xsl:value-of select="b:portransactionrec/d:creditMainAccountCurrencyCode"/>
			</infra:code>
		</counterpartCurrency>
	</xsl:template>
	<xsl:template name="counterpartOriginalAmount">
		<counterpartOriginalAmount>
			<xsl:value-of select="b:portransactionrec/d:transactionAmount"/>
		</counterpartOriginalAmount>
	</xsl:template>
	<xsl:template name="counterpartAccount">
		<counterpartAccount>
			<xsl:value-of select="b:portransactionrec/d:creditMainAccount"/>
		</counterpartAccount>
	</xsl:template>
	<xsl:template name="extBankAccOwnerName">
		<extBankAccOwnerName>
			<xsl:value-of select="b:portransactionrec/d:creditClientID"/>
		</extBankAccOwnerName>
	</xsl:template>
	<xsl:template name="chargedCustomer">
		<chargedCustomer>
			<xsl:value-of select="b:porpostingandconfirmationrec/f:PorPdClientId"/>
		</chargedCustomer>
	</xsl:template>
	<xsl:template name="totalChargedAmount">
		<xsl:choose>
		   <xsl:when test="b:porpostingandconfirmationrec[f:PorPdFeeType[contains(., 'VAT')]]">
			<totalChargedAmount>
				<xsl:value-of select="format-number(b:portransactionadditionalrec/e:postingChargeAmountDebit + b:portransactionadditionalrec/e:postingVATAmountDebit,$decimalformat,'nan2zero')"/>
			</totalChargedAmount>
		   </xsl:when>
		   <xsl:otherwise>
			 <totalChargedAmount>
				<xsl:value-of select="format-number(b:portransactionadditionalrec/e:postingMainAmountDebit - b:portransactionrec/d:debitMainAmount,$decimalformat,'nan2zero')"/>
			 </totalChargedAmount>
		   </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="counterpartAmount">
		<counterpartAmount>
			<xsl:value-of select="b:portransactionrec/d:debitMainAmount"/>
		</counterpartAmount>
	</xsl:template>
	<xsl:template name="fxClientRate">
		<fxClientRate>
			<xsl:value-of select="b:portransactionrec/d:debitExchangeRate"/>
		</fxClientRate>
	</xsl:template>
	<xsl:template name="fxMarketRate">
		<fxMarketRate>
			<xsl:value-of select="b:portransactionrec/d:debitTreasuryRate"/>
		</fxMarketRate>
	</xsl:template>
	<xsl:template name="originalNetAmount">
		<originalNetAmount>
			<xsl:value-of select="b:portransactionrec/d:debitMainAmount"/>
		</originalNetAmount>
	</xsl:template>
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
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="bankFeeAmount"/>
	<xsl:template name="chargeAmount"/>
	<xsl:template name="chargeCode"/>
	<xsl:template name="commissionCode"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
</xsl:stylesheet>