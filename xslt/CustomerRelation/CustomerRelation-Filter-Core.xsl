<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerRelation"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerRelation" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerRelation" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerRelation"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- BEG - Filter groups "origPartyGroup" which donot satisfy origParty = 'CUSTOMER' -->
	<!-- Condition 1 -->
	<xsl:template match="b:origPartyGroup">
		<xsl:apply-templates select="self::b:origPartyGroup[b:origParty = 'CUSTOMER']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:origPartyGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:origPartyGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:origPartyGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter groups "origPartyGroup" which donot satisfy origParty = 'CUSTOMER' -->

	<!-- BEG - Filter Subgroups "relPartySubGroup" which donot satisfy relParty = 'CUSTOMER' -->
	<!-- Condition 1 -->
	<xsl:template match="b:relPartySubGroup">
		<xsl:apply-templates select="self::b:relPartySubGroup[b:relParty = 'CUSTOMER']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:relPartySubGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:relPartySubGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:relPartySubGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter Subgroups "relPartySubGroup" which donot satisfy relParty = 'CUSTOMER' -->

	<!-- BEG - Filter sectors from sectorList group which donot belong to origPartyGroup which are 'CUSTOMER' -->
	<!-- Condition 1 -->
	<xsl:template match="b:sector">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::b:sector[../../b:origPartyGroup[@index = $index]/b:origParty = 'CUSTOMER']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:sector" mode="filter-custo">
		<xsl:apply-templates select="self::b:sector" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:sector" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter sectors from sectorList group which donot belong to origPartyGroup which are 'CUSTOMER' -->

	<!-- BEG - Print Sector values outside the sectorList group for multi-entity checks(only those which belong to groups origPartyGroup which are 'CUSTOMERS' -->
	<!-- Condition 1 -->
	<xsl:template match="b:sectorList">
		<xsl:for-each select="b:sector">
			<xsl:variable name="index" select="@index"/>
			<xsl:if test="../../b:origPartyGroup[@index = $index]/b:origParty = 'CUSTOMER'">
				<xsl:variable name="sector" select="name()"/>
				<xsl:variable name="namespaceSector" select="substring-before($sector,'sector')"/>
				<!--<xsl:namespace-alias stylesheet-prefix="b" result-prefix="{$namespaceSector}"/>-->
				<xsl:element name="{$sector}" namespace="http://www.temenos.com/T24/event/TTI/CustomerRelation">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Print Sector values outside the sectorList group for multi-entity checks(only those which belong to groups origPartyGroup which are 'CUSTOMERS' -->

	<!-- BEG - Filter Whole Record if origParty and relParty are not 'CUSTOMER' in atleast one origPartyGroup -->
	<!-- Condition 1 -->
	<xsl:template match="c:MultiCustomerRelation">
		<xsl:variable name="ifFilterWholeRecord">
			<xsl:for-each select="c:CurrentEvent/b:CustomerRelation/b:origPartyGroup/b:relPartySubGroup">
				<xsl:choose>
					<xsl:when test="b:relParty = 'CUSTOMER' and ../b:origParty = 'CUSTOMER'">
						<xsl:value-of select="'Y'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::c:MultiCustomerRelation[contains($ifFilterWholeRecord,'Y')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="c:MultiCustomerRelation" mode="filter-custo">
		<xsl:apply-templates select="self::c:MultiCustomerRelation" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="c:MultiCustomerRelation" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter Whole Record if origParty and relParty are not 'CUSTOMER' in atleast one origPartyGroup -->
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
--><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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