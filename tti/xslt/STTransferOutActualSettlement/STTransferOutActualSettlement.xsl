<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/STTransferOutActualSettlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSTTransferOutActualSettlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSTTransferOutActualSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSTTransferOutActualSettlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSTTransferOutActualSettlement">
      <xsl:apply-templates select="c:CurrentEvent/b:STTransferOutActualSettlement"/>
   </xsl:template>
   <xsl:template match="batch:BatchSTTransferOutActualSettlement">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSTTransferOutActualSettlement" name="BatchSTTransferOutActualSettlement">
         <xsl:apply-templates select="b:STTransferOutActualSettlement"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSTTransferOutActualSettlement">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSTTransferOutActualSettlement" name="BatchMultiSTTransferOutActualSettlement">
         <xsl:apply-templates select="c:MultiSTTransferOutActualSettlement"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:STTransferOutActualSettlement">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('STTransferOutActualSettlement',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Security>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('STTransferOutActualSettlement.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <transferOut>
                  <xsl:call-template name="account1"/>
				  <xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account1NetAmount"/>
                  <xsl:call-template name="account2"/>
                  <xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account2NetAmount"/>
                  <xsl:call-template name="account3"/>
                  <xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account3NetAmount"/>
                  <xsl:call-template name="accountingCode"/>
                  <xsl:call-template name="accountingDate"/>
                  <xsl:call-template name="cashPortfolio"/>
                  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="ContractNumber"/>
				  <xsl:call-template name="intermediary"/>
				  <xsl:call-template name="market"/>                  
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="portfolioManager"/>
                  <xsl:call-template name="remark"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="sourceSystemCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionFeesTaxesCounter"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="accountCurrency"/>
                  <xsl:call-template name="accruedInterestCounter"/>
                  <xsl:call-template name="accruedInterests"/>
				  <xsl:call-template name="boAccount"/>
				  <xsl:call-template name="boPortfolio"/>
                  <xsl:call-template name="depositaryAccount"/>
				  <xsl:call-template name="histOpExchRate"/>
				  <xsl:call-template name="histOpNetAmount"/>
				  <xsl:call-template name="histQuote"/>
                  <xsl:call-template name="initiatedBy"/>
				  <xsl:call-template name="paymentDate"/>
				  <xsl:call-template name="paymentStatus"/>
                  <xsl:call-template name="positionCriteria1"/>
                  <xsl:call-template name="positionCriteria2"/>
                  <xsl:call-template name="positionCriteria3"/>
                  <xsl:call-template name="quantity"/>
                  <xsl:call-template name="security"/>
				  <xsl:call-template name="settlementDate"/>
				  <xsl:call-template name="settlementStatus"/>
				  <xsl:call-template name="splitPortfolio"/>
                  <xsl:call-template name="trader"/>
                  <xsl:call-template name="transactionCcyGrossAmount"/>
                  <xsl:call-template name="transactionCcyNetAmount"/>
                  <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="transactionCurrency"/>
                  <xsl:call-template name="transactionDate"/>
				  <xsl:call-template name="transferPrice"/>
               </transferOut>
            </Security>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\STTransferOutActualSettlement\STTransferOutActualSettlement.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\STTransferOutActualSettlement\ss.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\STTransferOutActualSettlement\STTransferOutActualSettlement.xml" srcSchemaRoot="STTransferOutActualSettlement" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="c:MultiSTTransferOutActualSettlement"></template>
			<template match="b:STTransferOutActualSettlement">
				<block path="TransactionPMS/xsl:attribute[1]/xsl:value-of" x="351" y="54"/>
				<block path="TransactionPMS/DataGroup/Security/xsl:attribute/xsl:value-of" x="351" y="108"/>
				<block path="TransactionPMS/DataGroup/Security/xsl:attribute/xsl:value-of/name[1]" x="305" y="130"/>
				<block path="TransactionPMS/DataGroup/Security/xsl:attribute[1]/xsl:call-template" x="391" y="126"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template" x="311" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[1]" x="271" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[2]" x="231" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[3]" x="191" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[4]" x="151" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[5]" x="111" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[6]" x="71" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[7]" x="31" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[8]" x="311" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[9]" x="271" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[10]" x="231" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[11]" x="191" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[12]" x="151" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[13]" x="111" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[14]" x="71" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[15]" x="31" y="104"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[16]" x="391" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[17]" x="311" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[18]" x="271" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[19]" x="231" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[20]" x="191" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[21]" x="151" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[22]" x="111" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[23]" x="71" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[24]" x="31" y="64"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[25]" x="391" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[26]" x="311" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[27]" x="271" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[28]" x="231" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[29]" x="191" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[30]" x="151" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[31]" x="111" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[32]" x="71" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[33]" x="31" y="24"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[34]" x="351" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[35]" x="391" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[36]" x="311" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[37]" x="271" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[38]" x="231" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[39]" x="191" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[40]" x="151" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[41]" x="111" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[42]" x="71" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[43]" x="31" y="184"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[44]" x="351" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[45]" x="391" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[46]" x="311" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[47]" x="271" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[48]" x="231" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[49]" x="191" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[50]" x="151" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[51]" x="111" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[52]" x="71" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[53]" x="31" y="224"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[54]" x="351" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[55]" x="351" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[56]" x="351" y="144"/>
				<block path="TransactionPMS/DataGroup/Security/transferOut/xsl:call-template[57]" x="351" y="144"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->