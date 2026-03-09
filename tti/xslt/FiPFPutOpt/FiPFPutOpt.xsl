<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyFxForwards" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyFxForwards" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyFxForwards" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyFxForwards" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSyFxForwards">
      <xsl:apply-templates select="c:CurrentEvent/b:SyFxForwards"/>
   </xsl:template>
   <xsl:template match="batch:BatchSyFxForwards">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSyFxForwards" name="BatchSyFxForwards">
         <xsl:apply-templates select="b:SyFxForwards"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSyFxForwards">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSyFxForwards" name="BatchMultiSyFxForwards">
         <xsl:apply-templates select="c:MultiSyFxForwards"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SyFxForwards">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FiPFPutOpt',translate(translate(b:id,'/',''),':',''))"/>
         </xsl:attribute>
         <DataGroup>
            <Option>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FiPFPutOpt.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
               <xsl:call-template name="sector"/>
               <xsl:call-template name="stockExchange"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="taxCountry"/>
               <xsl:call-template name="tickSize"/>
               <xsl:call-template name="tradable"/>
               <xsl:call-template name="type"/>
               <xsl:call-template name="valuationRule"/>
			   <xsl:call-template name="barrier"/>
			   <xsl:call-template name="barrierNature"/>
               <xsl:call-template name="beginDate"/>
               <xsl:call-template name="callPutIndicator"/>
               <xsl:call-template name="cashSettlement"/>
               <xsl:call-template name="category"/>                              
               <xsl:call-template name="commonReference"/>
               <xsl:call-template name="complexity"/> 
               <xsl:call-template name="complexityLevel"/>
               <xsl:call-template name="contractMaster"/>
               <xsl:call-template name="contractSize"/>
			   <xsl:call-template name="desc"/>
			   <xsl:call-template name="eventType"/>
               <xsl:call-template name="expirationDate"/>
               <xsl:call-template name="exerciseCurrency"/>
               <xsl:call-template name="exerciseType"/>
               <xsl:call-template name="faceValue"/>
               <xsl:call-template name="fixingDate"/>          
               <xsl:call-template name="instrumentClass"/>
			   <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="issuer"/>
			   <xsl:call-template name="knockInDate"/>
			   <xsl:call-template name="knockOutDate"/>
               <xsl:call-template name="lastTradeDate"/>
			   <xsl:call-template name="lowerBarrierP"/>
			   <xsl:call-template name="marketDirectiveCategory"/>
               <xsl:call-template name="paymentFrequency"/>
               <xsl:call-template name="paymentFrequencyUnit"/> 			   
               <xsl:call-template name="parentInstrument"/>
			   <xsl:call-template name="riskLevel"/>
               <xsl:call-template name="subNature"/>
               <xsl:call-template name="strikePrice"/>
               <xsl:call-template name="underlying"/>
               <xsl:call-template name="underlyingQuantity"/>
			   <xsl:call-template name="upperBarrier"/>
			   <xsl:call-template name="upperBarrierNature"/>
			   <xsl:call-template name="upperBarrierP"/>
			   <xsl:call-template name="usageNature"/>
               <xsl:if test="b:sPutCcy!=''">
			   <termEvent>
				   <xsl:call-template name="barrier_termEvent"/>
				   <xsl:call-template name="barrierNature_termEvent"/>
				   <xsl:call-template name="beginDate_termEvent"/>
				   <xsl:call-template name="callPutIndicator_termEvent"/>
				   <xsl:call-template name="cashSettlement_termEvent"/>
				   <xsl:call-template name="code_termEvent"/>
				   <xsl:call-template name="currency_termEvent"/>
				   <xsl:call-template name="endDate_termEvent"/>
				   <xsl:call-template name="exercisePrice_termEvent"/>
				   <xsl:call-template name="exerciseType_termEvent"/>
				   <xsl:call-template name="lowerBarrierP_termEvent"/>
				   <xsl:call-template name="payOffNature_termEvent"/>
				   <xsl:call-template name="totalQuantity_termEvent"/>
				   <xsl:call-template name="underlyingInstrument_termEvent"/>
				   <xsl:call-template name="underlyingQuantity_termEvent"/>
				   <xsl:call-template name="upperBarrier_termEvent"/>
				   <xsl:call-template name="upperBarrierNature_termEvent"/>
				   <xsl:call-template name="upperBarrierP_termEvent"/>
				   <xsl:call-template name="validityDate_termEvent"/>
				   <xsl:call-template name="mbFields_termEvent"/>
			   </termEvent>
			   </xsl:if>
			   <xsl:call-template name="yieldCurve"/>
            </Option>
         </DataGroup>
		 <xsl:for-each select="b:sFixingDateGroup">
				<DataGroup>
					<Event>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FiPFPutOpt.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<corporateAction>
							<xsl:call-template name="ExchangeEvent_cashSettlement"/>
							<xsl:call-template name="ExchangeEvent_code"/>
							<xsl:call-template name="ExchangeEvent_currency"/>
							<xsl:call-template name="ExchangeEvent_endDate"/>
							<xsl:call-template name="ExchangeEvent_endValidity"/>
							<xsl:call-template name="ExchangeEvent_eventPriority"/>
							<xsl:call-template name="ExchangeEvent_exchangeRate"/>
							<xsl:call-template name="ExchangeEvent_exDate"/>
							<xsl:call-template name="ExchangeEvent_instrument"/>
							<xsl:call-template name="ExchangeEvent_nature"/>
							<xsl:call-template name="ExchangeEvent_newInstrument"/>
							<xsl:call-template name="ExchangeEvent_newRatio"/>	
							<xsl:call-template name="ExchangeEvent_oddLotCompensation"/>
							<xsl:call-template name="ExchangeEvent_oldRatio"/>
							<xsl:call-template name="ExchangeEvent_price"/>
							<xsl:call-template name="ExchangeEvent_replaceOld"/>
							<xsl:call-template name="ExchangeEvent_validityDate"/>
							<xsl:call-template name="ExchangeEvent_mbFields"/>
						</corporateAction>
					</Event>
				</DataGroup>
			</xsl:for-each>
			<xsl:for-each select="b:sFixingDateGroup">
			<xsl:if test="b:sFixedStatus = 'FIXED'">
			<DataGroup>
				<ChronologicalData>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FiPFPutOpt.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->