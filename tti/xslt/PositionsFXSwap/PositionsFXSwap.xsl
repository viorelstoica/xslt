<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsForex" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/><!-- Main template -->
   <xsl:template match="c:MultiPositionsForex">
      <xsl:apply-templates select="c:CurrentEvent/b:PositionsForex"/>
   </xsl:template>
   <xsl:template match="batch:BatchPositionsForex">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPositionsForex" name="BatchPositionsForex">
         <xsl:apply-templates select="b:PositionsForex"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiPositionsForex">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsForex" name="BatchMultiPositionsForex">
         <xsl:apply-templates select="c:MultiPositionsForex"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:PositionsForex">
      <PositionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('PositionsFXSwap',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <FxSwapPosition>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('PositionsFXSwap.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="account1"/>
               <xsl:call-template name="account1CcyFTCcyExchangeRate"/>
               <xsl:call-template name="account1NetAmount"/>
               <xsl:call-template name="account2"/>
               <xsl:call-template name="account2CcyFTCcyExchangeRate"/>
               <xsl:call-template name="account2NetAmount"/>
               <xsl:call-template name="accountingDate"/>
               <xsl:call-template name="baseCurrQuantity"/>
               <xsl:call-template name="direction"/>
               <xsl:call-template name="expirationDate"/>
               <xsl:call-template name="fxClientRate"/>
               <xsl:call-template name="fxMargin"/>
               <xsl:call-template name="fxMarginP"/>
               <xsl:call-template name="fxMarketRate"/>
               <xsl:call-template name="fxRateDirection"/>
               <xsl:call-template name="fxSpotRate"/>
               <xsl:call-template name="fxSwapContract"/>
               <xsl:call-template name="operationGrossAmount"/>
               <xsl:call-template name="orderType"/>
               <xsl:call-template name="portfolio"/>
               <xsl:call-template name="referenceNature"/>
               <xsl:call-template name="reversalIndicator"/>
               <xsl:call-template name="reversedTransactionCode"/>
               <xsl:call-template name="sellForward"/>
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
            </FxSwapPosition>
         </DataGroup>
      </PositionPMS>
   </xsl:template><!-- End of template b:FXSwapOpening -->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\PositionsForex.xml" htmlbaseurl="" outputurl="..\..\..\PositionsFXSwap_msg-4Custo.xml" processortype="jaxp" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
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