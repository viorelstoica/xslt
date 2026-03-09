<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AAProductSubType" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAAProductSubType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAAProductSubType" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAAProductSubType" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiAAProductSubType">
      <xsl:apply-templates select="c:CurrentEvent/b:AAProductSubType"/>
   </xsl:template>
   <xsl:template match="batch:BatchAAProductSubType">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAAProductSubType" name="BatchAAProductSubType">
         <xsl:apply-templates select="b:AAProductSubType"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiAAProductSubType">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAAProductSubType" name="BatchMultiAAProductSubType">
         <xsl:apply-templates select="c:MultiAAProductSubType"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:AAProductSubType">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('AAProductSubType',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Type>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('AAProductSubType.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <instrumentSubType>
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
                  <xsl:call-template name="parentType"/>
                  <xsl:call-template name="parentTypeAttribute"/>
               </instrumentSubType>
            </Type>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->