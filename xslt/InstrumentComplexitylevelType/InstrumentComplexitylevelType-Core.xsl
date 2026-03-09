<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookup"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEBLookup" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookup" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookup"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<!-- Filter out this flow since this is only  business entity specific -->
	<xsl:template name="code"/>
	<xsl:template name="entity"/>
	<xsl:template name="shortName"/>
	<xsl:template name="longName"/>
	<xsl:template name="attribute"/>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="synonym"/>
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