<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSyAccuDecu">
      <xsl:apply-templates select="c:CurrentEvent/b:SyAccuDecu"/>
   </xsl:template>
   <xsl:template match="batch:BatchSyAccuDecu">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu" name="BatchSyAccuDecu">
         <xsl:apply-templates select="b:SyAccuDecu"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSyAccuDecu">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu" name="BatchMultiSyAccuDecu">
         <xsl:apply-templates select="c:MultiSyAccuDecu"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SyAccuDecu">
      <StructuredProducts>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumenSPAccuDecu',translate(translate(b:id,'/',''),':',''))"/>
         </xsl:attribute>
         <DataGroup>
            <AccuDecu>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumenSPAccuDecu.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
          <xsl:call-template name="infra:notepad-custo"/>
               <xsl:call-template name="infra:notepad"/>
          <xsl:call-template name="infra:userDefinedField-custo"/>
               <xsl:call-template name="infra:userDefinedField"/>
               <xsl:call-template name="infra:mbFields"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="beginDate"/>
			   <xsl:call-template name="category"/>
               <xsl:call-template name="commonReference"/>
               <xsl:call-template name="complexityLevel"/>
               <xsl:call-template name="compoundingFrequency"/>
               <xsl:call-template name="compoundingFrequencyUnit"/>
			   <xsl:call-template name="contractType"/>
			   <xsl:call-template name="desc"/>
               <xsl:call-template name="endDate"/>
               <xsl:call-template name="euroConversionDate"/>
               <xsl:call-template name="euroConversionRule"/>
               <xsl:call-template name="euroNewInstrument"/>
			   <xsl:call-template name="eventType"/>
               <xsl:call-template name="fixingDate"/>               
			   <xsl:call-template name="genericFlag"/>
			   <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="issuer"/>
			   <xsl:call-template name="knockInDate"/>
			   <xsl:call-template name="knockOutDate"/>
               <xsl:call-template name="mainBusinessEntity"/>
               <xsl:call-template name="mainStockExchange"/>
               <xsl:call-template name="marketDirectiveCategory"/>
               <xsl:call-template name="priceCalculationRule"/>
               <xsl:call-template name="referenceCurrency"/>
               <xsl:call-template name="riskCountry"/>
               <xsl:call-template name="riskLevel"/>
               <xsl:call-template name="riskNature"/>
               <xsl:call-template name="settlementFrequency"/>
               <xsl:call-template name="settlementFrequencyUnit"/>
               <xsl:call-template name="subNature"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="taxCountry"/>
               <xsl:call-template name="tradable"/>
               <xsl:call-template name="type"/>
			   <xsl:call-template name="underlying"/>
			   <xsl:call-template name="usageNature"/>
               <xsl:call-template name="valuationRule"/>
            </AccuDecu>
            <xsl:if test="b:securityCode!=''">
			<Event>
               <termEvent>
			      <xsl:call-template name="averagingNumber"/>
                  <xsl:call-template name="barrier"/>
                  <xsl:call-template name="barrierNature"/>
                  <xsl:call-template name="beginDate_TermEvent"/>
                  <xsl:call-template name="callPutIndicator"/>
                  <xsl:call-template name="cashSettlement"/>
				  <xsl:call-template name="code"/>
                  <xsl:call-template name="currency"/>
                  <xsl:call-template name="effectiveLeverage"/>
                  <xsl:call-template name="endDate_TermEvent"/>
				  <xsl:call-template name="endValidityDate"/>
                  <xsl:call-template name="exercisePrice"/>
                  <xsl:call-template name="exerciseType"/>
                  <xsl:call-template name="fixDate"/>
                  <xsl:call-template name="frequency"/>
                  <xsl:call-template name="frequencyUnit"/>
				  <xsl:call-template name="gap"/>
                  <xsl:call-template name="gearing"/>
                  <xsl:call-template name="lowerBarrierP"/>                  
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
				  <xsl:call-template name="totalWorkDays"/>
                  <xsl:call-template name="upperBarrier"/>
				  <xsl:call-template name="upperBarrierNature"/>
                  <xsl:call-template name="upperBarrierP"/>				  
				  <xsl:call-template name="upperRebate"/>
				  <xsl:call-template name="upperRebateAtHit"/>
                  <xsl:call-template name="underlyingInstrument"/>
                  <xsl:call-template name="underlyingQuantity"/>
                  <xsl:call-template name="validityDate"/>
				  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="instrument"/>
               </termEvent>
            </Event>
			</xsl:if>
         </DataGroup>
		 <xsl:for-each select="b:fixingDateGroup">
				<DataGroup>
					<Event>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumenSPAccuDecu.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<conversionEvent>
							<xsl:call-template name="ExchangeEvent_cashSettlement"/>
							<xsl:call-template name="ExchangeEvent_code"/>
							<xsl:call-template name="ExchangeEvent_currency"/>
							<xsl:call-template name="ExchangeEvent_endDate"/>
							<xsl:call-template name="ExchangeEvent_eventPriority"/>
							<xsl:call-template name="ExchangeEvent_exchangeRate"/>
							<xsl:call-template name="ExchangeEvent_exDate"/>
							<xsl:call-template name="ExchangeEvent_instrument"/>
							<xsl:call-template name="ExchangeEvent_nature"/>
							<xsl:call-template name="ExchangeEvent_newInstrument"/>
							<xsl:call-template name="ExchangeEvent_newRatio"/>								
							<xsl:call-template name="ExchangeEvent_oldRatio"/>
							<xsl:call-template name="ExchangeEvent_price"/>
							<xsl:call-template name="ExchangeEvent_replaceOld"/>
							<xsl:call-template name="ExchangeEvent_validityDate"/>
							<xsl:call-template name="ExchangeEvent_workingDays"/>
							<xsl:call-template name="ExchangeEvent_mbFields"/>
						</conversionEvent>
					</Event>
				</DataGroup>
			</xsl:for-each>
			<xsl:for-each select="b:fixingDateGroup">
			<xsl:if test="b:accruedUnits1 and b:accruedUnits1 != '' and b:fixedStatus = 'FIXED'">
			<DataGroup>
				<ChronologicalData>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumenSPAccuDecu.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="ChronologicalData_currency"/>
					<xsl:call-template name="ChronologicalData_dataNature"/>
					<xsl:call-template name="ChronologicalData_instrument"/>
					<xsl:call-template name="ChronologicalData_validity"/>
					<xsl:call-template name="ChronologicalData_value"/>
					<xsl:call-template name="ChronologicalData_provider"/>
					<xsl:call-template name="ChronologicalData_valueType"/>
					<xsl:call-template name="ChronologicalData_mbFields"/>
				</ChronologicalData>
			</DataGroup>
			</xsl:if>
		</xsl:for-each>
      </StructuredProducts>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumenSPAccuDecu" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumenSPAccuDecu\FinancialInstrumenSPAccuDecu.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumenSPAccuDecu\FinancialInstrumenSPAccuDecuGWP.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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