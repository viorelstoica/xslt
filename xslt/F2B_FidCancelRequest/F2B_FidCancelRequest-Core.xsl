<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	
	<xsl:template name="transactionId">
		<transactionId>
			<xsl:value-of select="substring-before(b:pmsReferenceCode,'_')"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="tapRefId">
		<field name="TAP.REF.ID">
        	<xsl:value-of select="translate(b:pmsReferenceCode, '_', '%')"/>
        </field>
	</xsl:template>
	<xsl:template name="ModelBankSpecificFields"/>
	<xsl:template name="ModelBankSpecificFields-Custo"/>
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