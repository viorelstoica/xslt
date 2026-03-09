<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsForex" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:PositionsForex">
    <xsl:apply-templates select="self::b:PositionsForex[b:dealType = 'SW']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:PositionsForex" mode="filter1">
    <xsl:apply-templates select="self::b:PositionsForex[not(b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin) and not(b:dealerBookSecAccMasterHistJoinList/b:dealerBookSecAccMasterHistJoin)]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:PositionsForex" mode="filter2">
    <xsl:apply-templates select="self::b:PositionsForex[b:memoAccountSecAccMasterJoinList/b:memoAccountSecAccMasterJoin[@index=1] = 'NO' or b:memoAccountSecAccMasterHistJoinList/b:memoAccountSecAccMasterHistJoin[@index=1] = 'NO']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:PositionsForex" mode="filter3">
    <xsl:apply-templates select="self::b:PositionsForex[not(b:ourAccountPayGroup[@index=1]/b:status = 'MAT')]" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:PositionsForex" mode="filter4">
    <xsl:variable name="LegType">
      <xsl:choose>
        <xsl:when test="b:forwardRate">
          <xsl:value-of select="'FWD'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'SPOT'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:PositionsForex[$LegType = 'FWD']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:PositionsForex" mode="filter-custo">
    <xsl:apply-templates select="self::b:PositionsForex" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:PositionsForex" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PositionsFXSwap\PositionsFXSwap_msg-4.xml" htmlbaseurl="" outputurl="..\..\TestFiles\PositionsFXSwap\PositionsFXSwap_msg-4Custo.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->