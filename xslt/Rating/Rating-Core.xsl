<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/Rating"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:value-of select="substring-before(b:ratingDescList/b:ratingDesc,'.')"/>
      </code>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="rank">
      <rank>
         <xsl:value-of select="b:id"/>
      </rank>
   </xsl:template>
   <xsl:template name="agency">
      <agency>
         <xsl:value-of select="b:agencyId"/>
      </agency>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName"/>
   <xsl:template name="longName"/>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
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
