<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/RatePrice" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchRatePrice" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiRatePrice" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiRatePrice" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiRatePrice">
      <xsl:apply-templates select="c:CurrentEvent/b:RatePrice"/>
   </xsl:template>
   <xsl:template match="batch:BatchRatePrice">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchRatePrice" name="BatchRatePrice">
         <xsl:apply-templates select="b:RatePrice"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiRatePrice">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiRatePrice" name="BatchMultiRatePrice">
         <xsl:apply-templates select="c:MultiRatePrice"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:RatePrice">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="'ratePrice'"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:for-each select="b:restPeriodGroup/b:amtSubGroup">
               <Price>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('RatePrice.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_ask"/>
                  <xsl:call-template name="instrument_ask"/>
                  <xsl:call-template name="provider_ask"/>
                  <xsl:call-template name="quotationDate_ask"/>
                  <xsl:call-template name="stockExchange_ask"/>
                  <xsl:call-template name="value_ask"/>
                  <xsl:call-template name="valueType_ask"/>
                  <xsl:call-template name="valueTermType_ask"/>
                  <xsl:call-template name="priceCalculationRule_ask"/>
                  <xsl:call-template name="mbFields_ask"/>
               </Price>
            </xsl:for-each>
            <xsl:for-each select="b:restPeriodGroup[*]/b:amtSubGroup[not(b:amt)]">
               <Price>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('RatePrice.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_bid"/>
                  <xsl:call-template name="instrument_bid"/>
                  <xsl:call-template name="provider_bid"/>
                  <xsl:call-template name="quotationDate_bid"/>
                  <xsl:call-template name="stockExchange_bid"/>
                  <xsl:call-template name="value_bid"/>
                  <xsl:call-template name="valueType_bid"/>
                  <xsl:call-template name="valueTermType_bid"/>
                  <xsl:call-template name="priceCalculationRule_bid"/>
                  <xsl:call-template name="mbFields_bid"/>
               </Price>
            </xsl:for-each>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="FinancialInstrumentRate" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentRate\FinancialInstrumentRate.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentRate\FinancialInstrumentGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="yes" name="RatePrice" userelativepaths="yes" externalpreview="no" url="..\..\AUTO_TEST\Online\RatePrice\RatePrice_msg-1Filter.xml" htmlbaseurl="" outputurl="..\..\AUTO_TEST\Online\RatePrice\RatePrice_msg-1FilterCusto.xml"
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