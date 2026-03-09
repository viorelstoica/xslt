<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDci" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyDci" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyDci" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyDci" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSyDci">
      <xsl:apply-templates select="c:CurrentEvent/b:SyDci"/>
   </xsl:template>
   <xsl:template match="batch:BatchSyDci">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSyDci" name="BatchSyDci">
         <xsl:apply-templates select="b:SyDci"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSyDci">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSyDci" name="BatchMultiSyDci">
         <xsl:apply-templates select="c:MultiSyDci"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SyDci">
      <StructuredProducts>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentSPDCI',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <DualCurrencyInvestment>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentSPDCI.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code"/>
               <xsl:call-template name="synonym"/>
               <xsl:call-template name="shortName"/>
               <xsl:call-template name="longName"/>
               <xsl:call-template name="multilingualLongName"/>
               <xsl:call-template name="notepad"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
               <xsl:call-template name="accrualRule"/>
               <xsl:call-template name="accruedInterestCalculation"/>
               <xsl:call-template name="accruedInterestRoundingRule"/>
               <xsl:call-template name="accruedInterestRoundingUnit"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="beginDate"/>
			   <xsl:call-template name="category"/>
               <xsl:call-template name="commonReference"/>
               <xsl:call-template name="complexityLevel"/>
               <xsl:call-template name="convertInterest"/>              
               <xsl:call-template name="endDate"/>
               <xsl:call-template name="euroConversionDate"/>
               <xsl:call-template name="euroConversionRule"/>
               <xsl:call-template name="euroNewInstrument"/>
               <xsl:call-template name="fixingCurrency"/>               
               <xsl:call-template name="genericFlag"/>
               <xsl:call-template name="interestRate"/>
               <xsl:call-template name="islamicCompliance"/>
			   <xsl:call-template name="knockInDate"/>
			   <xsl:call-template name="knockOutDate"/>
               <xsl:call-template name="mainBusinessEntity"/>
			   <xsl:call-template name="marketDirectiveCategory"/>
               <xsl:call-template name="priceCalculationRule"/>
               <xsl:call-template name="referenceCurrency"/>
               <xsl:call-template name="riskCountry"/>
               <xsl:call-template name="riskNature"/>
               <xsl:call-template name="subNature"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="taxCountry"/>
               <xsl:call-template name="tradable"/>
               <xsl:call-template name="type"/>
			   <xsl:call-template name="underlying"/>
			   <xsl:call-template name="usageNature"/>
               <xsl:call-template name="valuationRule"/>
            </DualCurrencyInvestment>
            <xsl:call-template name="price"/>               
            <Composition>
			   <xsl:call-template name="basketBarrier_MM"/>
			   <xsl:call-template name="basketBarrierPercent_MM"/>
			   <xsl:call-template name="basketExcercicePrice_MM"/>
			   <xsl:call-template name="basketExcercicePricePercent_MM"/>
			   <xsl:call-template name="basketInitialFixingPrice_MM"/>
			   <xsl:call-template name="basketWeight_MM"/>
               <xsl:call-template name="cheapest_MM"/>
               <xsl:call-template name="compositeInstrument_MM"/>
               <xsl:call-template name="conversionFactor_MM"/>
               <xsl:call-template name="conversionRatio_MM"/>
               <xsl:call-template name="divisor_MM"/>
               <xsl:call-template name="endDate_MM"/>
               <xsl:call-template name="instrument_MM"/>
               <xsl:call-template name="rank_MM"/>
               <xsl:call-template name="validityDate_MM"/>
               <xsl:call-template name="value_MM"/>
			   <xsl:call-template name="mbFields_MM"/>
            </Composition>
            <Composition>
			   <xsl:call-template name="basketBarrier_FX"/>
			   <xsl:call-template name="basketBarrierPercent_FX"/>
			   <xsl:call-template name="basketExcercicePrice_FX"/>
			   <xsl:call-template name="basketExcercicePricePercent_FX"/>
			   <xsl:call-template name="basketInitialFixingPrice_FX"/>
			   <xsl:call-template name="basketWeight_FX"/>
               <xsl:call-template name="cheapest_FX"/>
               <xsl:call-template name="compositeInstrument_FX"/>
               <xsl:call-template name="conversionFactor_FX"/>
               <xsl:call-template name="conversionRatio_FX"/>
               <xsl:call-template name="divisor_FX"/>
               <xsl:call-template name="endDate_FX"/>
               <xsl:call-template name="instrument_FX"/>
               <xsl:call-template name="rank_FX"/>
               <xsl:call-template name="validityDate_FX"/>
               <xsl:call-template name="value_FX"/> 
			   <xsl:call-template name="mbFields_FX"/>             
            </Composition>
            <xsl:if test="b:alternateCcy2 and b:alternateCcy2 !=''">
				<Composition>
				   <xsl:call-template name="basketBarrier_FX2"/>
				   <xsl:call-template name="basketBarrierPercent_FX2"/>
			       <xsl:call-template name="basketExcercicePrice_FX2"/>
			       <xsl:call-template name="basketExcercicePricePercent_FX2"/>
			       <xsl:call-template name="basketInitialFixingPrice_FX2"/>
			       <xsl:call-template name="basketWeight_FX2"/>
	               <xsl:call-template name="cheapest_FX2"/>
	               <xsl:call-template name="compositeInstrument_FX2"/>
	               <xsl:call-template name="conversionFactor_FX2"/>
	               <xsl:call-template name="conversionRatio_FX2"/>
	               <xsl:call-template name="divisor_FX2"/>
	               <xsl:call-template name="endDate_FX2"/>
	               <xsl:call-template name="instrument_FX2"/>
	               <xsl:call-template name="rank_FX2"/>
	               <xsl:call-template name="validityDate_FX2"/>
	               <xsl:call-template name="value_FX2"/> 
				   <xsl:call-template name="mbFields_FX2"/>             
	            </Composition>
	         </xsl:if>
         </DataGroup>
      </StructuredProducts>
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