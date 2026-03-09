<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOption" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentExoticOption" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOption" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentExoticOption" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentExoticOption">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentExoticOption"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentExoticOption">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentExoticOption" name="BatchFinancialInstrumentExoticOption">
         <xsl:apply-templates select="b:FinancialInstrumentExoticOption"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentExoticOption">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentExoticOption" name="BatchMultiFinancialInstrumentExoticOption">
         <xsl:apply-templates select="c:MultiFinancialInstrumentExoticOption"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentExoticOption">
      <StructuredProducts>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentExoticOption',translate(translate(b:id,'/',''),':',''))"/>
         </xsl:attribute>
         <DataGroup>
            <ExoticOption>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentExoticOption.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code"/>
					<xsl:call-template name="synonym-custo"/>
               <xsl:call-template name="synonym"/>
               <xsl:call-template name="shortName"/>
               <xsl:call-template name="longName"/>
               <xsl:call-template name="multilingualLongName"/>
					<xsl:call-template name="notepad-custo"/>
               <xsl:call-template name="notepad"/>
					<xsl:call-template name="userDefinedField-custo"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="euroConversionDate"/>
               <xsl:call-template name="euroConversionRule"/>
               <xsl:call-template name="euroNewInstrument"/>
               <xsl:call-template name="mainBusinessEntity"/>
               <xsl:call-template name="mainStockExchange"/>
               <xsl:call-template name="minimumQuantity"/>
               <xsl:call-template name="priceCalculationRule"/>
               <xsl:call-template name="provider"/>
               <xsl:call-template name="referenceCurrency"/>
               <xsl:call-template name="riskCountry"/>
               <xsl:call-template name="riskNature"/>
               <xsl:call-template name="roundLotQuantity"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="taxCountry"/>
               <xsl:call-template name="tickSize"/>
               <xsl:call-template name="tradable"/>
               <xsl:call-template name="type"/>
               <xsl:call-template name="valuationRule"/>
               <xsl:call-template name="beginDate"/>
			   <xsl:call-template name="category"/>
			   <xsl:call-template name="commonReference"/>
			   <xsl:call-template name="complexity"/>
			   <xsl:call-template name="complexityLevel"/>
			   <xsl:call-template name="contractMaster"/>
               <xsl:call-template name="contractSize"/>
			   <xsl:call-template name="exerciseCurrency"/>
               <xsl:call-template name="expirationDate"/>
               <xsl:call-template name="instrumentClass"/>
               <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="lastTradeDate"/>
			   <xsl:call-template name="marketDirectiveCategory"/>
               <xsl:call-template name="riskLevel"/>
               <xsl:call-template name="subNature"/>
			   <xsl:call-template name="underlying"/>
			   <xsl:call-template name="usageNature"/>
               <xsl:call-template name="yieldCurve"/>
            </ExoticOption>
            <xsl:if test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying!='' or b:deliveryCcy!=''">
			<Event>
               <termEvent>
                  <xsl:call-template name="averagingNumber"/>
                  <xsl:call-template name="barrier"/>
                  <xsl:call-template name="barrierNature"/>
                  <xsl:call-template name="beginDate1"/>
                  <xsl:call-template name="callPutIndicator"/>
                  <xsl:call-template name="cashSettlement"/>
                  <xsl:call-template name="code1"/>
                  <xsl:call-template name="currency"/>
                  <xsl:call-template name="effectiveLeverage"/>
                  <xsl:call-template name="endDate"/>
                  <xsl:call-template name="endValidityDate"/>
                  <xsl:call-template name="exercisePrice"/>
                  <xsl:call-template name="exerciseType"/>
                  <xsl:call-template name="fixDate"/>
                  <xsl:call-template name="frequency"/>
                  <xsl:call-template name="frequencyUnit"/>
                  <xsl:call-template name="gap"/>
                  <xsl:call-template name="gearing"/>
				  <xsl:call-template name="lowBarrierP_termEvent"/>
                  <xsl:call-template name="maximumValue"/>
                  <xsl:call-template name="minimumValue"/>
                  <xsl:call-template name="payOffNature"/>
                  <xsl:call-template name="premiumPaymentRule"/>
                  <xsl:call-template name="protectedDate"/>
                  <xsl:call-template name="rebateAtHit"/>
                  <xsl:call-template name="rebatePayoff"/>
                  <xsl:call-template name="scaleFactor"/>
                  <xsl:call-template name="season"/>
                  <xsl:call-template name="totalQuantity"/>
                  <xsl:call-template name="upperBarrier"/>
                  <xsl:call-template name="upperBarrierNature"/>
				  <xsl:call-template name="upperBarrierP_termEvent"/>
                  <xsl:call-template name="upperRebate"/>
                  <xsl:call-template name="upperRebateAtHit"/>
                  <xsl:call-template name="underlyingInstrument"/>
                  <xsl:call-template name="underlyingQuantity"/>
                  <xsl:call-template name="validityDate"/>
				  <xsl:call-template name="mbFields_termEvent"/>
                  <xsl:call-template name="instrument"/>
               </termEvent>
            </Event>
			</xsl:if>
         </DataGroup>
      </StructuredProducts>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentExoticOption" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentExoticOption\FinancialInstrumentExoticOption.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentExoticOption\FinancialInstrumentExoticOption_GWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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