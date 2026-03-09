<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgIndicator" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScEsgIndicator" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgIndicator" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScEsgIndicator" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiScEsgIndicator">
      <xsl:apply-templates select="c:CurrentEvent/b:ScEsgIndicator"/>
   </xsl:template>
   <xsl:template match="batch:BatchScEsgIndicator">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchScEsgIndicator" name="BatchScEsgIndicator">
         <xsl:apply-templates select="b:ScEsgIndicator"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiScEsgIndicator">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiScEsgIndicator" name="BatchMultiScEsgIndicator">
         <xsl:apply-templates select="c:MultiScEsgIndicator"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:ScEsgIndicator">
      <BusIndicator>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('ScEsgIndicator',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <BusIndicatorElt>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('ScEsgIndicator.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               
			   <xsl:call-template name="busIndicator"/>
               <xsl:call-template name="code"/>
               <xsl:call-template name="shortName"/>
               <xsl:call-template name="longName"/>
               <xsl:call-template name="multilingualLongName"/>
               <xsl:call-template name="parentBiElt"/>
               <xsl:call-template name="parentBiEltBusIndicator"/>
               <xsl:call-template name="thresholdAllowed"/>
               <xsl:call-template name="rank"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="type"/>
            </BusIndicatorElt>
            <!-- potential type definitions linked to the element definition  -->
            <xsl:call-template name="bi-type-definitions"/>
            <!-- potential type definitions linked to the element definition, added on site -->
            <xsl:call-template name="bi-type-definitions-added"/>
         </DataGroup>
      </BusIndicator>
   </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\XML Schema\BusIndicator.xsd" destSchemaRoot="BusIndicator" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="c:MultiCustomer"></template>
			<template match="b:Customer">
				<block path="BusIndicator/xsl:attribute[1]/xsl:value-of" x="303" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:attribute/xsl:value-of" x="303" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:attribute/xsl:value-of/name[1]" x="257" y="103"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:attribute[1]/xsl:call-template" x="303" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template" x="343" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[1]" x="263" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[2]" x="223" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[3]" x="183" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[4]" x="143" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[5]" x="103" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[6]" x="63" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[7]" x="23" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[8]" x="303" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[9]" x="343" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[10]" x="263" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[11]" x="223" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[12]" x="183" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[13]" x="143" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[14]" x="103" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[15]" x="63" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[16]" x="23" y="41"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[17]" x="303" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[18]" x="343" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[19]" x="263" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[20]" x="223" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[21]" x="183" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[22]" x="143" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[23]" x="103" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[24]" x="63" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[25]" x="23" y="121"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[26]" x="303" y="81"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[27]" x="303" y="81"/>
			</template>
			<template match="c:MultiScEsgIndicator"></template>
			<template match="b:ScEsgIndicator">
				<block path="BusIndicator/xsl:attribute[1]/xsl:value-of" x="303" y="90"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:attribute/xsl:value-of" x="303" y="24"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:attribute/xsl:value-of/name[1]" x="257" y="46"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:attribute[1]/xsl:call-template" x="303" y="162"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template" x="303" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[1]" x="343" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[2]" x="263" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[3]" x="223" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[4]" x="183" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[5]" x="143" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[6]" x="103" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[7]" x="63" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[8]" x="23" y="126"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[9]" x="343" y="86"/>
				<block path="BusIndicator/BusIndicator/BusIndicatorElt/xsl:call-template[10]" x="263" y="86"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->