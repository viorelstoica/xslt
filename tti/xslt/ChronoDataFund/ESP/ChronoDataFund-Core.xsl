<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ChronologicalDataFixedIncome"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchChronologicalDataFixedIncome" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiChronologicalDataFixedIncome" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiChronologicalDataFixedIncome" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="active">
		<active>
			<xsl:choose>
				<xsl:when test="b:statusDate and  b:secStatus = 'SUS' and translate(b:statusDate,'-','') &lt;= translate(b:eventCommon/ns0:today,'-','')">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:blockingDate != ''">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'1'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="issueQuantity">
		<issueQuantity>
			<xsl:value-of select="b:totalIssued"/>
		</issueQuantity>
	</xsl:template>


	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="dataNature">
		<dataNature>
			<xsl:value-of select="'5'"/>
		</dataNature>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validity">
		<validity>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</validity>
	</xsl:template>
	<xsl:template name="value">
		<value>
			<xsl:value-of select="b:totalIssued"/>
		</value>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="valueType"/>
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