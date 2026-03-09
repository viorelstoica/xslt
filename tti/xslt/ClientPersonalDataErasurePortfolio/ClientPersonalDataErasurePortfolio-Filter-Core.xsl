<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ClientPersonalDataErasure"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchClientPersonalDataErasure" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiClientPersonalDataErasure" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiClientPersonalDataErasure" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:ClientPersonalDataErasure">
		<xsl:apply-templates select="self::b:ClientPersonalDataErasure[b:tableName = 'SEC.ACC.MASTER' and b:fileType = 'HIS']" mode="filter1"/>
	</xsl:template>

	<!-- Condition 2 -->
	<xsl:template match="b:ClientPersonalDataErasure" mode="filter1">
		<xsl:variable name="boolean">
			<xsl:for-each select="b:recordIdGroup[@index = '1']/b:fieldNameSubGroup">
				<xsl:if test="b:fieldName = 'ACCOUNT.NAME'">
					<xsl:value-of select="'true'"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::b:ClientPersonalDataErasure[contains($boolean,'true')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:ClientPersonalDataErasure" mode="filter-custo">
		<xsl:apply-templates select="self::b:ClientPersonalDataErasure" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:ClientPersonalDataErasure" mode="filter-final">
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