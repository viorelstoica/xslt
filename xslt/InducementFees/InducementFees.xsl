<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/InducementFees"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchInducementFees" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiInducementFees" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiInducementFees" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiInducementFees">
		<xsl:apply-templates select="c:CurrentEvent/b:InducementFees"/>
	</xsl:template>
	<xsl:template match="batch:BatchInducementFees">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchInducementFees" name="BatchInducementFees">
			<xsl:apply-templates select="b:InducementFees"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiInducementFees">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiInducementFees" name="BatchMultiInducementFees">
			<xsl:apply-templates select="c:MultiInducementFees"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:InducementFees">
		<ClientPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('InducementFees',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<InducementFees>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('InducementFees.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="portfolio"/>
					<xsl:call-template name="instrument"/>
					<xsl:call-template name="deposit"/>
					<xsl:call-template name="paymentDate"/>
					<xsl:call-template name="paidAmount"/>
					<xsl:call-template name="currency"/>
					<xsl:call-template name="reimbursement"/>
					<xsl:call-template name="receivedAmount"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
				</InducementFees>
			</DataGroup>
		</ClientPMS>
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