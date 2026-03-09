<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDxPrice" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyDxPrice" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyDxPrice"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyDxPrice" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SyDxPrice">
		<xsl:apply-templates select="self::b:SyDxPrice[b:counterpartyTrade != 'YES' or not(b:counterpartyTrade)]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SyDxPrice" mode="filter1">
		<xsl:apply-templates select="self::b:SyDxPrice[number(translate(b:tradeDate,'-','')) &gt;= number(translate($securityPriceStartDate,'-',''))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SyDxPrice" mode="filter2">
		<xsl:variable name="check_MaturityDateSYACCUDECU">
			<xsl:choose>
				<xsl:when test="string-length(b:maturityDateSYACCUDECU) ='8'">
					<xsl:value-of select="b:maturityDateSYACCUDECU"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(translate(b:maturityDateSYACCUDECU,'-',''),1,8)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="check_MaturityDateSYDCI">
			<xsl:choose>
				<xsl:when test="string-length(b:maturityDateSYDCI) ='8'">
					<xsl:value-of select="b:maturityDateSYDCI"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(translate(b:maturityDateSYDCI,'-',''),1,8)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="check_MaturityDateSYIMF">
			<xsl:choose>
				<xsl:when test="string-length(b:maturityDateSYIMF) ='8'">
					<xsl:value-of select="b:maturityDateSYIMF"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(translate(b:maturityDateSYIMF,'-',''),1,8)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="check_MaturityDateSyFxForward">
			<xsl:choose>
				<xsl:when test="string-length(b:maturityDateSyFxForward) ='8'">
					<xsl:value-of select="b:maturityDateSyFxForward"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(translate(b:maturityDateSyFxForward,'-',''),1,8)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="check_toDay">
			<xsl:choose>
				<xsl:when test="string-length(b:eventCommon/ns0:today) ='8'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(translate(b:eventCommon/ns0:today,'-',''),1,8)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SyDxPrice[(starts-with(b:dealReference,'SYACDC') and(b:contractStatusSYACCUDECU='ACTIVE' or b:contractStatusSYACCUDECU='FIXED') and(b:productTypeSYACCUDECU='ACCUMULATOR' or b:productTypeSYACCUDECU='DECUMULATOR') and ($check_MaturityDateSYACCUDECU &gt; $check_toDay))       or      (starts-with(b:dealReference,'SYDCI') and b:contractStatusSYDCI='ACTIVE' and ($check_MaturityDateSYDCI &gt; $check_toDay))          or         (starts-with(b:dealReference,'SYIMF') and b:contractStatusSYIMF='ACTIVE' and ($check_MaturityDateSYIMF &gt; $check_toDay)                )              or               (starts-with(b:dealReference,'SYFX') and b:suppressUnderlyingSyFxForward='NO' and ($check_MaturityDateSyFxForward &gt; $check_toDay)) or (starts-with(b:dealReference,'DXTRA')) ]"
		                     mode="filter3"/></xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SyDxPrice" mode="filter3">
		<xsl:apply-templates select="self::b:SyDxPrice[(b:price and b:price != '') or (b:valuationAmt and b:valuationAmt !='')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SyDxPrice" mode="filter-custo">
		<xsl:apply-templates select="self::b:SyDxPrice" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SyDxPrice" mode="filter-final">
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