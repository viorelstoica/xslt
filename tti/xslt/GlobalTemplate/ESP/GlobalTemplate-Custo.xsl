<?xml version="1.0"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<!-- START of protected area  -->
	<xsl:param name="SOOTAP" select="'CSD.TAP'"/>
	<!--DO 278667 - New Transaction Types TRE and TRS-->
	<xsl:param select="' TRI UTI ETI CBY OAB OWI LWI TRE '" name="securityTransferInSupportedTypes"/>
	<xsl:param select="' TRO UTO ETO CSL OAS OWO LWO TRS '" name="securityTransferOutSupportedTypes"/>
	<!-- END of protected area  -->
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