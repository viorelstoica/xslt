<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">
  <xsl:template name="account1">
    <xsl:variable name="payoutProperty" select="'INTEREST'"/>
    <account1>
      <infra:code>
        <xsl:for-each select="../c:settlementrecord/h:settPayOutDetails">
          <xsl:if test="h:payoutPptyClass and contains(h:payoutPptyClass,$payoutProperty)">
            <xsl:value-of select="h:payoutAccount"/>
          </xsl:if>
        </xsl:for-each>
      </infra:code>
    </account1>
  </xsl:template>
  <xsl:template name="account1CcyDepositCcyExchangeRate"/>
  <xsl:template name="account1NetAmount">
    <xsl:variable name="MASTERAAA" select="../c:aaarecord/d:masterAaa"/>
    <xsl:variable name="BILLID" select="../c:recaccountdetails/f:actBillDetails[f:activityRef = $MASTERAAA  
                                                                                 and f:billId = ../../c:billdetails[j:billProperyDetails/j:property = 'DEPOSITINT']/j:aaBillId]/f:billId"/>
    <xsl:variable name="NaN2Zero_acc1_depositInt">
      <xsl:value-of select="format-number(../c:billdetails[j:aaBillId = $BILLID]/j:billProperyDetails[j:property = 'DEPOSITINT']/j:orPropAmount,$decimalformat,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="NaN2Zero_acc1_depositIntTax">
      <xsl:value-of select="format-number(../c:billdetails[j:aaBillId = $BILLID]/j:billProperyDetails[j:property = 'DEPOSITINT-TAX']/j:orPropAmount,$decimalformat,'nan2zero')"/>
    </xsl:variable>
    <account1NetAmount>
	      <xsl:choose>
	        <xsl:when test="../c:billdetails[j:aaBillId = $BILLID]/j:paymentIndicator='DEBIT'">
	             <xsl:value-of select=" (-1) * format-number($NaN2Zero_acc1_depositInt, $decimalformat, 'nan2zero') "/>
	        </xsl:when>
	        <xsl:otherwise>
	             <xsl:value-of select=" format-number($NaN2Zero_acc1_depositInt - $NaN2Zero_acc1_depositIntTax,$decimalformat,'nan2zero') "/>
	        </xsl:otherwise>
	      </xsl:choose>    
    </account1NetAmount>
  </xsl:template>
  <xsl:template name="account2"/>
  <xsl:template name="account2CcyDepositCcyExchangeRate"/>
  <xsl:template name="account2NetAmount"/>
  <xsl:template name="account3"/>
  <xsl:template name="account3CcyDepositCcyExchangeRate"/>
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
  <xsl:template name="deposit">
    <deposit>
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
    </deposit>
  </xsl:template>
  <xsl:template name="depositCurrency"/>
  <xsl:template name="depositCcyPortfolioCcyExchangeRate"/>
  <xsl:template name="fusionRule"/>
  <xsl:template name="initiatedBy"/>
  <xsl:template name="initiator"/>
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
      		<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'-2')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,'-2')"/>
		</xsl:otherwise>
	</xsl:choose>
    </transactionCode>
  </xsl:template>
  <xsl:template name="transactionDate"/>
  <xsl:template name="transactionFeesTaxesCounter"/>
  <xsl:template name="type">
    <type>
      <infra:code>
        <xsl:value-of select="'AA_DepositCapitalInt'"/>
      </infra:code>
    </type>
  </xsl:template>
  <xsl:template name="valueDate">
    <valueDate>
      <xsl:call-template name="xsdate">
        <xsl:with-param name="date" select="../c:aatxncontext/b:aaEffectiveDate"/>
      </xsl:call-template>
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
  <xsl:template name="depositAmount">
    <xsl:variable name="MASTERAAA" select="../c:aaarecord/d:masterAaa"/>
    <xsl:variable name="BILLID" select="../c:recaccountdetails/f:actBillDetails[f:activityRef = $MASTERAAA 
                                                                                 and f:billId = ../../c:billdetails[j:billProperyDetails/j:property = 'DEPOSITINT']/j:aaBillId]/f:billId"/>
    <xsl:variable name="NaN2Zero_acc1_depositInt">
      <xsl:value-of select="format-number(../c:billdetails[j:aaBillId = $BILLID]/j:billProperyDetails[j:property = 'DEPOSITINT']/j:orPropAmount,$decimalformat,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="NaN2Zero_acc1_depositIntTax">
      <xsl:value-of select="format-number(../c:billdetails[j:aaBillId = $BILLID]/j:billProperyDetails[j:property = 'DEPOSITINT-TAX']/j:orPropAmount,$decimalformat,'nan2zero')"/>
    </xsl:variable>
    <depositAmount>
      <!-- same as account amount -->
          <xsl:choose>
            <xsl:when test="../c:billdetails[j:aaBillId = $BILLID]/j:paymentIndicator='DEBIT'">
                  <xsl:value-of select=" (-1) * format-number($NaN2Zero_acc1_depositInt, $decimalformat,'nan2zero') "/>
            </xsl:when>
            <xsl:otherwise>
                  <xsl:value-of select=" format-number($NaN2Zero_acc1_depositInt - $NaN2Zero_acc1_depositIntTax, $decimalformat,'nan2zero') "/>
            </xsl:otherwise>
          </xsl:choose>          
    </depositAmount>
  </xsl:template>
  <xsl:template name="depositInterestRate"/>
  <xsl:template name="expirationDate"/>
  <xsl:template name="renewalAmount"/>
  <xsl:template name="renewalEndDate"/>
  <xsl:template name="renewalInterestrate"/>
  <xsl:template name="renewalMode"/>
  <xsl:template name="renewalPeriod"/>
  <xsl:template name="renewalPeriodNumber"/>
  <xsl:template name="renewalTreatment"/>
  <xsl:template name="lockNature"/>
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