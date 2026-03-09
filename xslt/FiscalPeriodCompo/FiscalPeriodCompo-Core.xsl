<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Company" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="beginD">
		<beginD>
			<xsl:value-of select="concat(substring(b:financialYearEnd,1,4),'-01-01')"/>
		</beginD>
	</xsl:template>
	<xsl:template name="entityType">
		<entityType>
			<xsl:value-of select="'instrument'"/>
		</entityType>
	</xsl:template>
	<xsl:template name="fiscalPeriod">
		<fiscalPeriod>
			<code>
				<xsl:value-of select="b:id"/>
			</code>
		</fiscalPeriod>
	</xsl:template>
	<xsl:template name="fiscalPeriodFreq">
		<fiscalPeriodFreq>
			<xsl:value-of select="substring(b:financialYearEnd,10,2)"/>
		</fiscalPeriodFreq>
	</xsl:template>
	<xsl:template name="fiscalPeriodFreqUnit">
		<xsl:variable name="fiscalFreq">
			<xsl:value-of select="substring(b:financialYearEnd,9,1)"/>
		</xsl:variable>
		<fiscalPeriodFreqUnit>
			<xsl:choose>
				<xsl:when test="$fiscalFreq = 'NULL' or $fiscalFreq = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'D'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'B'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'W'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'M'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'Q'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'S'">
					<xsl:value-of select="'6'"/>
				</xsl:when>
				<xsl:when test="$fiscalFreq = 'Y'">
					<xsl:value-of select="'7'"/>
				</xsl:when>
			</xsl:choose>
		</fiscalPeriodFreqUnit>
	</xsl:template>
	<xsl:template name="instrumentNature">
		<instrumentNature>
			<xsl:value-of select="'0'"/>
		</instrumentNature>
	</xsl:template>
	<xsl:template name="nature_e">
		<nature_e>
			<xsl:value-of select="'1'"/>
		</nature_e>
	</xsl:template>
	<xsl:template name="operationNature">
		<operationNature>
			<xsl:value-of select="'0'"/>
		</operationNature>
	</xsl:template>
</xsl:stylesheet>