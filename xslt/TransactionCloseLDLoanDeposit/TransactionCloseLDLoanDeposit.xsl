<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/AcEntry/AcEntry" xmlns:batch="http://www.temenos.com/T24/event/AcEntry/BatchAcEntry" xmlns:c="http://www.temenos.com/T24/event/AcEntry/MultiAcEntry" xmlns:d="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:e="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/AcEntry/BatchMultiAcEntry" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiAcEntry">
      <xsl:apply-templates select="c:CurrentEvent/b:AcEntry"/>
   </xsl:template>
   <xsl:template match="batch:BatchAcEntry">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAcEntry" name="BatchAcEntry">
         <xsl:apply-templates select="b:AcEntry"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiAcEntry">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAcEntry" name="BatchMultiAcEntry">
         <xsl:apply-templates select="c:MultiAcEntry"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:AcEntry">
      <TransactionPMS mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('TransactionCloseLDLoanDeposit',b:entryReference)"/>
         </xsl:attribute>
         <DataGroup>
            <DepositLoan>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('TransactionCloseLDLoanDeposit.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:variable name="MinRank">
                  <xsl:call-template name="setMinRank"/>
               </xsl:variable>
               <xsl:variable name="CRFPRODCAT">
                  <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:crfProdCat"/>
               </xsl:variable>
               <xsl:if test="($CRFPRODCAT &lt;= '21039' and '21001' &lt;= $CRFPRODCAT) or ($CRFPRODCAT &lt;= '21049' and '21045' &lt;= $CRFPRODCAT)">
                  <depositClosing>
                     <xsl:call-template name="d_account1"/>
                     <xsl:call-template name="d_account1CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="d_account1NetAmount"/>
                     <xsl:call-template name="d_account2"/>
                     <xsl:call-template name="d_account2CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="d_account2NetAmount"/>
                     <xsl:call-template name="d_account3"/>
                     <xsl:call-template name="d_account3CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="d_account3NetAmount"/>
                     <xsl:call-template name="d_accountingCode"/>
                     <xsl:call-template name="d_accountingDate"/>
                     <xsl:call-template name="d_cashPortfolio"/>
                     <xsl:call-template name="d_commonReference"/>
                     <xsl:call-template name="d_contractNumber"/>
                     <xsl:call-template name="d_counterparty"/>
                     <xsl:call-template name="d_deposit"/>
                     <xsl:call-template name="d_depositCurrency"/>
                     <xsl:call-template name="d_depositCcyPortfolioCcyExchangeRate"/>
                     <xsl:call-template name="d_fusionRule"/>
                     <xsl:call-template name="d_initiatedBy"/>
                     <xsl:call-template name="d_initiator"/>
                     <xsl:call-template name="d_notepad"/>
                     <xsl:call-template name="d_portfolio"/>
                     <xsl:call-template name="d_portfolioManager"/>
                     <xsl:call-template name="d_remark"/>
                     <xsl:call-template name="d_referenceTransactionCode"/>
                     <xsl:call-template name="d_reversalIndicator"/>
                     <xsl:call-template name="d_reversedTransactionCode"/>
                     <xsl:call-template name="d_sourceSystemCode"/>
                     <xsl:call-template name="d_status"/>
                     <xsl:call-template name="d_subType"/>
                     <xsl:call-template name="d_trader"/>
                     <xsl:call-template name="d_transactionCode"/>
                     <xsl:call-template name="d_transactionDate"/>
                     <xsl:call-template name="d_transactionFeesTaxesCounter"/>
                     <xsl:call-template name="d_type"/>
                     <xsl:call-template name="d_valueDate"/>
                     <xsl:call-template name="d_userDefinedField"/>
                     <xsl:call-template name="d_mbFields"/>
                     <xsl:call-template name="d_accruedInterestAmount"/>
                     <xsl:call-template name="d_depositAmount"/>
                     <xsl:call-template name="d_depositInterestRate"/>
                     <xsl:call-template name="d_expirationDate"/>
				     <xsl:call-template name="d_lockNature"/>
                     <xsl:call-template name="d_referenceNature"/>
                     <xsl:call-template name="d_renewalAmount"/>
                     <xsl:call-template name="d_renewalEndDate"/>
                     <xsl:call-template name="d_renewalInterestrate"/>
                     <xsl:call-template name="d_renewalMode"/>
                     <xsl:call-template name="d_renewalPeriod"/>
                     <xsl:call-template name="d_renewalPeriodNumber"/>
                     <xsl:call-template name="d_renewalTreatment"/>
					 <xsl:call-template name="d_interestAmount"/>
                  </depositClosing>
               </xsl:if>
               <xsl:if test="($CRFPRODCAT &lt;= '21074' and '21050' &lt;= $CRFPRODCAT)">
                  <loanClosing>
                     <xsl:call-template name="l_account1"/>
                     <xsl:call-template name="l_account1CcyLoanCcyExchangeRate"/>
                     <xsl:call-template name="l_account1NetAmount"/>
                     <xsl:call-template name="l_account2"/>
                     <xsl:call-template name="l_account2CcyLoanCcyExchangeRate"/>
                     <xsl:call-template name="l_account2NetAmount"/>
                     <xsl:call-template name="l_account3"/>
                     <xsl:call-template name="l_account3CcyLoanCcyExchangeRate"/>
                     <xsl:call-template name="l_account3NetAmount"/>
                     <xsl:call-template name="l_accountingCode"/>
                     <xsl:call-template name="l_accountingDate"/>
                     <xsl:call-template name="l_cashPortfolio"/>
                     <xsl:call-template name="l_commonReference"/>
                     <xsl:call-template name="l_contractNumber"/>
                     <xsl:call-template name="l_counterparty"/>
                     <xsl:call-template name="l_fusionRule"/>
                     <xsl:call-template name="l_initiatedBy"/>
                     <xsl:call-template name="l_initiator"/>
                     <xsl:call-template name="l_loan"/>
                     <xsl:call-template name="l_loanCurrency"/>
                     <xsl:call-template name="l_loanCcyPortfolioCcyExchangeRate"/>
                     <xsl:call-template name="l_loanInterestRate"/>
                     <xsl:call-template name="l_notepad"/>
                     <xsl:call-template name="l_portfolio"/>
                     <xsl:call-template name="l_portfolioManager"/>
                     <xsl:call-template name="l_remark"/>
                     <xsl:call-template name="l_referenceTransactionCode"/>
                     <xsl:call-template name="l_reversalIndicator"/>
                     <xsl:call-template name="l_reversedTransactionCode"/>
                     <xsl:call-template name="l_sourceSystemCode"/>
                     <xsl:call-template name="l_status"/>
                     <xsl:call-template name="l_subType"/>
                     <xsl:call-template name="l_trader"/>
                     <xsl:call-template name="l_transactionCode"/>
                     <xsl:call-template name="l_transactionDate"/>
                     <xsl:call-template name="l_transactionFeesTaxesCounter"/>
                     <xsl:call-template name="l_type"/>
                     <xsl:call-template name="l_valueDate"/>
                     <xsl:call-template name="l_userDefinedField"/>
                     <xsl:call-template name="l_mbFields"/>
                     <xsl:call-template name="l_accruedInterestAmount"/>
                     <xsl:call-template name="l_expirationDate"/>
                     <xsl:call-template name="l_loanAmount"/>
                     <xsl:call-template name="l_referenceNature"/>
                     <xsl:call-template name="l_renewalAmount"/>
                     <xsl:call-template name="l_renewalEndDate"/>
                     <xsl:call-template name="l_renewalInterestRate"/>
                     <xsl:call-template name="l_renewalMode"/>
                     <xsl:call-template name="l_renewalPeriod"/>
                     <xsl:call-template name="l_renewalPeriodNumber"/>
                     <xsl:call-template name="l_renewalTreatment"/>
					 <xsl:call-template name="l_interestAmount"/>
                  </loanClosing>
               </xsl:if>
            </DepositLoan>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionCloseLDLoanDeposit" userelativepaths="yes" externalpreview="no" url="..\..\..\..\testfiles\TransactionLDCommAndChrg\20170117_141229_237_46_msgin_AcEntry_70a34192-6a74-4bb8-93c4-0e4ef3797028.xml"
		          htmlbaseurl="" outputurl="..\..\..\TransactionCloseLDLoanDepositCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->