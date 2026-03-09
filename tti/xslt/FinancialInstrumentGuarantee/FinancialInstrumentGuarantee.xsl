<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentGuarantee" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentGuarantee" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentGuarantee" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentGuarantee" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentGuarantee">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentGuarantee"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentGuarantee">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentGuarantee" name="BatchFinancialInstrumentGuarantee">
         <xsl:apply-templates select="b:FinancialInstrumentGuarantee"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentGuarantee">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentGuarantee" name="BatchMultiFinancialInstrumentGuarantee">
         <xsl:apply-templates select="c:MultiFinancialInstrumentGuarantee"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentGuarantee">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentGuarantee',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Other>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentGuarantee.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
               <xsl:call-template name="accrualRule"/>
               <xsl:call-template name="accruedInterestRoundingRule"/>
               <xsl:call-template name="accruedInterestRoundingUnit"/>
               <xsl:call-template name="accruedInterestUnitaryRounding"/>
               <xsl:call-template name="accruedInterestCalculation"/>
               <xsl:call-template name="capitalGainTax"/>
			   <xsl:call-template name="complexity"/>
			   <xsl:call-template name="complexityLevel"/>
               <xsl:call-template name="contractSize"/>
               <xsl:call-template name="couponFrequencyNumber"/>
               <xsl:call-template name="couponFrequencyUnit"/>
               <xsl:call-template name="effectiveMaturityDate"/>
               <xsl:call-template name="eomConvention"/>
               <xsl:call-template name="faceValue"/>
               <xsl:call-template name="firstCouponDate"/>
               <xsl:call-template name="firstExDate"/>
               <xsl:call-template name="interestAccrualDate"/>
               <xsl:call-template name="interestRate"/>
               <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="issuedAmount"/>
               <xsl:call-template name="issueDate"/>
               <xsl:call-template name="issuedPrice"/>
               <xsl:call-template name="issuer"/>
               <xsl:call-template name="lastCouponDate"/>
               <xsl:call-template name="lastTradeDate"/>
			   <xsl:call-template name="marketDirectiveCategory"/>
               <xsl:call-template name="maturityDate"/>
               <xsl:call-template name="maturityPrice"/>
               <xsl:call-template name="nature"/>
               <xsl:call-template name="subNature"/>
               <xsl:call-template name="witholdingTax"/>
               <xsl:call-template name="votingRights"/>
               <xsl:call-template name="composition"/>
               <xsl:call-template name="coupon"/>
               <xsl:call-template name="dividend"/>
               <xsl:call-template name="interestSchedule"/>
               <xsl:call-template name="rating"/>
			   <xsl:call-template name="riskLevel"/>
               <xsl:call-template name="yieldCurve"/>
            </Other>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="FinancialInstrumentGuarantees" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentGuarantee\FinancialInstrumentGuarantee.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentGuarantee\FinancialInstrumentGuaranteeCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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
		<scenario default="yes" name="FinancialInstrumentGuarantee.xsl" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentGuarantee\FinancialInstrumentGuarantee.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentGuarantee\FinancialInstrumentGuaranteeCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
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