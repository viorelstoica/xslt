<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c ns0" version="1.0" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MifidClientClassif"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMifidClientClassif" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="mbFields">
		<mbFields>
			<mbField>
				<name>personal_expenses_m</name>
				<value>
					<xsl:value-of select="b:finCommitGroup[b:finCommit='PERSONALEXP']/b:valFinCommit"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>fin_commitments_m</name>
				<value>
					<xsl:value-of select="b:finCommitGroup[b:finCommit='FC']/b:valFinCommit"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>bank_deposit_m</name>
				<value>
					<xsl:value-of select="b:assetsHeldGroup[b:assetsHeld='CASHWITH']/b:valueAssets"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>external_deposit_m</name>
				<value>
					<xsl:value-of select="b:assetsHeldGroup[b:assetsHeld='CASHOUTSIDEBANK']/b:valueAssets"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>bank_fin_assets_m</name>
				<value>
					<xsl:value-of select="b:assetsHeldGroup[b:assetsHeld='FA']/b:valueAssets"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>external_fin_assets_m</name>
				<value>
					<xsl:value-of select="b:assetsHeldGroup[b:assetsHeld='FAFB']/b:valueAssets"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>total_insurance_m</name>
				<value>
					<xsl:value-of select="b:assetsHeldGroup[b:assetsHeld='INS']/b:valueAssets"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>other_assets_m</name>
				<value>
					<xsl:value-of select="b:assetsHeldGroup[b:assetsHeld='PROPERTY']/b:valueAssets"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>total_liability_m</name>
				<value>
					<xsl:value-of select="b:finCommitGroup[b:finCommit='TL']/b:valFinCommit"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>invest_obj_e</name>
				<value>
					<xsl:choose>
						<xsl:when test="b:investmentObjectiveList/b:investmentObjective = 'ASSET.ACCUMULATION'">3</xsl:when>
						<xsl:when test="b:investmentObjectiveList/b:investmentObjective = 'CAPITAL.GROWTH'">2</xsl:when>
						<xsl:when test="b:investmentObjectiveList/b:investmentObjective = 'CAPITAL.PRESERVATION'">0</xsl:when>
						<xsl:when test="b:investmentObjectiveList/b:investmentObjective = 'INCOME.GENERATION'">1</xsl:when>
						<xsl:when test="b:investmentObjectiveList/b:investmentObjective = 'MEDIUM.TERM.RETURNS'">5</xsl:when>
						<xsl:when test="b:investmentObjectiveList/b:investmentObjective = 'SHORT.TERM.RETURNS'">4</xsl:when>
					</xsl:choose>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>cli_invest_horizn_e</name>
				<value>
					<xsl:choose>
						<xsl:when test="b:transPeriod = 'ZEROTOONE'">0</xsl:when>
						<xsl:when test="b:transPeriod = 'ONETOTWO'">1</xsl:when>
						<xsl:when test="b:transPeriod = 'THREETOFIVE'">2</xsl:when>
						<xsl:when test="b:transPeriod = 'FIVETOTEN'">3</xsl:when>
					</xsl:choose>
				</value>
				<type>string</type>
			</mbField>
		</mbFields>
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