<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgScores"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScEsgScores" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgScores" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScEsgScores"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiScEsgScores">
		<xsl:apply-templates select="c:CurrentEvent/b:ScEsgScores"/>
	</xsl:template>
	<xsl:template match="batch:BatchScEsgScores">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchScEsgScores" name="BatchScEsgScores">
			<xsl:apply-templates select="b:ScEsgScores"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiScEsgScores">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiScEsgScores" name="BatchMultiScEsgScores">
			<xsl:apply-templates select="c:MultiScEsgScores"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:ScEsgScores">
		<BusIndicator>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="translate(concat('ScEsgScoresIssuer',b:id), '*', '-')"/>
			</xsl:attribute>		
			<DataGroup>
				<xsl:call-template name="esg-rating-global-rating"/>
				<xsl:call-template name="esg-rating-global-score"/>
				<xsl:call-template name="esg-environment-pillar-score"/>
				<xsl:call-template name="esg-environment-pillar-weight"/>
				<xsl:call-template name="esg-rating-social-score"/>
				<xsl:call-template name="esg-rating-social-weight"/>
				<xsl:call-template name="esg-government-pillar-score"/>
				<xsl:call-template name="esg-government-pillar-weight"/>
				<xsl:call-template name="esg-controversies-overall-score"/>
				<xsl:call-template name="esg-controversies-overall-flag"/>
				<xsl:call-template name="esg-controversies-overall-summary"/>
				<xsl:call-template name="esg-controversies-env-score"/>
				<xsl:call-template name="esg-controversies-env-flag"/>
				<xsl:call-template name="esg-controversies-social-score"/>
				<xsl:call-template name="esg-controversies-social-flag"/>
				<xsl:call-template name="esg-controversies-govern-score"/>
				<xsl:call-template name="esg-controversies-govern-flag"/>
				<xsl:call-template name="esg-ratings-below-pillar"/>
				<xsl:call-template name="esg-controversies-below-pillar"/>
				<xsl:call-template name="esg-screening-values"/>
				<xsl:call-template name="esg-sdg-values"/>
				<xsl:call-template name="esg-sdg-classification"/>
				<xsl:call-template name="esg-sdg-classification-other"/>
				<xsl:call-template name="esg-eu-taxonomy"/>
				<xsl:call-template name="esg-sfdr-advers-impacts"/>
			</DataGroup>
		</BusIndicator>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\XML Schema\BusIndicator.xsd" destSchemaRoot="BusIndicator" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="c:MultiScEsgIndicator"></template>
			<template match="b:ScEsgIndicator"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->