<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSswap" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchIRSswap" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiIRSswap" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiIRSswap" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiIRSswap">
      <xsl:apply-templates select="c:CurrentEvent/b:IRSswap"/>
   </xsl:template>
   <xsl:template match="batch:BatchIRSswap">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchIRSswap" name="BatchIRSswap">
         <xsl:apply-templates select="b:IRSswap"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiIRSswap">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiIRSswap" name="BatchMultiIRSswap">
         <xsl:apply-templates select="c:MultiIRSswap"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:IRSswap">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentIRS',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <GenericIrSwap>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentIRS.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="infra:code"/>
               <xsl:call-template name="infra:synonym"/>
               <xsl:call-template name="infra:shortName"/>
               <xsl:call-template name="infra:longName"/>
               <xsl:call-template name="infra:multilingualLongName"/>
               <xsl:call-template name="infra:notepad"/>
               <xsl:call-template name="infra:userDefinedField"/>
               <xsl:call-template name="infra:mbFields"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="averagePeriodNumber"/>
               <xsl:call-template name="averagePeriodUnit"/>
               <xsl:call-template name="averaging"/>
               <xsl:call-template name="backset"/>
               <xsl:call-template name="backsetDelayPeriodNumber"/>
               <xsl:call-template name="backsetDelayPeriodUnit"/>
               <xsl:call-template name="businessDayConvention"/>
               <xsl:call-template name="capitalGainTax"/>
               <xsl:call-template name="compoundingConvention"/>
               <xsl:call-template name="compoundingFrequencyNumber"/>
               <xsl:call-template name="compoundingFrequencyUnit"/>
               <xsl:call-template name="decompoundingConvention"/>
               <xsl:call-template name="interestRateConvention"/>
               <xsl:call-template name="lengthSwapNumber"/>
               <xsl:call-template name="lengthSwapUnit"/>
               <xsl:call-template name="mainBusinessEntity"/>
               <xsl:call-template name="mainStockExchange"/>
               <xsl:call-template name="nominalExchangeRule"/>
               <xsl:call-template name="paidCurrency"/>
               <xsl:call-template name="paidLegAcrrualRule"/>
               <xsl:call-template name="paidLegCalendar"/>
               <xsl:call-template name="paidLegEomConvention"/>
               <xsl:call-template name="paidLegFloatingRate"/>
               <xsl:call-template name="paidLegInterestRate"/>
               <xsl:call-template name="paidLegPaymentFrequencyNumber"/>
               <xsl:call-template name="paidLegPaymentFrequencyUnit"/>
               <xsl:call-template name="paidLegYieldCurve"/>
               <xsl:call-template name="paymentDayCalcConvention"/>
               <xsl:call-template name="priceCalculationRule"/>
               <xsl:call-template name="provider"/>
               <xsl:call-template name="receivedLegAccrualRule"/>
               <xsl:call-template name="receivedLegAdditiveMargin"/>
               <xsl:call-template name="receivedLegCalendar"/>
               <xsl:call-template name="receivedLegCurrency"/>
               <xsl:call-template name="receivedLegEomConvention"/>
               <xsl:call-template name="receivedLegFloatingRate"/>
               <xsl:call-template name="receivedLegInterestRate"/>
               <xsl:call-template name="receivedLegPaymentFrequencyNumber"/>
               <xsl:call-template name="receivedLegPaymentFrequencyUnit"/>
               <xsl:call-template name="receivedLegYieldCurve"/>
               <xsl:call-template name="riskCountry"/>
               <xsl:call-template name="riskCurrency"/>
               <xsl:call-template name="riskNature"/>
               <xsl:call-template name="subNature"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="taxCountry"/>
               <xsl:call-template name="tradable"/>
               <xsl:call-template name="type"/>
               <xsl:call-template name="valuationRule"/>
               <xsl:call-template name="valuedays"/>
            </GenericIrSwap>
         </DataGroup><!-- End of if 'SW' -->
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentIRS\IRSswap.xml" htmlbaseurl="" outputurl="..\..\TestFiles\FinancialInstrumentIRS\TTI-FinancialInstrumentIRSfilteGWP..xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
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