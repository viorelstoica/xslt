<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:SyAccuDecu">
    <xsl:apply-templates select="self::b:SyAccuDecu[b:blockFunds = 'BLOCK']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:SyAccuDecu" mode="filter1">
    <xsl:apply-templates select="self::b:SyAccuDecu[b:productType='ACCUMULATOR']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:SyAccuDecu" mode="filter2">
    <xsl:variable name="check_MaturityDate">
      <xsl:choose>
        <xsl:when test="string-length(b:maturityDate) ='8'">
          <xsl:value-of select="b:maturityDate"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(translate(b:maturityDate,'-',''),1,8)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="check_toDay">
      <xsl:choose>
        <xsl:when test="string-length(b:eventCommon/ns0:today) ='8'">
          <xsl:value-of select="b:eventCommon/ns0:today"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring(translate(b:eventCommon/ns0:today,'-',''),1,8)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:SyAccuDecu[number($check_MaturityDate) &gt;= number($check_toDay)]" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:SyAccuDecu" mode="filter3">
    <xsl:apply-templates select="self::b:SyAccuDecu[b:portfolio != '']" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:SyAccuDecu" mode="filter4">
    <xsl:apply-templates select="self::b:SyAccuDecu[b:dealerBook = '' or not(b:dealerBook)]" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="b:SyAccuDecu" mode="filter5">
    <xsl:apply-templates select="self::b:SyAccuDecu[b:memoAccount = 'NO']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="b:SyAccuDecu" mode="filter6">
    <xsl:variable name="opStatus">
      <xsl:call-template name="operationStatus">
        <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
        <xsl:with-param name="recordStatus" select="b:recordStatus"/>
      </xsl:call-template>
    </xsl:variable>   
    <xsl:apply-templates select="self::b:SyAccuDecu[$opStatus = 'INPUT-AUTHORISE']" mode="filter-custo"/>
  </xsl:template>  
  <!-- Custo placeholder -->
  <xsl:template match="b:SyAccuDecu" mode="filter-custo">
    <xsl:apply-templates select="self::b:SyAccuDecu" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:SyAccuDecu" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionOpenDerivativeBuylReversal" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionOpenDerivativeBuyReversal\TransactionOpenDerivativeBuyReversal.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionOpenDerivativeBuyReversal\TransactionOpenDerivativeBuyReversalCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
