<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrderCob"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation">
      <accruedInterestCalculation>
         <xsl:value-of select=" '1' "/>
      </accruedInterestCalculation>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:currencyCode"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature">
      <riskNature>
         <xsl:value-of select=" '2' "/>
      </riskNature>
   </xsl:template>
   <xsl:template name="valuationRule">
  	  <valuationRule>
	  	 <xsl:value-of select="'3'"/>
	  </valuationRule>
   </xsl:template>
   <xsl:template name="noticeDay"/>
   <xsl:template name="closingDate">
      <xsl:if test="string-length(b:reimburseDate) &gt;= 8 and b:reimburseReq = 'YES' and b:orderStatus ='LIQ' ">
         <closingDate>
            <xsl:choose>
               <xsl:when test="string-length(b:reimburseDate) = 8">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:reimburseDate"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:reimburseDate"/>
               </xsl:otherwise>
            </xsl:choose>
         </closingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="interestRate"/>
   <xsl:template name="openingDate"/>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="accruedInterestUnitaryRounding"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type"/>
   <xsl:template name="provider"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="portfolio"/>
   <xsl:template name="issuer"/>
   <xsl:template name="nextPayDay"/>
   <xsl:template name="paymentFrequency"/>
   <xsl:template name="paymentFrequencyDay"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="subNature"/>
   <xsl:template name="tenorFrequency"/>
   <xsl:template name="tenorFrequencyUnit"/>
   <xsl:template name="usageNature"/>
   <xsl:template name="infra:shortName"/>
   <xsl:template name="infra:longName"/>
   <xsl:template name="accrualRule"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="infra:code"></template>
			<template name="accrualRule"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->