<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyImf" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyImf" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyImf" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyImf" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSyImf">
      <xsl:apply-templates select="c:CurrentEvent/b:SyImf"/>
   </xsl:template>
   <xsl:template match="batch:BatchSyImf">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSyImf" name="BatchSyImf">
         <xsl:apply-templates select="b:SyImf"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSyImf">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSyImf" name="BatchMultiSyImf">
         <xsl:apply-templates select="c:MultiSyImf"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SyImf">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('SyIMFUnwindDeposit',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <DepositLoan>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('SyIMFUnwindDeposit.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <depositClosing>
                  <xsl:call-template name="account1"/>
                  <xsl:call-template name="account1CcyDepositCcyExchangeRate"/>
                  <xsl:call-template name="account1NetAmount"/>
                  <xsl:call-template name="account2"/>
                  <xsl:call-template name="account2CcyDepositCcyExchangeRate"/>
                  <xsl:call-template name="account2NetAmount"/>
                  <xsl:call-template name="account3"/>
                  <xsl:call-template name="account3CcyDepositCcyExchangeRate"/>
                  <xsl:call-template name="account3NetAmount"/>
                  <xsl:call-template name="accountingCode"/>
                  <xsl:call-template name="accountingDate"/>
                  <xsl:call-template name="cashPortfolio"/>
                  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="contractNumber"/>
                  <xsl:call-template name="counterparty"/>
                  <xsl:call-template name="deposit"/>
                  <xsl:call-template name="depositCurrency"/>
                  <xsl:call-template name="depositCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="fusionRule"/>
                  <xsl:call-template name="initiatedBy"/>
                  <xsl:call-template name="initiator"/>
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
                  <xsl:call-template name="depositAmount"/>
                  <xsl:call-template name="depositInterestRate"/>
                  <xsl:call-template name="expirationDate"/>
				  <xsl:call-template name="lockNature"/>
                  <xsl:call-template name="referenceNature"/>
                  <xsl:call-template name="renewalAmount"/>
                  <xsl:call-template name="renewalEndDate"/>
                  <xsl:call-template name="renewalInterestRate"/>
                  <xsl:call-template name="renewalMode"/>
                  <xsl:call-template name="renewalPeriod"/>
                  <xsl:call-template name="renewalPeriodNumber"/>
                  <xsl:call-template name="renewalTreatment"/>
				  <xsl:call-template name="interestAmount"/>
               </depositClosing>
            </DepositLoan>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\SyIMFUnwindDeposit\SyIMFUnwindDepositFilter.xml" htmlbaseurl="" outputurl="..\..\TestFiles\SyIMFUnwindDeposit\SyIMFUnwindDepositGWP.xml"
		          processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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