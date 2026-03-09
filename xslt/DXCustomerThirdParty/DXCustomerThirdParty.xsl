<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/DXCustomer" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXCustomer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXCustomer" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXCustomer" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiDXCustomer">
      <xsl:apply-templates select="c:CurrentEvent/b:DXCustomer"/>
   </xsl:template>
   <xsl:template match="batch:BatchDXCustomer">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDXCustomer" name="BatchDXCustomer">
         <xsl:apply-templates select="b:DXCustomer"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiDXCustomer">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDXCustomer" name="BatchMultiDXCustomer">
         <xsl:apply-templates select="c:MultiDXCustomer"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:DXCustomer">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('DXCustomerThirdParty',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <ThirdParty>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('DXCustomerThirdParty.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code"/>
               <xsl:call-template name="synonym"/>
               <xsl:call-template name="shortName"/>
               <xsl:call-template name="longName"/>
               <xsl:call-template name="multilingualLongName"/>
               <xsl:call-template name="notepad"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="beginDate"/>
               <xsl:call-template name="businessEntityComposition"/>
               <xsl:call-template name="currency"/>
               <xsl:call-template name="clientRole"/>
			   <xsl:call-template name="classification"/>
               <xsl:call-template name="custodianRole"/>
			   <xsl:call-template name="externalBank"/>
               <xsl:call-template name="emailAddress"/>
               <xsl:call-template name="faxNumber"/>
               <xsl:call-template name="intermediaryRole"/>
               <xsl:call-template name="islamicCompliance"/>
               <xsl:call-template name="issuerRole"/>
               <xsl:call-template name="language"/>
               <xsl:call-template name="manager"/>
               <xsl:call-template name="phoneNumber"/>
               <xsl:call-template name="rating"/>
               <xsl:call-template name="residenceCountry"/>
               <xsl:call-template name="riskCountry"/>
               <xsl:call-template name="sector"/>
               <xsl:call-template name="taxationCountry"/>
               <xsl:call-template name="thirdPartyGroup"/>
               <xsl:call-template name="type"/>
            </ThirdParty>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="DXCustomer" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\DXCustomer\DXCustomer.xml" htmlbaseurl="" outputurl="..\..\TestFiles\DXCustomer\DXCustomerGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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