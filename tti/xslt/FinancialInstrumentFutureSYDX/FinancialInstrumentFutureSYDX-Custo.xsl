<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentFutureSYDX" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentFutureSYDX"
                xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c d" version="1.0">

	<xsl:template name="mainStockExchange">
		<mainStockExchange>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:dxExchangeMnemonic)"/>
			</infra:code>
		</mainStockExchange>
	</xsl:template>

	<xsl:template name="infra:synonym">
		<xsl:for-each select="b:altIndNameGroup">
			<xsl:if test="b:altIndId">
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
		<xsl:call-template name="OldNewAltDerivativeSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentFutureSYDX"/>
		</xsl:call-template>
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