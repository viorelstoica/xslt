<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Deposit"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDeposit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDeposit" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDeposit"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiDeposit">
		<xsl:apply-templates select="c:CurrentEvent/b:Deposit"/>
	</xsl:template>
	<xsl:template match="batch:BatchDeposit">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDeposit" name="BatchDeposit">
			<xsl:apply-templates select="b:Deposit"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiDeposit">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDeposit" name="BatchMultiDeposit">
			<xsl:apply-templates select="c:MultiDeposit"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:Deposit">
		<InfraPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('deposit',b:id)"/>
			</xsl:attribute>

			<DataGroup>
				<Deposit>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('Deposit.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code"/>
					<xsl:call-template name="custodian"/>
					<xsl:call-template name="name"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
				</Deposit>
			</DataGroup>

			<xsl:choose>
			<xsl:when test="b:subAccountGroup">
			<xsl:for-each select="b:subAccountGroup">
			<DataGroup>
				<Deposit>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('Deposit.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code_sub"/>
					<xsl:call-template name="custodian_sub"/>
					<xsl:call-template name="name_sub"/>
					<xsl:call-template name="subAccount"/>
					<xsl:call-template name="userDefinedField_sub"/>
					<xsl:call-template name="mbFields_sub"/>
				</Deposit>
			</DataGroup>
			</xsl:for-each>
			</xsl:when>
			</xsl:choose>
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