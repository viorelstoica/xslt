<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImfRollover" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyImfRollover" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyImfRollover" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c batch  ns0" version="1.0">
   <xsl:template name="LOAN_account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:loanLiqAccount"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="LOAN_account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="LOAN_account1NetAmount"/>
   <xsl:template name="LOAN_account2"/>
   <xsl:template name="LOAN_account2CcyDepositCcyExchangeRate"/>
   <xsl:template name="LOAN_account2NetAmount"/>
   <xsl:template name="LOAN_account3"/>
   <xsl:template name="LOAN_account3CcyDepositCcyExchangeRate"/>
   <xsl:template name="LOAN_account3NetAmount"/>
   <xsl:template name="LOAN_accountingCode"/>
   <xsl:template name="LOAN_accountingDate"/>
   <xsl:template name="LOAN_cashPortfolio"/>
   <xsl:template name="LOAN_contractNumber"/>
   <xsl:template name="LOAN_counterparty"/>
   <xsl:template name="LOAN_deposit">
      <deposit>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
         </infra:code>
      </deposit>
   </xsl:template>
   <xsl:template name="LOAN_depositCurrency">
      <depositCurrency>
         <infra:code>
            <xsl:value-of select="b:loanCcy"/>
         </infra:code>
      </depositCurrency>
   </xsl:template>
   <xsl:template name="LOAN_depositCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="LOAN_fusionRule"/>
   <xsl:template name="LOAN_initiatedBy"/>
   <xsl:template name="LOAN_initiator"/>
   <xsl:template name="LOAN_notepad"/>
   <xsl:template name="LOAN_portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="LOAN_portfolioManager"/>
   <xsl:template name="LOAN_remark"/>
   <xsl:template name="LOAN_referenceTransactionCode">
      <referenceTransactionCode>
         <xsl:value-of select="b:id"/>
      </referenceTransactionCode>
   </xsl:template>
   <xsl:template name="LOAN_reversalIndicator">
      <reversalIndicator>
         <xsl:value-of select=" '1' "/>
      </reversalIndicator>
   </xsl:template>
   <xsl:template name="LOAN_reversedTransactionCode">
      <reversedTransactionCode>
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable>
         <xsl:choose>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               <xsl:value-of select=" concat(b:id,'_R',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
            </xsl:otherwise>
         </xsl:choose>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="LOAN_sourceSystemCode"/>
   <xsl:template name="LOAN_status">
      <status>
         <xsl:value-of select=" '90' "/>
      </status>
   </xsl:template>
   <xsl:template name="LOAN_subType"/>
   <xsl:template name="LOAN_trader"/>
   <xsl:template name="LOAN_transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'LIC') "/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="LOAN_transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:rolloverDate,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="LOAN_transactionFeesTaxesCounter"/>
   <xsl:template name="LOAN_type"/>
   <xsl:template name="LOAN_valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:rolloverDate,'-','')"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="LOAN_userDefinedField"/>
   <xsl:template name="LOAN_mbFields"/>
   <xsl:template name="LOAN_commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="LOAN_NewInterestRate">
      <NewInterestRate>
         <xsl:value-of select=" b:loanNewIntRate "/>
      </NewInterestRate>
   </xsl:template>
   <xsl:template name="LOAN_expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </expirationDate>
   </xsl:template>
   <xsl:template name="LOAN_renewalAmount"/>
   <xsl:template name="LOAN_renewalEndDate"/>
   <xsl:template name="LOAN_renewalInterestRate"/>
   <xsl:template name="LOAN_renewalMode"/>
   <xsl:template name="LOAN_renewalPeriod"/>
   <xsl:template name="LOAN_renewalPeriodNumber"/>
   <xsl:template name="LOAN_renewalTreatment"/>
   <xsl:template name="DEPOSIT_account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:depAccount"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="DEPOSIT_account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="DEPOSIT_account1NetAmount"/>
   <xsl:template name="DEPOSIT_account2"/>
   <xsl:template name="DEPOSIT_account2CcyDepositCcyExchangeRate"/>
   <xsl:template name="DEPOSIT_account2NetAmount"/>
   <xsl:template name="DEPOSIT_account3"/>
   <xsl:template name="DEPOSIT_account3CcyDepositCcyExchangeRate"/>
   <xsl:template name="DEPOSIT_account3NetAmount"/>
   <xsl:template name="DEPOSIT_accountingCode"/>
   <xsl:template name="DEPOSIT_accountingDate"/>
   <xsl:template name="DEPOSIT_cashPortfolio"/>
   <xsl:template name="DEPOSIT_contractNumber"/>
   <xsl:template name="DEPOSIT_counterparty"/>
   <xsl:template name="DEPOSIT_deposit">
      <deposit>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
         </infra:code>
      </deposit>
   </xsl:template>
   <xsl:template name="DEPOSIT_depositCurrency">
      <depositCurrency>
         <infra:code>
            <xsl:value-of select="b:depositCcy"/>
         </infra:code>
      </depositCurrency>
   </xsl:template>
   <xsl:template name="DEPOSIT_depositCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="DEPOSIT_fusionRule"/>
   <xsl:template name="DEPOSIT_initiatedBy"/>
   <xsl:template name="DEPOSIT_initiator"/>
   <xsl:template name="DEPOSIT_notepad"/>
   <xsl:template name="DEPOSIT_portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="DEPOSIT_portfolioManager"/>
   <xsl:template name="DEPOSIT_remark"/>
   <xsl:template name="DEPOSIT_referenceTransactionCode">
      <referenceTransactionCode>
         <xsl:value-of select="b:id"/>
      </referenceTransactionCode>
   </xsl:template>
   <xsl:template name="DEPOSIT_reversalIndicator">
      <reversalIndicator>
         <xsl:value-of select=" '1' "/>
      </reversalIndicator>
   </xsl:template>
   <xsl:template name="DEPOSIT_reversedTransactionCode">
      <reversedTransactionCode>
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable>
         <xsl:choose>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               <xsl:value-of select=" concat(b:id,'_R',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
            </xsl:otherwise>
         </xsl:choose>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="DEPOSIT_sourceSystemCode"/>
   <xsl:template name="DEPOSIT_status">
      <status>
         <xsl:value-of select=" '90' "/>
      </status>
   </xsl:template>
   <xsl:template name="DEPOSIT_subType"/>
   <xsl:template name="DEPOSIT_trader"/>
   <xsl:template name="DEPOSIT_transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'DEP INT CHANGE') "/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="DEPOSIT_transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:rolloverDate,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="DEPOSIT_transactionFeesTaxesCounter"/>
   <xsl:template name="DEPOSIT_type"/>
   <xsl:template name="DEPOSIT_valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:rolloverDate,'-','')"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="DEPOSIT_userDefinedField"/>
   <xsl:template name="DEPOSIT_mbFields"/>
   <xsl:template name="DEPOSIT_commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="DEPOSIT_NewInterestRate">
      <NewInterestRate>
         <xsl:value-of select=" b:depNewIntRate "/>
      </NewInterestRate>
   </xsl:template>
   <xsl:template name="DEPOSIT_expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </expirationDate>
   </xsl:template>
   <xsl:template name="DEPOSIT_renewalAmount"/>
   <xsl:template name="DEPOSIT_renewalEndDate"/>
   <xsl:template name="DEPOSIT_renewalInterestRate"/>
   <xsl:template name="DEPOSIT_renewalMode"/>
   <xsl:template name="DEPOSIT_renewalPeriod"/>
   <xsl:template name="DEPOSIT_renewalPeriodNumber"/>
   <xsl:template name="DEPOSIT_renewalTreatment"/>
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