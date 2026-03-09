<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookup"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEBLookup" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookup" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookup"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="substring-after(b:id,'*')"/>
		</code>
	</xsl:template>
	<xsl:template name="entity">
		<entity>
			<xsl:value-of select="'portfolio'"/>
		</entity>
	</xsl:template>
	<xsl:template name="shortName">
		<shortName>
			<xsl:value-of select="translate(substring-after(b:id,'*'),'.',' ')"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName"/>
	<xsl:template name="attribute">
		<attribute>fund_portfolio_type_id</attribute>
	</xsl:template>
	<xsl:template name="multilingualLongName">
		<xsl:for-each select="b:descriptionList/b:description">
			<xsl:variable name="currentLanguage" select="@language"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:EBLookup/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="synonym"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields">
		<mbFields>
			<mbField>
				<name>instr_nat_e</name>
				<value>0</value>
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