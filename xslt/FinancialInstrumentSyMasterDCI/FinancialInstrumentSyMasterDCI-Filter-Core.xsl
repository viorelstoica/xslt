<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSyContractMaster" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSyContractMaster" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSyContractMaster" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSyContractMaster" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:FinancialInstrumentSyContractMaster">
    <xsl:apply-templates select="self::b:FinancialInstrumentSyContractMaster[($g_filterBySubAssetType='Y' and (b:subAssetType = $SY_SAT_DCI or b:subAssetType = $SY_SAT_TCI)) or
								($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='DCI' or b:subAssetTypeTapInstrType='TCI'))]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FinancialInstrumentSyContractMaster" mode="filter-custo">
    <xsl:apply-templates select="self::b:FinancialInstrumentSyContractMaster" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FinancialInstrumentSyContractMaster" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentLombardWeightsDX" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentSyMasterPartFwd\FinancialInstrumentSyMasterPartFwd.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentLombrdWeightDX\FinancialInstrumentLombardWeightDXCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->