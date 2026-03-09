<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSSaleClosing" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchIRSSaleClosing" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiIRSSaleClosing" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiIRSSaleClosing" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiIRSSaleClosing">
      <xsl:apply-templates select="c:CurrentEvent/b:IRSSaleClosing"/>
   </xsl:template>
   <xsl:template match="batch:BatchIRSSaleClosing">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchIRSSaleClosing" name="BatchIRSSaleClosing">
         <xsl:apply-templates select="b:IRSSaleClosing"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiIRSSaleClosing">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiIRSSaleClosing" name="BatchMultiIRSSaleClosing">
         <xsl:apply-templates select="c:MultiIRSSaleClosing"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:IRSSaleClosing">
      <TransactionPMS mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('IRSSaleClosing',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <IrSwap>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('IRSSaleClosing.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <IRSwapSaleClosing>
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
                  <xsl:call-template name="contractNumber"/>
                  <xsl:call-template name="counterparty"/>
                  <xsl:call-template name="expirationDate"/>
				  <xsl:call-template name="fixedInterestRate"/>
                  <xsl:call-template name="fusionRule"/>
                  <xsl:call-template name="initiatedBy"/>
                  <xsl:call-template name="initiator"/>
                  <xsl:call-template name="intermediary"/>
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="portfolioManager"/>
                  <xsl:call-template name="principalAmount"/>
                  <xsl:call-template name="remark"/>
				  <xsl:call-template name="referenceNature"/>
                  <xsl:call-template name="referenceTransactionCode"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="sourceSystemCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="swap"/>
                  <xsl:call-template name="swapCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="swapCurrency"/>
                  <xsl:call-template name="trader"/>
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionDate"/>
                  <xsl:call-template name="transactionFeesTaxesCounter"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
               </IRSwapSaleClosing>
            </IrSwap>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionIRSSaleClosing\IRSSaleClosingFilter.xml" htmlbaseurl="" outputurl="..\..\TestFiles\TransactionIRSSaleClosing\IRSSaleClosingGWP.xml"
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