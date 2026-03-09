<?xml version="1.0" encoding="UTF-8"?>
<!-- _@GVA$Date: 2024-05-17 11:55:37 +0200 (Fri, 17 May 2024) $@_   -->
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentFutureContractMaster" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentFutureContractMaster" exclude-result-prefixes="b c ns0" version="1.0">

	<!-- START of protected area  -->
	<!-- END of protected area  -->

<xsl:template name="infra:mbFields">
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

			<!-- BEG - JPP20240512 - TSR-806283/TSR-771166 - correct old custo L3 for Instruments - field kid_eligible_f (type PRIIP, UCITS or FinSA) -->
			<xsl:choose>
				<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'PRIIP' or b:instrumentTypeGroup/b:instrumentType = 'UCITS' or b:instrumentTypeGroup/b:instrumentType = 'FinSA' ">
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


</xsl:stylesheet>
