<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">
  <xsl:param name="pay" select="'LENDING-APPLYPAYMENT-PO.WITHDRAWAL'"/>
  <xsl:template name="account1">
    <account1>
      <infra:code>
        <xsl:choose>
          <xsl:when test="d:txnSystemId = 'FT'">
            <xsl:value-of select="../c:ftrecord/l:creditAcctNo"/>
          </xsl:when>
          <xsl:when test="(d:txnSystemId = 'AAAA' or not(d:txnSystemId)) and contains($pay,../c:settlementrecord/h:settPayOutDetails/h:payoutSettleActivity)">
            <xsl:value-of select="../c:settlementrecord/h:settPayOutDetails/h:payoutAccount"/>
          </xsl:when>
        </xsl:choose>
      </infra:code>
    </account1>
  </xsl:template>
  <xsl:template name="account1CcyLoanCcyExchangeRate">
    <xsl:if test="d:txnSystemId = 'FT' and ../c:ftrecord/l:customerRate">
      <account1CcyLoanCcyExchangeRate>
        <xsl:value-of select="../c:ftrecord/l:customerRate"/>
      </account1CcyLoanCcyExchangeRate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="account1NetAmount">
    <account1NetAmount>
      <xsl:choose>
        <xsl:when test="d:txnSystemId = 'FT'">
          <xsl:value-of select="substring(../c:ftrecord/l:amountCredited,4)"/>
        </xsl:when>
        <xsl:when test="d:txnSystemId = 'AAAA'">
          <xsl:value-of select="d:txnAmount"/>
        </xsl:when>
        <xsl:when test="not(d:txnSystemId)">
          <xsl:value-of select="../c:aatxncontext/b:aaCommitmentAmount"/>
        </xsl:when>         
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
      <xsl:call-template name="xsdate">
        <xsl:with-param name="date" select="d:effectiveDate"/>
      </xsl:call-template>
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
  <xsl:template name="loanCurrency"/>
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
      <xsl:choose>
        <xsl:when test="d:recordStatus = 'INAU'">
          <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'TOVALIDATE'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="d:recordStatus = '' or not(d:recordStatus)">
              <xsl:choose>
                <xsl:when test="not(d:txnSystemId)">
                  <xsl:call-template name="statusTranslation">
                    <xsl:with-param name="boStatus" select="'PLACED'"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:call-template name="statusTranslation">
                    <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>        
        </xsl:when>
      </xsl:choose>
    </status>
  </xsl:template>
  <xsl:template name="subType"/>
  <xsl:template name="trader"/>
  <xsl:template name="transactionCode">
    <transactionCode>
      <xsl:choose>
		<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
            <xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic)"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="../c:aatxncontext/b:aaArrangementId"/>
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
  <xsl:template name="transactionFeesTaxesCounter"/>
  <xsl:template name="type">
    <type>
      <infra:code>
        <xsl:value-of select="'AA_OpenLending'"/>
      </infra:code>
    </type>
  </xsl:template>
  <xsl:template name="valueDate">
    <valueDate>
      <xsl:choose>
        <xsl:when test="d:txnSystemId = 'FT'">
          <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="../c:ftrecord/l:creditValueDate"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="d:txnSystemId = 'AAAA' or not(d:txnSystemId)">
          <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="d:effectiveDate"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </valueDate>
  </xsl:template>
  <xsl:template name="userDefinedField"/>
  <xsl:template name="mbFields"/>
  <xsl:template name="referenceNature">
    <referenceNature>
      <xsl:value-of select="'0'"/>
    </referenceNature>
  </xsl:template>
  <xsl:template name="accruedInterestAmount">
    <accruedInterestAmount>
      <xsl:value-of select="'0'"/>
    </accruedInterestAmount>
  </xsl:template>
  <xsl:template name="commonReference"/>
  <xsl:template name="expirationDate"/>
  <xsl:template name="loanAmount">
    <loanAmount>
        <xsl:choose>
            <xsl:when test="not(d:txnSystemId)">
               <xsl:value-of select="../c:aatxncontext/b:aaCommitmentAmount"/>
            </xsl:when>
            <xsl:when test="../c:recaccountdetails/f:maturityDate and ../c:recaccountdetails/f:maturityDate != ''">
               <xsl:value-of select="d:txnAmount"/>
            </xsl:when>
        </xsl:choose>
    </loanAmount>
  </xsl:template>
  <xsl:template name="renewalAmount"/>
  <xsl:template name="renewalEndDate"/>
  <xsl:template name="renewalInterestRate"/>
  <xsl:template name="renewalMode">
	<renewalMode>
		<xsl:choose>
            <xsl:when test="../c:recaccountdetails/f:renewalDate and ../c:recaccountdetails/f:renewalDate != ''">
               <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:when test="../c:recaccountdetails/f:maturityDate and ../c:recaccountdetails/f:maturityDate != ''">
               <xsl:value-of select="'2'"/>
            </xsl:when>
		</xsl:choose>
	</renewalMode>
	</xsl:template>
  <xsl:template name="renewalPeriod"/>
  <xsl:template name="renewalPeriodNumber"/>
  <xsl:template name="renewalTreatment"/>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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