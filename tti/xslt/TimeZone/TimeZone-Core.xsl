<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TimeZone" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTimeZone" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c"
                version="1.0">
	<xsl:template name="code">
		<code>
			<xsl:value-of select="b:id"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName">
		<shortName>
			<xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName">
		<longName>
			<xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
		</longName>
	</xsl:template>
	<xsl:template name="utcOffset">
		<utcOffset>
			<xsl:value-of select="b:utcOffset"/>
		</utcOffset>
	</xsl:template>
	<xsl:template name="dbTimeZoneF"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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