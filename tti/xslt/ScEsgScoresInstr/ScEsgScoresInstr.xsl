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
				<xsl:value-of select="translate(concat('ScEsgScores',b:id), '*', '-')"/>
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
				<xsl:call-template name="esg-eu-taxonamy-indicators"/>
				<xsl:call-template name="esg-sfdr-advers-impacts"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-indicators"/>
				<xsl:call-template name="esg-custom-indicators"/>
			</DataGroup>
		</BusIndicator>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\XML Schema\BusIndicator.xsd" destSchemaRoot="BusIndicator" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="c:MultiScEsgScores"></template>
			<template match="b:ScEsgScores">
				<block path="BusIndicator/xsl:attribute[1]/xsl:value-of" x="303" y="90"/>
				<block path="BusIndicator/DataGroup/InstrbiValue/xsl:attribute/xsl:value-of" x="23" y="135"/>
				<block path="BusIndicator/DataGroup/InstrbiValue/xsl:attribute/xsl:value-of/name[1]" x="0" y="157"/>
				<block path="BusIndicator/DataGroup/InstrbiValue/xsl:call-template" x="183" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[1]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[1]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[1]/xsl:call-template" x="143" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[2]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[2]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[2]/xsl:call-template" x="103" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[3]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[3]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[3]/xsl:call-template" x="63" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[4]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[4]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[4]/xsl:call-template" x="23" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[5]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[5]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[5]/xsl:call-template" x="303" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[6]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[6]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[6]/xsl:call-template" x="343" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[7]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[7]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[7]/xsl:call-template" x="263" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[8]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[8]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[8]/xsl:call-template" x="223" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[9]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[9]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[9]/xsl:call-template" x="183" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[10]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[10]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[10]/xsl:call-template" x="143" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[11]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[11]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[11]/xsl:call-template" x="103" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[12]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[12]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[12]/xsl:call-template" x="63" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[13]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[13]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[13]/xsl:call-template" x="23" y="55"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[14]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[14]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[14]/xsl:call-template" x="303" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[15]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[15]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[15]/xsl:call-template" x="343" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[16]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[16]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[16]/xsl:call-template" x="263" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[17]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[17]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[17]/xsl:for-each" x="323" y="155"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[17]/xsl:for-each/xsl:if/=[0]" x="227" y="143"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[17]/xsl:for-each/xsl:if" x="273" y="145"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[17]/xsl:for-each/xsl:if/xsl:call-template" x="223" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[18]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[18]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[18]/xsl:call-template" x="183" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[19]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[19]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[19]/xsl:for-each" x="363" y="155"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[19]/xsl:for-each/xsl:if/=[0]" x="187" y="143"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[19]/xsl:for-each/xsl:if" x="233" y="145"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[19]/xsl:for-each/xsl:if/xsl:call-template" x="143" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[20]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[20]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[20]/xsl:for-each" x="123" y="155"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[20]/xsl:for-each/xsl:if/=[0]" x="147" y="143"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[20]/xsl:for-each/xsl:if" x="193" y="145"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[20]/xsl:for-each/xsl:if/xsl:call-template" x="103" y="15"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[21]/xsl:attribute/xsl:value-of" x="303" y="95"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[21]/xsl:attribute/xsl:value-of/name[1]" x="257" y="117"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[21]/xsl:for-each" x="243" y="35"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[21]/xsl:for-each/xsl:if/=[0]" x="27" y="143"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[21]/xsl:for-each/xsl:if" x="73" y="145"/>
				<block path="BusIndicator/DataGroup/InstrbiValue[21]/xsl:for-each/xsl:if/xsl:call-template" x="63" y="15"/>
				<block path="BusIndicator/DataGroup/xsl:call-template" x="343" y="108"/>
				<block path="BusIndicator/DataGroup/xsl:call-template[1]" x="263" y="108"/>
				<block path="BusIndicator/DataGroup/xsl:call-template[2]" x="223" y="108"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->