<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyAccuDecu"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SyAccuDecu">
		<xsl:apply-templates select="self::b:SyAccuDecu[b:memoAccount='NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2-->
	<xsl:template match="b:SyAccuDecu" mode="filter1">
		<xsl:apply-templates select="self::b:SyAccuDecu[not(b:dealerBook) or b:dealerBook='']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3-->
	<xsl:template match="b:SyAccuDecu" mode="filter2">
		<xsl:apply-templates select="self::b:SyAccuDecu[b:customerTypeList/b:customerType='CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4-->
	<xsl:template match="b:SyAccuDecu" mode="filter3">
		<xsl:apply-templates select="self::b:SyAccuDecu[b:eventCommon/ns0:application='EW.SY.EMIT.EVENT']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5-->
	<xsl:template match="b:SyAccuDecu" mode="filter4">
		<xsl:apply-templates select="self::b:SyAccuDecu[b:settlementMethod='CASH']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SyAccuDecu" mode="filter-custo">
		<xsl:apply-templates select="self::b:SyAccuDecu" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SyAccuDecu" mode="filter-final">
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