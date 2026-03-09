<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MIFID" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMIFID" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMIFID" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="allowedInvestor">
		<xsl:call-template name="allowedInvestor_retail"/>
		<xsl:call-template name="allowedInvestor_professional"/>
		<xsl:call-template name="allowedInvestor_eligible_counterparty"/>
		<xsl:call-template name="allowedInvestor_custom"/>
	</xsl:template>
	<xsl:template name="allowedInvestor_retail">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA allowedInvestor_RETAIL'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'RETAIL'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[starts-with(., 'RETAIL^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:allowedInvestorList/b:allowedInvestor[starts-with(., 'RETAIL^')][1],'RETAIL^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[. = 'RETAIL'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'RETAIL'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="allowedInvestor_professional">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA allowedInvestor_PROFESSIONAL'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'PROFESSIONAL'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<!-- NEUTRAL condition -->
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[
					. = 'PROFESSIONAL^NEUTRAL' or 
					. = 'PROFPERSE.PROFESSIONAL^NEUTRAL' or 
					. = 'ELECTIVEPROF.PROFESSIONAL^NEUTRAL' or 
					. = 'BOTH.PROFESSIONAL^NEUTRAL'
				]">
							<xsl:value-of select="'NEUTRAL'"/>
						</xsl:when>
						<!-- YES condition -->
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[
					. = 'PROFESSIONAL^YES' or 
					. = 'PROFPERSE.PROFESSIONAL^YES' or 
					. = 'ELECTIVEPROF.PROFESSIONAL^YES' or 
					. = 'BOTH.PROFESSIONAL^YES'
				]">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<!-- NO condition -->
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[
					. = 'PROFESSIONAL^NO' or 
					. = 'PROFPERSE.PROFESSIONAL^NO' or 
					. = 'ELECTIVEPROF.PROFESSIONAL^NO' or 
					. = 'BOTH.PROFESSIONAL^NO'
				]">
							<xsl:value-of select="'NO'"/>
						</xsl:when>
						<!-- Default -->
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'PROFESSIONAL'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="allowedInvestor_eligible_counterparty">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA allowedInvestor_ELIGIBLE_COUNTERPARTY'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'ELIGIBLE_COUNTERPARTY'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[starts-with(., 'ELIGIBLE.COUNTERPARTY^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:allowedInvestorList/b:allowedInvestor[starts-with(., 'ELIGIBLE.COUNTERPARTY^')][1],'ELIGIBLE.COUNTERPARTY^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:allowedInvestorList/b:allowedInvestor[. = 'ELIGIBLE.COUNTERPARTY'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'ELIGIBLE_COUNTERPARTY'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="allowedInvestor_custom"/>
	<xsl:template name="investTenor">
		<xsl:call-template name="investTenor_tenor_veryshort"/>
		<xsl:call-template name="investTenor_tenor_short"/>
		<xsl:call-template name="investTenor_tenor_medium"/>
		<xsl:call-template name="investTenor_tenor_long"/>
		<xsl:call-template name="investTenor_custom"/>
	</xsl:template>
	<xsl:template name="investTenor_tenor_veryshort">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_VERYSHORT'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_VERYSHORT'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor = 'VERYSHORT^YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'VERYSHORT^NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'VERYSHORT^NEUTRAL'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_tenor_short">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_SHORT'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_SHORT'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor = 'SHORT^YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'SHORT^NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'SHORT^NEUTRAL'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_tenor_medium">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_MEDIUM'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_MEDIUM'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor = 'MEDIUM^YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'MEDIUM^NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'MEDIUM^NEUTRAL'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_tenor_long">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_LONG'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_LONG'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="starts-with(b:id, 'DX*')">
							<xsl:value-of select="translate(b:id, 'DX*', '')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider"/>
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor = 'LONG^YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'LONG^NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:investTenorList/b:investTenor = 'LONG^NEUTRAL'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_custom"/>
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