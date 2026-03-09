<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentAADepositsInterestRateIL" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentAADepositsInterestRateIL" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentAADepositsInterestRateIL" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentAADepositsInterestRateIL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL">
    <xsl:variable name="custoCondition">
      <xsl:call-template name="aaCustoAdditionalSelectionCriteria"/>
    </xsl:variable>
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL[$custoCondition = '1']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 1 -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter1">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL[b:idComp2 = 'DEPOSITINT' or b:idComp2 = 'PRINCIPALINT']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter2">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL[b:rateTierType = 'SINGLE']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter3">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL[not(b:periodicIndexGroup/b:periodicIndex)]" mode="filter4"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter4">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL[b:acPortfolioNoGroup/b:acPortfolioNoList/b:acPortfolioNo]" mode="filter5"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter5">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL[((b:arrStatus = 'AUTH' or b:arrStatus = 'AUTH-FWD') and $AA_INTERFACE_INPUT_DEALS = 'Y') or b:arrStatus =  'CURRENT' ]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter-custo">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsInterestRateIL" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FinancialInstrumentAADepositsInterestRateIL" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentAADepositsInterestRateIL\FinancialInstrumentAADepositsInterestRateIL.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentAADepositsInterestRateIL\FinancialInstrumentAADepositsInterestRateILCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\FinancialInstrumentAADepositsInterestRateIL\FinancialInstrumentAADepositsInterestRateIL.xml" srcSchemaRoot="FinancialInstrumentAADepositsInterestRateIL" AssociatedInstance=""
			              loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="@* | node()"></template>
			<template match="b:FinancialInstrumentAADepositsInterestRateIL"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->