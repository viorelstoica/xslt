<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" 
                xmlns:b="http://www.temenos.com/T24/event/TTI/ScBackValInt" 
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScBackValInt" 
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScBackValInt"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" 
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScBackValInt" 
				xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                exclude-result-prefixes="b c batch multibatch" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiScBackValInt">
		<xsl:apply-templates select="c:CurrentEvent/b:ScBackValInt"/>
	</xsl:template>
	<xsl:template match="batch:BatchScBackValInt">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchScBackValInt" name="BatchScBackValInt">
			<xsl:apply-templates select="b:ScBackValInt"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiScBackValInt">
		<xsl:element name="BatchMultiScBackValInt">
			<xsl:apply-templates select="c:MultiScBackValInt"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:ScBackValInt">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
						<xsl:value-of select="concat('ScBackValInt', b:accountNumber)"/>
			</xsl:attribute>
            <DataGroup>
                <xsl:for-each select="b:dateGroup">
	               <ChronologicalData>
			            <xsl:attribute name="description">
			               <xsl:value-of select="concat('ScBackValInt.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
			            </xsl:attribute>
			            <xsl:attribute name="sequenceNumber">
			               <xsl:call-template name="calcSeqNum">
			                  <xsl:with-param name="creationTime">
			                     <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
			                  </xsl:with-param>
			               </xsl:call-template>
			            </xsl:attribute>
			            <xsl:call-template name="currency"/>
			            <xsl:call-template name="dataNature"/>
			            <xsl:call-template name="instrument"/>
			            <xsl:call-template name="validity"/>
			            <xsl:call-template name="value"/>
			            <xsl:call-template name="provider"/>
			            <xsl:call-template name="valueType"/>
			            <xsl:call-template name="mbFields"/>
	               </ChronologicalData>
                </xsl:for-each>
            </DataGroup>
		</FiPMS>
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