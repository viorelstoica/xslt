<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ClientPersonalDataErasure"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiClientPersonalDataErasure" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c ns0" version="1.0">

	<xsl:template name="infra:code">
	<xsl:variable name="RecordID" select="b:recordIdGroup[@index=1]/b:recordId"/>
		<xsl:choose>
			<xsl:when test="contains($RecordID,';')">
				<infra:code>
					<xsl:value-of select="substring-before($RecordID,';')"/>
				</infra:code>
			</xsl:when>
			<xsl:otherwise>
				<infra:code>
					<xsl:value-of select="b:recordIdGroup[@index=1]/b:recordId"/>
				</infra:code>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:shortName">
	<xsl:choose>
			<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
				<xsl:for-each select="b:recordIdGroup[@index=1]/b:fieldNameSubGroup">
					<xsl:choose>
						<xsl:when test="b:fieldName = 'ACCOUNT.NAME'">
							<xsl:if test="b:fieldName = 'ACCOUNT.NAME' and b:newFieldValue">
								<infra:shortName>
									<xsl:value-of select="b:newFieldValue"/>
								</infra:shortName>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="RecordID" select="b:recordIdGroup[@index=1]/b:recordId"/>
				<xsl:choose>
					<xsl:when test="contains($RecordID,';')">
						<infra:shortName>
							<xsl:value-of select="substring-before($RecordID,';')"/>
						</infra:shortName>
					</xsl:when>
					<xsl:otherwise>
						<infra:shortName>
							<xsl:value-of select="b:recordIdGroup[@index=1]/b:recordId"/>
						</infra:shortName>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:template>
	<xsl:template name="infra:longName">
	<xsl:choose>
			<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
				<xsl:for-each select="b:recordIdGroup[@index=1]/b:fieldNameSubGroup">
					<xsl:choose>
						<xsl:when test="b:fieldName = 'ACCOUNT.NAME'">
							<xsl:if test="b:fieldName = 'ACCOUNT.NAME' and b:newFieldValue">
								<infra:longName>
									<xsl:value-of select="b:newFieldValue"/>
								</infra:longName>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="RecordID" select="b:recordIdGroup[@index=1]/b:recordId"/>
				<xsl:choose>
					<xsl:when test="contains($RecordID,';')">
						<infra:longName>
							<xsl:value-of select="substring-before($RecordID,';')"/>
						</infra:longName>
					</xsl:when>
					<xsl:otherwise>
						<infra:longName>
							<xsl:value-of select="b:recordIdGroup[@index=1]/b:recordId"/>
						</infra:longName>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="managementType"/>
	<xsl:template name="status"/>
	<xsl:template name="active">
		<active>
		<xsl:value-of select="'0'"/>
		</active>
	</xsl:template>
	<xsl:template name="businessEntityComposition"/>
	<xsl:template name="client"/>
	<xsl:template name="managementBeginDate"/>
	<xsl:template name="managementEndDate"/>	
	<xsl:template name="ownership"/>
	<xsl:template name="parentChildIndicator">
		<parentChildIndicator>1</parentChildIndicator>
	</xsl:template>
	<xsl:template name="paymentInstruction"/>
	<xsl:template name="performanceCurrency"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="relationshipManager"/>
	<xsl:template name="reportingLanguage"/>
	<xsl:template name="marginLending"/>
	<xsl:template name="cashBookingModel"/>
	<xsl:template name="serviceType"/>
	<xsl:template name="trailerFeeEligibility"/>
	<xsl:template name="trailerFeePercentage"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="creditStatus"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="nature"/>
	<xsl:template name="parentPortfolio"/>
	<xsl:template name="performanceDataStorageFrequency"/>
	<xsl:template name="performanceDataStorageUnit"/>
	<xsl:template name="performanceDetailLevel"/>
	<xsl:template name="portfolioGroup"/>
	<xsl:template name="portfolioType"/>
	<xsl:template name="positionManagementDate"/>
	<xsl:template name="positionManagementLevel"/>
	<xsl:template name="positionManagementRule"/>
	<xsl:template name="sharia"/>
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