<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/Request"
                xmlns:a="http://www.odcgroup.com/Request"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXOrderReturn"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="identifier">
      <identifier>
         <xsl:value-of select="b:tapEventId"/>
      </identifier>
   </xsl:template>
   <xsl:template name="requestStatus">
      <requestStatus>
         <xsl:value-of select="'60'"/>
      </requestStatus>
   </xsl:template>
   <xsl:template name="errorReason"/>
   <xsl:template name="errorInfo"/>
   <xsl:template name="userDefinedField_Event"/>
   <xsl:template name="mbFields_Event"/>
   <xsl:template name="code">
      <code>
         <xsl:value-of select="b:tapRefId"/>
      </code>
   </xsl:template>
   <xsl:template name="status"/>
   <xsl:template name="userDefinedField_Update"/>
   <xsl:template name="mbFields_Update"/>
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
