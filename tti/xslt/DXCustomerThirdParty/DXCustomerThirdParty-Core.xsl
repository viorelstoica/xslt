<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXCustomer"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXCustomer"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:choose>
            <xsl:when test="CUSTOMER_PREFIX != ''">
               <xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:id"/>
            </xsl:otherwise>
         </xsl:choose>
      </code>
   </xsl:template>
   <xsl:template name="intermediaryRole">
      <intermediaryRole>
         <xsl:choose>
            <xsl:when test="(b:dxCustomerType = 'BROKER') and (b:exchMemberGroup/b:exchMemberList/b:exchMember = 'TRADING' or b:exchMemberGroup/b:exchMemberList/b:exchMember = 'BOTH')">
               <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="not(b:customerTypeList/b:customerType = '') and (b:customerTypeList/b:customerType = 'BROKER' or b:customerTypeList/b:customerType = 'COUNTERPARTY')">
                     <xsl:value-of select="'1'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'0'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </intermediaryRole>
   </xsl:template>
   <xsl:template name="custodianRole">
      <custodianRole>
         <xsl:choose>
            <xsl:when test="(b:dxCustomerType = 'BROKER') and (b:exchMemberGroup/b:exchMemberList/b:exchMember = 'CLEARING' or b:exchMemberGroup/b:exchMemberList/b:exchMember = 'BOTH')">
               <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="not(b:customerTypeList/b:customerType = '') and (b:customerTypeList/b:customerType = 'DEPOSITORY')">
                     <xsl:value-of select="'1'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'0'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </custodianRole>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName"/>
   <xsl:template name="longName"/>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="beginDate"/>
   <xsl:template name="businessEntityComposition"/>
   <xsl:template name="currency"/>
   <xsl:template name="clientRole"/>
   <xsl:template name="classification"/>
   <xsl:template name="externalBank"/>
   <xsl:template name="emailAddress"/>
   <xsl:template name="faxNumber"/>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="issuerRole"/>
   <xsl:template name="language"/>
   <xsl:template name="manager"/>
   <xsl:template name="phoneNumber"/>
   <xsl:template name="rating"/>
   <xsl:template name="residenceCountry"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="sector"/>
   <xsl:template name="taxationCountry"/>
   <xsl:template name="thirdPartyGroup"/>
   <xsl:template name="type"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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