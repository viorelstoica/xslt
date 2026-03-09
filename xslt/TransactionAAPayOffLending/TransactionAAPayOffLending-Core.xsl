<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"   xmlns:m="http://www.temenos.com/T24/event/Common/EventCommon"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l m" version="1.0">
  <xsl:template name="account1">
    <account1>
      <infra:code>
        <xsl:value-of select="../c:ftrecord/l:debitAcctNo"/>
      </infra:code>
    </account1>
  </xsl:template>
  <xsl:template name="account1CcyLoanCcyExchangeRate">
    <xsl:if test="../c:ftrecord/l:customerRate">
      <account1CcyLoanCcyExchangeRate>
        <xsl:choose>
          <xsl:when test="$boDefaultExch_Inverse_Flag = 0">
            <xsl:value-of select="../c:ftrecord/l:customerRate"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number(1 div ../c:ftrecord/l:customerRate,$decimalformat,'nan2zero')"/>
          </xsl:otherwise>
        </xsl:choose>
      </account1CcyLoanCcyExchangeRate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="account1NetAmount">
    <account1NetAmount>
      <xsl:variable name="orPropAmountACCOUNT">
        <xsl:call-template name="getAAPayOffLendingLoanAmount">
          <xsl:with-param name="billdetailnode" select="../c:billdetails"/>
          <xsl:with-param name="billId" select="../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId"/>
        </xsl:call-template>
        <!--
<xsl:value-of select="format-number(../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT']/j:orPropAmount,$decimalformat,'nan2zero')"/>
-->
      </xsl:variable>
      <xsl:variable name="orPropAmountPAYOFFFEE">
        <xsl:value-of select="format-number(../c:billdetails/j:billProperyDetails[j:property = 'PAYOFFFEE']/j:orPropAmount,$decimalformat,'nan2zero')"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="../c:ftrecord/l:customerRate and ../c:ftrecord/l:customerRate != 0">
          <xsl:value-of select="format-number(($orPropAmountACCOUNT + $orPropAmountPAYOFFFEE) div ../c:ftrecord/l:customerRate,$decimalformat,'nan2zero')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number($orPropAmountACCOUNT + $orPropAmountPAYOFFFEE,$decimalformat,'nan2zero')"/>
        </xsl:otherwise>
      </xsl:choose>
    </account1NetAmount>
  </xsl:template>
  <xsl:template name="account2"/>
  <xsl:template name="account2CcyLoanCcyExchangeRate"/>
  <xsl:template name="account2NetAmount"/>
  <xsl:template name="account3"/>
  <xsl:template name="account3CcyLoanCcyExchangeRate"/>
  <xsl:template name="account3NetAmount"/>
  <xsl:template name="accountingCode"/>
  <xsl:template name="accountingDate">
    <accountingDate>
        <xsl:value-of select="../c:eventCommon/m:today"/>
    </accountingDate>
  </xsl:template>
  <xsl:template name="cashPortfolio"/>
  <xsl:template name="contractNumber"/>
  <xsl:template name="counterparty"/>
  <xsl:template name="fusionRule"/>
  <xsl:template name="initiatedBy"/>
  <xsl:template name="initiator"/>
  <xsl:template name="loan">
    <loan>
      <infra:code>
        <xsl:choose>
			<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
        		<xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="../c:aatxncontext/b:aaArrangementId"/>
			</xsl:otherwise>
		</xsl:choose>
      </infra:code>
    </loan>
  </xsl:template>
  <xsl:template name="loanCurrency">
    <loanCurrency>
      <infra:code>
        <xsl:value-of select="d:currency"/>
      </infra:code>
    </loanCurrency>
  </xsl:template>
  <xsl:template name="loanCcyPortfolioCcyExchangeRate"/>
  <xsl:template name="loanInterestRate"/>
  <xsl:template name="notepad"/>
  <xsl:template name="portfolio">
    <portfolio>
      <infra:code>
        <xsl:value-of select="../c:accountrecord/g:portfolioId"/>
      </infra:code>
    </portfolio>
  </xsl:template>
  <xsl:template name="portfolioManager"/>
  <xsl:template name="remark"/>
  <xsl:template name="referenceTransactionCode"/>
  <xsl:template name="reversalIndicator"/>
  <xsl:template name="reversedTransactionCode"/>
  <xsl:template name="sourceSystemCode">
   	  <sourceSystemCode>
		 <xsl:value-of select="../c:aatxncontext/b:aaArrActivityId"/>
	  </sourceSystemCode>
  </xsl:template>
  <xsl:template name="status">
    <status>
      <xsl:call-template name="statusTranslation">
        <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
      </xsl:call-template>
    </status>
  </xsl:template>
  <xsl:template name="subType"/>
  <xsl:template name="trader"/>
  <xsl:template name="transactionCode">
    <transactionCode>
      <xsl:choose>
			<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
      			<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'-1')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,'-1')"/>
			</xsl:otherwise>
		</xsl:choose>
    </transactionCode>
  </xsl:template>
  <xsl:template name="transactionDate">
    <transactionDate>
      <xsl:call-template name="xsdate">
        <xsl:with-param name="date" select="d:effectiveDate"/>
      </xsl:call-template>
    </transactionDate>
  </xsl:template>
  <xsl:template name="transactionFeesTaxesCounter">
    <transactionFeesTaxesCounter>
		<xsl:choose>
			<xsl:when test="../c:billdetails/j:billProperyDetails[j:property = 'PAYOFFFEE']/j:orPropAmount and ../c:billdetails/j:billProperyDetails[j:property = 'PAYOFFFEE']/j:orPropAmount != ''">
				<amount>
					<xsl:value-of select="../c:billdetails/j:billProperyDetails[j:property = 'PAYOFFFEE']/j:orPropAmount"/>
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
          <xsl:value-of select="../c:billdetails/j:currency"/>
        </infra:code>
      </currency>
    </transactionFeesTaxesCounter>
  </xsl:template>
  <xsl:template name="type">
    <type>
      <infra:code>
        <xsl:value-of select="'AA_LendingPayOff'"/>
      </infra:code>
    </type>
  </xsl:template>
  <xsl:template name="valueDate">
    <xsl:choose>
        <xsl:when test="../c:ftrecord/l:debitValueDate and ../c:ftrecord/l:debitValueDate != ''">
            <valueDate>
              <xsl:call-template name="xsdate">
                <xsl:with-param name="date" select="../c:ftrecord/l:debitValueDate"/>
              </xsl:call-template>
            </valueDate>
        </xsl:when>    
        <xsl:otherwise>
            <valueDate>
                 <xsl:call-template name="xsdate">
                    <xsl:with-param name="date" select="../c:billdetails[j:aaBillId = ../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId]/j:financialDate"/>
                 </xsl:call-template>
            </valueDate>
        </xsl:otherwise>        
    </xsl:choose>
  </xsl:template>
  <xsl:template name="userDefinedField"/>
  <xsl:template name="mbFields"/>
  <xsl:template name="accruedInterestAmount">
    <accruedInterestAmount>
      <xsl:value-of select="'0'"/>
    </accruedInterestAmount>
  </xsl:template>
  <xsl:template name="referenceNature">
    <referenceNature>
      <xsl:value-of select="'0'"/>
    </referenceNature>
  </xsl:template>
  <xsl:template name="commonReference"/>
  <xsl:template name="expirationDate"/>
  <xsl:template name="loanAmount">
    <loanAmount>
      <xsl:call-template name="getAAPayOffLendingLoanAmount">
        <xsl:with-param name="billdetailnode" select="../c:billdetails"/>
        <xsl:with-param name="billId" select="../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId"/>
      </xsl:call-template>
      <!--
<xsl:value-of select="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT']/j:orPropAmount"/>
-->
    </loanAmount>
  </xsl:template>
  <xsl:template name="renewalAmount"/>
  <xsl:template name="renewalEndDate"/>
  <xsl:template name="renewalInterestRate"/>
  <xsl:template name="renewalMode"/>
  <xsl:template name="renewalPeriod"/>
  <xsl:template name="renewalPeriodNumber"/>
  <xsl:template name="renewalTreatment"/>
  <xsl:template name="interestAmount"/>
  <xsl:template name="getAAPayOffLendingLoanAmount">
    <xsl:param name="billdetailnode"/>
    <xsl:param name="billId"/>
    <xsl:for-each select="$billdetailnode">
      <xsl:if test="j:aaBillId = $billId  ">
        <xsl:value-of select="j:billProperyDetails[j:property = 'ACCOUNT']/j:orPropAmount"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
