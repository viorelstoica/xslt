<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/AAAccountInterestUpdate" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b"
                version="1.0">
	<xsl:template name="benchmark">
		<benchmark>
			<infra:code>
				<xsl:value-of select="concat(b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinterestperiodicIndex,b:APPLICATIONAAARRANGEMENTACTIVITYDetails/b:applicationaaArrangementActivitycurrency)"/>
			</infra:code>
		</benchmark>
	</xsl:template>
	<xsl:template name="spreadRate">
		<userDefinedField>
			<infra:name>add_margin_p</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinterestmarginTypeSubGroup/b:propertycrinterestmarginOper = 'ADD'">
						<xsl:value-of select="b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinterestmarginTypeSubGroup/b:propertycrinterestmarginRate"/>
					</xsl:when>
					<xsl:when test="b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinterestmarginTypeSubGroup/b:propertycrinterestmarginOper = 'SUB'">
						<xsl:value-of select="(-1) *(b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinterestmarginTypeSubGroup/b:propertycrinterestmarginRate)"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="scheduledDate">
		<scheduledDate>
			<xsl:value-of select="b:APPLICATIONAAARRANGEMENTACTIVITYDetails/b:applicationaaArrangementActivityeffectiveDate"/>
		</scheduledDate>
	</xsl:template>
	<xsl:template name="validityDate">
		<validityDate>
			<xsl:value-of select="b:APPLICATIONAAARRANGEMENTACTIVITYDetails/b:applicationaaArrangementActivityeffectiveDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:APPLICATIONACCOUNTDetails/b:applicationaccountaccountNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="endDate"/>
	<xsl:template name="firstBenchmarkDate"/>
	<xsl:template name="firstResetDate"/>
	<xsl:template name="interestRate">
		<xsl:choose>
			<xsl:when test="b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinteresteffectiveRate != ''">
				<interestRate>
					<xsl:value-of select="b:PROPERTYCRINTERESTDetails/b:propertycrinterestfloatingIndexGroup/b:propertycrinteresteffectiveRate"/>
				</interestRate>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<infra:name>neg_bal_rate_p</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:PROPERTYDRINTERESTDetails/b:propertydrinterestperiodicRateGroup/b:propertydrinteresteffectiveRate != ''">
						<xsl:value-of select="b:PROPERTYDRINTERESTDetails/b:propertydrinterestperiodicRateGroup/b:propertydrinteresteffectiveRate"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</userDefinedField>
	</xsl:template>
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