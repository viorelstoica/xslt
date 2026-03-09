<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImf" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:depAccount"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyDepositLoanCcyExchangeRate"/>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:value-of select="b:depIntAmt"/>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyDepositLoanCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyDepositLoanCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="depositLoan">
      <depositLoan>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
         </infra:code>
      </depositLoan>
   </xsl:template>
   <xsl:template name="depositLoanCurrency">
      <depositLoanCurrency>
         <infra:code>
            <xsl:value-of select="b:depositCcy"/>
         </infra:code>
      </depositLoanCurrency>
   </xsl:template>
   <xsl:template name="depositLoanCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="fusionRule"/>
   <xsl:template name="incomeFeesTaxesCounter"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="interestAmount">
      <interestAmount>
         <xsl:value-of select="b:depositAmt"/>
      </interestAmount>
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
   <xsl:template name="referenceTransactionCode"/>
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
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'Dep Int') "/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type"/>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
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
   <xsl:template name="referenceNature"/>
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