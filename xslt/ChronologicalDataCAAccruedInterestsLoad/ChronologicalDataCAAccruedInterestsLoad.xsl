<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ChronologicalDataCAAccruedInterestsLoad" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchChronologicalDataCAAccruedInterestsLoad" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiChronologicalDataCAAccruedInterestsLoad" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiChronologicalDataCAAccruedInterestsLoad" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiChronologicalDataCAAccruedInterestsLoad">
      <xsl:apply-templates select="c:CurrentEvent/b:ChronologicalDataCAAccruedInterestsLoad"/>
   </xsl:template>
   <xsl:template match="batch:BatchChronologicalDataCAAccruedInterestsLoad">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchChronologicalDataCAAccruedInterestsLoad" name="BatchChronologicalDataCAAccruedInterestsLoad">
         <xsl:apply-templates select="b:ChronologicalDataCAAccruedInterestsLoad"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiChronologicalDataCAAccruedInterestsLoad">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiChronologicalDataCAAccruedInterestsLoad" name="BatchMultiChronologicalDataCAAccruedInterestsLoad">
         <xsl:apply-templates select="c:MultiChronologicalDataCAAccruedInterestsLoad"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:ChronologicalDataCAAccruedInterestsLoad">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('ChronologicalDataCAAccruedInterestsLoad',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <ChronologicalData>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('ChronologicalDataCAAccruedInterestsLoad.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\ChronologicalDataCAAccruedInterestsLoad\ChronologicalDataCAAccruedInterestsLoad.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\ChronologicalDataCAAccruedInterestsLoad\ChronologicalDataCAAccruedInterestsLoad_Custo.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->