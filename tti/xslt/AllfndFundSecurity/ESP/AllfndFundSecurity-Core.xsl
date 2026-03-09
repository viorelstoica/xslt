<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AllfndFundSecurity"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAllfndFundSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAllfndFundSecurity" xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAllfndFundSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="infra:mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>ucits_f</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="((b:ucitsFund = 'Y') or (b:ucitsFund = 'S')) ">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:ucitsFund = 'N'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'2'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
		</infra:mbFields>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="FundsCatalogue_code"/>
	<xsl:template name="FundsCatalogue_synonym"/>
	<xsl:template name="FundsCatalogue_shortName"/>
	<xsl:template name="FundsCatalogue_longName"/>
	<xsl:template name="FundsCatalogue_multilingualLongName"/>
	<xsl:template name="FundsCatalogue_notepad"/>
	<xsl:template name="FundsCatalogue_userDefinedField"/>
	<xsl:template name="FundsCatalogue_mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>recomm_holding_freq_e</infra:name>
				<infra:value>1</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
		</infra:mbFields>
	</xsl:template>
	<xsl:template name="FundsCatalogue_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="FundsCatalogue_initialShares">
		<initialShares>
			<xsl:value-of select="b:initialShares"/>
		</initialShares>
	</xsl:template>
	<xsl:template name="FundsCatalogue_additionalShares">
		<additionalShares>
			<xsl:value-of select="b:additionalShares"/>
		</additionalShares>
	</xsl:template>
	<xsl:template name="FundsCatalogue_maximumAmount">
		<maximumAmount>
			<xsl:value-of select="b:maximumAmount"/>
		</maximumAmount>
	</xsl:template>
	<xsl:template name="FundsCatalogue_maximumShares">
		<maximumShares>
			<xsl:value-of select="b:maximumShares"/>
		</maximumShares>
	</xsl:template>
	<xsl:template name="FundsCatalogue_decimalsForShares">
		<decimalsForShares>
			<xsl:value-of select="b:decimalShares"/>
		</decimalsForShares>
	</xsl:template>
	<xsl:template name="FundsCatalogue_decimalsForAmount">
		<decimalsForAmount>
			<xsl:value-of select="b:decimalAmount"/>
		</decimalsForAmount>
	</xsl:template>
	<xsl:template name="FundsCatalogue_decimalsForPrice">
		<decimalsForPrice>
			<xsl:value-of select="b:priceDecimals"/>
		</decimalsForPrice>
	</xsl:template>
	<xsl:template name="FundsCatalogue_RecomHoldingPeriod">
		<RecomHoldingPeriod>
			<xsl:value-of select="b:tgtNeedCus"/>
		</RecomHoldingPeriod>
	</xsl:template>
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