<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSyContractMaster" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSyContractMaster" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSyContractMaster" xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSyContractMaster" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentSyContractMaster">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentSyContractMaster"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentSyContractMaster">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSyContractMaster" name="BatchFinancialInstrumentSyContractMaster">
         <xsl:apply-templates select="b:FinancialInstrumentSyContractMaster"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentSyContractMaster">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSyContractMaster" name="BatchMultiFinancialInstrumentSyContractMaster">
         <xsl:apply-templates select="c:MultiFinancialInstrumentSyContractMaster"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentSyContractMaster">
      <StructuredProducts>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentSyMasterAccuDecu',translate(translate(b:id,'/',''),':',''))"/>
         </xsl:attribute>
         <DataGroup>
            <AccuDecu>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentSyMasterAccuDecu.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
               <xsl:call-template name="beginDate"/>
			   <xsl:call-template name="category"/>
               <xsl:call-template name="commonReference"/>
			   <xsl:call-template name="complexityLevel"/>
               <xsl:call-template name="compoundingFrequency"/>
               <xsl:call-template name="compoundingFrequencyUnit"/>
               <xsl:call-template name="endDate"/>
               <xsl:call-template name="euroConversionDate"/>
               <xsl:call-template name="euroConversionRule"/>
               <xsl:call-template name="euroNewInstrument"/>
			   <xsl:call-template name="fixingDate"/>
			   <xsl:call-template name="genericFlag"/>
			   <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="issuer"/>
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
			   <xsl:call-template name="dxContractCode"/>
            </AccuDecu>
         </DataGroup>
      </StructuredProducts>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumenSPAccuDecu" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumenSPAccuDecu\FinancialInstrumenSPAccuDecu.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumenSPAccuDecu\FinancialInstrumenSPAccuDecuGWP.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
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