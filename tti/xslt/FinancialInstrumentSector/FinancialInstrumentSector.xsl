<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSector" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSector" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSector" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSector" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentSector">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentSector"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentSector">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSector" name="BatchFinancialInstrumentSector">
			<xsl:apply-templates select="b:FinancialInstrumentSector"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentSector">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSector" name="BatchMultiFinancialInstrumentSector">
			<xsl:apply-templates select="c:MultiFinancialInstrumentSector"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentSector">
		<InfraPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('instrumentSector',b:industryCode)"/>
			</xsl:attribute>
			<xsl:if test="not(b:gicsCode) or b:gicsCode='NO'">
				<DataGroup>
					<Sector>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentSector.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<instrumentSector>
							<xsl:call-template name="code_GN"/>
							<xsl:call-template name="synonym_GN"/>
							<xsl:call-template name="shortName_GN"/>
							<xsl:call-template name="longName_GN"/>
							<xsl:call-template name="multilingualLongName_GN"/>
							<xsl:call-template name="notepad_GN"/>
							<xsl:call-template name="userDefinedField_GN"/>
							<xsl:call-template name="mbFields_GN"/>
							<xsl:call-template name="codification_GN"/>
						</instrumentSector>
					</Sector>
				</DataGroup>
			</xsl:if>
			<xsl:if test="b:gicsCode = 'YES' and b:industryGroup != ''">
				<DataGroup>
					<Sector>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentSector.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<instrumentChildSector>
							<xsl:call-template name="code_IG"/>
							<xsl:call-template name="synonym_IG"/>
							<xsl:call-template name="shortName_IG"/>
							<xsl:call-template name="longName_IG"/>
							<xsl:call-template name="multilingualLongName_IG"/>
							<xsl:call-template name="notepad_IG"/>
							<xsl:call-template name="userDefinedField_IG"/>
							<xsl:call-template name="mbFields_IG"/>
							<xsl:call-template name="codification_IG"/>
							<xsl:call-template name="parentSector_IG"/>
						</instrumentChildSector>
					</Sector>
				</DataGroup>
			</xsl:if>
			<xsl:if test="b:gicsCode = 'YES' and b:industry != ''">
				<DataGroup>
					<Sector>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentSector.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<instrumentChildSector>
							<xsl:call-template name="code_I"/>
							<xsl:call-template name="synonym_I"/>
							<xsl:call-template name="shortName_I"/>
							<xsl:call-template name="longName_I"/>
							<xsl:call-template name="multilingualLongName_I"/>
							<xsl:call-template name="notepad_I"/>
							<xsl:call-template name="userDefinedField_I"/>
							<xsl:call-template name="mbFields_I"/>
							<xsl:call-template name="codification_I"/>
							<xsl:call-template name="parentSector_I"/>
						</instrumentChildSector>
					</Sector>
				</DataGroup>
			</xsl:if>
			<xsl:if test="b:gicsCode = 'YES' and b:subIndustry != ''">
				<DataGroup>
					<Sector>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentSector.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<instrumentChildSector>
							<xsl:call-template name="code_SI"/>
							<xsl:call-template name="synonym_SI"/>
							<xsl:call-template name="shortName_SI"/>
							<xsl:call-template name="longName_SI"/>
							<xsl:call-template name="multilingualLongName_SI"/>
							<xsl:call-template name="notepad_SI"/>
							<xsl:call-template name="userDefinedField_SI"/>
							<xsl:call-template name="mbFields_SI"/>
							<xsl:call-template name="codification_SI"/>
							<xsl:call-template name="parentSector_SI"/>
						</instrumentChildSector>
					</Sector>
				</DataGroup>
			</xsl:if>
			<xsl:if test="b:gicsCode = 'YES' and b:sector != ''">
				<DataGroup>
					<Sector>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentSector.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<instrumentSector>
							<xsl:call-template name="code_S"/>
							<xsl:call-template name="synonym_S"/>
							<xsl:call-template name="shortName_S"/>
							<xsl:call-template name="longName_S"/>
							<xsl:call-template name="multilingualLongName_S"/>
							<xsl:call-template name="notepad_S"/>
							<xsl:call-template name="userDefinedField_S"/>
							<xsl:call-template name="mbFields_S"/>
							<xsl:call-template name="codification_S"/>
							<xsl:call-template name="parentSector_S"/>
						</instrumentSector>
					</Sector>
				</DataGroup>
			</xsl:if>
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