<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerRelation"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerRelation" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerRelation" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerRelation"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="relationship">
		<xsl:param name="previousOrCurrent" select="'current'"/>
		<xsl:param name="origPartyGroupIndex"/>
		<xsl:choose>
			<xsl:when test="$previousOrCurrent = 'previous'">
				<xsl:if test="../../../../c:PreviousEvent/b:CustomerRelation/b:origPartyGroup[@index = $origPartyGroupIndex]/b:origRel">
				<attribute name="relationship_e">
					<xsl:variable name="orgiRel">
						<xsl:call-template name="origRelTranslation">
							<xsl:with-param name="origRelType" select="../../../../c:PreviousEvent/b:CustomerRelation/b:origPartyGroup[@index = $origPartyGroupIndex]/b:origRel"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$orgiRel"/>
				</attribute>
				</xsl:if>
				<xsl:if test="not(../../../../c:PreviousEvent/b:CustomerRelation/b:origPartyGroup[@index = $origPartyGroupIndex]/b:origRel)">
					<attribute name="relationship_e">
						<xsl:value-of select="0"/>
					</attribute>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$previousOrCurrent = 'current'">
				<xsl:if test="../b:origRel">
					<attribute name="relationship_e">
						<xsl:variable name="orgiRel">
							<xsl:call-template name="origRelTranslation">
								<xsl:with-param name="origRelType" select="../b:origRel"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="$orgiRel"/>
					</attribute>
				</xsl:if>
				<xsl:if test="not(../b:origRel)">
					<attribute name="relationship_e">
						<xsl:value-of select="0"/>
					</attribute>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="relThirdEntity">
		<xsl:param name="previousOrCurrent" select="'current'"/>
		<xsl:param name="origPartyGroupIndex"/>
		<attribute name="rel_third_party_id.code">
				<xsl:choose>
					<xsl:when test="$previousOrCurrent = 'previous'">
						<xsl:value-of select="b:relPartyId"/>
					</xsl:when>
					<xsl:when test="$previousOrCurrent = 'current'">
						<xsl:value-of select="b:relPartyId"/>
					</xsl:when>
				</xsl:choose>
		</attribute>
	</xsl:template>
	<xsl:template name="thirdEntity">
		<xsl:param name="previousOrCurrent" select="'current'"/>
		<xsl:param name="origPartyGroupIndex"/>
		<attribute name="third_party_id.code">
				<xsl:choose>
					<xsl:when test="$previousOrCurrent = 'previous'">
						<xsl:value-of select="../../../../c:PreviousEvent/b:CustomerRelation/b:origPartyGroup[@index = $origPartyGroupIndex]/b:origPartyId"/>
					</xsl:when>
					<xsl:when test="$previousOrCurrent = 'current'">
						<xsl:value-of select="../b:origPartyId"/>
					</xsl:when>
				</xsl:choose>
		</attribute>
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