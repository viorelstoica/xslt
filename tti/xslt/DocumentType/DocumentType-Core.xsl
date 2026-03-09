<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DocumentType" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDocumentType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDocumentType"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDocumentType">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="b:documentTypeId"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName">
		<shortName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName">
		<longName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</longName>
	</xsl:template>
	<xsl:template name="attribute">
		<attribute>
			<xsl:value-of select="'type_id'"/>
		</attribute>
	</xsl:template>
	<xsl:template name="synonym"/>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad"/>
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