<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/FxValuation" xmlns:b="http://www.temenos.com/T24/event/TTI/generateFxPositions" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="batch:BatchgenerateFxPositions">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions" name="BatchgenerateFxPositions">
			<xsl:apply-templates select="b:generateFxPositions"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:generateFxPositions">
		<FiPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FXInstrPrice',b:fxValuationRec/ns1:portfolioId)"/>
			</xsl:attribute>
			<xsl:for-each select="b:fxValuationRec/ns1:fxValuesList">
				<xsl:call-template name="mappingPrice"/>
			</xsl:for-each>
		</FiPMS>
	</xsl:template>


	<!-- BEG - Mapping for node Price -->
	<xsl:template name="mappingPrice">
		<DataGroup>
			<Price>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('FXInstrPrice.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="currency"/>
				<xsl:call-template name="instrument"/>
				<xsl:call-template name="provider"/>
				<xsl:call-template name="quotationDate"/>
				<xsl:call-template name="stockExchange"/>
				<xsl:call-template name="value">
					<xsl:with-param name="quotationCode1">
						<xsl:choose>
							<xsl:when test="ns1:quotationCode1">
								<xsl:value-of select="ns1:quotationCode1"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="quotationCode2">
						<xsl:choose>
							<xsl:when test="ns1:quotationCode2 and ns1:quotationCode2 !='0'">
								<xsl:value-of select="ns1:quotationCode2"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="valueType"/>
				<xsl:call-template name="valueTermType"/>
				<xsl:call-template name="priceCalculationRule"/>
				<xsl:call-template name="mbFields"/>
			</Price>
		</DataGroup>
	</xsl:template>
	<!-- END - Mapping for node Price -->
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