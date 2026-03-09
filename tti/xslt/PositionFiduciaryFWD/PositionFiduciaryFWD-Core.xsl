<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:drawdownAcct"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:valueDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="deposit">
      <deposit>
         <infra:code>
            <xsl:value-of select="concat(b:orderNo,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </deposit>
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
		<xsl:value-of select="$FD_UNPLACED_ORDER_STATUS"/>
	</status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:orderNo,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      	<transactionDate>
      		<xsl:choose>
      			<xsl:when test="substring(b:orderNo, string-length(b:orderNo) - string-length('-1') +1) = '-1'">
      			   <xsl:variable name="valueToMap" select="b:orderDate"/>
				   <xsl:choose>
						<xsl:when test="string-length($valueToMap) = 8">
							<xsl:call-template name="xsdate">
								<xsl:with-param name="date" select="$valueToMap"/>
				   			</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
				   			<xsl:value-of select="$valueToMap"/>
						</xsl:otherwise>
        			</xsl:choose>
      			</xsl:when>
	            <xsl:otherwise>
      			 	<xsl:variable name="valueToMap" select="b:valueDate"/>
				    <xsl:choose>
						<xsl:when test="string-length($valueToMap) = 8">
							<xsl:call-template name="xsdate">
								<xsl:with-param name="date" select="$valueToMap"/>
				   			</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
				   			<xsl:value-of select="$valueToMap"/>
						</xsl:otherwise>
        			</xsl:choose>      			 	
	            </xsl:otherwise>      			
      		</xsl:choose>		
      	</transactionDate>	      
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
      <type>
         <infra:code>
			<xsl:value-of select="'FD_REQUEST'"/>
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
   <xsl:template name="depositAmount">
      <depositAmount>
         <xsl:value-of select="b:amount"/>
      </depositAmount>
   </xsl:template>
   <xsl:template name="account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:value-of select="b:amount"/>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyDepositCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyDepositCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="depositCurrency"/>
   <xsl:template name="depositCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="fusionRule"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
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
   <xsl:template name="commonReference"/>
   <xsl:template name="accruedInterestAmount"/>
   <xsl:template name="referenceNature">
        <referenceNature>0</referenceNature>
   </xsl:template>
   <xsl:template name="depositInterestRate"/>
   <xsl:template name="expirationDate"/>
   <xsl:template name="lockNature"/>
   <xsl:template name="renewalAmount"/>
   <xsl:template name="renewalEndDate"/>
   <xsl:template name="renewalInterestrate"/>
   <xsl:template name="renewalMode"/>
   <xsl:template name="renewalPeriod"/>
   <xsl:template name="renewalPeriodNumber"/>
   <xsl:template name="renewalTreatment"/>
</xsl:stylesheet>