<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAdjustmentGuaranteeQuantity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAdjustmentGuaranteeQuantity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAdjustmentGuaranteeQuantity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAdjustmentGuaranteeQuantity" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity">
    <xsl:variable name="DealerBook">
      <xsl:choose>
        <xsl:when test="b:dealerBook">
          <xsl:choose>
            <xsl:when test="b:dealerBook!=''">
              <xsl:value-of select="'Y'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'N'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'N'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:TransactionAdjustmentGuaranteeQuantity[$DealerBook = 'N']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity" mode="filter1">
    <xsl:variable name="MemoPortfolio">
      <xsl:choose>
        <xsl:when test="b:memoAccountFlag">
          <xsl:choose>
            <xsl:when test="b:memoAccountFlag = 'Y'">
              <xsl:value-of select="'Y'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'N'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'N'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:TransactionAdjustmentGuaranteeQuantity[$MemoPortfolio = 'N']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity" mode="filter2">
    <xsl:variable name="ClientPortfolio">
      <xsl:choose>
        <xsl:when test="b:customerTypeList/b:customerType">
          <xsl:choose>
            <xsl:when test="b:customerTypeList/b:customerType='Client'">
              <xsl:value-of select="'Y'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'N'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'N'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:TransactionAdjustmentGuaranteeQuantity[$ClientPortfolio = 'N']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity" mode="filter3">
    <xsl:apply-templates select="self::b:TransactionAdjustmentGuaranteeQuantity[b:cusPortId != '']" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity" mode="filter4">
    <xsl:apply-templates select="self::b:TransactionAdjustmentGuaranteeQuantity[b:contractType = 'CA' or b:contractType = 'CL']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity" mode="filter-custo">
    <xsl:apply-templates select="self::b:TransactionAdjustmentGuaranteeQuantity" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Condition 1 -->
  <xsl:template match="b:pastSchedDateGroup">
    <xsl:apply-templates select="self::b:pastSchedDateGroup[b:pastSchedType = 'PRN' or b:pastSchedType = 'INV' or b:pastSchedType = 'MAT']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <!-- Only handle those records that have been created today -->
  <xsl:template match="b:pastSchedDateGroup" mode="filter1">
    <xsl:apply-templates select="self::b:pastSchedDateGroup[b:pastProcessDt = ../b:eventCommon/ns0:today]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:pastSchedDateGroup" mode="filter-custo">
    <xsl:apply-templates select="self::b:pastSchedDateGroup" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:pastSchedDateGroup" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionAdjustmentGuaranteeQuantity" userelativepaths="yes" externalpreview="no"
		          url="..\..\AUTO_TEST\Online\TransactionAdjustmentGuaranteeQuantity\TransactionAdjustmentGuaranteeQuantity_TransactionAdjustmentGuaranteeQuantity.xml" htmlbaseurl=""
		          outputurl="..\..\AUTO_TEST\Online\TransactionAdjustmentGuaranteeQuantity\TransactionAdjustmentGuaranteeQuantity_TransactionAdjustmentGuaranteeQuantityFilter.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\AUTO_TEST\Online\TransactionAdjustmentGuaranteeQuantity\TransactionAdjustmentGuaranteeQuantity_TransactionAdjustmentGuaranteeQuantity.xml" srcSchemaRoot="TransactionAdjustmentGuaranteeQuantity"
			              AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="@* | node()"></template>
			<template match="b:pastSchedDateGroup"></template>
		</MapperBlockPosition>
		<TemplateContext>
			<template match="b:pastSchedDateGroup" mode="" srcContextPath="/TransactionAdjustmentGuaranteeQuantity"
			          srcContextFile="file:///x:/TTI/AUTO_TEST/Online/TransactionAdjustmentGuaranteeQuantity/TransactionAdjustmentGuaranteeQuantity_TransactionAdjustmentGuaranteeQuantity.xml" targetContextPath="/test" targetContextFile=""/>
			<template match="@* | node()" mode="" srcContextPath="/TransactionAdjustmentGuaranteeQuantity"
			          srcContextFile="file:///x:/TTI/AUTO_TEST/Online/TransactionAdjustmentGuaranteeQuantity/TransactionAdjustmentGuaranteeQuantity_TransactionAdjustmentGuaranteeQuantity.xml" targetContextPath="" targetContextFile=""/>
		</TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->