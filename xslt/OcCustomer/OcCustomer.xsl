<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OcCustomer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOcCustomer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOcCustomer" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOcCustomer"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiOcCustomer">
		<xsl:apply-templates select="c:CurrentEvent/b:OcCustomer"/>
	</xsl:template>
	<xsl:template match="batch:BatchOcCustomer">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchOcCustomer" name="BatchOcCustomer">
			<xsl:apply-templates select="b:OcCustomer"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiOcCustomer">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiOcCustomer" name="BatchMultiOcCustomer">
			<xsl:apply-templates select="c:MultiOcCustomer"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:OcCustomer"/>
	<!-- Filter out this flow since this is only  business entity specific -->
	<!--  <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('OcCustomer',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <ThirdParty>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('OcCustomer.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
		  <xsl:call-template name="notepad-custo"/>
               <xsl:call-template name="notepad"/>
		  <xsl:call-template name="userDefinedField-custo"/>
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
   </xsl:template>-->
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