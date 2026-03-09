<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/BusIndicator" xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookupESG" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookupESG" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
	<xsl:template name="code">
	<code>
		<infra:code>
			<xsl:value-of select="substring-after(b:id,'*')"/>
		</infra:code>
	</code>
	</xsl:template>

	<xsl:template name="busIndicatorElt">
		<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(b:dataNameGroup[b:dataName='INDICATOR']/b:dataValue,'-','_')"/>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>

	<xsl:template name="busIndicatorEltbusIndicator">
		<busIndicatorEltbusIndicator>
			<infra:code>
                <xsl:choose>
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'RATING'">
                        <xsl:value-of select="'ESG_RATING'"/>
                    </xsl:when>
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'CONTROVERSIES'">
                        <xsl:value-of select="'ESG_CONTROVERSIES'"/>
                    </xsl:when>                         
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'SCREENING'">
                        <xsl:value-of select="'ESG_SCREENING'"/>
                    </xsl:when>
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'SDG'">
                        <xsl:value-of select="'ESG_SDG'"/>
                    </xsl:when>
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'CLASSIFICATION'">
                        <xsl:value-of select="'ESG_CLASSIFICATION'"/>
                    </xsl:when>
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'EU.TAXONOMY'">
                        <xsl:value-of select="'ESG_EU_TAXONOMY'"/>
                    </xsl:when>
                    <xsl:when test="b:indicatorCategoryList/b:indicatorCategory = 'SFDR.ADVERSE.IMPACT'">
                        <xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="''"/>
                    </xsl:otherwise>
                </xsl:choose>                 				
			</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>

	<xsl:template name="shortName">
		<xsl:variable name="description" select="substring(b:descriptionList/b:description[@language='GB'],1,60)"/>
		<shortName>
			<xsl:value-of select="$description"/>
		</shortName>
	</xsl:template>

	<xsl:template name="longName">
		<longName>
			<xsl:value-of select="b:descriptionList/b:description[@language='GB']"/>
		</longName>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:EBLookupESG/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="provider">
		<provider>
			<infra:code>
				<xsl:value-of select="b:dataNameGroup[b:dataName='PROVIDER']/b:dataValue"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="rank">
		<rank>
			<xsl:value-of select="b:dataNameGroup[b:dataName='RANK']/b:dataValue"/>
		</rank>
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