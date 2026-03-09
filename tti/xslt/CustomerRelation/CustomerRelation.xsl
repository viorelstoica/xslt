<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerRelation"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerRelation" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerRelation" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerRelation"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCustomerRelation">
		<xsl:apply-templates select="c:CurrentEvent/b:CustomerRelation"/>
	</xsl:template>
	<xsl:template match="batch:BatchCustomerRelation">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCustomerRelation" name="BatchCustomerRelation">
			<xsl:apply-templates select="b:CustomerRelation"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCustomerRelation">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerRelation" name="BatchMultiCustomerRelation">
			<xsl:apply-templates select="c:MultiCustomerRelation"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:CustomerRelation">
		<generic>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CustomerRelation',b:id)"/>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="b:eventCommon/ns0:transactionStage = 'REVERSE-AUTHORISE'">
					<entity>
						<xsl:attribute name="name"/>
						<xsl:attribute name="parent">third_relation</xsl:attribute>

						<xsl:attribute name="mode">DELETE</xsl:attribute>
						<records>
							<xsl:for-each select="b:origPartyGroup/b:relPartySubGroup">
								<xsl:variable name="origPartyGroupIndex" select="../@index"/>
								<xsl:call-template name="deleteCustomerRelation">
									<xsl:with-param name="previousOrCurrent" select="'current'"/>
									<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
								</xsl:call-template>
							</xsl:for-each>
						</records>
					</entity>
				</xsl:when>
				<xsl:otherwise>
					<entity>
						<xsl:attribute name="name"/>
						<xsl:attribute name="parent">third_relation</xsl:attribute>
						<xsl:attribute name="mode">DELETE</xsl:attribute>
						<records>
							<xsl:for-each select="../../c:PreviousEvent/b:CustomerRelation/b:origPartyGroup/b:relPartySubGroup">
								<xsl:variable name="origPartyGroupIndex" select="../@index"/>
								<xsl:call-template name="deleteCustomerRelation">
									<xsl:with-param name="previousOrCurrent" select="'previous'"/>
									<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
								</xsl:call-template>
							</xsl:for-each>
						</records>
					</entity>
					<entity>
						<xsl:attribute name="name"/>
						<xsl:attribute name="parent">third_relation</xsl:attribute>
						<xsl:attribute name="mode">INSUPD</xsl:attribute>
						<records>
							<xsl:for-each select="b:origPartyGroup/b:relPartySubGroup">
								<xsl:variable name="origPartyGroupIndex" select="../@index"/>
								<xsl:call-template name="mappingCustomerRelation">
									<xsl:with-param name="previousOrCurrent" select="'current'"/>
									<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
								</xsl:call-template>
							</xsl:for-each>
						</records>
					</entity>
				</xsl:otherwise>
			</xsl:choose>
		</generic>
	</xsl:template>
	<xsl:template name="mappingCustomerRelation">
		<xsl:param name="previousOrCurrent"/>
		<xsl:param name="origPartyGroupIndex"/>
		<record>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('CustomerRelation.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<attributes>
				<xsl:call-template name="relationship">
					<xsl:with-param name="previousOrCurrent" select="$previousOrCurrent"/>
					<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="relThirdEntity">
					<xsl:with-param name="previousOrCurrent" select="$previousOrCurrent"/>
					<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="thirdEntity">
					<xsl:with-param name="previousOrCurrent" select="$previousOrCurrent"/>
					<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
				</xsl:call-template>
			</attributes>
		</record>
	</xsl:template>
	<xsl:template name="deleteCustomerRelation">
		<xsl:param name="previousOrCurrent"/>
		<xsl:param name="origPartyGroupIndex"/>
		<record>

			<xsl:attribute name="description">
				<xsl:value-of select="concat('CustomerRelation.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<attributes>
				<xsl:call-template name="relationship">
					<xsl:with-param name="previousOrCurrent" select="$previousOrCurrent"/>
					<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="relThirdEntity">
					<xsl:with-param name="previousOrCurrent" select="$previousOrCurrent"/>
					<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="thirdEntity">
					<xsl:with-param name="previousOrCurrent" select="$previousOrCurrent"/>
					<xsl:with-param name="origPartyGroupIndex" select="$origPartyGroupIndex"/>
				</xsl:call-template>
			</attributes>
		</record>
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