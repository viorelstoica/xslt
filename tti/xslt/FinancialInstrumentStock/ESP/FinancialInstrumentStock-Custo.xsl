<?xml version="1.0" encoding="UTF-8"?>
<!-- _@GVA$Date: 2024-05-17 11:55:37 +0200 (Fri, 17 May 2024) $@_   -->
<xsl:stylesheet exclude-result-prefixes="b c" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- END of protected area  -->
	<xsl:template name="infra:mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>status_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:secStatus='DEF'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:secStatus='DEL'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
						<xsl:when test="b:secStatus='SUS'">
							<xsl:value-of select="'150'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
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
				<infra:name>esma_indicator_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:esmaIndicator='YES'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:esmaIndicator='NO'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
				<infra:name>liquidity_indicator_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:liquidityIndicator='YES'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:liquidityIndicator='NO'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
				<infra:name>reportable_indicator_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:reportableIndicator='YES'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:reportableIndicator='NO'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
				<infra:name>leveraged_instr_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:leveragedInstrument='YES'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:leveragedInstrument='NO'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
				<infra:name>embedded_derivatives_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:embeddedDerivatives='YES'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:embeddedDerivatives='NO'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<infra:mbField>
				<infra:name>listing_indicator_e</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:quotedListedNo='QUOTED'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:quotedListedNo='LISTED'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:quotedListedNo='NO'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<xsl:if test="b:complexity = '1' or b:complexity = '2'">
				<infra:mbField>
					<infra:name>complexity_level_id.code</infra:name>
					<infra:value>
						<xsl:value-of select="b:complexity"/>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:issuerGroup[not(@index)] != ''">
				<infra:mbField>
					<infra:name>group_issuer_third_id.code</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="$ISSUER_PREFIX !='' and b:SCIssuerJoinId and b:SCIssuerJoinId != ''">
								<xsl:value-of select="concat($ISSUER_PREFIX ,b:issuerGroup[not(@index)])"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:issuerGroup[not(@index)])"/>
							</xsl:otherwise>
						</xsl:choose>
					</infra:value>
				</infra:mbField>
			</xsl:if>
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
			<xsl:choose>
				<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'UCITS'">
					<infra:mbField>
						<infra:name>ucits_f</infra:name>
						<infra:value>
							<xsl:value-of select="'1'"/>
						</infra:value>
						<infra:type>string</infra:type>
					</infra:mbField>
				</xsl:when>
				<xsl:otherwise>
					<infra:mbField>
						<infra:name>ucits_f</infra:name>
						<infra:value>
							<xsl:value-of select="'0'"/>
						</infra:value>
						<infra:type>string</infra:type>
					</infra:mbField>
				</xsl:otherwise>
			</xsl:choose>
			<infra:mbField>
				<infra:name>nonvoting_share_f</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:nonVotingShr='YES'">
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
