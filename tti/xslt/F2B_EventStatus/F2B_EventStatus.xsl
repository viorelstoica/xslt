<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:a="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/OFSML/150" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="b:T24">
      <Event>
         <xsl:attribute name="mode">UPDATE</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('eventStatus',b:CashAccount/b:id)"/>
            <xsl:value-of select="b:serviceResponse/*/b:transactionId"/>
         </xsl:attribute>
         <DataGroup>
            <EventStatus>
               <xsl:call-template name="identifier"/>
               <xsl:call-template name="requestStatus"/>
               <xsl:call-template name="errorReason"/>
               <xsl:call-template name="errorInfo"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
            </EventStatus>
         </DataGroup>
      </Event>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\TTI_1.5\TestFiles\F2B_EventStatus\F2B_EventStatusFilter.xml" htmlbaseurl=""
		          outputurl="..\..\..\TTI_1.5\TestFiles\F2B_EventStatus\F2B_EventStatusFilterGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->