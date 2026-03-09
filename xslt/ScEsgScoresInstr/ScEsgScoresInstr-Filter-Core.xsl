<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgScores"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScEsgScores" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgScores"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScEsgScores" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!--Condition1 -->
	<xsl:template match="b:ScEsgScores">
	<xsl:apply-templates select="self::b:ScEsgScores[b:securityNo != '' and b:securityNo]" mode="filter-custo"/>
	</xsl:template>
	
	<!-- Custo placeholder -->
	<xsl:template match="b:ScEsgScores" mode="filter-custo">
		<xsl:apply-templates select="self::b:ScEsgScores" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:ScEsgScores" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\ScEsgScoresIssuerScIssuer.xml" htmlbaseurl="" outputurl="..\ScEsgScoresIssuerScIssuerFILTEROUT.xml" processortype="jaxp" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->