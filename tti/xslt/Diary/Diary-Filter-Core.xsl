<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Diary"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDiary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDiary" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDiary"
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
	<xsl:template match="b:Diary">
		<!-- STOCK.DIVIDENDS -->
		<xsl:param name="list_EventType_StockDividends">
			<xsl:call-template name="diaryTypeTranslation">
				<xsl:with-param name="diaryType" select="'STOCK.DIVIDENDS'"/>
			</xsl:call-template>
		</xsl:param>
		<!-- STOCK.SPLIT -->
		<xsl:param name="list_EventType_StockSplit">
			<xsl:call-template name="diaryTypeTranslation">
				<xsl:with-param name="diaryType" select="'STOCK.SPLIT'"/>
			</xsl:call-template>
		</xsl:param>
		<!-- REVERSE.STOCK.SPLIT -->
		<xsl:param name="list_EventType_ReverseStockSplit">
			<xsl:call-template name="diaryTypeTranslation">
				<xsl:with-param name="diaryType" select="'REV.STOCK.SPLIT'"/>
			</xsl:call-template>
		</xsl:param>
		<!-- SPIN.OFF -->
		<xsl:param name="list_EventType_SpinOff">
			<xsl:call-template name="diaryTypeTranslation">
				<xsl:with-param name="diaryType" select="'SPIN.OFF'"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="list_EventType">
			<xsl:value-of select="concat(' ',$list_EventType_StockDividends,' ',$list_EventType_StockSplit,' ',$list_EventType_ReverseStockSplit,' ',$list_EventType_SpinOff,' ')"/>
		</xsl:param>
		<xsl:apply-templates select="self::b:Diary[b:eventType and contains(concat(' ',$list_EventType,' '),concat(' ',b:eventType,' '))]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:Diary" mode="filter1">
		<xsl:apply-templates select="self::b:Diary[b:mandVoluFlag = 'MAND']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:Diary" mode="filter2">
		<xsl:apply-templates select="self::b:Diary[b:optionsDiaryTypeJoin = 'NO']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:Diary" mode="filter3">
		<xsl:apply-templates select="self::b:Diary[b:inclPendSecDiaryTypeJoin = 'YES' or b:inclPendSecDiaryTypeJoin = 'Y']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:Diary" mode="filter-custo">
		<xsl:apply-templates select="self::b:Diary" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:Diary" mode="filter-final">
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