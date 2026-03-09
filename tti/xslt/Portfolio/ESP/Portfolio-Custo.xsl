<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c" version="1.0" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Portfolio" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolio"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!--RNJ-MIR - Custom mappings for service type-->
	<xsl:template name="serviceType">
        <serviceType>
                <xsl:choose>
                    <xsl:when test="not(b:managedAccount) or b:managedAccount = '' or b:managedAccount = '99'">
                        <xsl:value-of select="'0'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '11'">
                        <xsl:value-of select="'2'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '12'">
                        <xsl:value-of select="'1'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '10'">
                        <xsl:value-of select="'3'"/>
                    </xsl:when>                                                       
                    <xsl:otherwise>
                        <xsl:value-of select="'0'"/>
                    </xsl:otherwise>
                </xsl:choose>            
        </serviceType>
	</xsl:template>
	<!-- END of protected area  -->

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