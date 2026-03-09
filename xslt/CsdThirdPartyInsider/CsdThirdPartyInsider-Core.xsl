<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdThirdPartyInsider" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="userDefinedField">
	<xsl:variable name="index" select="@index"/>
		<attribute name="code" type="string">
			<xsl:value-of select="concat(../../b:mnemonic,$index)"/>
		</attribute>
		<attribute name="third_id.code" type="string">
			<xsl:value-of select="../../b:id"/>
		</attribute>
		<attribute name="instr_isin" type="string">
				<xsl:value-of select="b:csdInsidIsin"/>
		</attribute>  
		<attribute name="begin_d" type="date">
				<xsl:for-each select="b:csdInsidStDt">
					<xsl:variable name="date" select="." />
					<xsl:variable name="year" select="substring($date, 1, 4)" />
					<xsl:variable name="month" select="substring($date, 5, 2)" />
					<xsl:variable name="day" select="substring($date, 7, 2)" />
						<xsl:value-of select="concat($day, '/', $month, '/', $year)" />
				</xsl:for-each>
		</attribute>
		<attribute name="end_d" type="date">
				<xsl:for-each select="b:csdInsidEdDt">
					<xsl:variable name="date" select="." />
					<xsl:variable name="year" select="substring($date, 1, 4)" />
					<xsl:variable name="month" select="substring($date, 5, 2)" />
					<xsl:variable name="day" select="substring($date, 7, 2)" />
					<xsl:value-of select="concat($day, '/', $month, '/', $year)" />
				</xsl:for-each>
		</attribute>
		<attribute name="type_id.code" type="string">
		<xsl:choose>
			<xsl:when test="b:csdInisdType = '-1'">
				<xsl:value-of select="'None'"/>
			</xsl:when>
			<xsl:when test="b:csdInisdType = '0'">
				<xsl:value-of select="'Primary'"/>
			</xsl:when>
			<xsl:when test="b:csdInisdType = '1'">
				<xsl:value-of select="'Secondary'"/>
			</xsl:when>
		</xsl:choose>
		</attribute>
	</xsl:template>
</xsl:stylesheet>