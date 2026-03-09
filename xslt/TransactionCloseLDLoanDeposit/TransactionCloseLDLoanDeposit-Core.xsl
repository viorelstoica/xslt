<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/AcEntry/AcEntry" xmlns:batch="http://www.temenos.com/T24/event/AcEntry/BatchAcEntry" xmlns:c="http://www.temenos.com/T24/event/AcEntry/MultiAcEntry" xmlns:d="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:e="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/AcEntry/BatchMultiAcEntry" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="setMinRank">
      <xsl:for-each select="b:statemententry/e:transactionCode/@Rank">
         <xsl:sort data-type="number" order="descending" select="."/>
         <xsl:if test="position()=last()">
            <xsl:value-of select="."/>
         </xsl:if>
      </xsl:for-each>
   </xsl:template><!-- DEPOSIT -->
   <xsl:template name="d_account1">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <account1>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="d_account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="d_account1NetAmount"/>
   <xsl:template name="d_account2"/>
   <xsl:template name="d_account2CcyDepositCcyExchangeRate"/>
   <xsl:template name="d_account2NetAmount"/>
   <xsl:template name="d_account3"/>
   <xsl:template name="d_account3CcyDepositCcyExchangeRate"/>
   <xsl:template name="d_account3NetAmount"/>
   <xsl:template name="d_accountingCode"/>
   <xsl:template name="d_accountingDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <accountingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </accountingDate>
   </xsl:template>
   <xsl:template name="d_cashPortfolio"/>
   <xsl:template name="d_contractNumber"/>
   <xsl:template name="d_counterparty"/>
   <xsl:template name="d_deposit">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <deposit>
         <infra:code>
            <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
         </infra:code>
      </deposit>
   </xsl:template>
   <xsl:template name="d_depositCurrency">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <depositCurrency>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:currency"/>
         </infra:code>
      </depositCurrency>
   </xsl:template>
   <xsl:template name="d_depositCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="d_fusionRule"/>
   <xsl:template name="d_initiatedBy"/>
   <xsl:template name="d_initiator"/>
   <xsl:template name="d_notepad"/>
   <xsl:template name="d_portfolio">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="d_portfolioManager"/>
   <xsl:template name="d_remark"/>
   <xsl:template name="d_referenceTransactionCode"/>
   <xsl:template name="d_reversalIndicator"/>
   <xsl:template name="d_reversedTransactionCode"/>
   <xsl:template name="d_sourceSystemCode"/>
   <xsl:template name="d_status">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="d_subType"/>
   <xsl:template name="d_trader"/>
   <xsl:template name="d_transactionCode">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCode>
         <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNumber,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="d_transactionDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionDate>
         <xsl:choose>
            <xsl:when test="string-length(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionDate>
   </xsl:template>
   <xsl:template name="d_transactionFeesTaxesCounter"/>
   <xsl:template name="d_type"/>
   <xsl:template name="d_valueDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </valueDate>
   </xsl:template>
   <xsl:template name="d_userDefinedField"/>
   <xsl:template name="d_mbFields"/>
   <xsl:template name="d_referenceNature">
      <referenceNature>
         <xsl:value-of select="'0'"/>
      </referenceNature>
   </xsl:template>
   <xsl:template name="d_accruedInterestAmount">
      <accruedInterestAmount>
         <xsl:value-of select="'0'"/>
      </accruedInterestAmount>
   </xsl:template>
   <xsl:template name="d_commonReference"/>
   <xsl:template name="d_depositAmount">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <depositAmount>
         <xsl:choose>
            <xsl:when test="(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy)) and (b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy))">
               <xsl:value-of select="0"/>
            </xsl:when>
            <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy)">
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy"/>
            </xsl:otherwise>
         </xsl:choose>
      </depositAmount>
   </xsl:template>
   <xsl:template name="d_depositInterestRate"/>
   <xsl:template name="d_expirationDate"/>
   <xsl:template name="d_renewalAmount"/>
   <xsl:template name="d_renewalEndDate"/>
   <xsl:template name="d_renewalInterestrate"/>
   <xsl:template name="d_renewalMode"/>
   <xsl:template name="d_renewalPeriod"/>
   <xsl:template name="d_renewalPeriodNumber"/>
   <xsl:template name="d_interestAmount"/>
   <xsl:template name="d_renewalTreatment"/>
   <xsl:template name="d_lockNature"/><!-- end of DEPOSIT --><!-- LOAN -->
   <xsl:template name="l_account1">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <account1>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="l_account1CcyLoanCcyExchangeRate"/>
   <xsl:template name="l_account1NetAmount"/>
   <xsl:template name="l_account2"/>
   <xsl:template name="l_account2CcyLoanCcyExchangeRate"/>
   <xsl:template name="l_account2NetAmount"/>
   <xsl:template name="l_account3"/>
   <xsl:template name="l_account3CcyLoanCcyExchangeRate"/>
   <xsl:template name="l_account3NetAmount"/>
   <xsl:template name="l_accountingCode"/>
   <xsl:template name="l_accountingDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <accountingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </accountingDate>
   </xsl:template>
   <xsl:template name="l_cashPortfolio"/>
   <xsl:template name="l_contractNumber"/>
   <xsl:template name="l_counterparty"/>
   <xsl:template name="l_loan">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <loan>
         <infra:code>
            <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
         </infra:code>
      </loan>
   </xsl:template>
   <xsl:template name="l_loanCurrency">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <loanCurrency>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:currency"/>
         </infra:code>
      </loanCurrency>
   </xsl:template>
   <xsl:template name="l_loanCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="l_fusionRule"/>
   <xsl:template name="l_initiatedBy"/>
   <xsl:template name="l_initiator"/>
   <xsl:template name="l_notepad"/>
   <xsl:template name="l_portfolio">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="l_portfolioManager"/>
   <xsl:template name="l_remark"/>
   <xsl:template name="l_referenceTransactionCode"/>
   <xsl:template name="l_reversalIndicator"/>
   <xsl:template name="l_reversedTransactionCode"/>
   <xsl:template name="l_sourceSystemCode"/>
   <xsl:template name="l_status">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="l_subType"/>
   <xsl:template name="l_trader"/>
   <xsl:template name="l_transactionCode">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCode>
         <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNumber,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="l_transactionDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionDate>
         <xsl:choose>
            <xsl:when test="string-length(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionDate>
   </xsl:template>
   <xsl:template name="l_transactionFeesTaxesCounter"/>
   <xsl:template name="l_type"/>
   <xsl:template name="l_valueDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </valueDate>
   </xsl:template>
   <xsl:template name="l_userDefinedField"/>
   <xsl:template name="l_mbFields"/>
   <xsl:template name="l_referenceNature">
      <referenceNature>
         <xsl:value-of select="'0'"/>
      </referenceNature>
   </xsl:template>
   <xsl:template name="l_accruedInterestAmount">
      <accruedInterestAmount>
         <xsl:value-of select="'0'"/>
      </accruedInterestAmount>
   </xsl:template>
   <xsl:template name="l_commonReference"/>
   <xsl:template name="l_loanAmount">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <loanAmount>
         <xsl:choose>
            <xsl:when test="(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy)) and (b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy))">
               <xsl:value-of select="0"/>
            </xsl:when>
            <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy)">
               <xsl:value-of select="format-number(-1 * b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy,$decimalformat,'nan2zero')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="format-number(-1 * b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy,$decimalformat,'nan2zero')"/>
            </xsl:otherwise>
         </xsl:choose>
      </loanAmount>
   </xsl:template>
   <xsl:template name="l_loanInterestRate"/>
   <xsl:template name="l_expirationDate"/>
   <xsl:template name="l_renewalAmount"/>
   <xsl:template name="l_renewalEndDate"/>
   <xsl:template name="l_renewalInterestRate"/>
   <xsl:template name="l_renewalMode"/>
   <xsl:template name="l_renewalPeriod"/>
   <xsl:template name="l_renewalPeriodNumber"/>
   <xsl:template name="l_interestAmount"/>
   <xsl:template name="l_renewalTreatment"/><!-- end of LOAN -->
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