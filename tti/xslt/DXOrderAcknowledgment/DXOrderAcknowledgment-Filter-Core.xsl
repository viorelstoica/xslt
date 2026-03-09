<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/F2B" xmlns:b="http://www.temenos.com/T24/event/TTI/DXOrderAcknowledgment" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXOrderAcknowledgment" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXOrderAcknowledgment" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderAcknowledgment" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:DXOrderAcknowledgment">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin = 'NO']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter1">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[not(b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin)]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter2">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER' ]" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter3">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[($g_filterBySubAssetType='Y' and b:subAssetType != '' and contains($list_SubAssetType_DerivativesPrice,number(b:subAssetType))) or
								($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='OPTION' or b:subAssetTypeTapInstrType='FUTURE'))]" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter4">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[b:orderAmend != 'YES' or not(b:orderAmend)]" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter5">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[b:tapRefId]" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter6">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[$DxB2FAcknowledgmentActive = 'Y']" mode="filter7"/>
  </xsl:template>  
  <!-- Condition 8 -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter7">
    <xsl:variable name="TnsId">
      <xsl:value-of select="b:id"/>
    </xsl:variable>
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment[substring($TnsId,string-length($TnsId) - 1) = '-0']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter-custo">
    <xsl:apply-templates select="self::b:DXOrderAcknowledgment" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:DXOrderAcknowledgment" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->