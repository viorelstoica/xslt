<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/BusIndicator" xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgIndicator" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgIndicator" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">

	<xsl:template name="code">
	<code>
		<infra:code>
			<xsl:value-of select="translate(b:id,'-','_')"/>
		</infra:code>
	</code>
	</xsl:template>

	<xsl:template name="busIndicator">
		<busIndicator>
		<infra:code>
			<xsl:choose>
                <xsl:when test="b:indicatorCategory = 'RATING'">
                    <xsl:value-of select="'ESG_RATING'"/>
                </xsl:when>
                <xsl:when test="b:indicatorCategory = 'CONTROVERSIES'">
                    <xsl:value-of select="'ESG_CONTROVERSIES'"/>
                </xsl:when> 
				<xsl:when test="b:indicatorCategory = 'SCREENING'">
					<xsl:value-of select="'ESG_SCREENING'"/>
				</xsl:when>
				<xsl:when test="b:indicatorCategory = 'SDG'">
					<xsl:value-of select="'ESG_SDG'"/>
				</xsl:when>
				<xsl:when test="b:indicatorCategory = 'CLASSIFICATION'">
					<xsl:value-of select="'ESG_CLASSIFICATION'"/>
				</xsl:when>
				<xsl:when test="b:indicatorCategory = 'EU.TAXONOMY'">
					<xsl:value-of select="'ESG_EU_TAXONOMY'"/>
				</xsl:when>
				<xsl:when test="b:indicatorCategory = 'SFDR.ADVERSE.IMPACT'">
					<xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</busIndicator>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:ScEsgIndicator/b:descriptionList/b:description"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="parentBiElt">
		<xsl:choose>
			<xsl:when test="b:otherAttrGroup/b:otherAttr = 'Parent Indicator'">
				<parentBiElt>
					<infra:code>
						<xsl:value-of select="translate(b:otherAttrGroup[b:otherAttr = 'Parent Indicator']/b:otherAttrVal,'-','_')"/>
					</infra:code>
				</parentBiElt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="parentBiEltBusIndicator">
       <xsl:if test="b:otherAttrGroup/b:otherAttr = 'Parent Indicator'">	
			<parentBiEltBusIndicator>
				<infra:code>
						<xsl:choose>
							<xsl:when test="b:indicatorCategory = 'RATING'">
								<xsl:value-of select="'ESG_RATING'"/>
							</xsl:when>
                            <xsl:when test="b:indicatorCategory = 'CONTROVERSIES'">
                                <xsl:value-of select="'ESG_CONTROVERSIES'"/>
                            </xsl:when>							
							<xsl:when test="b:indicatorCategory = 'SCREENING'">
								<xsl:value-of select="'ESG_SCREENING'"/>
							</xsl:when>
							<xsl:when test="b:indicatorCategory = 'SDG'">
								<xsl:value-of select="'ESG_SDG'"/>
							</xsl:when>
							<xsl:when test="b:indicatorCategory = 'CLASSIFICATION'">
								<xsl:value-of select="'ESG_CLASSIFICATION'"/>
							</xsl:when>
							<xsl:when test="b:indicatorCategory = 'EU.TAXONOMY'">
								<xsl:value-of select="'ESG_EU_TAXONOMY'"/>
							</xsl:when>
							<xsl:when test="b:indicatorCategory = 'SFDR.ADVERSE.IMPACT'">
								<xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''"/>
							</xsl:otherwise>
						</xsl:choose>
				</infra:code>
			</parentBiEltBusIndicator>
       </xsl:if>
	</xsl:template>
	<xsl:template name="thresholdAllowed">
        <xsl:variable name="element">
            <xsl:value-of select="b:id"/>
        </xsl:variable>
        <xsl:variable name="element_len">
            <xsl:value-of select="string-length($element)"/>
        </xsl:variable>
        <xsl:variable name="element_last_mf">
            <xsl:value-of select="substring($element, $element_len - 3)"/>
        </xsl:variable>
		<thresholdAllowed>
			<xsl:choose>
				<xsl:when test="contains(b:id,'-SCR-') and not(contains($element_last_mf, '-MF'))">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</thresholdAllowed>
	</xsl:template>
	<xsl:template name="rank">
		<xsl:choose>
			<xsl:when test="b:otherAttrGroup/b:otherAttr = 'Sorting Order'">
				<rank>
					<xsl:value-of select="b:otherAttrGroup[b:otherAttr = 'Sorting Order']/b:otherAttrVal"/>
				</rank>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="type"/>
    <xsl:template name="bi-type-definitions">
        <xsl:if test="b:otherAttrGroup[b:otherAttr = 'Sub-datatypes']/b:otherAttrVal 
                        and b:otherAttrGroup[b:otherAttr = 'Sub-datatypes']/b:otherAttrVal = '1'">
		    <BiType description="string">
		      <code>
		        <infra:code>NUMBER</infra:code>
		      </code>
		      <busIndicatorElt>
		        <infra:code>
                        <xsl:value-of select="translate(b:id,'-','_')"/>		        
                </infra:code>
		      </busIndicatorElt>
		      <busIndicatorEltbusIndicator>
		        <infra:code>
	                <xsl:choose>
                        <xsl:when test="b:indicatorCategory = 'RATING'">
                            <xsl:value-of select="'ESG_RATING'"/>
                        </xsl:when>
                        <xsl:when test="b:indicatorCategory = 'CONTROVERSIES'">
                            <xsl:value-of select="'ESG_CONTROVERSIES'"/>
                        </xsl:when> 
	                    <xsl:when test="b:indicatorCategory = 'SCREENING'">
	                        <xsl:value-of select="'ESG_SCREENING'"/>
	                    </xsl:when>
	                    <xsl:when test="b:indicatorCategory = 'SDG'">
	                        <xsl:value-of select="'ESG_SDG'"/>
	                    </xsl:when>
	                    <xsl:when test="b:indicatorCategory = 'CLASSIFICATION'">
	                        <xsl:value-of select="'ESG_CLASSIFICATION'"/>
	                    </xsl:when>
	                    <xsl:when test="b:indicatorCategory = 'EU.TAXONOMY'">
	                        <xsl:value-of select="'ESG_EU_TAXONOMY'"/>
	                    </xsl:when>
	                    <xsl:when test="b:indicatorCategory = 'SFDR.ADVERSE.IMPACT'">
	                        <xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
	                    </xsl:when>
	                    <xsl:otherwise>
	                        <xsl:value-of select="''"/>
	                    </xsl:otherwise>
	                </xsl:choose>		        
		        </infra:code>
		      </busIndicatorEltbusIndicator>
		      <shortName>Number</shortName>
		      <longName>Number</longName>
		      <multilingualLongName>
		        <language>en</language>
		        <longName>Number</longName>
		        <mbFields/>
		      </multilingualLongName>
		      <multilingualLongName>
		        <language>fr</language>
		        <longName>Nombre</longName>
		        <mbFields/>
		      </multilingualLongName>
		      <multilingualLongName>
		        <language>de</language>
		        <longName>Zahl</longName>
		        <mbFields/>
		      </multilingualLongName>
		      <rank>1</rank>
		    </BiType>

            <BiType description="string">
              <code>
                <infra:code>PERCENT</infra:code>
              </code>
              <busIndicatorElt>
                <infra:code>
                        <xsl:value-of select="translate(b:id,'-','_')"/>                
                </infra:code>
              </busIndicatorElt>
              <busIndicatorEltbusIndicator>
                <infra:code>
                    <xsl:choose>
                        <xsl:when test="b:indicatorCategory = 'RATING'">
                            <xsl:value-of select="'ESG_RATING'"/>
                        </xsl:when>
                        <xsl:when test="b:indicatorCategory = 'CONTROVERSIES'">
                            <xsl:value-of select="'ESG_CONTROVERSIES'"/>
                        </xsl:when> 
                        <xsl:when test="b:indicatorCategory = 'SCREENING'">
                            <xsl:value-of select="'ESG_SCREENING'"/>
                        </xsl:when>
                        <xsl:when test="b:indicatorCategory = 'SDG'">
                            <xsl:value-of select="'ESG_SDG'"/>
                        </xsl:when>
                        <xsl:when test="b:indicatorCategory = 'CLASSIFICATION'">
                            <xsl:value-of select="'ESG_CLASSIFICATION'"/>
                        </xsl:when>
                        <xsl:when test="b:indicatorCategory = 'EU.TAXONOMY'">
                            <xsl:value-of select="'ESG_EU_TAXONOMY'"/>
                        </xsl:when>
                        <xsl:when test="b:indicatorCategory = 'SFDR.ADVERSE.IMPACT'">
                            <xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>               
                </infra:code>
              </busIndicatorEltbusIndicator>
              <shortName>Percent</shortName>
              <longName>Percent</longName>
              <multilingualLongName>
                <language>en</language>
                <longName>Percent</longName>
                <mbFields/>
              </multilingualLongName>
              <multilingualLongName>
                <language>fr</language>
                <longName>Pourcent</longName>
                <mbFields/>
              </multilingualLongName>
              <multilingualLongName>
                <language>de</language>
                <longName>Prozent</longName>
                <mbFields/>
              </multilingualLongName>
              <rank>1</rank>
            </BiType>
        </xsl:if>
    </xsl:template>
    <!--  type generations added on site, none for now  -->
    <xsl:template name="bi-type-definitions-added"/>
	
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="code"></template>
			<template name="thresholdAllowed"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->