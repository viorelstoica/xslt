<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DocumentType" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDocumentType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDocumentType"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDocumentType">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiDocumentType">
		<xsl:apply-templates select="c:CurrentEvent/b:DocumentType"/>
	</xsl:template>
	<xsl:template match="batch:BatchDocumentType">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDocumentType" name="BatchDocumentType">
			<xsl:apply-templates select="b:DocumentType"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiDocumentType">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDocumentType" name="BatchMultiDocumentType">
			<xsl:apply-templates select="c:MultiDocumentType"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:DocumentType">
		<InfraPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('DocumentType',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Type>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('DocumentType.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<documentType>
						<xsl:call-template name="code"/>
						<xsl:call-template name="synonym"/>
						<xsl:call-template name="shortName"/>
						<xsl:call-template name="longName"/>
						<xsl:call-template name="multilingualLongName"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
						<xsl:call-template name="attribute"/>
					</documentType>
				</Type>
			</DataGroup>
		</InfraPMS>
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