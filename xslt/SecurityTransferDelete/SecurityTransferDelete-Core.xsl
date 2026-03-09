<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="buySellIndicator"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="oldStatus"/>
	<xsl:template name="omsOrderReference"/>
	<xsl:template name="orderMode"/>
	<xsl:template name="orderStatus">
		<orderStatus>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'CANCELLED'"/>
			</xsl:call-template>
		</orderStatus>
	</xsl:template>
	<xsl:template name="pmsOrderReference">
		<pmsOrderReference>
			<xsl:value-of select="b:tapRefId"/>
		</pmsOrderReference>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAcc"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark"/>
	<xsl:template name="security"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="type"/>
	<xsl:template name="userDefinedField"/>
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