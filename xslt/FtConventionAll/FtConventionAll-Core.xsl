<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/CginventoryAll"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="code">
		<xsl:variable name="custId" select="substring-before(b:id,'.')"/>
		<xsl:variable name="portId" select="substring-before(substring-after(b:id,'.'),'.')"/>
		<code>
			<xsl:choose>
				<xsl:when test="$portId != 'ALL'">
					<xsl:value-of select="$portId"/>
				</xsl:when>
				<xsl:when test="$custId != 'ALL'">
					<xsl:value-of select="$custId"/>
				</xsl:when>
				<xsl:when test="$portId = 'ALL' and $custId = 'ALL'">
					<xsl:value-of select="b:coCode"/>
				</xsl:when>
			</xsl:choose>
		</code>
	</xsl:template>
	<xsl:template name="classification">
		<classification>
			<code>
				<xsl:value-of select="$TAX_CLASSIFICATION"/>
			</code>
		</classification>
	</xsl:template>
	<xsl:template name="nature">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
	</xsl:template>
	<xsl:template name="taxStatus">
		<taxStatus>
			<xsl:value-of select="'0'"/>
		</taxStatus>
	</xsl:template>

</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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