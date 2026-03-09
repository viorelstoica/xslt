<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/MDDealSubType"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:value-of select="concat(b:dealSubTyp,$COMPANY_POSTFIX_SEPARATOR,../../b:mnemonic)"/>
      </code>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:dealSubTyp"/>
      </shortName>
   </xsl:template>
   <xsl:template name="attribute">
      <attribute>subtype_id</attribute>
   </xsl:template>
   <xsl:template name="nature">
      <nature>0</nature>
   </xsl:template>
   <xsl:template name="parentType">
      <parentType>
         <code>
            <xsl:value-of select="concat(../b:contractType,$COMPANY_POSTFIX_SEPARATOR,../../b:mnemonic)"/>
         </code>
      </parentType>
   </xsl:template>
   <xsl:template name="parentTypeAttribute">
      <parentTypeAttribute>type_id</parentTypeAttribute>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="longName"/>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
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
