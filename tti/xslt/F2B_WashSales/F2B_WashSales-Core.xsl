<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="ID"/>
	<!-- BEG - Template for printing the multivalue depending on order of Priority as obtained from TAP -->
	<xsl:template name="multivalue_washsales">
		<xsl:param name="i"/>
		<xsl:param name="fieldname"/>
		<xsl:param name="inputfieldname"/>
		<xsl:param name="j" select="concat($inputfieldname,$i)"/>
		<xsl:if test="b:attribute[@name = $j] != '' and b:attribute[@name = $j]">
			<field>
				<xsl:attribute name="name">
					<xsl:value-of select="concat($fieldname,$i)"/>
				</xsl:attribute>
				<xsl:value-of select="b:attribute[@name = $j]"/>
			</field>
			<xsl:call-template name="multivalue_washsales">
				<xsl:with-param name="i" select="$i+1"/>
				<xsl:with-param name="fieldname" select="$fieldname"/>
				<xsl:with-param name="inputfieldname" select="$inputfieldname"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template for printing the multivalue depending on order of Priority as obtained from TAP -->
	<xsl:template name="REPLACEMENT.TXN">
		<xsl:call-template name="multivalue_washsales">
			<xsl:with-param name="i" select="'1'"/>
			<xsl:with-param name="fieldname" select="'REPLACEMENT.TXN:'"/>
			<xsl:with-param name="inputfieldname" select="'impTxnSourceCode_'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="SALE.TXN.1">
		<field name="SALE.TXN:1">
			<xsl:value-of select="b:attribute[@name = 'txnSourceCode']"/>
		</field>
	</xsl:template>
	<xsl:template name="PORTFOLIO.ID"/>
	<xsl:template name="SECURITY.MASTER.ID"/>
	<xsl:template name="CG.TXN.BASE.ID"/>
	<xsl:template name="ORIGINAL.TXN.ID-XX.XX"/>
	<xsl:template name="DISALLOWED.LOSS-XX-XX"/>
	<xsl:template name="DISALLOWED.LOTS-XX.XX"/>
	<xsl:template name="LOCAL.REF"/>
	<xsl:template name="USERDEF.FIELDS"/>
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