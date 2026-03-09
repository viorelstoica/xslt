<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">
	<xsl:template name="benchmark">
		<benchmark>
			<infra:code>
				<xsl:value-of select="concat(a:periodicIndex,../../c:recarrangement/i:currency)"/>
			</infra:code>
		</benchmark>
	</xsl:template>
	<xsl:template name="endDate"/>
	<xsl:template name="firstBenchmarkDate"/>
	<xsl:template name="firstResetDate"/>
	<xsl:template name="interestRate">
		<interestRate>
			<xsl:choose>
				<xsl:when test="contains(a:marginOper ,'!')">
					<xsl:value-of select="a:effectiveRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="a:periodicRate">
							<xsl:value-of select="a:periodicRate"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="a:effectiveRate"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</interestRate>
	</xsl:template>
	<xsl:template name="maximumRate"/>
	<xsl:template name="minimumRate"/>
	<xsl:template name="resetFrequencyNumber"/>
	<xsl:template name="resetFrequencyUnit"/>
	<xsl:template name="spreadRate">
		<spreadRate>
			<xsl:choose>
				<xsl:when test="contains(a:marginOper ,'!')">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="a:marginOper = 'ADD'">
							<xsl:value-of select="a:marginRate"/>
						</xsl:when>
						<xsl:when test="a:marginOper = 'SUB'">
							<xsl:value-of select="format-number(-1 * a:marginRate,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</spreadRate>
	</xsl:template>
	<xsl:template name="scheduledDate">
		<scheduledDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="substring(../a:idComp3,1,8)"/>
			</xsl:call-template>
		</scheduledDate>
	</xsl:template>
	<xsl:template name="validityDate">
		<validityDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="substring(../a:idComp3,1,8)"/>
			</xsl:call-template>
		</validityDate>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
						<xsl:value-of select="concat(../../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../../c:aatxncontext/b:aaCompanyMnemonic)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../../c:aatxncontext/b:aaArrangementId"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</instrument>
	</xsl:template>

	<xsl:template name="userDefinedField">
		<xsl:if test="../a:rfrConvention">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'market_conv_method_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="../a:rfrConvention = 'LOOKBACK'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="../a:rfrLookbackDays">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'lookback_days_n'"/>
				</infra:name>
				<infra:value>
					<xsl:value-of select="../a:rfrLookbackDays"/>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="../a:rfrLookbackType">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'lookback_conv_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="../a:rfrLookbackType='NARROW'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="../a:rfrLookbackType='OBSERVATION.SHIFT'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="../a:rfrSpreadTreatment">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'spread_inclusive_f'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="../a:rfrSpreadTreatment = 'EXCLUSIVE'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="../a:rfrSpreadTreatment ='INCLUSIVE'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="../a:rfrCalcMethod">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'compound_freq_n'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="../a:rfrCalcMethod='COMPOUND'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="../a:rfrCalcMethod">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'compound_freq_unit_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="../a:rfrCalcMethod='COMPOUND'">
							<xsl:value-of select="'Day'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="../a:rfrCalcMethod">
			<userDefinedField>
				<infra:name>
					<xsl:value-of select="'comp_conv_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="../a:rfrCalcMethod='COMPOUND'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</userDefinedField>
		</xsl:if>
	</xsl:template>
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