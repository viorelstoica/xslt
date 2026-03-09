<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentAADepositsInterestRateIL" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentAADepositsInterestRateIL" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentAADepositsInterestRateIL" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentAADepositsInterestRateIL" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:param name="list_auth" select="' CURRENT AUTH-FWD '"/><!-- FILTER -->
   <xsl:template match="c:MultiFinancialInstrumentAADepositsInterestRateIL">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentAADepositsInterestRateIL"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentAADepositsInterestRateIL">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentAADepositsInterestRateIL" name="BatchFinancialInstrumentAADepositsInterestRateIL">
         <xsl:apply-templates select="b:FinancialInstrumentAADepositsInterestRateIL"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentAADepositsInterestRateIL">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentAADepositsInterestRateIL" name="BatchMultiFinancialInstrumentAADepositsInterestRateIL">
         <xsl:apply-templates select="c:MultiFinancialInstrumentAADepositsInterestRateIL"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL"><!-- END FILTER -->
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentAADepositsInterestRateIL',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Event>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentAADepositsInterestRateIL.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <interestSchedule>
                  <xsl:call-template name="endDate"/>
                  <xsl:call-template name="interestRate"/>
                  <xsl:call-template name="scheduledDate"/>
                  <xsl:call-template name="validityDate"/>
                  <xsl:call-template name="instrument"/>
               </interestSchedule>
            </Event>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentAADepositsInterestRateIL\FinancialInstrumentAADepositsInterestRateIL.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentAADepositsInterestRateIL\FinancialInstrumentAADepositsInterestRateILCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="schemaCache" value="||"/>
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