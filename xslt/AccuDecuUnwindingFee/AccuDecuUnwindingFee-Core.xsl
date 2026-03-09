<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1CcyFTCcyExchangeRate"/>
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:unwindGroup/b:unwindChgAcc"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyFTCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyFTCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:if test="b:unwind = 'YES'">
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="translate(b:eventCommon/ns0:today,'-','')"/>
            </xsl:call-template>
         </xsl:if>
      </accountingDate>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="feesTaxesCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="feesTaxesCounter">
      <feesTaxesCounter>
         <infra:code>
            <xsl:value-of select=" 'UNWINDING_FEE'"/>
         </infra:code>
      </feesTaxesCounter>
   </xsl:template>
   <xsl:template name="feesTaxesCurrency">
      <feesTaxesCurrency>
         <infra:code>
            <xsl:value-of select="b:unwindGroup/b:unwindChgCcy"/>
         </infra:code>
      </feesTaxesCurrency>
   </xsl:template>
   <xsl:template name="feesTaxesAmount">
      <feesTaxesAmount>
         <xsl:value-of select="b:unwindGroup/b:unwindChgAmt"/>
      </feesTaxesAmount>
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
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'UNWND_FEE')"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate"/>
   <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
		<xsl:choose>
			<xsl:when test="b:unwindGroup/b:unwindChgAmt and b:unwindGroup/b:unwindChgAmt != ''">
				<amount>
					<xsl:value-of select="b:unwindGroup/b:unwindChgAmt"/>
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
		 		<xsl:value-of select="b:unwindGroup/b:unwindChgCcy"/>
			</infra:code>
		 </currency>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type"/>
   <xsl:template name="valueDate"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="quantity"/>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
</xsl:stylesheet>