<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImfRollover" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyImfRollover" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyImfRollover" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyImfRollover" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSyImfRollover">
      <xsl:apply-templates select="c:CurrentEvent/b:SyImfRollover"/>
   </xsl:template>
   <xsl:template match="batch:BatchSyImfRollover">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSyImfRollover" name="BatchSyImfRollover">
         <xsl:apply-templates select="b:SyImfRollover"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSyImfRollover">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSyImfRollover" name="BatchMultiSyImfRollover">
         <xsl:apply-templates select="c:MultiSyImfRollover"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SyImfRollover">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('SyIMFIntChange',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:if test="../../c:PreviousEvent/b:SyImfRollover/b:loanInt != b:loanInt">
               <DepositLoan>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('SyIMFIntChange.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <interestRateChange>
                     <xsl:call-template name="LOAN_account1"/>
                     <xsl:call-template name="LOAN_account1CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="LOAN_account1NetAmount"/>
                     <xsl:call-template name="LOAN_account2"/>
                     <xsl:call-template name="LOAN_account2CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="LOAN_account2NetAmount"/>
                     <xsl:call-template name="LOAN_account3"/>
                     <xsl:call-template name="LOAN_account3CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="LOAN_account3NetAmount"/>
                     <xsl:call-template name="LOAN_accountingCode"/>
                     <xsl:call-template name="LOAN_accountingDate"/>
                     <xsl:call-template name="LOAN_cashPortfolio"/>
                     <xsl:call-template name="LOAN_commonReference"/>
                     <xsl:call-template name="LOAN_contractNumber"/>
                     <xsl:call-template name="LOAN_counterparty"/>
                     <xsl:call-template name="LOAN_deposit"/>
                     <xsl:call-template name="LOAN_depositCurrency"/>
                     <xsl:call-template name="LOAN_depositCcyPortfolioCcyExchangeRate"/>
                     <xsl:call-template name="LOAN_fusionRule"/>
                     <xsl:call-template name="LOAN_initiatedBy"/>
                     <xsl:call-template name="LOAN_initiator"/>
                     <xsl:call-template name="LOAN_notepad"/>
                     <xsl:call-template name="LOAN_portfolio"/>
                     <xsl:call-template name="LOAN_portfolioManager"/>
                     <xsl:call-template name="LOAN_remark"/>
                     <xsl:call-template name="LOAN_referenceTransactionCode"/>
                     <xsl:call-template name="LOAN_reversalIndicator"/>
                     <xsl:call-template name="LOAN_reversedTransactionCode"/>
                     <xsl:call-template name="LOAN_sourceSystemCode"/>
                     <xsl:call-template name="LOAN_status"/>
                     <xsl:call-template name="LOAN_subType"/>
                     <xsl:call-template name="LOAN_trader"/>
                     <xsl:call-template name="LOAN_transactionCode"/>
                     <xsl:call-template name="LOAN_transactionDate"/>
                     <xsl:call-template name="LOAN_transactionFeesTaxesCounter"/>
                     <xsl:call-template name="LOAN_type"/>
                     <xsl:call-template name="LOAN_valueDate"/>
                     <xsl:call-template name="LOAN_userDefinedField"/>
                     <xsl:call-template name="LOAN_mbFields"/>
                     <xsl:call-template name="LOAN_NewInterestRate"/>
                     <xsl:call-template name="LOAN_expirationDate"/>
                     <xsl:call-template name="LOAN_renewalAmount"/>
                     <xsl:call-template name="LOAN_renewalEndDate"/>
                     <xsl:call-template name="LOAN_renewalInterestRate"/>
                     <xsl:call-template name="LOAN_renewalMode"/>
                     <xsl:call-template name="LOAN_renewalPeriod"/>
                     <xsl:call-template name="LOAN_renewalPeriodNumber"/>
                     <xsl:call-template name="LOAN_renewalTreatment"/>
                  </interestRateChange>
               </DepositLoan>
            </xsl:if>
            <xsl:if test="../../c:PreviousEvent/b:SyImfRollover/b:depositInt != b:depositInt">
               <DepositLoan>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('SyIMFIntChange.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <interestRateChange>
                     <xsl:call-template name="DEPOSIT_account1"/>
                     <xsl:call-template name="DEPOSIT_account1CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="DEPOSIT_account1NetAmount"/>
                     <xsl:call-template name="DEPOSIT_account2"/>
                     <xsl:call-template name="DEPOSIT_account2CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="DEPOSIT_account2NetAmount"/>
                     <xsl:call-template name="DEPOSIT_account3"/>
                     <xsl:call-template name="DEPOSIT_account3CcyDepositCcyExchangeRate"/>
                     <xsl:call-template name="DEPOSIT_account3NetAmount"/>
                     <xsl:call-template name="DEPOSIT_accountingCode"/>
                     <xsl:call-template name="DEPOSIT_accountingDate"/>
                     <xsl:call-template name="DEPOSIT_cashPortfolio"/>
                     <xsl:call-template name="DEPOSIT_commonReference"/>
                     <xsl:call-template name="DEPOSIT_contractNumber"/>
                     <xsl:call-template name="DEPOSIT_counterparty"/>
                     <xsl:call-template name="DEPOSIT_deposit"/>
                     <xsl:call-template name="DEPOSIT_depositCurrency"/>
                     <xsl:call-template name="DEPOSIT_depositCcyPortfolioCcyExchangeRate"/>
                     <xsl:call-template name="DEPOSIT_fusionRule"/>
                     <xsl:call-template name="DEPOSIT_initiatedBy"/>
                     <xsl:call-template name="DEPOSIT_initiator"/>
                     <xsl:call-template name="DEPOSIT_notepad"/>
                     <xsl:call-template name="DEPOSIT_portfolio"/>
                     <xsl:call-template name="DEPOSIT_portfolioManager"/>
                     <xsl:call-template name="DEPOSIT_remark"/>
                     <xsl:call-template name="DEPOSIT_referenceTransactionCode"/>
                     <xsl:call-template name="DEPOSIT_reversalIndicator"/>
                     <xsl:call-template name="DEPOSIT_reversedTransactionCode"/>
                     <xsl:call-template name="DEPOSIT_sourceSystemCode"/>
                     <xsl:call-template name="DEPOSIT_status"/>
                     <xsl:call-template name="DEPOSIT_subType"/>
                     <xsl:call-template name="DEPOSIT_trader"/>
                     <xsl:call-template name="DEPOSIT_transactionCode"/>
                     <xsl:call-template name="DEPOSIT_transactionDate"/>
                     <xsl:call-template name="DEPOSIT_transactionFeesTaxesCounter"/>
                     <xsl:call-template name="DEPOSIT_type"/>
                     <xsl:call-template name="DEPOSIT_valueDate"/>
                     <xsl:call-template name="DEPOSIT_userDefinedField"/>
                     <xsl:call-template name="DEPOSIT_mbFields"/>
                     <xsl:call-template name="DEPOSIT_NewInterestRate"/>
                     <xsl:call-template name="DEPOSIT_expirationDate"/>
                     <xsl:call-template name="DEPOSIT_renewalAmount"/>
                     <xsl:call-template name="DEPOSIT_renewalEndDate"/>
                     <xsl:call-template name="DEPOSIT_renewalInterestRate"/>
                     <xsl:call-template name="DEPOSIT_renewalMode"/>
                     <xsl:call-template name="DEPOSIT_renewalPeriod"/>
                     <xsl:call-template name="DEPOSIT_renewalPeriodNumber"/>
                     <xsl:call-template name="DEPOSIT_renewalTreatment"/>
                  </interestRateChange>
               </DepositLoan>
            </xsl:if>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\SyIMFIntChange\SyIMFIntChangeFilter.xml" htmlbaseurl="" outputurl="..\..\TestFiles\SyIMFIntChange\SyIMFIntChangeGWP.xml"
		          processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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