<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:a="http://www.odcgroup.com/Request" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/DXOrderReturn" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXOrderReturn" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXOrderReturn" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderReturn" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiDXOrderReturn">
      <xsl:apply-templates select="c:CurrentEvent/b:DXOrderReturn"/>
   </xsl:template>
   <xsl:template match="batch:BatchDXOrderReturn">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDXOrderReturn" name="BatchDXOrderReturn">
         <xsl:apply-templates select="b:DXOrderReturn"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiDXOrderReturn">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderReturn" name="BatchMultiDXOrderReturn">
         <xsl:apply-templates select="c:MultiDXOrderReturn"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:DXOrderReturn">
      <Event>
         <xsl:attribute name="mode">UPDATE</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('eventStatus',b:CashAccount/b:id)"/>
            <xsl:value-of select="b:serviceResponse/*/b:transactionId"/>
         </xsl:attribute>
         <DataGroup>
            <EventStatus>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('DXOrderUpdateRejected.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="identifier"/>
               <xsl:call-template name="requestStatus"/>
               <xsl:call-template name="errorReason"/>
               <xsl:call-template name="errorInfo"/>
               <xsl:call-template name="userDefinedField_Event"/>
               <xsl:call-template name="mbFields_Event"/>
            </EventStatus>
            <UpdateStatus>
               <xsl:call-template name="code"/>
               <xsl:call-template name="status"/>
               <xsl:call-template name="userDefinedField_Update"/>
               <xsl:call-template name="mbFields_Update"/>
            </UpdateStatus>
         </DataGroup>
      </Event>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\DXorderUpdateRejected\DXOrderUpdateRejectedFiter.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\DXorderUpdateRejected\DXOrderUpdateRejectedGWP.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->