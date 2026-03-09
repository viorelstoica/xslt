<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrderCob" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrderCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrderCob" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrderCob" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFdFidOrderCob">
      <xsl:apply-templates select="c:CurrentEvent/b:FdFidOrderCob"/>
   </xsl:template>
   <xsl:template match="batch:BatchFdFidOrderCob">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFdFidOrderCob" name="BatchFdFidOrderCob">
         <xsl:apply-templates select="b:FdFidOrderCob"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFdFidOrderCob">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrderCob" name="BatchMultiFdFidOrderCob">
         <xsl:apply-templates select="c:MultiFdFidOrderCob"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FdFidOrderCob">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FiduciaryAccruedInterest',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <ChronologicalData>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FiduciaryAccruedInterest.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="currency"/>
               <xsl:call-template name="dataNature"/>
               <xsl:call-template name="instrument"/>
               <xsl:call-template name="validity"/>
               <xsl:call-template name="value"/>
               <xsl:call-template name="provider"/>
               <xsl:call-template name="valueType"/>
               <xsl:call-template name="mbFields"/>
            </ChronologicalData>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\Untitled1.xml" htmlbaseurl="" outputurl="..\..\..\FidiGWo.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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