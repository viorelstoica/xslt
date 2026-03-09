<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Cginventory" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="beginD">
		<beginD>
			<xsl:value-of select="$TAX_START_DATE"/>
		</beginD>
	</xsl:template>
	<xsl:template name="discountFactor">
		<discountFactor>
			<xsl:value-of select='b:cgMethodGroup[not(b:dateTo)]/b:discountFactor'/>
		</discountFactor>
	</xsl:template>
	<xsl:template name="ftConvention">
		<xsl:variable name="custId" select="substring-before(b:id,'.')"/>
		<xsl:variable name="portId" select="substring-before(substring-after(b:id,'.'),'.')"/>
		<ftConvention>
			<code>
				<xsl:choose>
					<xsl:when test="$portId != 'ALL'">
						<xsl:value-of select="$portId"/>
					</xsl:when>
					<xsl:when test="$custId != 'ALL'">
						<xsl:value-of select="$custId"/>
					</xsl:when>
					<xsl:when test="$portId = 'ALL' and $custId = 'ALL'">
						<xsl:value-of select="b:coCode"/>
					</xsl:when>
				</xsl:choose>
			</code>
		</ftConvention>
	</xsl:template>
	<xsl:template name="instrList">
		<instrList>
			<code>
				<xsl:value-of select="concat('TAX_',substring-after(substring-after(b:id,'.'),'.'))"/>
			</code>
		</instrList>
	</xsl:template>
	<xsl:template name="longCapTaxRate">
		<longCapTaxRate>
			<xsl:value-of select='b:cgMethodGroup[not(b:dateTo)]/b:longTermRate'/>
		</longCapTaxRate>
	</xsl:template>
	<xsl:template name="longTermPeriod">
		<xsl:variable name="longTermPeriodVal">
			<xsl:value-of select="b:cgMethodGroup[@index=1]/b:longTermPeriod"/>
		</xsl:variable>
		<longTermPeriod>
			<xsl:value-of select="translate($longTermPeriodVal, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', '')"/>
		</longTermPeriod>
	</xsl:template>
	<xsl:template name="longTermPeriodUnit">
		<xsl:variable name="longTermVal">
			<xsl:value-of select="translate(b:cgMethodGroup[@index=1]/b:longTermPeriod, '0123456789','')"/>
		</xsl:variable>
		<longTermPeriodUnit>
			<xsl:choose>
				<xsl:when test="$longTermVal = 'NULL' or $longTermVal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'D'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'B'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'W'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'M'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'Q'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'H'">
					<xsl:value-of select="'6'"/>
				</xsl:when>
				<xsl:when test="$longTermVal = 'Y'">
					<xsl:value-of select="'7'"/>
				</xsl:when>
			</xsl:choose>
		</longTermPeriodUnit>
	</xsl:template>
	<xsl:template name="rank">
		<xsl:variable name="compId">
			<xsl:value-of select="substring-after(substring-after(b:id,'.'),'.')"/>
		</xsl:variable>
		<rank>
			<xsl:choose>
				<xsl:when test="contains ($compId,'-')">
					<xsl:value-of select="substring-after($compId,'-')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'9999'"/>
				</xsl:otherwise>
			</xsl:choose>
		</rank>
	</xsl:template>
	<xsl:template name="shortCapTaxRate">
		<shortCapTaxRate>
			<xsl:value-of select='b:cgMethodGroup[not(b:dateTo)]/b:shortTermRate'/>
		</shortCapTaxRate>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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