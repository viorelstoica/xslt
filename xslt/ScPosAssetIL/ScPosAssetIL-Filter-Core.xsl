<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScPosAsset"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScPosAsset" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScPosAsset" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScPosAsset"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- BEG - Filter groups "securityNoGroup" which donot satisfy application = 'FX' and subApplication = 'FW' -->
	<!-- Condition 1 -->
	<xsl:template match="b:securityNoGroup">
		<xsl:apply-templates select="self::b:securityNoGroup[b:application = 'FX']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:securityNoGroup" mode="filter1">
		<xsl:apply-templates select="self::b:securityNoGroup[b:subApplication = 'FW']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:securityNoGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:securityNoGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:securityNoGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter groups "securityNoGroup" which donot satisfy application = 'FX' and subApplication = 'FW' -->

	<!-- BEG - Print coCode/ownCompId values outside the coCodeList/ownCompIdList group for multi-entity checks -->
	<!-- Condition 1 -->
	<xsl:template match="b:coCodeList">
		<xsl:variable name="coCode" select="name(b:coCode)"/>
		<xsl:element name="{$coCode}" namespace="http://www.temenos.com/T24/event/TTI/ScPosAsset">
			<xsl:value-of select="b:coCode"/>
		</xsl:element>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="b:ownCompIdList">
		<xsl:variable name="ownCompId" select="name(b:ownCompId)"/>
		<xsl:element name="{$ownCompId}" namespace="http://www.temenos.com/T24/event/TTI/ScPosAsset">
			<xsl:value-of select="b:ownCompId"/>
		</xsl:element>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- BEG - Print coCode/ownCompId values outside the coCodeList/ownCompIdList group for multi-entity checks -->

	<!-- BEG - Filter Whole Record if Filter Conditions not met -->
	<!-- Condition 1 atleast one securityNoGroup present satisfying application = 'FX' and subApplication = 'FW' -->
	<xsl:template match="b:ScPosAsset">
		<xsl:apply-templates select="self::b:ScPosAsset[b:securityNoGroup[b:application = 'FX' and b:subApplication = 'FW']]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:ScPosAsset" mode="filter1">
		<xsl:apply-templates select="self::b:ScPosAsset[$PCK_GL_FWD_TEMPLATE = '1']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:ScPosAsset" mode="filter2">
		<xsl:apply-templates select="self::b:ScPosAsset[contains(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:ScPosAsset" mode="filter-custo">
		<xsl:apply-templates select="self::b:ScPosAsset" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:ScPosAsset" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter Whole Record if Filter Conditions not met -->
</xsl:stylesheet>