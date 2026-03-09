<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentLombardWeightsDX" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentLombardWeightsDX" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentLombardWeightsDX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentLombardWeightsDX" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentLombardWeightsDX">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentLombardWeightsDX"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentLombardWeightsDX">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentLombardWeightsDX" name="BatchFinancialInstrumentLombardWeightsDX">
         <xsl:apply-templates select="b:FinancialInstrumentLombardWeightsDX"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentLombardWeightsDX">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentLombardWeightsDX" name="BatchMultiFinancialInstrumentLombardWeightsDX">
         <xsl:apply-templates select="c:MultiFinancialInstrumentLombardWeightsDX"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentLombardWeightsDX">
      <FiPMS mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentLombardWeightsDX',translate(translate(b:id,'/',''),':',''))"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:if test="(b:subMarginRateCredit and b:subMarginRateCredit != '') or (b:assetMarginRateCredit and b:assetMarginRateCredit !='') or (b:dxMarketRateCredit and b:dxMarketRateCredit != '')"><!--   Pledge Credit rate    -->
               <ChronologicalData>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('FinancialInstrumentLombardWeightsDX.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_C"/>
                  <xsl:call-template name="dataNature_C"/>
                  <xsl:call-template name="instrument_C"/>
                  <xsl:call-template name="validity_C"/>
                  <xsl:call-template name="value_C"/>
                  <xsl:call-template name="provider_C"/>
                  <xsl:call-template name="valueType_C"/>
                  <xsl:call-template name="mbFields_C"/>
               </ChronologicalData>
            </xsl:if><!--   Pledge Debit rate    -->
            <xsl:if test="(b:subMarginRateDebit and b:subMarginRateDebit != '') or (b:assetMarginRateDebit and b:assetMarginRateDebit !='') or (b:dxMarketRateDebit and b:dxMarketRateDebit != '')">
               <ChronologicalData>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('FinancialInstrumentLombardWeightsDX.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_D"/>
                  <xsl:call-template name="dataNature_D"/>
                  <xsl:call-template name="instrument_D"/>
                  <xsl:call-template name="validity_D"/>
                  <xsl:call-template name="value_D"/>
                  <xsl:call-template name="provider_D"/>
                  <xsl:call-template name="valueType_D"/>
                  <xsl:call-template name="mbFields_D"/>
               </ChronologicalData>
            </xsl:if>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentLombardWeightsDX" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentLombrdWeightDX\FinancialInstrumentLombardWeightDX.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentLombrdWeightDX\FinancialInstrumentLombardWeightDXGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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