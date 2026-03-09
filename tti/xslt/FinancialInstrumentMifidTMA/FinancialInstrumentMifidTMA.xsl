<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MIFID"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMIFID" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMIFID" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiMIFID">
		<xsl:apply-templates select="c:CurrentEvent/b:MIFID"/>
	</xsl:template>
	<xsl:template match="batch:BatchMIFID">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMIFID" name="BatchMIFID">
			<xsl:apply-templates select="b:MIFID"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiMIFID">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" name="BatchMultiMIFID">
			<xsl:apply-templates select="c:MultiMIFID"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:MIFID">
	<BusIndicator>
		<xsl:attribute name="mode">INSUPD</xsl:attribute>
		<xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentMifidTMA',translate(b:id, '*', ''))"/>
         </xsl:attribute>
		 <DataGroup>
			 <xsl:attribute name="description">
				<xsl:value-of select="concat('FinancialInstrumentMifidTMA.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:call-template name="investObjective"/>
			<xsl:call-template name="allowedInvestor"/>
			<xsl:call-template name="riskLevel"/>
			<xsl:call-template name="investTenor"/>
			<xsl:call-template name="experienceRequired"/>
			<xsl:call-template name="objectives"/>
			<xsl:call-template name="distributionStrategy"/>
			<xsl:call-template name="lossTolerance"/>
			<xsl:call-template name="mifid_tma_custom"/>
		 </DataGroup>
		 </BusIndicator>
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