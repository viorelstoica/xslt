<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentRate" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentRate" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentRate" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentRate" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentRate">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentRate"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentRate">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentRate" name="BatchFinancialInstrumentRate">
         <xsl:apply-templates select="b:FinancialInstrumentRate"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentRate">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentRate" name="BatchMultiFinancialInstrumentRate">
         <xsl:apply-templates select="c:MultiFinancialInstrumentRate"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentRate">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentRate',substring(b:refCcyDate,'1','5'))"/>
         </xsl:attribute>
		 <xsl:if test="b:rfrRate">
         <DataGroup>
               <Rate>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('FinancialInstrumentRate.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="infra:code_rfr"/>
                  <xsl:call-template name="infra:synonym_rfr"/>
                  <xsl:call-template name="infra:shortName_rfr"/>
                  <xsl:call-template name="infra:longName_rfr"/>
                  <xsl:call-template name="infra:multilingualLongName_rfr"/>
                  <xsl:call-template name="infra:notepad_rfr"/>
                  <xsl:call-template name="infra:userDefinedField_rfr"/>
                  <xsl:call-template name="infra:mbFields_rfr"/>
                  <xsl:call-template name="active_rfr"/>
                  <xsl:call-template name="euroConversionDate_rfr"/>
                  <xsl:call-template name="euroConversionRule_rfr"/>
                  <xsl:call-template name="euroNewInstrument_rfr"/>
                  <xsl:call-template name="mainBusinessEntity_rfr"/>
                  <xsl:call-template name="mainStockExchange_rfr"/>
                  <xsl:call-template name="minimumQuantity_rfr"/>
                  <xsl:call-template name="priceCalculationRule_rfr"/>
                  <xsl:call-template name="provider_rfr"/>
                  <xsl:call-template name="referenceCurrency_rfr"/>
                  <xsl:call-template name="riskCountry_rfr"/>
                  <xsl:call-template name="riskNature_rfr"/>
                  <xsl:call-template name="roundLotQuantity_rfr"/>
                  <xsl:call-template name="sector_rfr"/>
                  <xsl:call-template name="stockExchange_rfr"/>
                  <xsl:call-template name="subType_rfr"/>
                  <xsl:call-template name="taxCountry_rfr"/>
                  <xsl:call-template name="tickSize_rfr"/>
                  <xsl:call-template name="tradable_rfr"/>
                  <xsl:call-template name="type_rfr"/>
                  <xsl:call-template name="valuationRule_rfr"/>
                  <xsl:call-template name="accrualRule_rfr"/>
                  <xsl:call-template name="defaultRiskFreeRate_rfr"/>
                  <xsl:call-template name="fixingCalendar_rfr"/>
                  <xsl:call-template name="fixingRuleNumber_rfr"/>
                  <xsl:call-template name="fixingRuleUnit_rfr"/>
                  <xsl:call-template name="interestRateConvention_rfr"/>
                  <xsl:call-template name="issuer_rfr"/>
                  <xsl:call-template name="logNormalDistribution_rfr"/>
                  <xsl:call-template name="paymentFrequencyNumber_rfr"/>
                  <xsl:call-template name="paymentFrequencyUnit_rfr"/>
                  <xsl:call-template name="rateFrequencyNumber_rfr"/>
                  <xsl:call-template name="rateFrequencyUnit_rfr"/>
                  <xsl:call-template name="subNature_rfr"/>
                  <xsl:call-template name="yieldCurve_rfr"/>
                  <xsl:call-template name="rating_rfr"/>
               </Rate>
         </DataGroup>
		 </xsl:if>
		 <xsl:if test="b:restPeriodGroup and not(b:rfrRate)">
		 <DataGroup>
            <xsl:for-each select="b:restPeriodGroup">
               <Rate>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('FinancialInstrumentRate.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
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
                  <xsl:call-template name="accrualRule"/>
                  <xsl:call-template name="defaultRiskFreeRate"/>
                  <xsl:call-template name="fixingCalendar"/>
                  <xsl:call-template name="fixingRuleNumber"/>
                  <xsl:call-template name="fixingRuleUnit"/>
                  <xsl:call-template name="interestRateConvention"/>
                  <xsl:call-template name="issuer"/>
                  <xsl:call-template name="logNormalDistribution"/>
                  <xsl:call-template name="paymentFrequencyNumber"/>
                  <xsl:call-template name="paymentFrequencyUnit"/>
                  <xsl:call-template name="rateFrequencyNumber"/>
                  <xsl:call-template name="rateFrequencyUnit"/>
                  <xsl:call-template name="subNature"/>
                  <xsl:call-template name="yieldCurve"/>
                  <xsl:call-template name="rating"/>
               </Rate>
            </xsl:for-each>
         </DataGroup>
		 </xsl:if>
		 <xsl:if test="b:rfrRate">
         <DataGroup>
            <Price>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentRate.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="currency"/>
               <xsl:call-template name="instrument"/>
               <xsl:call-template name="quotationDate"/>
               <xsl:call-template name="value"/>
               <xsl:call-template name="valueType"/>
               <xsl:call-template name="valueTermType"/>
               <xsl:call-template name="priceCalculationRule"/>
            </Price>
         </DataGroup>
		 </xsl:if>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentRate" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentRate\FinancialInstrumentRate.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentRate\FinancialInstrumentCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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