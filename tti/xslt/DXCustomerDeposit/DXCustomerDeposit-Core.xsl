<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXCustomer"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:value-of select="b:id"/>
      </code>
   </xsl:template>
   <xsl:template name="custodian">
      <custodian>
         <code>
            <xsl:choose>
               <xsl:when test="$CUSTOMER_PREFIX != ''">
                  <xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:id"/>
               </xsl:otherwise>
            </xsl:choose>
         </code>
      </custodian>
   </xsl:template>
   <xsl:template name="name">
      <name>
         <xsl:choose>
            <xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
               <xsl:value-of select="b:shortNameList/b:shortName"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:mnemonic"/>
            </xsl:otherwise>
         </xsl:choose>
      </name>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
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
