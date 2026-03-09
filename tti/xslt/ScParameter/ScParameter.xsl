<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScParameter" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScParameter" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScParameter" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScParameter" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiScParameter">
      <xsl:apply-templates select="c:CurrentEvent/b:ScParameter"/>
   </xsl:template>
   <xsl:template match="batch:BatchScParameter">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchScParameter" name="BatchScParameter">
         <xsl:apply-templates select="b:ScParameter"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiScParameter">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiScParameter" name="BatchMultiScParameter">
         <xsl:apply-templates select="c:MultiScParameter"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:ScParameter">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('ScParameter',b:id)"/>
         </xsl:attribute>
         <DataGroup>
		 <xsl:for-each select="b:altUserIndexList/b:altUserIndex">
            <BusinessEntityCodifCompo>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('ScParameter.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="codification"/>
               <xsl:call-template name="businessEntity"/>
			   <xsl:call-template name="entity"/>
               <xsl:call-template name="rank"/>
			   <xsl:call-template name="synonymEntity"/>
               <xsl:call-template name="type"/>
            </BusinessEntityCodifCompo>
		</xsl:for-each>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="StockExchange" userelativepaths="no" externalpreview="no" url="file:///d:/SVN/3.1/trunk/TestFiles/StockExchange/StockExchange.xml" htmlbaseurl=""
		          outputurl="file:///d:/SVN/3.1/trunk/TestFiles/StockExchange/StockExchangeCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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