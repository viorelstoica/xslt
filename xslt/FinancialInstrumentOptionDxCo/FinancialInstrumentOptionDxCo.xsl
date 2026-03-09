<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentOptionDxCo" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentOptionDxCo" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentOptionDxCo" xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentOptionDxCo" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentOptionDxCo">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentOptionDxCo"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentOptionDxCo">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentOptionDxCo" name="BatchFinancialInstrumentOptionDxCo">
         <xsl:apply-templates select="b:FinancialInstrumentOptionDxCo"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentOptionDxCo">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentOptionDxCo" name="BatchMultiFinancialInstrumentOptionDxCo">
         <xsl:apply-templates select="c:MultiFinancialInstrumentOptionDxCo"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentOptionDxCo">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentOptionDxCo',b:id)"/>
         </xsl:attribute>
         <xsl:variable name="index" select="./@index"/>
         <DataGroup>
            <Option>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentOptionDxCo.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="infra:code">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="infra:synonym"/>
               <xsl:call-template name="infra:shortName">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="infra:longName">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="infra:multilingualLongName"/>
               <xsl:call-template name="infra:notepad"/>
               <xsl:call-template name="infra:userDefinedField">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="infra:mbFields"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="euroConversionDate"/>
               <xsl:call-template name="euroConversionRule"/>
               <xsl:call-template name="euroNewInstrument"/>
               <xsl:call-template name="mainBusinessEntity"/>
               <xsl:call-template name="mainStockExchange">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="minimumQuantity">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="priceCalculationRule"/>
               <xsl:call-template name="provider"/>
               <xsl:call-template name="referenceCurrency">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="riskCountry">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="riskNature"/>
               <xsl:call-template name="roundLotQuantity"/>
               <xsl:call-template name="sector"/>
               <xsl:call-template name="stockExchange"/>
               <xsl:call-template name="subType">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="taxCountry"/>
               <xsl:call-template name="tickSize">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="tradable"/>
               <xsl:call-template name="type">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="valuationRule"/>
			   <xsl:call-template name="barrier"/>
			   <xsl:call-template name="barrierNature"/>
               <xsl:call-template name="beginDate"/>
               <xsl:call-template name="callPutIndicator">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="cashSettlement">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
			   <xsl:call-template name="category"/>
               <xsl:call-template name="commonReference"/>
               <xsl:call-template name="complexity"/>
               <xsl:call-template name="complexityLevel"/>
               <xsl:call-template name="contractMaster">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="contractSize">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="expirationDate"/>
               <xsl:call-template name="exerciseCurrency">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="exerciseType">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="faceValue">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
			   <xsl:call-template name="fixingDate"/>
               <xsl:call-template name="instrumentClass"/>
               <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="issuer"/>
               <xsl:call-template name="lastTradeDate"/>
			   <xsl:call-template name="lowBarrierP"/>
               <xsl:call-template name="marketDirectiveCategory"/>
			   <xsl:call-template name="paymentFrequency"/>
			   <xsl:call-template name="paymentFrequencyUnit"/>
               <xsl:call-template name="parentInstrument"/>
			   <xsl:call-template name="riskLevel"/>
               <xsl:call-template name="subNature"/>
               <xsl:call-template name="strikePrice">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="underlying">
                  <xsl:with-param name="index" select="$index"/>
               </xsl:call-template>
               <xsl:call-template name="underlyingQuantity"/>
			   <xsl:call-template name="upperBarrier"/>
			   <xsl:call-template name="upperBarrierNature"/>
			   <xsl:call-template name="upperBarrierP"/>
			   <xsl:call-template name="usageNature"/>
               <xsl:call-template name="termEvent"/>
               <xsl:call-template name="yieldCurve"/>
            </Option>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentOptionDxCo" userelativepaths="no" externalpreview="no" url="file:///d:/SVN/3.1/trunk/TestFiles/FinancialInstrumentOptionDxCo/FinancialInstrumentOptionDxCo.xml" htmlbaseurl=""
		          outputurl="file:///d:/SVN/3.1/trunk/TestFiles/FinancialInstrumentOptionDxCo/FinancialInstrumentOptionDxCoTest.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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