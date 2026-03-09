<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSellGuaranteeIssued" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSellGuaranteeIssued" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSellGuaranteeIssued" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSellGuaranteeIssued" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:dealDate) = '8'">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:dealDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:dealDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </accountingDate>
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
         <xsl:value-of select="b:dealNo"/>
         <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
         <xsl:value-of select="b:companyMnemonic"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>MD_IssuedGuarantee</infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = '8'">
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
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:principalAmount"/>
      </quantity>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="b:dealNo"/>
            <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
            <xsl:value-of select="b:companyMnemonic"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="transactionCurrency">
      <transactionCurrency>
         <infra:code>
            <xsl:value-of select="b:currency"/>
         </infra:code>
      </transactionCurrency>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:choose>
            <xsl:when test="string-length(b:dealDate) = '8'">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:dealDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:dealDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionDate>
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
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="accountCurrency"/>
   <xsl:template name="currentAccount"/>
   <xsl:template name="transactionCcyGrossAmount"/>
   <xsl:template name="transactionCcyNetAmount"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
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