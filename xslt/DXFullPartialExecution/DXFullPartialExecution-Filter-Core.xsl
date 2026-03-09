<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/F2B" xmlns:b="http://www.temenos.com/T24/event/TTI/DXFullPartialExecution"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXFullPartialExecution" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXFullPartialExecution" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXFullPartialExecution" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:DXFullPartialExecution">
		<xsl:apply-templates select="self::b:DXFullPartialExecution[((( b:parent = 'NO' or b:parent = '' or not(b:parent)) and starts-with(b:tapRefId,'I')) or ((b:parent = 'NO' or b:parent = '' or not(b:parent)) and starts-with(b:tapRefId,'D') and (b:parentChildRef != '' or b:parentChildRef)))]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:DXFullPartialExecution" mode="filter1">
		<xsl:apply-templates select="self::b:DXFullPartialExecution[not(b:orderAmend)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:DXFullPartialExecution" mode="filter2">
		<xsl:apply-templates select="self::b:DXFullPartialExecution[b:secLots and b:secLots!='0']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:DXFullPartialExecution" mode="filter3">
		<xsl:apply-templates select="self::b:DXFullPartialExecution[(b:orderStatus='FILLED') or (b:orderStatus='PARTIAL')]" mode="filter-custo"/>
	</xsl:template>
	

	<!-- Custo placeholder -->
	<xsl:template match="b:DXFullPartialExecution" mode="filter-custo">
		<xsl:apply-templates select="self::b:DXFullPartialExecution" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:DXFullPartialExecution" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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