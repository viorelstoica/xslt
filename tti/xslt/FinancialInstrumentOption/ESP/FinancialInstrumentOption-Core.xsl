<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentOption" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentOption"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:template name="infra:mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>instr_fatca_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:dxContractMasterJoinFatcaApplicable='NO'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="b:dxContractMasterJoinFatcaApplicable='US SECURITY'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:dxContractMasterJoinFatcaApplicable='US GRANDFATHERED'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:dxContractMasterJoinFatcaApplicable='SHORT TERM OBLIGATION'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
					<infra:name>ucits_f</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="b:dxContractMasterInstrumentTypeGroup/b:dxContractMasterInstrumentType = 'UCITS'">
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
					<infra:name>kid_eligible_f</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="b:dxContractMasterInstrumentTypeGroup/b:dxContractMasterInstrumentType = 'PRIIP'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			<xsl:if test="b:priipKiidLink != ''">
				<infra:mbField>
					<infra:name>kid_link</infra:name>
					<infra:value>
						<xsl:value-of select="b:priipKiidLink"/>
					</infra:value>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:ucitsKiidLink != ''">
				<infra:mbField>
					<infra:name>kiid_link</infra:name>
					<infra:value>
						<xsl:value-of select="b:ucitsKiidLink"/>
					</infra:value>
				</infra:mbField>
			</xsl:if>
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