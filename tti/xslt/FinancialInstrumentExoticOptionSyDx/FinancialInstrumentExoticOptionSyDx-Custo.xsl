<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionSyDx" xmlns:c="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionSyDx" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                exclude-result-prefixes="b c ns0" version="1.0">
    <!-- START of protected area  -->
    
    <!-- END of protected area  -->

	<xsl:template name="synonym">
		<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentExoticOptionSyDx"/>
		</xsl:call-template>
		<xsl:for-each select="b:altIndNameGroup">
			<xsl:if test="b:altIndId and b:altIndId!=''">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:altIndId"/>
					</infra:code>
					<infra:codification>
						<!-- BEG - JPP20250528 - ITSM-2255981 - devop 204794 - remove space in codification can cause wrong BB Ticker -->
						<xsl:value-of select="translate(b:altIndName, ' ', '_')"/>
						<!-- END - JPP20250528 - ITSM-2255981 - devop 204794 - remove space in codification can cause wrong BB Ticker -->
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
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