<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0"
    xmlns="http://www.temenos.com/T24/OFSML/150"
    xmlns:b="http://www.odcgroup.com/F2B"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:OrderInstruction">
		<xsl:apply-templates select="self::b:OrderInstruction[(b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13') and (b:userDefinedField[infra:name='ud_instr_traspasos_f']/infra:value = '1') and (b:buySellIndicator = '4')]"
		                     mode="filterMB-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:OrderInstruction" mode="filterMB-custo">
		<xsl:apply-templates select="self::b:OrderInstruction" mode="filterMB-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:OrderInstruction" mode="filterMB-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>


	<!-- Filter out whole input xml(i.e., root element F2B) if no orderInstruction passes the above filter -->
	<xsl:template match="b:F2B">
		<xsl:variable name="orderInstructionPresentCheck">
			<xsl:for-each select="b:DataGroup/b:Security/b:OrderLifeCycle/b:OrderInstruction">
				<xsl:choose>
					<xsl:when test="(b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13') and (b:userDefinedField[infra:name='ud_instr_traspasos_f']/infra:value = '1') and (b:buySellIndicator = '4')">
						<xsl:value-of select="'Y'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<!-- Condition 1 -->
		<xsl:apply-templates select="self::b:F2B[contains($orderInstructionPresentCheck,'Y')]" mode="filterMB-custo1"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:F2B" mode="filterMB-custo1">
		<xsl:apply-templates select="self::b:F2B" mode="filterMB-final1"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:F2B" mode="filterMB-final1">
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