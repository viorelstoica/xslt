<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrderProduct"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrderProduct"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:choose>
            <xsl:when test="$POSTFIX_TROPTYPE = 'Y'">
               <xsl:value-of select="concat('POR',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat('POR',$COMPANY_POSTFIX_SEPARATOR,b:id)"/>
            </xsl:otherwise>
         </xsl:choose>
      </code>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:descriptionList/b:description[@language='GB']"/>
      </shortName>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="b:descriptionList/b:description[@language='GB']"/>
      </longName>
   </xsl:template>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="attribute">
      <attribute>
         <xsl:value-of select="'type_id'"/>
      </attribute>
   </xsl:template>
   <xsl:template name="nature">
      <nature>
         <xsl:value-of select=" '0' "/>
      </nature>
   </xsl:template>
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
