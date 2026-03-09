<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/AcAccrual/AcAccrual" xmlns:batch="http://www.temenos.com/T24/event/AcAccrual/BatchAcAccrual" xmlns:c="http://www.temenos.com/T24/event/AcAccrual/MultiAcAccrual"
                xmlns:d="http://www.temenos.com/T24/AccountingEventsService/AcAccountAccruals" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/AcAccrual/BatchMultiAcAccrual"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiAcAccrual">
		<xsl:apply-templates select="c:CurrentEvent/b:AcAccrual"/>
	</xsl:template>
	<xsl:template match="batch:BatchAcAccrual">
		<xsl:element xmlns="http://www.temenos.com/T24/event/AcAccrual/BatchAcAccrual" name="BatchAcAccrual">
			<xsl:apply-templates select="b:AcAccrual"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiAcAccrual">
		<xsl:element name="BatchMultiAcAccrual">
			<xsl:apply-templates select="c:MultiAcAccrual"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:AcAccrual">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:choose>
					<xsl:when test="b:accountaccruals/d:arrangementId !=''">
						<xsl:value-of select="concat('AcAccrual',b:accountaccruals/d:arrangementId)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('AcAccrual',b:accountaccruals/d:accountId)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="b:accountaccruals"/>
		</FiPMS>
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