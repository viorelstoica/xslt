<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fdFidOrder="http://www.temenos.com/T24/fdFidOrder" exclude-result-prefixes="b" version="1.0">

    <xsl:template name="fdFidOrder:transactionId">
        <transactionId>
            <xsl:value-of select="substring(b:deposit/infra:code, 1, string-length(b:deposit/infra:code) - 4)"/>
        </transactionId>
    </xsl:template>
	<xsl:template name="TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="TAP.REF.ID">
		<field name="TAP.REF.ID">
        	<xsl:value-of select="translate(b:pmsReferenceCode, '_', '%')"/>
        </field>
	</xsl:template>
	<xsl:template name="TRANSFER.TO.PORT">
		<field name="TRANSFER.TO.PORT">
			<xsl:value-of select="substring-after(b:adjustedPortfolio/infra:code,'-')"/>
		</field>
	</xsl:template>
	<xsl:template name="TRANSFER.EFF.DATE">
		<field name="TRANSFER.EFF.DATE">
			<xsl:value-of select="translate(b:valueDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="TAP.FD.TRANSFER">
		<field name="TAP.FD.TRANSFER">
			<xsl:value-of select="translate(b:pmsReferenceCode, '_', '%')"/>
		</field>
	</xsl:template>
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