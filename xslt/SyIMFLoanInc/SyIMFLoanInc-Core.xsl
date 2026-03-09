<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImfRollover" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyImfRollover" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:loanLiqAccount"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyLoanCcyExchangeRate"/>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:value-of select="b:loanPrinAdjust"/>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="account2"/>
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
   <xsl:template name="loan">
      <loan>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'L') "/>
         </infra:code>
      </loan>
   </xsl:template>
   <xsl:template name="loanCurrency">
      <loanCurrency>
         <infra:code>
            <xsl:value-of select="b:loanCcy"/>
         </infra:code>
      </loanCurrency>
   </xsl:template>
   <xsl:template name="loanCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="loanInterestRate">
      <loanInterestRate>
         <xsl:value-of select="b:loanInt"/>
      </loanInterestRate>
   </xsl:template>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="referenceTransactionCode">
      <referenceTransactionCode>
         <xsl:value-of select="b:id"/>
      </referenceTransactionCode>
   </xsl:template>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="status">
      <status>
         <xsl:value-of select=" '90' "/>
      </status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'LI') "/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:rolloverDate,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select=" 'IMF_LOAN_INC' "/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:lnAdjEffDate,'-','')"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="loanCapitalIncrease">
      <loanCapitalIncrease>
         <xsl:value-of select=" b:loanPrinAdjust "/>
      </loanCapitalIncrease>
   </xsl:template>
   <xsl:template name="expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </expirationDate>
   </xsl:template>
   <xsl:template name="renewalAmount"/>
   <xsl:template name="renewalEndDate"/>
   <xsl:template name="renewalInterestRate"/>
   <xsl:template name="renewalMode"/>
   <xsl:template name="renewalPeriod"/>
   <xsl:template name="renewalPeriodNumber"/>
   <xsl:template name="renewalTreatment"/>
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