<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerSecurity" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiCustomerSecurity">
      <xsl:apply-templates select="c:CurrentEvent/b:CustomerSecurity"/>
   </xsl:template>
   <xsl:template match="batch:BatchCustomerSecurity">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCustomerSecurity" name="BatchCustomerSecurity">
         <xsl:apply-templates select="b:CustomerSecurity"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiCustomerSecurity">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerSecurity" name="BatchMultiCustomerSecurity">
         <xsl:apply-templates select="c:MultiCustomerSecurity"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:CustomerSecurity">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('customerSecurity',b:IDcustomer)"/>
         </xsl:attribute>
         <DataGroup>
            <ThirdParty>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('CustomerSecurity.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
			   <xsl:call-template name="dataSecuProf"/>
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

		 <xsl:choose>
			<xsl:when test="b:subAccountGroup">
			<xsl:for-each select="b:subAccountGroup">
			 <DataGroup>
            <ThirdParty>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('CustomerSecurity.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code_sub"/>
               <xsl:call-template name="synonym_sub"/>
               <xsl:call-template name="shortName_sub"/>
               <xsl:call-template name="longName_sub"/>
               <xsl:call-template name="multilingualLongName_sub"/>
               <xsl:call-template name="notepad_sub"/>
               <xsl:call-template name="userDefinedField_sub"/>
               <xsl:call-template name="mbFields_sub"/>
               <xsl:call-template name="active_sub"/>
               <xsl:call-template name="beginDate_sub"/>
               <xsl:call-template name="businessEntityComposition_sub"/>
               <xsl:call-template name="currency_sub"/>
               <xsl:call-template name="clientRole_sub"/>
			   <xsl:call-template name="classification_sub"/>
               <xsl:call-template name="custodianRole_sub"/>
			   <xsl:call-template name="dataSecuProf_sub"/>
			   <xsl:call-template name="externalBank_sub"/>
               <xsl:call-template name="emailAddress_sub"/>
               <xsl:call-template name="faxNumber_sub"/>
               <xsl:call-template name="intermediaryRole_sub"/>
               <xsl:call-template name="islamicCompliance_sub"/>
               <xsl:call-template name="issuerRole_sub"/>
               <xsl:call-template name="language_sub"/>
               <xsl:call-template name="manager_sub"/>
               <xsl:call-template name="phoneNumber_sub"/>
               <xsl:call-template name="rating_sub"/>
               <xsl:call-template name="residenceCountry_sub"/>
               <xsl:call-template name="riskCountry_sub"/>
               <xsl:call-template name="sector_sub"/>
               <xsl:call-template name="taxationCountry_sub"/>
               <xsl:call-template name="thirdPartyGroup_sub"/>
               <xsl:call-template name="type_sub"/>
            </ThirdParty>
         </DataGroup>
		 </xsl:for-each>
		 </xsl:when>
		 </xsl:choose>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet>