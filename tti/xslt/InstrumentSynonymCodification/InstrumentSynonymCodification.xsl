<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/InstrumentSynonymCodification" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchInstrumentSynonymCodification" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiInstrumentSynonymCodification" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiInstrumentSynonymCodification" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiInstrumentSynonymCodification">
      <xsl:apply-templates select="c:CurrentEvent/b:InstrumentSynonymCodification"/>
   </xsl:template>
   <xsl:template match="batch:BatchInstrumentSynonymCodification">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchInstrumentSynonymCodification" name="BatchInstrumentSynonymCodification">
         <xsl:apply-templates select="b:InstrumentSynonymCodification"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiInstrumentSynonymCodification">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiInstrumentSynonymCodification" name="BatchMultiInstrumentSynonymCodification">
         <xsl:apply-templates select="c:MultiInstrumentSynonymCodification"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:InstrumentSynonymCodification">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('instrumentSynonymCodification',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Codification>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('InstrumentSynonymCodification.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <synonymCodification>
                  <xsl:call-template name="code"/>
                  <xsl:call-template name="entity"/>
                  <xsl:call-template name="longName"/>
                  <xsl:call-template name="multilingualLongname"/>
                  <xsl:call-template name="shortName"/>
                  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="minimumNumberOfCharacter"/>
                  <xsl:call-template name="maximumNumberOfCharacter"/>
               </synonymCodification>
            </Codification>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="InstrumentSynonymCodification" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\InstrumentSynonymCodification\InstrumentSynonymCodification.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\InstrumentSynonymCodification\InstrumentSynonymCodificationCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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