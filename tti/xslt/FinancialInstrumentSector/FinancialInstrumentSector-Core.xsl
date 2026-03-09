<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSector"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSector"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
	<xsl:template name="code_GN">
		<code>
			<xsl:value-of select="b:industryCode"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_GN">
		<shortName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName_GN">
		<longName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</longName>
	</xsl:template>
	<xsl:template name="multilingualLongName_GN">
		<xsl:for-each select="b:descriptionList/b:description">
			<multilingualLongName>
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongName>
		</xsl:for-each>
		<xsl:call-template name="OldNewDenomManagment">
			<xsl:with-param name="CurrentEvent" select="./b:descriptionList/b:description"/>
			<xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:FinancialInstrumentSector/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="codification_GN">
		<codification>
			<xsl:value-of select="'T24_FI_INDUSTRY'"/>
		</codification>
	</xsl:template>
	<xsl:template name="synonym_GN"/>
	<xsl:template name="notepad_GN"/>
	<xsl:template name="userDefinedField_GN"/>
	<xsl:template name="mbFields_GN"/>

	<xsl:template name="code_SI">
		<code>
			<xsl:value-of select="b:subIndustry"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_SI">
		<shortName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName_SI">
		<longName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</longName>
	</xsl:template>
	<xsl:template name="multilingualLongName_SI">
		<xsl:for-each select="b:descriptionList/b:description">
			<multilingualLongName>
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongName>
		</xsl:for-each>
		<xsl:call-template name="OldNewDenomManagment">
			<xsl:with-param name="CurrentEvent" select="./b:subIndustryDescList/b:subIndustryDesc"/>
			<xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:FinancialInstrumentSector/b:subIndustryDescList/b:subIndustryDesc"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="codification_SI">
		<codification>
			<xsl:value-of select=" 'T24_FI_GICS_INDUSTRY' "/>
		</codification>
	</xsl:template>
	<xsl:template name="parentSector_SI">
		<parentSector>
			<code>
				<xsl:value-of select="b:industry"/>
			</code>
		</parentSector>
	</xsl:template>
	<xsl:template name="synonym_SI"/>
	<xsl:template name="notepad_SI"/>
	<xsl:template name="userDefinedField_SI"/>
	<xsl:template name="mbFields_SI"/>




	<xsl:template name="code_I">
		<code>
			<xsl:value-of select="b:industry"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_I">
		<shortName>
			<xsl:value-of select="b:industryDescList/b:industryDesc"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName_I">
		<longName>
			<xsl:value-of select="b:industryDescList/b:industryDesc"/>
		</longName>
	</xsl:template>
	<xsl:template name="multilingualLongName_I">
		<xsl:for-each select="b:industryDescList/b:industryDesc">
			<multilingualLongName>
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongName>
		</xsl:for-each>
		<xsl:call-template name="OldNewDenomManagment">
			<xsl:with-param name="CurrentEvent" select="./b:industryDescList/b:industryDesc"/>
			<xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:FinancialInstrumentSector/b:industryDescList/b:industryDesc"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="codification_I">
		<codification>
			<xsl:value-of select=" 'T24_FI_GICS_INDUSTRY' "/>
		</codification>
	</xsl:template>
	<xsl:template name="parentSector_I">
		<parentSector>
			<code>
				<xsl:value-of select="b:industryGroup"/>
			</code>
		</parentSector>
	</xsl:template>
	<xsl:template name="synonym_I"/>
	<xsl:template name="notepad_I"/>
	<xsl:template name="userDefinedField_I"/>
	<xsl:template name="mbFields_I"/>




	<xsl:template name="code_IG">
		<code>
			<xsl:value-of select="b:industryGroup"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_IG">
		<shortName>
			<xsl:value-of select="b:industryGroupDescList/b:industryGroupDesc"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName_IG">
		<longName>
			<xsl:value-of select="b:industryGroupDescList/b:industryGroupDesc"/>
		</longName>
	</xsl:template>
	<xsl:template name="multilingualLongName_IG">
		<xsl:for-each select="b:industryGroupDescList/b:industryGroupDesc">
			<multilingualLongName>
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongName>
		</xsl:for-each>
		<xsl:call-template name="OldNewDenomManagment">
			<xsl:with-param name="CurrentEvent" select="./b:industryGroupDescList/b:industryGroupDesc"/>
			<xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:FinancialInstrumentSector/b:industryGroupDescList/b:industryGroupDesc"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="codification_IG">
		<codification>
			<xsl:value-of select=" 'T24_FI_GICS_INDUSTRY' "/>
		</codification>
	</xsl:template>
	<xsl:template name="parentSector_IG">
		<parentSector>
			<code>
				<xsl:value-of select="b:sector"/>
			</code>
		</parentSector>
	</xsl:template>
	<xsl:template name="synonym_IG"/>
	<xsl:template name="notepad_IG"/>
	<xsl:template name="userDefinedField_IG"/>
	<xsl:template name="mbFields_IG"/>



	<xsl:template name="code_S">
		<code>
			<xsl:value-of select="b:sector"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_S">
		<shortName>
			<xsl:value-of select="b:sectorDescList/b:sectorDesc"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName_S">
		<longName>
			<xsl:value-of select="b:sectorDescList/b:sectorDesc"/>
		</longName>
	</xsl:template>
	<xsl:template name="multilingualLongName_S">
		<xsl:for-each select="b:sectorDescList/b:sectorDesc">
			<multilingualLongName>
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongName>
		</xsl:for-each>
		<xsl:call-template name="OldNewDenomManagment">
			<xsl:with-param name="CurrentEvent" select="./b:sectorDescList/b:sectorDesc"/>
			<xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:FinancialInstrumentSector/b:sectorDescList/b:sectorDesc"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="codification_S">
		<codification>
			<xsl:value-of select=" 'T24_FI_GICS_INDUSTRY' "/>
		</codification>
	</xsl:template>
	<xsl:template name="synonym_S"/>
	<xsl:template name="notepad_S"/>
	<xsl:template name="userDefinedField_S"/>
	<xsl:template name="mbFields_S"/>
	<xsl:template name="parentSector_S"/>
</xsl:stylesheet>