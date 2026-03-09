<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CashAccountType"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCashAccountType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCashAccountType" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCashAccountType"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCashAccountType">
		<xsl:apply-templates select="c:CurrentEvent/b:CashAccountType"/>
	</xsl:template>
	<xsl:template match="batch:BatchCashAccountType">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCashAccountType" name="BatchCashAccountType">
			<xsl:apply-templates select="b:CashAccountType"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCashAccountType">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCashAccountType" name="BatchMultiCashAccountType">
			<xsl:apply-templates select="c:MultiCashAccountType"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:CashAccountType">
		<InfraPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('cashAccountType',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Type>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('CashAccountType.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<instrumentType>
						<xsl:call-template name="code"/>
						<xsl:call-template name="synonym"/>
						<xsl:call-template name="shortName"/>
						<xsl:call-template name="longName"/>
						<xsl:call-template name="multilingualLongName"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
						<xsl:call-template name="attribute"/>
						<xsl:call-template name="nature"/>
					</instrumentType>
				</Type>
			</DataGroup>
			<!-- BEG - INCOME SUBTYPE -->
			<DataGroup>
				<Type>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('CashAccountType.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<instrumentSubType>
						<xsl:call-template name="code_I"/>
						<xsl:call-template name="synonym_I"/>
						<xsl:call-template name="shortName_I"/>
						<xsl:call-template name="longName_I"/>
						<xsl:call-template name="multilingualLongName_I"/>
						<xsl:call-template name="notepad_I"/>
						<xsl:call-template name="userDefinedField_I"/>
						<xsl:call-template name="mbFields_I"/>
						<xsl:call-template name="attribute_I"/>
						<xsl:call-template name="nature_I"/>
						<xsl:call-template name="parentType_I"/>
						<xsl:call-template name="parentTypeAttribute_I"/>
					</instrumentSubType>
				</Type>
			</DataGroup>
			<!-- END - INCOME SUBTYPE -->
			<!-- BEG - CAPITAL SUBTYPE -->
			<DataGroup>
				<Type>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('CashAccountType.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<instrumentSubType>
						<xsl:call-template name="code_C"/>
						<xsl:call-template name="synonym_C"/>
						<xsl:call-template name="shortName_C"/>
						<xsl:call-template name="longName_C"/>
						<xsl:call-template name="multilingualLongName_C"/>
						<xsl:call-template name="notepad_C"/>
						<xsl:call-template name="userDefinedField_C"/>
						<xsl:call-template name="mbFields_C"/>
						<xsl:call-template name="attribute_C"/>
						<xsl:call-template name="nature_C"/>
						<xsl:call-template name="parentType_C"/>
						<xsl:call-template name="parentTypeAttribute_C"/>
					</instrumentSubType>
				</Type>
			</DataGroup>
			<!-- END - CAPITAL SUBTYPE -->
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