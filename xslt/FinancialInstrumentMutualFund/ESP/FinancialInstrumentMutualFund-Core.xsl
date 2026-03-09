<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="infra:mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>pension_f</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'PENSIONPLAN'">
							<xsl:value-of select=" '1' "/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select=" '0' "/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
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
						<xsl:when test="b:secStatus='TRADABLE'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:secStatus='NON.TRADABLE'">
							<xsl:value-of select="'3'"/>
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
			<xsl:if test="b:traspasosAllow">
				<infra:mbField>
					<infra:name>traspasos_f</infra:name>
					<infra:value>
						<xsl:choose>
						<xsl:when test="b:traspasosAllow='YES'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:traspasosAllow='NO'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
					</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:minInvtCcyGroup/b:minSubsInvt != ''">
				<infra:mbField>
					<infra:name>min_add_amt_m</infra:name>
					<infra:value>
						<xsl:value-of select="b:minInvtCcyGroup/b:minSubsInvt"/>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'Retail' ">
				<infra:mbField>
					<infra:name>retail_investor_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Retail']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Retail']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Retail']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'Professional' ">
				<infra:mbField>
					<infra:name>professional_investor_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Professional']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Professional']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Professional']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
            <xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'Eligible.Counterparty' ">
				<infra:mbField>
					<infra:name>eligible_counterparty_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Eligible.Counterparty']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Eligible.Counterparty']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Eligible.Counterparty']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'Knowledge.And.Experience' ">
				<infra:mbField>
					<infra:name>investor_classification_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Knowledge.And.Experience']/b:instClassification,$lowercase,$uppercase) = 'BASIC INVESTOR'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Knowledge.And.Experience']/b:instClassification,$lowercase,$uppercase) = 'INFORMED INVESTOR'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Knowledge.And.Experience']/b:instClassification,$lowercase,$uppercase) = 'ADVANCED INVESTOR'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'No.Capital.Loss' ">
				<infra:mbField>
					<infra:name>no_cap_loss_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'No.Capital.Loss']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'No.Capital.Loss']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'No.Capital.Loss']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'No.Captial.Guarantee' ">
				<infra:mbField>
					<infra:name>no_cap_guarantee_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'No.Captial.Guarantee']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'No.Captial.Guarantee']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'No.Captial.Guarantee']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'Loss.Beyond.Captial' ">
				<infra:mbField>
					<infra:name>loss_beyond_cap_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Loss.Beyond.Captial']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Loss.Beyond.Captial']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Loss.Beyond.Captial']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
			<xsl:if test="b:instrumentTypeGroup/b:instrumentType = 'Limited.Capital.Loss' ">
				<infra:mbField>
					<infra:name>lim_cap_loss_e</infra:name>
					<infra:value>
						<xsl:choose>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Limited.Capital.Loss']/b:instClassification,$lowercase,$uppercase) = 'YES'">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Limited.Capital.Loss']/b:instClassification,$lowercase,$uppercase) = 'NO'">
								<xsl:value-of select="'2'"/>
							</xsl:when>
							<xsl:when test="translate(b:instrumentTypeGroup[b:instrumentType = 'Limited.Capital.Loss']/b:instClassification,$lowercase,$uppercase) = 'NEUTRAL'">
								<xsl:value-of select="'3'"/>
							</xsl:when>
						</xsl:choose>
					</infra:value>
					<infra:type>string</infra:type>
				</infra:mbField>
			</xsl:if>
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
			<infra:mbField>
				<infra:name>complexity_level_id.code</infra:name>
				<infra:value>
					<xsl:value-of select="b:complexity"/>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
			<xsl:if test="b:issuerGroup[not(@index)] != ''">
				<infra:mbField>
					<infra:name>group_issuer_third_id.code</infra:name>
					<infra:value>
						<xsl:value-of select="b:issuerGroup[not(@index)]"/>
					</infra:value>
				</infra:mbField>
			</xsl:if>
			<xsl:choose>
			<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'PRIIP' ">
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

	<xsl:template name="issueQuantity">
		<xsl:if test="b:totalIssued != ''">
			<issueQuantity>
				<xsl:value-of select="b:totalIssued"/>
			</issueQuantity>
		</xsl:if>
	</xsl:template>

	<xsl:template name="mappingRatingAttribution">
	<xsl:variable name="index">
		<xsl:choose>
			<xsl:when test="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:riskTypeIndGroup">
				<xsl:for-each select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:riskTypeIndGroup">
					<xsl:if test="position()=last()">
						<xsl:value-of select="@index"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:riskTypeIndGroup)">
				<xsl:value-of select="'0'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
		<xsl:for-each select="b:riskTypeIndGroup">
		<xsl:if test="(@index &gt; $index)">
			<xsl:if test="b:riskTypeInd = 'SRI'">
				<RatingAttribution>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentMutualFund.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code_SRI"/>
					<xsl:call-template name="agency_SRI"/>
					<xsl:call-template name="instrument_SRI"/>
					<xsl:call-template name="validityDate_SRI"/>
					<xsl:call-template name="mbFields_SRI"/>
				</RatingAttribution>
			</xsl:if>
			<xsl:if test="b:riskTypeInd = 'MRM'">
				<RatingAttribution>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentMutualFund.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code_MRM"/>
					<xsl:call-template name="agency_MRM"/>
					<xsl:call-template name="instrument_MRM"/>
					<xsl:call-template name="validityDate_MRM"/>
					<xsl:call-template name="mbFields_MRM"/>
				</RatingAttribution>
			</xsl:if>
			<xsl:if test="b:riskTypeInd = 'CRM'">
				<RatingAttribution>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentMutualFund.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code_CRM"/>
					<xsl:call-template name="agency_CRM"/>
					<xsl:call-template name="instrument_CRM"/>
					<xsl:call-template name="validityDate_CRM"/>
					<xsl:call-template name="mbFields_CRM"/>
				</RatingAttribution>
			</xsl:if>
			<xsl:if test="b:riskTypeInd = 'SRRI'">
				<RatingAttribution>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentMutualFund.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code_SRRI"/>
					<xsl:call-template name="agency_SRRI"/>
					<xsl:call-template name="instrument_SRRI"/>
					<xsl:call-template name="validityDate_SRRI"/>
					<xsl:call-template name="mbFields_SRRI"/>
				</RatingAttribution>
			</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="code_SRI">
		<code>
			<xsl:choose>
				<xsl:when test="b:regRiskLevel = '1'">
					<xsl:value-of select="'VeryLow/1'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '2'">
					<xsl:value-of select="'Low/2'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '3'">
					<xsl:value-of select="'MediumLow/3'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '4'">
					<xsl:value-of select="'Medium/4'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '5'">
					<xsl:value-of select="'MediumHigh/5'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '6'">
					<xsl:value-of select="'High/6'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '7'">
					<xsl:value-of select="'VeryHigh/7'"/>
				</xsl:when>
			</xsl:choose>
		</code>
	</xsl:template>
	<xsl:template name="agency_SRI">
		<agency>
			<xsl:value-of select="'PCK_MB_EUR_SRI'"/>
		</agency>
	</xsl:template>
	<xsl:template name="instrument_SRI">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validityDate_SRI">
		<validityDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="mbFields_SRI"/>

	<xsl:template name="code_MRM">
		<code>
			<xsl:choose>
				<xsl:when test="b:regRiskLevel = '1'">
					<xsl:value-of select="'VeryLow/1'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '2'">
					<xsl:value-of select="'Low/2'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '3'">
					<xsl:value-of select="'MediumLow/3'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '4'">
					<xsl:value-of select="'Medium/4'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '5'">
					<xsl:value-of select="'MediumHigh/5'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '6'">
					<xsl:value-of select="'High/6'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '7'">
					<xsl:value-of select="'VeryHigh/7'"/>
				</xsl:when>
			</xsl:choose>
		</code>
	</xsl:template>
	<xsl:template name="agency_MRM">
		<agency>
			<xsl:value-of select="'PCK_MB_EUR_MRM'"/>
		</agency>
	</xsl:template>
	<xsl:template name="instrument_MRM">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validityDate_MRM">
		<validityDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="mbFields_MRM"/>

	<xsl:template name="code_CRM">
		<code>
			<xsl:choose>
				<xsl:when test="b:regRiskLevel = '1'">
					<xsl:value-of select="'Low/1'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '2'">
					<xsl:value-of select="'MediumLow/2'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '3'">
					<xsl:value-of select="'Medium/3'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '4'">
					<xsl:value-of select="'MediumHigh/4'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '5'">
					<xsl:value-of select="'High/5'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '6'">
					<xsl:value-of select="'VeryHigh/6'"/>
				</xsl:when>
			</xsl:choose>
		</code>
	</xsl:template>
	<xsl:template name="agency_CRM">
		<agency>
			<xsl:value-of select="'PCK_MB_EUR_CRM'"/>
		</agency>
	</xsl:template>
	<xsl:template name="instrument_CRM">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validityDate_CRM">
		<validityDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="mbFields_CRM"/>

	<xsl:template name="code_SRRI">
		<code>
			<xsl:choose>
				<xsl:when test="b:regRiskLevel = '1'">
					<xsl:value-of select="'VeryLow/1'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '2'">
					<xsl:value-of select="'Low/2'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '3'">
					<xsl:value-of select="'MediumLow/3'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '4'">
					<xsl:value-of select="'Medium/4'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '5'">
					<xsl:value-of select="'MediumHigh/5'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '6'">
					<xsl:value-of select="'High/6'"/>
				</xsl:when>
				<xsl:when test="b:regRiskLevel = '7'">
					<xsl:value-of select="'VeryHigh/7'"/>
				</xsl:when>
			</xsl:choose>
		</code>
	</xsl:template>
	<xsl:template name="agency_SRRI">
		<agency>
			<xsl:value-of select="'PCK_MB_EUR_SRRI'"/>
		</agency>
	</xsl:template>
	<xsl:template name="instrument_SRRI">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validityDate_SRRI">
		<validityDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="mbFields_SRRI"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="infra:mbFields"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->