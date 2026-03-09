<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerDocument" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerDocument" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerDocument"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerDocument" xmlns:infra="http://www.odcgroup.com/InfraPMS">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCustomerDocument">
		<xsl:apply-templates select="c:CurrentEvent/b:CustomerDocument"/>
	</xsl:template>
	<xsl:template match="batch:BatchCustomerDocument">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCustomerDocument" name="BatchCustomerDocument">
			<xsl:apply-templates select="b:CustomerDocument"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCustomerDocument">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerDocument" name="BatchMultiCustomerDocument">
			<xsl:apply-templates select="c:MultiCustomerDocument"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:CustomerDocument">
		<ClientPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CustomerDocument',substring-before(b:id,'*'))"/>
			</xsl:attribute>
			<DataGroup>
				<ClientDocument>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('CustomerDocument.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code"/>
					<xsl:call-template name="documentCopy"/>
					<xsl:call-template name="documentOwner"/>
					<xsl:call-template name="expiryDate"/>
					<xsl:call-template name="language"/>
					<xsl:call-template name="receivedDate"/>
					<xsl:call-template name="referenceId"/>
					<xsl:call-template name="title"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
				</ClientDocument>
				<ClientDocumentLink>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('DocumentLink+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="client"/>
					<xsl:call-template name="document"/>
					<xsl:call-template name="userDefinedField_ClientDocumentLink"/>
					<xsl:call-template name="mbFields_ClientDocumentLink"/>
				</ClientDocumentLink>
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