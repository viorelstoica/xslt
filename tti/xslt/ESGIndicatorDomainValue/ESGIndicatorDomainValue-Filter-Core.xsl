<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookupESG"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEBLookupESG" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookupESG"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookupESG" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!--Condition1 -->
	<xsl:template match="b:EBLookupESG">
	<xsl:apply-templates select="self::b:EBLookupESG[b:dataNameGroup/b:dataName = 'PROVIDER']" mode="filter-custo"/>
	</xsl:template>
	
	<!-- Custo placeholder -->
	<xsl:template match="b:EBLookupESG" mode="filter-custo">
		<xsl:apply-templates select="self::b:EBLookupESG" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:EBLookupESG" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->