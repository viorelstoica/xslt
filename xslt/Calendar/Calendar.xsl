<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Calendar" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCalendar" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCalendar" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCalendar" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiCalendar">
      <xsl:apply-templates select="c:CurrentEvent/b:Calendar"/>
   </xsl:template>
   <xsl:template match="batch:BatchCalendar">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCalendar" name="BatchCalendar">
         <xsl:apply-templates select="b:Calendar"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiCalendar">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCalendar" name="BatchMultiCalendar">
         <xsl:apply-templates select="c:MultiCalendar"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:Calendar">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('calendar',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Calendar>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('Calendar.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code"/>
               <xsl:call-template name="shortName"/>
               <xsl:call-template name="longName"/>
               <xsl:call-template name="addDaysNumber"/>
               <xsl:call-template name="businessDateRule"/>
               <xsl:call-template name="nextBusinessDateRule"/>
               <xsl:call-template name="multilingualLongName"/>
               <xsl:call-template name="calendarDate"/>
               <xsl:call-template name="calendarConvention"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
            </Calendar>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Calendar" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Calendar\Calendar.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Calendar\Calendar_Custo.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="schemaCache" value="||"/>
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