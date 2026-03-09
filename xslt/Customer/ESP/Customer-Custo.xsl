<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Customer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="mbFields">
	<mbFields>
		<mbField>
			<name>legal_entity_type_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdClntType ='0'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='IND'">
						<xsl:value-of select="'100'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='JNT'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='COL'">
						<xsl:value-of select="'102'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='ASC'">
						<xsl:value-of select="'103'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='COM'">
						<xsl:value-of select="'104'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='FOU'">
						<xsl:value-of select="'105'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='LIN'">
						<xsl:value-of select="'106'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='TRU'">
						<xsl:value-of select="'107'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='OTH'">
						<xsl:value-of select="'109'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='LIF'">
						<xsl:value-of select="'110'"/>
					</xsl:when>
					<xsl:when test="b:csdClntType ='SELF'">
						<xsl:value-of select="'111'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</mbField>
	</mbFields>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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