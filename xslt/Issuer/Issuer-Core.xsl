<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/Issuer"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:choose>
            <xsl:when test="$ISSUER_PREFIX != ''">
               <xsl:value-of select="concat($ISSUER_PREFIX,b:id)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:id"/>
            </xsl:otherwise>
         </xsl:choose>
      </code>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:descriptionList/b:description[1]"/>
      </shortName>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="b:descriptionList/b:description[1]"/>
      </longName>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="clientRole">
      <clientRole>0</clientRole>
   </xsl:template>
   <xsl:template name="issuerRole">
      <issuerRole>1</issuerRole>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="beginDate"/>
   <xsl:template name="businessEntityComposition"/>
   <xsl:template name="currency"/>
   <xsl:template name="custodianRole"/>
   <xsl:template name="emailAddress"/>
   <xsl:template name="faxNumber"/>
   <xsl:template name="intermediaryRole"/>
   <xsl:template name="islamicCompliance"/>
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
   <xsl:template name="classification"/>
   <xsl:template name="externalBank"/>
   <xsl:template name="dataSecuProf"/>
</xsl:stylesheet>