<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AccountClosureCOB"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAccountClosureCOB" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAccountClosureCOB" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAccountClosureCOB" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:AccountClosureCOB">
		<xsl:apply-templates select="self::b:AccountClosureCOB[b:acctCloseDate != '' and (b:closedOnlineAccountJoin != 'Y' or not(b:closedOnlineAccountJoin))]"
		                     mode="filter1"/>
	</xsl:template>

	<!-- Condition 2 -->
	<xsl:template match="b:AccountClosureCOB" mode="filter1">
		<xsl:apply-templates select="self::b:AccountClosureCOB[b:acctCloseDate = b:eventCommon/ns0:today]" mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:AccountClosureCOB" mode="filter-custo">
		<xsl:apply-templates select="self::b:AccountClosureCOB" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:AccountClosureCOB" mode="filter-final">
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