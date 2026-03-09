<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDeposits"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="concat(b:id,b:finMatDate,b:currency)"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="concat(b:id,b:finMatDate,b:currency)"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="accrualRule">
      <accrualRule>
         <xsl:choose>
            <xsl:when test="b:interestBasis = 'A'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'A1'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'A2'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'A4'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'B'">
               <xsl:value-of select="'31'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'C'">
               <xsl:value-of select="'19'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'C2'">
               <xsl:value-of select="'20'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'D'">
               <xsl:value-of select="'13'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'E'">
               <xsl:value-of select="'29'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'E1'">
               <xsl:value-of select="'30'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'F'">
               <xsl:value-of select="'26'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'F1'">
               <xsl:value-of select="'26'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'F2'">
               <xsl:value-of select="'26'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'H'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'W'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'W1'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:when test="b:interestBasis = 'S'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:otherwise/>
         </xsl:choose>
      </accrualRule>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation">
      <accruedInterestCalculation>
         <xsl:value-of select="'1'"/>
      </accruedInterestCalculation>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:if test="b:status = 'CUR'">
            <xsl:value-of select="'1'"/>
         </xsl:if>
      </active>
   </xsl:template>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:currency"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="noticeDay"/>
   <xsl:template name="closingDate">
      <xsl:if test="string-length(b:finMatDate) &gt;= 8">
         <closingDate>
            <xsl:choose>
               <xsl:when test="string-length(b:finMatDate) = 8">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:finMatDate"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:finMatDate"/>
               </xsl:otherwise>
            </xsl:choose>
         </closingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="b:interestRateList/b:interestRate"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="openingDate">
      <openingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </openingDate>
   </xsl:template>
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
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="b:category"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="provider"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="issuer"/>
   <xsl:template name="nextPayDay"/>
   <xsl:template name="paymentFrequency"/>
   <xsl:template name="paymentFrequencyDay"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="portfolio"/>
   <xsl:template name="subNature"/>
   <xsl:template name="tenorFrequency"/>
   <xsl:template name="tenorFrequencyUnit"/>
   <xsl:template name="usageNature"/>
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
