<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionDerivativeMarginRev" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionDerivativeMarginRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionDerivativeMarginRev" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionDerivativeMarginRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionDerivativeMarginRev">
      <xsl:apply-templates select="c:CurrentEvent/b:TransactionDerivativeMarginRev"/>
   </xsl:template>
   <xsl:template match="batch:BatchTransactionDerivativeMarginRev">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionDerivativeMarginRev" name="BatchTransactionDerivativeMarginRev">
         <xsl:apply-templates select="b:TransactionDerivativeMarginRev"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiTransactionDerivativeMarginRev">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionDerivativeMarginRev" name="BatchMultiTransactionDerivativeMarginRev">
         <xsl:apply-templates select="c:MultiTransactionDerivativeMarginRev"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:TransactionDerivativeMarginRev">
      <TransactionPMS>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('TransactionDerivativeMarginRev',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:for-each select="b:dateGroup">
               <Derivative>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionDerivativeMarginRev.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <marginCall>
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
                     <xsl:call-template name="adjustedDeposit"/>
                     <xsl:call-template name="depositaryAccount"/>
                     <xsl:call-template name="heldQuantity"/>
                     <xsl:call-template name="future"/>
                     <xsl:call-template name="initiatedBy"/>
                     <xsl:call-template name="marginCallDate"/>
                     <xsl:call-template name="newPrice"/>
                     <xsl:call-template name="positionCriteria1"/>
                     <xsl:call-template name="positionCriteria2"/>
                     <xsl:call-template name="positionCriteria3"/>
                     <xsl:call-template name="positionCurrency"/>
                     <xsl:call-template name="referenceNature"/>
                     <xsl:call-template name="referenceTransactionCode"/>
                     <xsl:call-template name="trader"/>
                  </marginCall>
               </Derivative>
            </xsl:for-each>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionDerivativeMarginRev" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionDerivativeMarginRev\TransactionDerivativeMarginRev.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionDerivativeMarginRev\TransactionDerivativeMarginRevGW.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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