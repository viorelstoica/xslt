<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDepositsOldNew" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDepositsOldNew" exclude-result-prefixes="b c" version="1.0">
	<xsl:template name="benchmark">
		<benchmark>
			<infra:code>
					<xsl:choose>
						<xsl:when test="b:rfrCalcMethod = 'SIMPLE' and b:intRate = '3'">
							<xsl:value-of select="concat(b:interestKey,b:currency,'F')"/>
						</xsl:when>
						<xsl:when test="b:rfrCalcMethod = 'SIMPLE' and b:intRateType = '2'">
							<xsl:value-of select="concat(b:interestKey,b:currency)"/>
						</xsl:when>
					</xsl:choose>
			</infra:code>
		</benchmark>
	</xsl:template>
	<xsl:template name="spreadRate">
		<spreadRate>
			<xsl:choose>
				<xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestSpread = '' or not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestKey)">
					<xsl:value-of select="b:interestSpread"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:newSpread"/>
				</xsl:otherwise>
			</xsl:choose>
		</spreadRate>
	</xsl:template>
	<xsl:template name="scheduledDate">
		<scheduledDate>
			<xsl:choose>
				<xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestSpread = '' or not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestSpread)">
					<xsl:if test="string-length(b:valueDate) = '8'">
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="b:valueDate"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="string-length(b:valueDate) != '8'">
						<xsl:value-of select="b:valueDate"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="string-length(b:spreadVDate) = '8'">
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="b:spreadVDate"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="string-length(b:spreadVDate) != '8'">
						<xsl:value-of select="b:spreadVDate"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</scheduledDate>
	</xsl:template>
	<xsl:template name="validityDate">
		<validityDate>
			<xsl:choose>
				<xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestSpread = '' or not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestSpread)">
					<xsl:if test="string-length(b:valueDate) = 8">
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="b:valueDate"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="string-length(b:valueDate) != 8">
						<xsl:value-of select="b:valueDate"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="string-length(b:spreadVDate) = 8">
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="b:spreadVDate"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="string-length(b:spreadVDate) != 8">
						<xsl:value-of select="b:spreadVDate"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</validityDate>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<xsl:if test="b:rfrConvention">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'market_conv_method_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:rfrConvention = 'LOOKBACK'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:rfrLookBackDays">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'lookback_days_n'"/>
				</infra:name>
				<infra:value>
					<xsl:value-of select="b:rfrLookBackDays"/>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:rfrLookBackType">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'lookback_conv_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:rfrLookBackType = 'NARROW'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:rfrLookBackType = 'OBSERVATION.SHIFT'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:rfrSpreadTreatment">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'spread_inclusive_f'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:rfrSpreadTreatment = 'EXCLUSIVE'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="b:rfrSpreadTreatment = 'INCLUSIVE'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:rfrCalcMethod">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'compound_freq_n'"/>
				</infra:name>
				<infra:value>
					<xsl:if test="b:rfrCalcMethod = 'COMPOUND'">
						<xsl:value-of select="'1'"/>
					</xsl:if>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:rfrCalcMethod">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'compound_freq_unit_e'"/>
				</infra:name>
				<infra:value>
					<xsl:if test="b:rfrCalcMethod = 'COMPOUND'">
						<xsl:value-of select="'1'"/>
					</xsl:if>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:rfrCalcMethod">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'comp_conv_e'"/>
				</infra:name>
				<infra:value>
					<xsl:if test="b:rfrCalcMethod = 'COMPOUND'">
						<xsl:value-of select="'1'"/>
					</xsl:if>
				</infra:value>
			</userDefinedField>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate"/>
	<xsl:template name="firstBenchmarkDate"/>
	<xsl:template name="firstResetDate"/>
	<xsl:template name="interestRate"/>
	<xsl:template name="maximumRate"/>
	<xsl:template name="minimumRate"/>
	<xsl:template name="resetFrequencyNumber"/>
	<xsl:template name="resetFrequencyUnit"/>
	<xsl:template name="mbFields"/>
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