<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OpenUpfrontPaymentOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOpenUpfrontPaymentOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOpenUpfrontPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOpenUpfrontPaymentOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiOpenUpfrontPaymentOrder">
		<xsl:apply-templates select="c:CurrentEvent/b:OpenUpfrontPaymentOrder"/>
	</xsl:template>
	<xsl:template match="batch:BatchOpenUpfrontPaymentOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchOpenUpfrontPaymentOrder" name="BatchOpenUpfrontPaymentOrder">
			<xsl:apply-templates select="b:OpenUpfrontPaymentOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiOpenUpfrontPaymentOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiOpenUpfrontPaymentOrder" name="BatchMultiOpenUpfrontPaymentOrder">
			<xsl:apply-templates select="c:MultiOpenUpfrontPaymentOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:OpenUpfrontPaymentOrder">
		<ClientPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('UpfrontPaymentCancel',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<PortfolioEvent>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('UpfrontPaymentCancel.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code"/>
					<xsl:call-template name="instrument"/>
					<xsl:call-template name="linkedInstrument"/>
					<xsl:call-template name="portfolio"/>
					<xsl:call-template name="quantity"/>
					<xsl:call-template name="exDate"/>
					<xsl:call-template name="endDate"/>
					<xsl:call-template name="nature"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
				</PortfolioEvent>
			</DataGroup>
		</ClientPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\Portfolio\Portfolio.xml" srcSchemaRoot="Portfolio" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="c:MultiPortfolio">
				<block path="xsl:apply-templates" x="323" y="0"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->