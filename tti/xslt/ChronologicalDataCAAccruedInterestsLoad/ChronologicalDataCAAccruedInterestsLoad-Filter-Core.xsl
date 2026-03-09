<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/ChronologicalDataCAAccruedInterestsLoad" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchChronologicalDataCAAccruedInterestsLoad" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiChronologicalDataCAAccruedInterestsLoad" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiChronologicalDataCAAccruedInterestsLoad" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:ChronologicalDataCAAccruedInterestsLoad">
    <xsl:variable name="TotalAccr" select="format-number(sum(b:accrCrAmountGroup/b:accrCrAmount)+sum(b:accrCr2AmountGroup/b:accrCr2Amount)+sum(b:accrDrAmountGroup/b:accrDrAmount)+sum(b:accrDr2AmountGroup/b:accrDr2Amount),$decimalformat,'nan2zero')"/>
    <xsl:apply-templates select="self::b:ChronologicalDataCAAccruedInterestsLoad[$TotalAccr != 0]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:ChronologicalDataCAAccruedInterestsLoad" mode="filter1">
    <xsl:apply-templates select="self::b:ChronologicalDataCAAccruedInterestsLoad[b:customerCustomerSecurityTypeList/b:customerCustomerSecurityType = 'CUSTOMER']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:ChronologicalDataCAAccruedInterestsLoad" mode="filter2">
    <xsl:apply-templates select="self::b:ChronologicalDataCAAccruedInterestsLoad[b:category &gt;= '1001' and b:category &lt;= '1998']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:ChronologicalDataCAAccruedInterestsLoad" mode="filter-custo">
    <xsl:apply-templates select="self::b:ChronologicalDataCAAccruedInterestsLoad" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:ChronologicalDataCAAccruedInterestsLoad" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\ChronologicalDataCAAccruedInterestsLoad\ChronologicalDataCAAccruedInterestsLoad.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\ChronologicalDataCAAccruedInterestsLoad\ChronologicalDataCAAccruedInterestsLoad_Custo.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->