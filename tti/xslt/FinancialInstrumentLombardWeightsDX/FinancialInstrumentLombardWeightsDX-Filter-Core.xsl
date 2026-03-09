<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentLombardWeightsDX" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentLombardWeightsDX" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentLombardWeightsDX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentLombardWeightsDX" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:FinancialInstrumentLombardWeightsDX">
    <xsl:variable name="list_PriceSet">
      <xsl:call-template name="priceSetTranslation">
        <xsl:with-param name="priceSet" select="'CLOSING'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="self::b:FinancialInstrumentLombardWeightsDX[contains(concat(' ',$list_PriceSet,' '),concat(' ',b:priceSet,' '))]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FinancialInstrumentLombardWeightsDX" mode="filter1">
    <xsl:variable name="optionType" select="' KNOCKIN KNOCKOUT KIKI KIKO KOKO DIGITAL '"/>
    <xsl:apply-templates select="self::b:FinancialInstrumentLombardWeightsDX[b:optionTypeList/b:optionType ='' or contains(concat(' ',$optionType,' '),concat(' ',b:optionTypeList/b:optionType,' '))]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:FinancialInstrumentLombardWeightsDX" mode="filter2">
    <xsl:apply-templates select="self::b:FinancialInstrumentLombardWeightsDX[number(substring(translate(b:maturityDate ,'-',''),'1','6')) &gt;= number(substring(translate(b:coCodeDatesToday ,'-',''),'1','6'))]" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:FinancialInstrumentLombardWeightsDX" mode="filter3">
    <xsl:apply-templates select="self::b:FinancialInstrumentLombardWeightsDX[($g_filterBySubAssetType='Y' and contains($list_subAssetType_FinancialInstrumentLombardWeightsDX,concat(' ',b:subAssetTypeJoin,' '))) or
								($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='OPTION' or b:subAssetTypeTapInstrType='FUTURE'))]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FinancialInstrumentLombardWeightsDX" mode="filter-custo">
    <xsl:apply-templates select="self::b:FinancialInstrumentLombardWeightsDX" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FinancialInstrumentLombardWeightsDX" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentLombardWeightsDX" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentLombrdWeightDX\FinancialInstrumentLombardWeightDX.xml" htmlbaseurl=""
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