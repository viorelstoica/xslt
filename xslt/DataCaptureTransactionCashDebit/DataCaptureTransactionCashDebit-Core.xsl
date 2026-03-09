<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DataCaptureTransactionCashDebit" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:accountNumber"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="accountingCode">
      <accountingCode>
         <xsl:value-of select="b:id"/>
      </accountingCode>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:eventCommon/ns0:today,'-','')"/>
         </xsl:call-template>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
		 	<xsl:choose>
				<xsl:when test="b:idSecAccMasterJoinList/b:idSecAccMasterJoin">
					<xsl:value-of select="b:idSecAccMasterJoinList/b:idSecAccMasterJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:idSecAccMasterHistJoin"/>
				</xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:id"/>
      </sourceSystemCode>
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
         <xsl:value-of select="concat('DC_',b:id,'_D',$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:choose>
               <xsl:when test="$POSTFIX_TROPTYPE = 'Y' ">
                  <xsl:value-of select="concat('TR_',b:transactionCode,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="concat('TR_',b:transactionCode)"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="currentAccount">
      <currentAccount>
         <infra:code>
            <xsl:value-of select="b:accountNumber"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:choose>
            <xsl:when test="b:amountFcy and b:amountFcy != ''">
               <xsl:value-of select="b:amountFcy"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:amountLcy"/>
            </xsl:otherwise>
         </xsl:choose>
      </quantity>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="commonReference"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="transactionCcyGrossAmount"/>
   <xsl:template name="transactionCcyNetAmount"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="transactionCurrency"/>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:eventCommon/ns0:today,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
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