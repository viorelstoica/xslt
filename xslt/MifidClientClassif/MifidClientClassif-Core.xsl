<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MifidClientClassif" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMifidClientClassif" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c" version="1.0">
	<xsl:template name="code">
		<code>
			<xsl:if test="b:id != ''">
				<xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
			</xsl:if>
		</code>
	</xsl:template>
	<xsl:template name="shortName"/>
	<xsl:template name="longName"/>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="active">
    <active>1</active>
    </xsl:template>
	<xsl:template name="beginDate"/>
	<xsl:template name="businessEntityComposition"/>
	<xsl:template name="currency"/>
	<xsl:template name="emailAddress"/>
	<xsl:template name="faxNumber"/>
	<xsl:template name="language"/>
	<xsl:template name="phoneNumber"/>
	<xsl:template name="rating"/>
	<xsl:template name="residenceCountry"/>
	<xsl:template name="sector"/>
	<xsl:template name="taxationCountry"/>
	<xsl:template name="type"/>
	<xsl:template name="clientRole"/>
	<xsl:template name="custodianRole"/>
	<xsl:template name="synonym"/>
	<xsl:template name="notepad"/>
	<xsl:template name="intermediaryRole"/>
	<xsl:template name="islamicCompliance"/>
	<xsl:template name="issuerRole"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="thirdPartyGroup"/>
	<xsl:template name="manager"/>
	<xsl:template name="externalBank"/>
	<xsl:template name="classification">
		<classification>
			<xsl:choose>
				<xsl:when test="b:classification='RETAIL'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:classification='PROFESSIONAL'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:classification='PROFESSIONAL.ON.REQUEST'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="b:classification='ELIGIBLE.COUNTERPARTY'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="b:classification='INSTITUTIONAL'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
			</xsl:choose>
		</classification>
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