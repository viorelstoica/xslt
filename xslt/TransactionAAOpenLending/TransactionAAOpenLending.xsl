<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:batch="http://www.temenos.com/T24/event/AAAExtractor/BatchAAAFlow" exclude-result-prefixes="a b c d e f g h i j k l ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="batch:BatchAAAFlow">
      <xsl:element xmlns="http://www.temenos.com/T24/event/AAAExtractor/BatchAAAFlow" name="BatchAAAFlow">
         <xsl:apply-templates select="c:AAAFlow"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="c:AAAFlow">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('transactionAAOpenLending',c:aatxncontext/b:aaArrangementId)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:call-template name="mappingTransactionAAOpenLending"/>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
   <xsl:template name="mappingTransactionAAOpenLending">
      <xsl:for-each select="c:aaarecord">
         <DepositLoan>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionAAOpenLending.xsl+', name(/*), '+', ../c:eventCommon/ns0:eventId, '+', ../c:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../c:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <loanOpening>
               <xsl:call-template name="account1"/>
               <xsl:call-template name="account1CcyLoanCcyExchangeRate"/>
               <xsl:call-template name="account1NetAmount"/>
               <xsl:call-template name="account2"/>
               <xsl:call-template name="account2CcyLoanCcyExchangeRate"/>
               <xsl:call-template name="account2NetAmount"/>
               <xsl:call-template name="account3"/>
               <xsl:call-template name="account3CcyLoanCcyExchangeRate"/>
               <xsl:call-template name="account3NetAmount"/>
               <xsl:call-template name="accountingCode"/>
               <xsl:call-template name="accountingDate"/>
               <xsl:call-template name="cashPortfolio"/>
               <xsl:call-template name="commonReference"/>
               <xsl:call-template name="contractNumber"/>
               <xsl:call-template name="counterparty"/>
               <xsl:call-template name="fusionRule"/>
               <xsl:call-template name="initiatedBy"/>
               <xsl:call-template name="initiator"/>
               <xsl:call-template name="loan"/>
               <xsl:call-template name="loanCurrency"/>
               <xsl:call-template name="loanCcyPortfolioCcyExchangeRate"/>
               <xsl:call-template name="loanInterestRate"/>
               <xsl:call-template name="notepad"/>
               <xsl:call-template name="portfolio"/>
               <xsl:call-template name="portfolioManager"/>
               <xsl:call-template name="remark"/>
               <xsl:call-template name="referenceTransactionCode"/>
               <xsl:call-template name="reversalIndicator"/>
               <xsl:call-template name="reversedTransactionCode"/>
               <xsl:call-template name="sourceSystemCode"/>
               <xsl:call-template name="status"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="trader"/>
               <xsl:call-template name="transactionCode"/>
               <xsl:call-template name="transactionDate"/>
               <xsl:call-template name="transactionFeesTaxesCounter"/>
               <xsl:call-template name="type"/>
               <xsl:call-template name="valueDate"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
               <xsl:call-template name="accruedInterestAmount"/>
               <xsl:call-template name="expirationDate"/>
               <xsl:call-template name="loanAmount"/>
               <xsl:call-template name="referenceNature"/>
               <xsl:call-template name="renewalAmount"/>
               <xsl:call-template name="renewalEndDate"/>
               <xsl:call-template name="renewalInterestRate"/>
               <xsl:call-template name="renewalMode"/>
               <xsl:call-template name="renewalPeriod"/>
               <xsl:call-template name="renewalPeriodNumber"/>
               <xsl:call-template name="renewalTreatment"/>
            </loanOpening>
         </DepositLoan>
      </xsl:for-each>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="batch:BatchAAAFlow"></template>
			<template name="mappingTransactionAAOpenLending"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->