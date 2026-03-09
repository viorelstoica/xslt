<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerSecurity"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:if test="b:IDcustomer != ''">
            <xsl:value-of select="concat($CUSTOMER_PREFIX,b:IDcustomer)"/>
         </xsl:if>
      </code>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="currency">
      <currency>
         <code>
            <xsl:choose>
               <xsl:when test="b:referenceCurrency">
                  <xsl:value-of select="b:referenceCurrency"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:customerCurrencyCodeList/b:customerCurrencyCode"/>
               </xsl:otherwise>
            </xsl:choose>
         </code>
      </currency>
   </xsl:template>
   <xsl:template name="clientRole">
      <xsl:choose>
         <xsl:when test="b:customerTypeList/b:customerType = 'CLIENT' or b:customerTypeList/b:customerType = 'CUSTOMER'">
            <clientRole>
               <xsl:value-of select="'1'"/>
            </clientRole>
         </xsl:when>
         <xsl:otherwise>
            <clientRole>
               <xsl:value-of select="'0'"/>
            </clientRole>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="custodianRole">
      <xsl:choose>
         <xsl:when test="(b:id != '') and (b:customerTypeList/b:customerType = 'DEPOSITORY')">
            <custodianRole>
               <xsl:value-of select="'1'"/>
            </custodianRole>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="(b:idDxCustomer != '') and (b:dxCustomerType = 'BROKER') and (b:exchMemberGroup/b:exchMemberList/b:exchMember = 'CLEARING' or b:exchMemberGroup/b:exchMemberList/b:exchMember = 'BOTH')">
                  <custodianRole>
                     <xsl:value-of select="'1'"/>
                  </custodianRole>
               </xsl:when>
               <xsl:otherwise>
                  <custodianRole>
                     <xsl:value-of select="'0'"/>
                  </custodianRole>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="intermediaryRole">
      <xsl:choose>
         <xsl:when test="(b:id != '') and (b:customerTypeList/b:customerType = 'BROKER' or b:customerTypeList/b:customerType = 'COUNTERPARTY')">
            <intermediaryRole>
               <xsl:value-of select="'1'"/>
            </intermediaryRole>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="(b:idDxCustomer != '') and (b:dxCustomerType = 'BROKER') and (b:exchMemberGroup/b:exchMemberList/b:exchMember = 'TRADING' or b:exchMemberGroup/b:exchMemberList/b:exchMember = 'BOTH')">
                  <intermediaryRole>
                     <xsl:value-of select="'1'"/>
                  </intermediaryRole>
               </xsl:when>
               <xsl:otherwise>
                  <intermediaryRole>
                     <xsl:value-of select="'0'"/>
                  </intermediaryRole>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="externalBank">
		<xsl:choose>
         <xsl:when test="b:customerTypeList/b:customerType = 'COUNTERPARTY' and not(b:customerTypeList/b:customerType = 'BROKER')">
            <externalBank>
               <xsl:value-of select="'1'"/>
            </externalBank>
         </xsl:when>
         <xsl:otherwise>
            <externalBank>
               <xsl:value-of select="'0'"/>
            </externalBank>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName"/>
   <xsl:template name="longName"/>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="beginDate"/>
   <xsl:template name="classification"/>
   <xsl:template name="dataSecuProf"/>
   <xsl:template name="businessEntityComposition"/>
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

   <!--SUB ACCOUNTS-->
		
   <xsl:template name="code_sub">
      <code>
         <xsl:value-of select="b:subAccount"/>
      </code>
   </xsl:template>
   <xsl:template name="active_sub">
      <active>1</active>
   </xsl:template>
   
   
   <xsl:template name="custodianRole_sub">
            <custodianRole>
               <xsl:value-of select="'1'"/>
            </custodianRole>
   </xsl:template>
   <xsl:template name="intermediaryRole_sub"/>
   <xsl:template name="currency_sub"/>
   <xsl:template name="externalBank_sub"/>
   <xsl:template name="clientRole_sub"/>
   <xsl:template name="synonym_sub"/>
   <xsl:template name="shortName_sub"/>
   <xsl:template name="longName_sub"/>
   <xsl:template name="multilingualLongName_sub"/>
   <xsl:template name="notepad_sub"/>
   <xsl:template name="userDefinedField_sub"/>
   <xsl:template name="mbFields_sub"/>
   <xsl:template name="beginDate_sub"/>
   <xsl:template name="classification_sub"/>
   <xsl:template name="businessEntityComposition_sub"/>
   <xsl:template name="dataSecuProf_sub"/>
   <xsl:template name="emailAddress_sub"/>
   <xsl:template name="faxNumber_sub"/>
   <xsl:template name="islamicCompliance_sub"/>
   <xsl:template name="issuerRole_sub"/>
   <xsl:template name="language_sub"/>
   <xsl:template name="manager_sub"/>
   <xsl:template name="phoneNumber_sub"/>
   <xsl:template name="rating_sub"/>
   <xsl:template name="residenceCountry_sub"/>
   <xsl:template name="riskCountry_sub"/>
   <xsl:template name="sector_sub"/>
   <xsl:template name="taxationCountry_sub"/>
   <xsl:template name="thirdPartyGroup_sub"/>
   <xsl:template name="type_sub"/>

</xsl:stylesheet>