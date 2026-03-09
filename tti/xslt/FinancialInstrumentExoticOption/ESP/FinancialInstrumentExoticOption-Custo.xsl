<?xml version="1.0" encoding="UTF-8"?>
<!-- _@GVA$Date: 2024-05-17 11:55:37 +0200 (Fri, 17 May 2024) $@_   -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOption" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOption" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                exclude-result-prefixes="b c ns0" version="1.0">
	<!-- START of protected area  -->

	<xsl:template name="mbFields">
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

			<!-- BEG - JPP20240512 - TSR-806283/TSR-771166 - correct old custo L3 for Instruments - field kid_eligible_f (type PRIIP, UCITS or FinSA) -->
			<xsl:choose>
				<xsl:when test="b:dxContractMasterInstrumentTypeGroup/b:dxContractMasterInstrumentType = 'PRIIP' or b:dxContractMasterInstrumentTypeGroup/b:dxContractMasterInstrumentType = 'UCITS' or b:dxContractMasterInstrumentTypeGroup/b:dxContractMasterInstrumentType = 'FinSA' ">
					<infra:mbField>
						<infra:name>kid_eligible_f</infra:name>
						<infra:value>
							<xsl:value-of select="'1'"/>
						</infra:value>
					</infra:mbField>
				</xsl:when>
				<xsl:otherwise>
					<infra:mbField>
						<infra:name>kid_eligible_f</infra:name>
						<infra:value>
							<xsl:value-of select="'0'"/>
						</infra:value>
					</infra:mbField>
				</xsl:otherwise>
			</xsl:choose>
			<!-- END - JPP20240512 - TSR-806283/TSR-771166 - correct old custo L3 for Instruments - field kid_eligible_f (type PRIIP, UCITS or FinSA) -->

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

	<!-- END of protected area  -->
</xsl:stylesheet>
