<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:p="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:batch="http://www.temenos.com/T24/event/AAAExtractor/BatchAAAFlow" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l p ns0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="@* | node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template match="batch:BatchAAAFlow">
      <xsl:element xmlns="http://www.temenos.com/T24/event/AAAExtractor/BatchAAAFlow" name="BatchAAAFlow">
         <xsl:apply-templates select="c:AAAFlow"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="c:AAAFlow">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('TransactionAARedemptionFeeDeposits',c:aatxncontext/b:aaArrangementId)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:apply-templates select="c:aaarecord"/>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
   <xsl:template match="c:aaarecord">
      <DepositLoan>
         <xsl:attribute name="description">
            <xsl:value-of select="concat('TransactionAARedemptionFeeDeposits.xsl+', name(/*), '+', ../c:eventCommon/ns0:eventId, '+', ../c:eventCommon/ns0:creationTime)"/>
         </xsl:attribute>
         <xsl:attribute name="sequenceNumber">
            <xsl:call-template name="calcSeqNum">
               <xsl:with-param name="creationTime">
                  <xsl:value-of select="../c:eventCommon/ns0:creationTime"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:attribute>
         <depositOpening>
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
            <xsl:call-template name="renewalInterestrate"/>
            <xsl:call-template name="renewalMode"/>
            <xsl:call-template name="renewalPeriod"/>
            <xsl:call-template name="renewalPeriodNumber"/>
            <xsl:call-template name="renewalTreatment"/>
         </depositOpening>
      </DepositLoan>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionAARedemptionFeeDeposits\TransactionAARedemptionFeeDeposits.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionAARedemptionFeeDeposits\TransactionAARedemptionFeeDepositsGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\TTI-1.5\gwpackSchemas\TransactionPMS.xsd" destSchemaRoot="TransactionPMS" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="batch:BatchAAAFlow">
				<block path="xsl:element/xsl:apply-templates" x="351" y="216"/>
			</template>
			<template match="c:AAAFlow">
				<block path="TransactionPMS/xsl:attribute/xsl:value-of" x="351" y="72"/>
				<block path="TransactionPMS/DataGroup/xsl:call-template" x="391" y="90"/>
			</template>
			<template name="mappingTransactionAARedemptionFeeDeposits">
				<block path="xsl:for-each" x="351" y="126"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template" x="391" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[1]" x="311" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[2]" x="271" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[3]" x="231" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[4]" x="191" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[5]" x="151" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[6]" x="111" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[7]" x="71" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[8]" x="31" y="129"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[9]" x="351" y="89"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[10]" x="391" y="89"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[11]" x="311" y="89"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[12]" x="271" y="89"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[13]" x="231" y="56"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[14]" x="191" y="56"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[15]" x="151" y="56"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[16]" x="111" y="56"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[17]" x="71" y="56"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[18]" x="31" y="56"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[19]" x="351" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[20]" x="391" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[21]" x="311" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[22]" x="271" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[23]" x="231" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[24]" x="191" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[25]" x="151" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[26]" x="111" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[27]" x="71" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[28]" x="31" y="16"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[29]" x="391" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[30]" x="311" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[31]" x="271" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[32]" x="231" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[33]" x="191" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[34]" x="151" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[35]" x="111" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[36]" x="71" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[37]" x="31" y="136"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[38]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[39]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[40]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[41]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[42]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[43]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[44]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[45]" x="351" y="96"/>
				<block path="xsl:for-each/DepositLoan/depositOpening/xsl:call-template[46]" x="351" y="96"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->