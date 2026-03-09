<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/MDDealType" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMDDealType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMDDealType" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMDDealType" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiMDDealType">
      <xsl:apply-templates select="c:CurrentEvent/b:MDDealType"/>
   </xsl:template>
   <xsl:template match="batch:BatchMDDealType">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMDDealType" name="BatchMDDealType">
         <xsl:apply-templates select="b:MDDealType"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiMDDealType">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiMDDealType" name="BatchMultiMDDealType">
         <xsl:apply-templates select="c:MultiMDDealType"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:MDDealType">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('MDDealType',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:for-each select="b:contractTypeGroup">
               <Type>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('MDDealType.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <instrumentType>
                     <xsl:call-template name="code"/>
                     <xsl:call-template name="synonym"/>
                     <xsl:call-template name="shortName"/>
                     <xsl:call-template name="longName"/>
                     <xsl:call-template name="multilingualLongName"/>
                     <xsl:call-template name="notepad"/>
                     <xsl:call-template name="userDefinedField"/>
                     <xsl:call-template name="mbFields"/>
                     <xsl:call-template name="attribute"/>
                     <xsl:call-template name="nature"/>
                  </instrumentType>
               </Type>
            </xsl:for-each>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="MDDealType" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\MDDealType\MDDealType.xml" htmlbaseurl="" outputurl="..\..\TestFiles\MDDealType\MDDealTypeCusto.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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