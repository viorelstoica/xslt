<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookupESG"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEBLookupESG" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookupESG" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookupESG" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiEBLookupESG">
		<xsl:apply-templates select="c:CurrentEvent/b:EBLookupESG"/>
	</xsl:template>
	<xsl:template match="batch:BatchEBLookupESG">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchEBLookupESG" name="BatchEBLookupESG">
			<xsl:apply-templates select="b:EBLookupESG"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiEBLookupESG">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookupESG" name="BatchMultiEBLookupESG">
			<xsl:apply-templates select="c:MultiEBLookupESG"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:EBLookupESG">
		<BusIndicator>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="translate(concat('ESGIndicatorDomainValue',b:id), '*', '-')"/>
			</xsl:attribute>
			<DataGroup>
				<BiValueType>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('ESGIndicatorDomainValue.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:call-template name="code"/>
					<xsl:call-template name="busIndicatorElt"/>
					<xsl:call-template name="busIndicatorEltbusIndicator"/>
					<xsl:call-template name="provider"/>
					<xsl:call-template name="shortName"/>
					<xsl:call-template name="longName"/>
					<xsl:call-template name="multilingualLongName"/>
					<xsl:call-template name="rank"/>
				</BiValueType>
			</DataGroup>
		</BusIndicator>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\XML Schema\BusIndicator.xsd" destSchemaRoot="BusIndicator" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="c:MultiESGIndicatorDomainValue"></template>
			<template match="b:ESGIndicatorDomainValue">
				<block path="BusIndicator/xsl:attribute[1]/xsl:value-of" x="303" y="90"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:attribute/xsl:value-of" x="23" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:attribute/xsl:value-of/name[1]" x="0" y="90"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:attribute[1]/xsl:call-template" x="303" y="28"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template" x="343" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template[1]" x="263" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template[2]" x="223" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template[3]" x="183" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template[4]" x="143" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template[5]" x="103" y="68"/>
				<block path="BusIndicator/BusIndicator/ThirdParty/xsl:call-template[6]" x="63" y="68"/>
			</template>
			<template match="c:MultiEBLookupESG"></template>
			<template match="b:EBLookupESG">
				<block path="BusIndicator/xsl:attribute[1]/xsl:value-of" x="303" y="90"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:attribute/xsl:value-of" x="63" y="180"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:attribute/xsl:value-of/name[1]" x="17" y="202"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:attribute[1]/xsl:call-template" x="303" y="198"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template" x="303" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[1]" x="343" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[2]" x="263" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[3]" x="223" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[4]" x="183" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[5]" x="143" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[6]" x="103" y="162"/>
				<block path="BusIndicator/DataGroup/BiValueType/xsl:call-template[7]" x="63" y="162"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->