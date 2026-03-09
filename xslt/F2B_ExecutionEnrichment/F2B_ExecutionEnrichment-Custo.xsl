<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:dxorder="http://www.temenos.com/T24/dxorder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:scexesecorders="http://www.temenos.com/T24/scexesecorders" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<!-- SC.EXE.SEC.ORDERS section -->
	<!-- START of protected area  -->
	<xsl:template name="scexesecorders:USERDEF.FIELDS">
		<field name="CSD.TRD.MTCH.ID:-1">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_trade_match_id_t']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='ud_trade_match_id_t']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="scexesecorders:VALUE.DATE">
		<field name="VALUE.DATE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_settlement_date_d']/infra:value != 'NULL'">
					<xsl:variable name="rawDate" select="b:userDefinedField[infra:name='ud_settlement_date_d']/infra:value"/>
					<xsl:variable name="day" select="substring($rawDate, 1, 2)"/>
					<xsl:variable name="month" select="substring($rawDate, 4, 2)"/>
					<xsl:variable name="year" select="substring($rawDate, 7, 4)"/>
					<xsl:value-of select="concat($year, $month, $day)"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="scexesecorders:UTC.DATE.TIME">
		<field name="UTC.DATE.TIME:-1">
			<xsl:variable name="noTZ" select="substring-before(b:executionDate,'+')"/>
			<xsl:value-of select="concat(substring-before($noTZ,'.'),':',substring(substring-after($noTZ,'.'),1,3),'Z')"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:USERDEF.FIELDS">
		<field name="CSD.TRD.MTCH.ID:-1">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_trade_match_id_t']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='ud_trade_match_id_t']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.EXEC.DTE:-1">
			<xsl:choose>
				<xsl:when test="b:executionDate and b:executionDate != 'NULL'">
					<xsl:variable name="utcDateTime" select="concat(substring-before(b:executionDate,'.'),':',substring-after(b:executionDate,'.'))"/>
					<xsl:value-of select="concat(substring-before($utcDateTime,'+'),'Z')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>