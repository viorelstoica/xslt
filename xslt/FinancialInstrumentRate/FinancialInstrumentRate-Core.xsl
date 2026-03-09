<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentRate"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
	<!-- Rate starts -->
   <xsl:template name="infra:code_rfr">
      <infra:code>
         <xsl:value-of select="concat(substring(b:refCcyDate,'1','5'),b:restPeriod)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="active_rfr">
      <active>1</active>
   </xsl:template>
   <xsl:template name="referenceCurrency_rfr">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="substring(b:refCcyDate,'3','3')"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="rateFrequencyNumber_rfr">
      <rateFrequencyNumber>
	  	<xsl:choose>
		  	<xsl:when test="b:rfrRate != ''">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			 <xsl:otherwise>
	            <xsl:value-of select="'NULL'"/>
	          </xsl:otherwise>
		</xsl:choose>
      </rateFrequencyNumber>
   </xsl:template>
   <xsl:template name="rateFrequencyUnit_rfr">
      <rateFrequencyUnit>
         <xsl:choose>
		 	<xsl:when test="b:rfrRate != ''">
				<xsl:value-of select="'1'"/>
			</xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </rateFrequencyUnit>
   </xsl:template>
   <xsl:template name="subNature_rfr">
   <xsl:if test="b:rfrRate != ''">
   		<subNature>
			<xsl:value-of select="'32'"/>		
		</subNature>
	</xsl:if>
   </xsl:template>
   <xsl:template name="interestRateConvention_rfr">
	<xsl:if test="b:rfrRate != ''">
		<interestRateConvention>
			<xsl:value-of select="'3'"/>
		</interestRateConvention>
	</xsl:if>
   </xsl:template>
   <xsl:template name="infra:synonym_rfr"/>
   <xsl:template name="infra:shortName_rfr"/>
   <xsl:template name="infra:longName_rfr"/>
   <xsl:template name="infra:multilingualLongName_rfr"/>
   <xsl:template name="infra:notepad_rfr"/>
   <xsl:template name="infra:userDefinedField_rfr"/>
   <xsl:template name="infra:mbFields_rfr"/>
   <xsl:template name="euroConversionDate_rfr"/>
   <xsl:template name="euroConversionRule_rfr"/>
   <xsl:template name="euroNewInstrument_rfr"/>
   <xsl:template name="mainBusinessEntity_rfr"/>
   <xsl:template name="mainStockExchange_rfr"/>
   <xsl:template name="minimumQuantity_rfr"/>
   <xsl:template name="priceCalculationRule_rfr"/>
   <xsl:template name="provider_rfr"/>
   <xsl:template name="riskCountry_rfr"/>
   <xsl:template name="riskNature_rfr"/>
   <xsl:template name="roundLotQuantity_rfr"/>
   <xsl:template name="sector_rfr"/>
   <xsl:template name="stockExchange_rfr"/>
   <xsl:template name="subType_rfr"/>
   <xsl:template name="taxCountry_rfr"/>
   <xsl:template name="tickSize_rfr"/>
   <xsl:template name="tradable_rfr"/>
   <xsl:template name="type_rfr"/>
   <xsl:template name="valuationRule_rfr"/>
   <xsl:template name="accrualRule_rfr"/>
   <xsl:template name="defaultRiskFreeRate_rfr"/>
   <xsl:template name="fixingCalendar_rfr"/>
   <xsl:template name="fixingRuleNumber_rfr"/>
   <xsl:template name="fixingRuleUnit_rfr"/>
   <xsl:template name="issuer_rfr"/>
   <xsl:template name="logNormalDistribution_rfr"/>
   <xsl:template name="paymentFrequencyNumber_rfr"/>
   <xsl:template name="paymentFrequencyUnit_rfr"/>
   <xsl:template name="yieldCurve_rfr"/>
   <xsl:template name="rating_rfr"/>
   <!-- Rate ends -->
   <!--  Start restPeriodGroup -->
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="concat(substring(../b:refCcyDate,'1','5'),b:restPeriod)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="substring(../b:refCcyDate,'3','3')"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="rateFrequencyNumber">
      <rateFrequencyNumber>
	  	<xsl:choose>
			<xsl:when test="substring(b:restPeriod,string-length(b:restPeriod),1) = 'D'">
	             <xsl:value-of select="substring-before(b:restPeriod,'D')"/>
	         </xsl:when>
			 <xsl:when test="substring(b:restPeriod,string-length(b:restPeriod),1) = 'M'">
	             <xsl:value-of select="substring-before(b:restPeriod,'M')"/>
	         </xsl:when>
			 <xsl:when test="substring(b:restPeriod,string-length(b:restPeriod),1) = 'Y'">
	             <xsl:value-of select="substring-before(b:restPeriod,'Y')"/>
	         </xsl:when>
			 <xsl:otherwise>
	            <xsl:value-of select="'NULL'"/>
	          </xsl:otherwise>
		</xsl:choose>
      </rateFrequencyNumber>
   </xsl:template>
   <xsl:template name="rateFrequencyUnit">
      <rateFrequencyUnit>
         <xsl:choose>
            <xsl:when test="substring(b:restPeriod,string-length(b:restPeriod),1) = 'D'">
               <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:when test="substring(b:restPeriod,string-length(b:restPeriod),1) = 'M'">
               <xsl:value-of select="'4'"/>
            </xsl:when>
            <xsl:when test="substring(b:restPeriod,string-length(b:restPeriod),1) = 'Y'">
               <xsl:value-of select="'7'"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </rateFrequencyUnit>
   </xsl:template>
   <xsl:template name="subNature"/>
   <xsl:template name="interestRateConvention"/>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:shortName"/>
   <xsl:template name="infra:longName"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="minimumQuantity"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="provider"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="roundLotQuantity"/>
   <xsl:template name="sector"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tickSize"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="accrualRule"/>
   <xsl:template name="defaultRiskFreeRate"/>
   <xsl:template name="fixingCalendar"/>
   <xsl:template name="fixingRuleNumber"/>
   <xsl:template name="fixingRuleUnit"/>
   <xsl:template name="issuer"/>
   <xsl:template name="logNormalDistribution"/>
   <xsl:template name="paymentFrequencyNumber"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="rating"/>
   <!--  End restPeriodGroup -->
   <!-- Price Begin -->
   <xsl:template name="currency">
    <currency>
      <infra:code>
        <xsl:value-of select="substring(b:refCcyDate,'3','3')"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="instrument">
    <instrument>
      <infra:code>
        <xsl:value-of select="substring(b:refCcyDate,'1','5')"/>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="quotationDate">
  	<xsl:if test="b:rfrDateRecd">
    <quotationDate>
        <xsl:value-of select="concat(b:rfrDateRecd,'T00:00:00')"/>
    </quotationDate>
	</xsl:if>
  </xsl:template>
  <xsl:template name="value">
    <value>
        <xsl:value-of select="b:rfrRate"/>
    </value>
  </xsl:template>
  <xsl:template name="valueType"/>
  <xsl:template name="valueTermType"/>
  <!-- Price End -->
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