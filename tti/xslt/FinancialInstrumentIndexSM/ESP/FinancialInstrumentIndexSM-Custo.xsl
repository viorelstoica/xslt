<?xml version="1.0" encoding="UTF-8"?>
<!-- _@GVA$Date: 2024-04-22 19:13:06 +0200 (Mon, 22 Apr 2024) $@_  -->
<!-- BEG - JPP20240412 - TSR-771166 - L3 Incorrect syntax in FinancialInstrumentIndexSM custo file -->
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- END - JPP20240412 - TSR-771166 - L3 Incorrect syntax in FinancialInstrumentIndexSM custo file -->
	<!-- Your existing templates here -->
	<!-- START of protected area  -->
	<!-- RNJ-MIR - ISIN for Index instruments -->
	<xsl:template name="infra:synonym">
		<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity"/>
		</xsl:call-template>
	</xsl:template>
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
			<!-- BEG - JPP20240412 - TSR-771166 - L3 Incorrect syntax in FinancialInstrumentIndexSM custo file -->
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
			<!-- END - JPP20240412 - TSR-771166 - L3 Incorrect syntax in FinancialInstrumentIndexSM custo file -->
			<xsl:if test="b:priipKiidLink != ''">
				<infra:mbField>
					<infra:name>kid_link</infra:name>
					<infra:value>
						<xsl:value-of select="b:priipKiidLink"/>
					</infra:value>
				</infra:mbField>
			</xsl:if>
		</infra:mbFields>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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