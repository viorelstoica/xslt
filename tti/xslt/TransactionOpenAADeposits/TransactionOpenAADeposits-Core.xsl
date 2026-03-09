<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="a b c d e f g h i j k l ns0" version="1.0">
   <xsl:template name="account1">
      <xsl:variable name="payinSettleActivity" select="'DEPOSITS-APPLYPAYMENT-PR.DEPOSIT'"/>
      <account1>
         <infra:code>
            <xsl:choose>
			   <xsl:when test="d:activity = 'DEPOSITS-NEW-ARRANGEMENT'">
                  <xsl:value-of select="../c:settlementrecord/h:settPayInDetails/h:payinAccount"/>
               </xsl:when>
               <xsl:when test="d:txnSystemId = 'FT'">
                  <xsl:value-of select="../c:ftrecord/l:debitAcctNo"/>
               </xsl:when>
               <xsl:when test="d:txnSystemId = 'AAAA' and contains(../c:settlementrecord/h:settPayInDetails/h:payinSettleActivity,$payinSettleActivity)">
                  <xsl:value-of select="../c:settlementrecord/h:settPayInDetails/h:payinAccount"/>
               </xsl:when>
            </xsl:choose>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyDepositCcyExchangeRate">
      <xsl:if test="c:aaarecord/d:activity != 'DEPOSITS-NEW-ARRANGEMENT' and d:txnSystemId = 'FT' and ../c:ftrecord/l:customerRate">
         <account1CcyDepositCcyExchangeRate>
            <xsl:value-of select="../c:ftrecord/l:customerRate"/>
         </account1CcyDepositCcyExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:choose>
		 	<xsl:when test="d:activity = 'DEPOSITS-NEW-ARRANGEMENT'">
               <xsl:value-of select="../c:billdetails/j:billPaymentDetails[j:paymentType = 'DEPOSIT.PRINCIPAL']/j:paymentAmount"/>
            </xsl:when>
            <xsl:when test="d:txnSystemId = 'FT'">
               <xsl:value-of select="substring(../c:ftrecord/l:amountDebited,4)"/>
            </xsl:when>
            <xsl:when test="d:txnSystemId = 'AAAA'">
               <xsl:value-of select="d:txnAmount"/>
            </xsl:when>
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
		 <xsl:choose>
		 	<xsl:when test="d:activity = 'DEPOSITS-NEW-ARRANGEMENT'">
			   <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="../c:aatxncontext/b:aaEffectiveDate"/>
               </xsl:call-template>
            </xsl:when>
			<xsl:when test="d:txnSystemId and d:txnSystemId = 'FT'">
				<xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="../c:ftrecord/l:processingDate"/>
                 </xsl:call-template>
            </xsl:when>
			<xsl:otherwise>
			   <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="../c:aatxncontext/b:aaEffectiveDate"/>
               </xsl:call-template>
			</xsl:otherwise>
		 </xsl:choose>
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
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="status">
      <status>
         <xsl:choose>
            <xsl:when test="(../c:aatxncontext/b:aaArrStatus = 'AUTH' or ../c:aatxncontext/b:aaArrStatus = 'AUTH-FWD')">
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
   	  <xsl:if test="../c:recaccountdetails/f:contractDate and ../c:recaccountdetails/f:contractDate != ''">
	      <transactionDate>
		  	  	<xsl:call-template name="xsdate">
		            <xsl:with-param name="date" select="../c:recaccountdetails/f:contractDate"/>
		        </xsl:call-template>
	      </transactionDate>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select=" '0' "/>
         </amount>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="'AA_OpenDeposit'"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:choose>
		 	<xsl:when test="d:activity = 'DEPOSITS-NEW-ARRANGEMENT'">
			   <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="../c:aatxncontext/b:aaEffectiveDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="d:txnSystemId = 'FT'">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="../c:ftrecord/l:creditValueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="d:txnSystemId = 'AAAA'">
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
   <xsl:template name="depositAmount">
      <depositAmount>
         <xsl:choose>
		    <xsl:when test="d:activity = 'DEPOSITS-NEW-ARRANGEMENT'">
               <xsl:value-of select="../c:billdetails/j:billPaymentDetails[j:paymentType = 'DEPOSIT.PRINCIPAL']/j:paymentAmount"/>
            </xsl:when>
            <xsl:when test="d:txnSystemId = 'FT'">
               <xsl:value-of select="substring(../c:ftrecord/l:amountCredited,4)"/>
            </xsl:when>
            <xsl:when test="starts-with(d:txnSystemId,'AA')">
               <xsl:value-of select="d:txnAmount"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </depositAmount>
   </xsl:template>
   <xsl:template name="depositInterestRate"/>
   <xsl:template name="expirationDate"/>
   <xsl:template name="renewalAmount"/>
   <xsl:template name="renewalEndDate"/>
   <xsl:template name="renewalInterestrate"/>
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
   <xsl:template name="lockNature"/>
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