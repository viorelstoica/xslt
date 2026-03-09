<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="PORTFOLIO.ID">
		<field name="PORTFOLIO.ID">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="SOURCE.FUND">
		<field name="SOURCE.FUND">
			<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'source_fund_instr']/infra:value"/>
		</field>
	</xsl:template>
	<xsl:template name="BIC.IDEN.BANK">
		<field name="BIC.IDEN.BANK">
			<xsl:value-of select="b:extBankBIC"/>
		</field>
	</xsl:template>
	<xsl:template name="EXT.BANK.NAME">
		<field name="EXT.BANK.NAME">
			<xsl:value-of select="b:extBankName"/>
		</field>
	</xsl:template>
	<xsl:template name="AC.HOLDER">
		<field name="AC.HOLDER">
			<xsl:value-of select="b:extBankOwnerName"/>
		</field>
	</xsl:template>
	<xsl:template name="EXT.SEC.NO">
		<field name="EXT.SEC.NO">
			<xsl:value-of select="b:counterpartAccount"/>
		</field>
	</xsl:template>
	<xsl:template name="TARGET.FUND">
		<field name="TARGET.FUND">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="DEPOSITORY">
		<field name="DEPOSITORY">
			<xsl:value-of select="b:depositaryAccount/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="REQUEST.TYPE">
		<field name="REQUEST.TYPE">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name = 'request_type_e']/infra:value = '0'">
					<xsl:value-of select="'None'"/>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name = 'request_type_e']/infra:value = '1'">
					<xsl:value-of select="'Partial'"/>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name = 'request_type_e']/infra:value = '2'">
					<xsl:value-of select="'Total'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="VALUE.TYPE">
		<field name="VALUE.TYPE">
			<xsl:choose>
				<xsl:when test="b:targetNature = '1'">
					<xsl:value-of select="'Shares'"/>
				</xsl:when>
				<xsl:when test="b:targetNature = '2'">
					<xsl:value-of select="'Amount'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="SHARES.ORDERED">
		<field name="SHARES.ORDERED">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="NET.AMOUNT">
		<field name="NET.AMOUNT">
			<xsl:value-of select="b:opNetAmount"/>
		</field>
	</xsl:template>
	<xsl:template name="TRADE.DATE">
		<field name="TRADE.DATE">
			<xsl:value-of select="translate(b:tradeDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="VALUE.DATE">
		<field name="VALUE.DATE">
			<xsl:value-of select="translate(b:valueDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="REQUEST.DATE">
		<field name="REQUEST.DATE">
			<xsl:value-of select="translate(b:tradeDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="TRANS.IN.STATUS">
		<field name="TRANS.IN.STATUS">
			<xsl:value-of select="'REQUEST.SENT'"/>
		</field>
	</xsl:template>
	<xsl:template name="TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="BANK.ID">
		<field name="BANK.ID">
			<xsl:value-of select="b:counterparty/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="FUND.COMM.ID">
		<field name="FUND.COMM.ID">
			<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'distributor_c']/infra:value"/>
		</field>
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