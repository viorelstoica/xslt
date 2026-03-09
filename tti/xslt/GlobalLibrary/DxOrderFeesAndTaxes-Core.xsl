<?xml version="1.0"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printDxOrderFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:call-template name="PRI.TAX.CODE"/>
		<xsl:call-template name="PRI.TAX.TYPE"/>
		<xsl:call-template name="TAX.AMT.ACY"/>
		<xsl:call-template name="PRI.COMM.TYP"/>
		<xsl:call-template name="PRI.COMM.CDE"/>
		<xsl:call-template name="PRI.COMM.CCY"/>
		<xsl:call-template name="PRI.COMM.AMT"/>
		<xsl:call-template name="PRI.COMM.ACC"/>
		<xsl:call-template name="PRI.AUTO.MANUAL"/>
		<xsl:call-template name="PRICE.TRADED"/>
	</xsl:template>
	<xsl:template name="PRI.TAX.CODE"/>
	<xsl:template name="PRI.TAX.TYPE"/>
	<xsl:template name="TAX.AMT.ACY"/>
	<xsl:template name="PRI.COMM.TYP">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100')">
			<field name="PRI.COMM.TYP:1:1">
				<xsl:value-of select="'COMMISSION'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.CDE">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100')">
			<field name="PRI.COMM.CDE:1:1">
				<xsl:value-of select="'OVERRIDE'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.CCY">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100')">
			<field name="PRI.COMM.CCY:1:1">
				<xsl:value-of select="substring-before(substring-after(*[local-name() = 'security']/infra:code,'/'),'/')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.AMT">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100')">
			<field name="PRI.COMM.AMT:1:1">
				<xsl:value-of select="- translate(*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.ACC">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100')">
			<field name="PRI.COMM.ACC:1:1">
				<xsl:value-of select="*[local-name() = 'currentAccount']/infra:code"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.AUTO.MANUAL">
		<field name="PRI.AUTO.MANUAL">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100')">
					<xsl:value-of select="'MANUAL'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'AUTOMATIC'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="PRICE.TRADED">
		<field name="PRICE.TRADED">
			<xsl:value-of select="*[local-name() = 'userDefinedField'][infra:name='quote_n']/infra:value"/>
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