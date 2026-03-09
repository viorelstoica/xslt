<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts"
                xmlns:b="http://www.temenos.com/T24/event/TTI/SyDci"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <infra:code>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_MM')"/>
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'MM') "/>
            </xsl:otherwise>
          </xsl:choose>           
      </infra:code>      
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_MM')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,'MM')"/>
            </xsl:otherwise>
         </xsl:choose>        
      </infra:shortName>
   </xsl:template>
   <xsl:template name="longName">
      <infra:longName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_MM')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,'MM')"/>
            </xsl:otherwise>
         </xsl:choose>  
      </infra:longName>
   </xsl:template>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="genericFlag">
      <genericFlag>
         <xsl:value-of select=" '0' "/>
      </genericFlag>
   </xsl:template>
   <xsl:template name="accrualRule">
      <accrualRule>
         <xsl:choose>
            <xsl:when test="b:dayBasis != ' ' and contains('A A1 A2 A3',b:dayBasis)">24</xsl:when>
            <xsl:when test="b:dayBasis = 'B'">31</xsl:when>
            <xsl:when test="b:dayBasis != ' ' and contains('C C1',b:dayBasis)">19</xsl:when>
            <xsl:when test="b:dayBasis = 'C2'">20</xsl:when>
            <xsl:when test="b:dayBasis = 'D'">13</xsl:when>
            <xsl:when test="b:dayBasis = 'E'">29</xsl:when>
            <xsl:when test="b:dayBasis = 'E1'">30</xsl:when>
            <xsl:when test="b:dayBasis != ' ' and contains('F F1 F2',b:dayBasis)">26</xsl:when>
            <xsl:when test="b:dayBasis != ' ' and contains('G S W W1',b:dayBasis)">0</xsl:when>
         </xsl:choose>
      </accrualRule>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="beginDate">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>
   </xsl:template>
   <xsl:template name="category">
      <category>10</category>
   </xsl:template>   
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="endDate">
      <endDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </endDate>
   </xsl:template>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="convertInterest"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="fixingCurrency"/>
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="b:interestRate"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="knockInDate"/>
   <xsl:template name="knockOutDate"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select=" '1' "/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:tradeCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subNature"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:if test="b:alternateCcy2!='' or b:alternateCcy2">
               <xsl:value-of select="'SY_TRIPLE_CURRENCY_INVESTMENT'"/>
            </xsl:if>
            <xsl:if test="b:alternateCcy2='' or not(b:alternateCcy2)">
               <xsl:value-of select="'SY_DUAL_CURRENCY_INVESTMENT'"/>
            </xsl:if>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valuationRule"/>
   <xsl:template name="underlying"/>
   <xsl:template name="usageNature"/>
   <xsl:template name="riskLevel"/>
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