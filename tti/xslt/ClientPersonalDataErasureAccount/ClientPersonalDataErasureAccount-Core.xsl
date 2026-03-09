<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/ClientPersonalDataErasure" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiClientPersonalDataErasure" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
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
	<xsl:template name="infra:shortName">
		<xsl:variable name="acctTitle2">
			<xsl:for-each select="b:recordIdGroup[@index=1]/b:fieldNameSubGroup">
				<xsl:choose>
					<xsl:when test="b:fieldName = 'ACCOUNT.TITLE.2'">
						<xsl:if test="b:fieldName = 'ACCOUNT.TITLE.2' and b:newFieldValue">
							<xsl:value-of select="b:newFieldValue"/>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="acctTitle1">
			<xsl:for-each select="b:recordIdGroup[@index=1]/b:fieldNameSubGroup">
				<xsl:choose>
					<xsl:when test="b:fieldName = 'ACCOUNT.TITLE.1'">
						<xsl:if test="b:fieldName = 'ACCOUNT.TITLE.1' and b:newFieldValue">
							<xsl:value-of select="b:newFieldValue"/>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
				<xsl:choose>
					<xsl:when test="$acctTitle1 and $acctTitle2 != ''">
						<infra:shortName>
							<xsl:value-of select="$acctTitle1"/>
							<xsl:value-of select="'/'"/>
							<xsl:value-of select="$acctTitle2"/>
						</infra:shortName>
					</xsl:when>
					<xsl:otherwise>
						<infra:shortName>
							<xsl:value-of select="$acctTitle1"/>
						</infra:shortName>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="b:recordIdGroup[@index=1]/b:fieldNameSubGroup">
					<xsl:choose>
						<xsl:when test="b:fieldName = 'MNEMONIC'">
							<xsl:if test="b:fieldName = 'MNEMONIC' and b:newFieldValue">
								<infra:shortName>
									<xsl:value-of select="b:newFieldValue"/>
								</infra:shortName>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="active"/>
	<xsl:template name="referenceCurrency"/>
	<xsl:template name="type"/>
	<xsl:template name="openingDate"/>
	<xsl:template name="closingDate"/>
	<xsl:template name="client"/>
	<xsl:template name="infra:businessEntity"/>
	<xsl:template name="infra:mainBusinessEntity"/>
	<xsl:template name="infra:role"/>
	<xsl:template name="infra:type"/>
	<xsl:template name="instrument"/>
	<xsl:template name="suspenseAccount"/>
	<xsl:template name="infra:longName"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="infra:mbFields_becompo"/>
	<xsl:template name="accrualRule"/>
	<xsl:template name="accruedInterestCalculation"/>
	<xsl:template name="accruedInterestRoundingRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="interestAccrualDate"/>
	<xsl:template name="eomConvention"/>
	<xsl:template name="parentCashAccount"/>
	<xsl:template name="portfolio"/>
	<xsl:template name="witholdingTax"/>
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