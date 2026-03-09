<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDepositsOldNew"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDepositsOldNew"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:drawdownAccount"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account2">
      <account2>
         <infra:code>
            <xsl:if test="b:drawdownAccount != b:chrgLiqAcct">
               <xsl:value-of select="b:chrgLiqAcct"/>
            </xsl:if>
         </infra:code>
      </account2>
   </xsl:template>
   <xsl:template name="loan">
      <loan>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </loan>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:cusPortId"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
		<xsl:choose>
			<xsl:when test="b:totPrincTax and b:totPrincTax != ''">
				<amount>
					<xsl:value-of select="b:totPrincTax"/>
				</amount>
			</xsl:when>
			<xsl:otherwise>
				<amount>
					<xsl:value-of select="'0'"/>
				</amount>
			</xsl:otherwise>
		</xsl:choose>
         <currency>
            <infra:code>
               <xsl:value-of select="b:currency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP2'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="'OPEN_LD_LOAN'"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </valueDate>
   </xsl:template>
   <xsl:template name="loanAmount">
      <loanAmount>
         <xsl:value-of select="b:amountList/b:amount"/>
      </loanAmount>
   </xsl:template>
   <xsl:template name="account1CcyLoanCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2CcyLoanCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyLoanCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="fusionRule"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="loanCurrency"/>
   <xsl:template name="loanCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="loanInterestRate"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="referenceTransactionCode"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="referenceNature">
      <referenceNature>
         <xsl:value-of select="'0'"/>
      </referenceNature>
   </xsl:template>
   <xsl:template name="accruedInterestAmount">
      <accruedInterestAmount>
         <xsl:value-of select="'0'"/>
      </accruedInterestAmount>
   </xsl:template>
   <xsl:template name="commonReference"/>
   <xsl:template name="expirationDate"/>
   <xsl:template name="renewalAmount"/>
   <xsl:template name="renewalEndDate"/>
   <xsl:template name="renewalInterestRate"/>
   <xsl:template name="renewalMode"/>
   <xsl:template name="renewalPeriod"/>
   <xsl:template name="renewalPeriodNumber"/>
   <xsl:template name="renewalTreatment"/>
</xsl:stylesheet>
