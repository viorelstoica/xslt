<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/InducementFees"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchInducementFees" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiInducementFees" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiInducementFees" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->

	<xsl:template match="b:InducementFees">
		<xsl:apply-templates select="self::b:InducementFees[b:memoAccountJoin = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:InducementFees" mode="filter1">
		<xsl:apply-templates select="self::b:InducementFees[not(b:dealerBookJoin)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:InducementFees" mode="filter2">
		<xsl:apply-templates select="self::b:InducementFees[b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:InducementFees" mode="filter3">
		<xsl:variable name="i" select="substring-after(substring-after(substring-after(substring-after(b:id,'.'),'.'),'.'),'.')"/>
		<xsl:apply-templates select="self::b:InducementFees[$i != '']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:InducementFees" mode="filter4">
		<xsl:apply-templates select="self::b:InducementFees[(contains(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD') and (substring(substring-after(substring-after(substring-after(substring-after(b:id,'.'),'.'),'.'),'.'),1,4 ) = substring(b:eventCommon/ns0:today,1,4))) or not(contains(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD'))]"
		                     mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:InducementFees" mode="filter-custo">
		<xsl:apply-templates select="self::b:InducementFees" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:InducementFees" mode="filter-final">
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