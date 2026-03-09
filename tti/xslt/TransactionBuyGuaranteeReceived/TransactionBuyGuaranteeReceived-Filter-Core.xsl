<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionBuyGuaranteeReceived" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionBuyGuaranteeReceived" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionBuyGuaranteeReceived" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionBuyGuaranteeReceived" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived">
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
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[$DealerBook = 'N']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter1">
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
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[$MemoPortfolio = 'N']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter2">
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
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[$ClientPortfolio = 'N']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter3">
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[b:cusPortId != '']" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter4">
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[b:portfolioNo != '']" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter5">
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[b:contractType = 'CL']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter6">
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[b:currNo = 1]" mode="filter7"/>
  </xsl:template>
  <!-- Condition 8 -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter7">
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived[b:status != 'REV']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter-custo">
    <xsl:apply-templates select="self::b:TransactionBuyGuaranteeReceived" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:TransactionBuyGuaranteeReceived" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
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