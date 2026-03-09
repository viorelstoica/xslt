<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://www.odcgroup.com/F2B"  xmlns:infra="http://www.odcgroup.com/InfraPMS"
                   exclude-result-prefixes="b" version="1.0">

	<xsl:template name="TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="transactionId">
		<field name="transactionId">
			<xsl:value-of select="b:sourceSystemCode"/>
		</field>
	</xsl:template>
	<xsl:template name="ORDER.STATUS">
		<field name="ORDER.STATUS">
			<xsl:if test="b:orderStatus= '40' or b:orderStatus= '45' or b:orderStatus= '70' or b:orderStatus= '75'">
				<xsl:value-of select="'Cancellation.Requested'"/>
			</xsl:if>
		</field>
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