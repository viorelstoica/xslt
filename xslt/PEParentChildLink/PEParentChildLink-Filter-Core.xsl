<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PEProductEvents" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPEProductEvents"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPEProductEvents" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPEProductEvents"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PEProductEvents">
		<xsl:apply-templates select="self::b:PEProductEvents[../../c:CurrentEvent/b:PEProductEvents/b:undrawnSecurity and ../../c:CurrentEvent/b:PEProductEvents/b:capitalSecurity and ../../c:CurrentEvent/b:PEProductEvents/b:actualPeSecurity]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PEProductEvents" mode="filter1">
		<xsl:apply-templates select="self::b:PEProductEvents[not(../../c:PreviousEvent/b:PEProductEvents/b:undrawnSecurity and ../../c:PreviousEvent/b:PEProductEvents/b:capitalSecurity and ../../c:PreviousEvent/b:PEProductEvents/b:actualPeSecurity)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PEProductEvents" mode="filter-custo">
		<xsl:apply-templates select="self::b:PEProductEvents" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:PEProductEvents" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="@* | node()"></template>
			<template match="b:PEProductEvents"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->