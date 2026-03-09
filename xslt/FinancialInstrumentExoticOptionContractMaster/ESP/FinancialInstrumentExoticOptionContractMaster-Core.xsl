<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionContractMaster" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOptionContractMaster" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ex="http://exslt.org/dates-and-times" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c ex ns0" version="1.0">
	<xsl:template name="mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>instr_fatca_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:fatcaApplicable='NO'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="b:fatcaApplicable='US SECURITY'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:fatcaApplicable='US GRANDFATHERED'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:fatcaApplicable='SHORT TERM OBLIGATION'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
					<infra:name>kid_eligible_f</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'PRIIP'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
				<infra:mbField>
					<infra:name>ucits_f</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'UCITS'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
		</infra:mbFields>
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