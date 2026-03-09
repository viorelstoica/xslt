<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:m="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l m" version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../c:ftrecord/l:debitAcctNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyDepositLoanCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyDepositLoanCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyDepositLoanCcyExchangeRate"/>
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
	<xsl:template name="depositLoan">
		<depositLoan>
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
		</depositLoan>
	</xsl:template>
	<xsl:template name="depositLoanCurrency"/>
	<xsl:template name="depositLoanCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="incomeFeesTaxesCounter"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="interestAmount">
		<interestAmount>
			<xsl:value-of select="format-number(  (-1) * ../c:billdetails[j:aaBillId = ../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId]/j:billProperyDetails[j:property = 'PRINCIPALINT']/j:orPropAmount,$decimalformat,'nan2zero')"/>
		</interestAmount>
	</xsl:template>
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
	<xsl:template name="transactionDate">
		<xsl:param name="varPayOffBillId" select="../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId"/>
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
				<xsl:value-of select="'AA_LendingPayOffInt'"/>
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
	<xsl:template name="commonReference"/>
	<xsl:template name="referenceNature"/>
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