<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgIndicator" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScEsgIndicator"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgIndicator" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScEsgIndicator" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!--Condition1 -->
	<xsl:template match="b:ScEsgIndicator">
		<xsl:variable name="element">
			<xsl:value-of select="b:id"/>
		</xsl:variable>
		<xsl:variable name="element_len">
			<xsl:value-of select="string-length($element)"/>
		</xsl:variable>
		<xsl:variable name="element_last_revenue">
			<xsl:value-of select="substring($element, $element_len - 8)"/>
		</xsl:variable>

		<xsl:apply-templates select="self::b:ScEsgIndicator[not(contains(b:id,'-SCR-') and contains($element_last_revenue,'-REVENUE'))]" mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:ScEsgIndicator" mode="filter-custo">
		<xsl:apply-templates select="self::b:ScEsgIndicator" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:ScEsgIndicator" mode="filter-final">
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