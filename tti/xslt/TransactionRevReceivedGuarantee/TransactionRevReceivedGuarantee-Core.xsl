<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionRevReceivedGuarantee" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionRevReceivedGuarantee" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:cusPortId"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <reversalIndicator>
         <xsl:value-of select="'1'"/>
      </reversalIndicator>
   </xsl:template>
   <xsl:template name="reversedTransactionCode">
      <reversedTransactionCode>
         <xsl:value-of select="concat(b:dealNo,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
      </reversedTransactionCode>
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
         <xsl:value-of select="concat(b:dealNo,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic,'_R')"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>1</quantity>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="concat(b:dealNo,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="account1"/>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type"/>
   <xsl:template name="valueDate">
	<valueDate>
      <xsl:value-of select="b:valueDate"/>
    </valueDate>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="accountCurrency"/>
   <xsl:template name="currentAccount"/>
   <xsl:template name="transactionCcyGrossAmount"/>
   <xsl:template name="transactionCcyNetAmount"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="transactionCurrency"/>
   <xsl:template name="transactionDate">
    <transactionDate>
      <xsl:value-of select="b:dealDate"/>
    </transactionDate>
   </xsl:template>
   <xsl:template name="accruedInterestCounter"/>
   <xsl:template name="accruedInterests"/>
   <xsl:template name="depositaryAccount"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="trader"/>
   <xsl:template name="transferPrice"/>
   <xsl:template name="referenceNature"/>
   <xsl:template name="referenceTransactionCode"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/>
   <xsl:template name="histOpExchRate"/>
   <xsl:template name="histOpNetAmount"/>
   <xsl:template name="histQuote"/>
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