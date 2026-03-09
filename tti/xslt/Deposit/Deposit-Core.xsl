<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Deposit"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDeposit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDeposit" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDeposit"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="b:id"/>
		</code>
	</xsl:template>
	<xsl:template name="custodian">
		<custodian>
			<code>
				<xsl:if test="b:id != ''">
					<xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
				</xsl:if>
			</code>
		</custodian>
	</xsl:template>
	<xsl:template name="name">
		<name>
			<xsl:choose>
				<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
					<xsl:value-of select="b:shortNameList/b:shortName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:mnemonic"/>
				</xsl:otherwise>
			</xsl:choose>
		</name>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<!--sub account-->
	<xsl:template name="code_sub">
	<xsl:variable name="index" select="@index"/>
	<xsl:choose>
		<xsl:when test="../b:id !=''">
		<code>
			<xsl:choose>
				<xsl:when test="../b:subAccountTypeList/b:subAccountType[@index=$index] !='' and ../b:subAccountTypeList/b:subAccountType[@index=$index] = $subAccountNature and b:subAccount">
					<xsl:value-of select="concat(../b:id,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:id"/>
				</xsl:otherwise>
			</xsl:choose>
			</code>
		</xsl:when>
	</xsl:choose>
	</xsl:template>
	<xsl:template name="custodian_sub">
	<custodian>
			<code>
				<xsl:if test="../b:id != ''">
					<xsl:value-of select="concat($CUSTOMER_PREFIX,../b:id)"/>
				</xsl:if>
			</code>
		</custodian>
		</xsl:template>
	<xsl:template name="name_sub">
	<xsl:variable name="index" select="@index"/>
	<name>
	<xsl:choose>
				<xsl:when test="../b:subAccountTypeList/b:subAccountType[@index=$index] !='' and ../b:subAccountTypeList/b:subAccountType[@index=$index] = $subAccountNature and b:subAccount">
			<xsl:choose>
				<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
					<xsl:value-of select="concat(../b:shortNameList/b:shortName,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../b:mnemonic,'_',b:subAccount)"/>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:when>
			</xsl:choose>
		</name>
		</xsl:template>
		<xsl:template name="subAccount">
		<xsl:if test="b:subAccount">
		<subAccount>
			<xsl:value-of select="b:subAccount"/>
		</subAccount>
		</xsl:if>
		</xsl:template>
	<xsl:template name="userDefinedField_sub"/>
	<xsl:template name="mbFields_sub"/>
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