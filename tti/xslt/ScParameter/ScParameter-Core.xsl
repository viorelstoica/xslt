<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/ScParameter"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScParameter"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="codification">
      <codification>
		<code>
			<xsl:value-of select="."/>
		</code>
      </codification>
   </xsl:template>
   <xsl:template name="businessEntity">
      <businessEntity>
		<code>
			<xsl:value-of select="../../b:id"/>
		</code>
      </businessEntity>
   </xsl:template>
   <xsl:template name="entity">
      <entity>
		 <xsl:value-of select="'synonym'"/>
      </entity>
   </xsl:template>
   <xsl:template name="rank">
      <rank>
		 <xsl:value-of select="./@index"/>
      </rank>
   </xsl:template>  
   <xsl:template name="synonymEntity">
      <synonymEntity>
		 <xsl:value-of select="'instrument'"/>
      </synonymEntity>
   </xsl:template>
   <xsl:template name="type"/>
   
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