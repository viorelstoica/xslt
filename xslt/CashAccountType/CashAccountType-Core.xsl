<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CashAccountType"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCashAccountType" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCashAccountType" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCashAccountType"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="code">
		<code>
			<xsl:value-of select="b:id"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName">
		<shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</shortName>
	</xsl:template>
	<xsl:template name="multilingualLongName">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:CashAccountType/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="attribute">
		<attribute>type_id</attribute>
	</xsl:template>
	<xsl:template name="nature">
		<nature>4</nature>
	</xsl:template>
	<xsl:template name="synonym"/>
	<xsl:template name="longName"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>

	<!-- BEG - INCOME SUBTYPE -->
	<xsl:template name="code_I">
		<code>
			<xsl:value-of select="concat(b:id,'_INCOME')"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_I">
		<shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</shortName>
	</xsl:template>
	<xsl:template name="nature_I">
		<nature>4</nature>
	</xsl:template>
	<xsl:template name="parentType_I">
		<parentType>
			<code>
				<xsl:value-of select="b:id"/>
			</code>
		</parentType>
	</xsl:template>
	<xsl:template name="attribute_I">
		<attribute>subtype_id</attribute>
	</xsl:template>
	<xsl:template name="parentTypeAttribute_I">
		<parentTypeAttribute>type_id</parentTypeAttribute>
	</xsl:template>
	<xsl:template name="multilingualLongName_I">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:CashAccountType/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="synonym_I"/>
	<xsl:template name="longName_I"/>
	<xsl:template name="notepad_I"/>
	<xsl:template name="userDefinedField_I"/>
	<xsl:template name="mbFields_I"/>
	<!-- END - INCOME SUBTYPE -->

	<!-- BEG - CAPITAL SUBTYPE -->
	<xsl:template name="code_C">
		<code>
			<xsl:value-of select="concat(b:id,'_CAPITAL')"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName_C">
		<shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</shortName>
	</xsl:template>
	<xsl:template name="nature_C">
		<nature>4</nature>
	</xsl:template>
	<xsl:template name="parentType_C">
		<parentType>
			<code>
				<xsl:value-of select="b:id"/>
			</code>
		</parentType>
	</xsl:template>
	<xsl:template name="attribute_C">
		<attribute>subtype_id</attribute>
	</xsl:template>
	<xsl:template name="parentTypeAttribute_C">
		<parentTypeAttribute>type_id</parentTypeAttribute>
	</xsl:template>
	<xsl:template name="multilingualLongName_C">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:CashAccountType/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="synonym_C"/>
	<xsl:template name="longName_C"/>
	<xsl:template name="notepad_C"/>
	<xsl:template name="userDefinedField_C"/>
	<xsl:template name="mbFields_C"/>
	<!-- END - CAPITAL SUBTYPE -->
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