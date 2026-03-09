<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/BasicInterest" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:template name="infra:code">
    <xsl:variable name="id" select="substring(b:id,1,string-length(b:id)-8)"/>
    <infra:code>
      <xsl:value-of select="concat($id,'F')"/>
    </infra:code>
  </xsl:template>
  <xsl:template name="active">
    <active>1</active>
  </xsl:template>
  <xsl:template name="referenceCurrency">
    <xsl:variable name="id" select="substring(b:id,1,string-length(b:id)-8)"/>
    <referenceCurrency>
      <infra:code>
        <xsl:value-of select="substring($id,string-length($id)-2)"/>
      </infra:code>
    </referenceCurrency>
  </xsl:template>
  <xsl:template name="rateFrequencyNumber"/>
  <xsl:template name="rateFrequencyUnit"/>
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
  <xsl:template name="interestRateConvention"/>
  <xsl:template name="issuer"/>
  <xsl:template name="logNormalDistribution"/>
  <xsl:template name="paymentFrequencyNumber"/>
  <xsl:template name="paymentFrequencyUnit"/>
  <xsl:template name="subNature"/>
  <xsl:template name="yieldCurve"/>
  <xsl:template name="rating"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\IntegrationStudio\TTI\schemas\BasicInterest\TTI-BasicInterest.xsd" destSchemaRoot="BasicInterest" destSchemaPathIsRelative="yes"
		            destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\gwpackSchemas\FiPMS.xsd" srcSchemaRoot="FiPMS" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template name="infra:code">
				<block path="infra:code/xsl:value-of" x="322" y="90"/>
				<block path="infra:code/xsl:value-of/substring[0]" x="276" y="84"/>
			</template>
			<template name="rateFrequencyUnit">
				<block path="rateFrequencyUnit/xsl:choose" x="372" y="60"/>
				<block path="rateFrequencyUnit/xsl:choose/=[0]" x="326" y="54"/>
				<block path="rateFrequencyUnit/xsl:choose/=[0]/substring[0]" x="280" y="48"/>
				<block path="rateFrequencyUnit/xsl:choose/=[0]/substring[0]/string-length[1]" x="234" y="70"/>
				<block path="rateFrequencyUnit/xsl:choose/xsl:when/xsl:value-of" x="322" y="90"/>
				<block path="rateFrequencyUnit/xsl:choose/=[1]" x="326" y="82"/>
				<block path="rateFrequencyUnit/xsl:choose/=[1]/substring[0]" x="280" y="76"/>
				<block path="rateFrequencyUnit/xsl:choose/=[1]/substring[0]/string-length[1]" x="234" y="98"/>
				<block path="rateFrequencyUnit/xsl:choose/xsl:when[1]/xsl:value-of" x="282" y="90"/>
				<block path="rateFrequencyUnit/xsl:choose/=[2]" x="326" y="90"/>
				<block path="rateFrequencyUnit/xsl:choose/=[2]/substring[0]" x="280" y="84"/>
				<block path="rateFrequencyUnit/xsl:choose/=[2]/substring[0]/string-length[1]" x="234" y="106"/>
				<block path="rateFrequencyUnit/xsl:choose/xsl:when[2]/xsl:value-of" x="242" y="90"/>
				<block path="rateFrequencyUnit/xsl:choose/xsl:otherwise/xsl:value-of" x="202" y="90"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
