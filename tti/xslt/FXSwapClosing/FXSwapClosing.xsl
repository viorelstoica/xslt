<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FXSwapClosing" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFXSwapClosing" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFXSwapClosing" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFXSwapClosing" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/><!-- Main template -->
   <xsl:template match="c:MultiFXSwapClosing">
      <xsl:apply-templates select="c:CurrentEvent/b:FXSwapClosing"/>
   </xsl:template>
   <xsl:template match="batch:BatchFXSwapClosing">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFXSwapClosing" name="BatchFXSwapClosing">
         <xsl:apply-templates select="b:FXSwapClosing"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFXSwapClosing">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFXSwapClosing" name="BatchMultiFXSwapClosing">
         <xsl:apply-templates select="c:MultiFXSwapClosing"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FXSwapClosing">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FXSwapClosing',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <FxSwap>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FXSwapClosing.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <fxSwapClosing>
                  <xsl:call-template name="account1"/>
                  <xsl:call-template name="account1CcyFTCcyExchangeRate"/>
                  <xsl:call-template name="account1NetAmount"/>
                  <xsl:call-template name="account2"/>
                  <xsl:call-template name="account2CcyFTCcyExchangeRate"/>
                  <xsl:call-template name="account2NetAmount"/>
				 
                  <xsl:call-template name="accountingDate"/>
                  <xsl:call-template name="baseCurrQuantity"/>
                  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="direction"/>
                  <xsl:call-template name="expirationDate"/>
                  <xsl:call-template name="fxClientRate"/>
                  <xsl:call-template name="fxMargin"/>
                  <xsl:call-template name="fxMarginAmount"/>
                  <xsl:call-template name="fxMarginP"/>
                  <xsl:call-template name="fxMarketRate"/>
                  <xsl:call-template name="fxRateDirection"/>
                  <xsl:call-template name="fxSpotRate"/>
                  <xsl:call-template name="fxSwapContract"/>
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="operationGrossAmount"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="referenceNature"/>
                  <xsl:call-template name="referenceOperationCode"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="sourceSystemCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="swapRate"/>
                  <xsl:call-template name="tradeCurrency"/>
				 
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionDate"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
 <xsl:call-template name="account3"/>
				  <xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
				  <xsl:call-template name="account3NetAmount"/>
 <xsl:call-template name="transactionFeesTaxesCounter"/>
               </fxSwapClosing>
            </FxSwap>
         </DataGroup>
      </TransactionPMS>
   </xsl:template><!-- End of template b:FXSwapClosing -->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FXSwapClosing" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FXSwapClosing\FXSwapClosing.xml" htmlbaseurl="" outputurl="..\..\TestFiles\FXSwapClosing\FXSwapClosingCusto.xml" processortype="jaxp"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
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