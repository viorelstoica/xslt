<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AAProductGroup" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAAProductGroup" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAAProductGroup" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAAProductGroup" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiAAProductGroup">
      <xsl:apply-templates select="c:CurrentEvent/b:AAProductGroup"/>
   </xsl:template>
   <xsl:template match="batch:BatchAAProductGroup">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAAProductGroup" name="BatchAAProductGroup">
         <xsl:apply-templates select="b:AAProductGroup"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiAAProductGroup">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAAProductGroup" name="BatchMultiAAProductGroup">
         <xsl:apply-templates select="c:MultiAAProductGroup"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:AAProductGroup">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('AAProductGroupType',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Type>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('AAProductGroup.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <instrumentType>
                  <xsl:call-template name="code"/>
				  <xsl:call-template name="synonym"/>
                  <xsl:call-template name="shortName"/>
				  <xsl:call-template name="longName_insType"/>
                  <xsl:apply-templates select="b:descriptionList/b:description"/>
                  <xsl:call-template name="oldNewDenom"/>
				  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="attribute"/>
                  <xsl:call-template name="nature"/>
               </instrumentType>
            </Type>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\AUTO_TEST\Online\AAProductGroup\AAProductGroup_AAProductGroupTypeFilter.xml" htmlbaseurl=""
		          outputurl="..\..\AUTO_TEST\Online\AAProductGroup\AAProductGroup_AAProductGroupTypeFilterCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
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