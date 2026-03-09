<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSswap" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:setCurrencyGroup/b:accountNumber"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:tradeDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:maturityDate"/>
         </xsl:call-template>
      </expirationDate>
   </xsl:template>
   <xsl:template name="fixedInterestRate">
      <fixedInterestRate>
         <xsl:value-of select="'0'"/>
      </fixedInterestRate>
   </xsl:template>
   <xsl:template name="fusionRule"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="intermediary">
      <intermediary>
         <infra:code>
            <xsl:value-of select="b:brokerCode"/>
         </infra:code>
      </intermediary>
   </xsl:template>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="concat(b:customer,'-',b:portfolioNumber)"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="principalAmount">
      <principalAmount>
         <xsl:value-of select="b:asPrincipal"/>
      </principalAmount>
   </xsl:template>
   <xsl:template name="remark"/>
   <xsl:template name="referenceTransactionCode">
      <xsl:if test="b:swapType='IRS'">
	   	  <referenceTransactionCode>
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
		  </referenceTransactionCode>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
            <reversalIndicator>
               <xsl:value-of select="1"/>
            </reversalIndicator>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="reversedTransactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <reversedTransactionCode>
         <xsl:if test="$opStatus = 'REVERSE-AUTHORISE' and b:recordStatus = 'REVE' ">
            <xsl:value-of select="concat(b:swapType , '_OPEN',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </xsl:if>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
   		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
   <xsl:template name="spotExchangeRate"/>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="swap">
      <swap>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </swap>
   </xsl:template>
   <xsl:template name="swapCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="swapCurrency"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
         <xsl:choose>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE' and b:recordStatus = 'REVE' ">
               <xsl:value-of select="concat(b:swapType , '_OPEN',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic, '_R')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(b:swapType , '_OPEN',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:value-of select="b:tradeDate"/>
      </transactionDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
		<xsl:choose>
			<xsl:when test="b:brokerage and b:brokerage != ''">
				<amount>
					<xsl:value-of select="b:brokerage"/>
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
               <xsl:value-of select="b:brokerCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP3'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="concat(b:swapType , '_OPEN')"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="referenceNature">
      	<xsl:if test="b:swapType='IRS'">
		   	 <referenceNature>
					<xsl:value-of select="'23'"/>
			 </referenceNature>
	 	</xsl:if>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:valueDate"/>
      </valueDate>
   </xsl:template>
</xsl:stylesheet>