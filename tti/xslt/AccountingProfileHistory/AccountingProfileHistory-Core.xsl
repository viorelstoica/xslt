<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Cginventory" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="accProfile">
		<accProfile>
			<infra:code>
				<xsl:value-of select="substring-before(substring-after(b:id,'.'),'.')"/>
			</infra:code>
		</accProfile>
	</xsl:template>
	<xsl:template name="beginD">
		<beginD>
			<xsl:value-of select="$TAX_START_DATE"/>
		</beginD>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="substring-before(substring-after(b:id,'.'),'.')"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="endD"/>
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