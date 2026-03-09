<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/CginventoryAll" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="accProfile_AccountingRuleCompoAll">
		<xsl:variable name="custId" select="substring-before(b:id,'.')"/>
		<xsl:variable name="portId" select="substring-before(substring-after(b:id,'.'),'.')"/>
		<accProfile>
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
		</accProfile>
	</xsl:template>
	<xsl:template name="beginD_AccountingRuleCompoAll">
		<beginD>
			<xsl:value-of select="$TAX_START_DATE"/>
		</beginD>
	</xsl:template>
	<xsl:template name="fusionRule_AccountingRuleCompoAll">
		<fusionRule>
			<xsl:choose>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod = 'AVERAGE'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod= 'FIFO'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod = 'LIFO'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod = 'HIGHEST.COST'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod = 'LOWEST.COST'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod = 'MAX.GAIN'">
					<xsl:value-of select="'6'"/>
				</xsl:when>
				<xsl:when test="b:cgMethodGroup[@index=1]/b:cgMethod = 'MIN.GAIN'">
					<xsl:value-of select="'7'"/>
				</xsl:when>
			</xsl:choose>
		</fusionRule>
	</xsl:template>
	<xsl:template name="instrList_AccountingRuleCompoAll">
		<instrList>
			<code>
				<xsl:value-of select="concat('TAX_',substring-after(substring-after(b:id,'.'),'.'))"/>
			</code>
		</instrList>
	</xsl:template>
	<xsl:template name="taxLotMngt_AccountingRuleCompoAll">
		<taxLotMngt>
			<xsl:value-of select="'1'"/>
		</taxLotMngt>
	</xsl:template>
	<xsl:template name="taxLotOpRule_AccountingRuleCompoAll"/>

	<xsl:template name="accProfile_AccountingRuleCompoAllEL">
		<xsl:variable name="custId" select="substring-before(b:id,'.')"/>
		<xsl:variable name="portId" select="substring-before(substring-after(b:id,'.'),'.')"/>
		<accProfile>
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
		</accProfile>
	</xsl:template>
	<xsl:template name="beginD_AccountingRuleCompoAllEL">
		<beginD>
			<xsl:value-of select="$TAX_START_DATE"/>
		</beginD>
	</xsl:template>
	<xsl:template name="fusionRule_AccountingRuleCompoAllEL">
		<fusionRule>
			<xsl:value-of select="'1'"/>
		</fusionRule>
	</xsl:template>
	<xsl:template name="instrList_AccountingRuleCompoAllEL">
		<instrList>
			<code>
				<xsl:value-of select="'TAX_EXCLUSION_LIST'"/>
			</code>
		</instrList>
	</xsl:template>
	<xsl:template name="taxLotMngt_AccountingRuleCompoAllEL">
		<taxLotMngt>
			<xsl:value-of select="'0'"/>
		</taxLotMngt>
	</xsl:template>
	<xsl:template name="taxLotOpRule_AccountingRuleCompoAllEL"/>
</xsl:stylesheet>