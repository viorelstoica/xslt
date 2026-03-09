<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:c="http://www.temenos.com/T24/BatchOFSML/150" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:forex="http://www.temenos.com/T24/forex"	xmlns:nddeal="http://www.temenos.com/T24/nddeal" exclude-result-prefixes="b" version="1.0">
    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->
    <!-- Condition 1 -->
    <xsl:template match="b:F2B_MM_FX">
		<xsl:apply-templates select="self::b:F2B_MM_FX[b:DataGroup/b:ForexForward/b:Forward/b:OrderLifeCycle/b:saleRequest/b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '7']" mode="filter1"/>
	</xsl:template>

	<!-- Condition 2 -->
    <xsl:template match="b:F2B_MM_FX" mode="filter1">
		<xsl:apply-templates select="self::b:F2B_MM_FX[b:DataGroup/b:ForexForward/b:Forward/b:OrderLifeCycle/b:saleRequest[b:userDefinedField[infra:name='ud_instr_physical_f']/infra:value= '1' or b:userDefinedField[infra:name='ud_instr_physical_f']/infra:value= '0'] ]" mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:F2B_MM_FX" mode="filter-custo">
		<xsl:apply-templates select="self::b:F2B_MM_FX" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:F2B_MM_FX" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
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