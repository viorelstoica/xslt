<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Diary"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDiary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDiary" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDiary"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validityDate">
		<xsl:if test="../../b:exDate">
			<validityDate>
				<xsl:value-of select="../../b:exDate"/>
			</validityDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="exDate">
		<xsl:if test="../../b:exDate">
			<exDate>
				<xsl:value-of select="../../b:exDate"/>
			</exDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="eventPriority">
		<xsl:param name="positionVar"/>
		<eventPriority>
			<xsl:value-of select="$positionVar"/>
		</eventPriority>
	</xsl:template>
	<xsl:template name="nature">
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
		<xsl:param name="eventType" select="../../b:eventType"/>
		<nature>
			<xsl:choose>
				<xsl:when test="contains(concat(' ',$list_EventType_StockDividends,' '),concat(' ',$eventType,' '))">4</xsl:when>
				<xsl:when test="contains(concat(' ',$list_EventType_StockSplit,' '),concat(' ',$eventType,' '))">2</xsl:when>
				<xsl:when test="contains(concat(' ',$list_EventType_ReverseStockSplit,' '),concat(' ',$eventType,' '))">3</xsl:when>
				<xsl:when test="contains(concat(' ',$list_EventType_SpinOff,' '),concat(' ',$eventType,' '))">1</xsl:when>
			</xsl:choose>
		</nature>
	</xsl:template>
	<xsl:template name="code">
		<code>
			<xsl:value-of select="../../b:diaryId"/>
		</code>
	</xsl:template>
	<xsl:template name="newInstrument">
		<newInstrument>
			<infra:code>
				<xsl:value-of select="b:newSecNo"/>
			</infra:code>
		</newInstrument>
	</xsl:template>
	<xsl:template name="currency">
		<xsl:if test="../../b:currency">
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="oldRatio">
		<xsl:if test="b:oldRatio">
			<oldRatio>
				<xsl:value-of select="b:oldRatio"/>
			</oldRatio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cashSettlement">
		<cashSettlement>
			<xsl:value-of select="'1'"/>
		</cashSettlement>
	</xsl:template>
	<xsl:template name="replaceOld">
		<xsl:if test="../../b:retainOriginalDiaryTypeJoin">
			<replaceOld>
				<xsl:choose>
					<xsl:when test="../../b:retainOriginalDiaryTypeJoin = 'Y' or ../../b:retainOriginalDiaryTypeJoin = 'YES'">0</xsl:when>
					<xsl:when test="../../b:retainOriginalDiaryTypeJoin = 'NO'">1</xsl:when>
				</xsl:choose>
			</replaceOld>
		</xsl:if>
	</xsl:template>
	<xsl:template name="newRatio">
		<xsl:if test="b:newRatio">
			<newRatio>
				<xsl:value-of select="b:newRatio"/>
			</newRatio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate">
		<xsl:if test="../../b:payDate">
			<endDate>
				<xsl:value-of select="../../b:payDate"/>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="price">
		<xsl:if test="../../b:quotePriceGroup/b:quotePrice">
			<price>
				<xsl:value-of select="../../b:quotePriceGroup/b:quotePrice"/>
			</price>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endValidity">
		<xsl:if test="../../b:payDate">
			<endValidity>
				<xsl:value-of select="../../b:payDate"/>
			</endValidity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="oddLotCompensation"/>
	<xsl:template name="exchangeRate"/>
	<xsl:template name="mbFields"/>
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