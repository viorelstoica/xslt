<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentYieldCurve"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="substring(b:refCcyDate,'1','5')"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="b:descriptionList/b:description"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="b:descriptionList/b:description"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="substring(b:refCcyDate,'3','3')"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="InstrumentComposition">
      <xsl:for-each select="b:restPeriodGroup">
         <InstrumentComposition>
            <compositeInstrument>
               <infra:code>
                  <xsl:value-of select="concat(substring(../b:refCcyDate,'1','5'),b:restPeriod)"/>
               </infra:code>
            </compositeInstrument>
            <instrument>
               <infra:code>
                  <xsl:value-of select="substring(../b:refCcyDate,'1','5')"/>
               </infra:code>
            </instrument>
            <rank>
               <xsl:value-of select="@index"/>
            </rank>
            <value>1</value>
         </InstrumentComposition>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
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
   <xsl:template name="default"/>
   <xsl:template name="accrualRule"/>
   <xsl:template name="rateFrequencyUnit"/>
   <xsl:template name="rateFrequencyNumber"/>
   <xsl:template name="interpolationConvention"/>
   <xsl:template name="interpolationRule"/>
   <xsl:template name="interestRateConvention"/>
   <xsl:template name="referenceCurve"/>
   <xsl:template name="valueDays"/>
   <xsl:template name="businessDayConvention"/>
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