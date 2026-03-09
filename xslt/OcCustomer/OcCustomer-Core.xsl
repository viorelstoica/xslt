<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OcCustomer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOcCustomer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOcCustomer" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOcCustomer"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- Filter out this flow since this is only  business entity specific -->
	<xsl:template name="code"/>
	<xsl:template name="synonym"/>
	<xsl:template name="shortName"/>
	<xsl:template name="longName"/>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad-custo"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="active"/>
	<xsl:template name="beginDate"/>
	<xsl:template name="businessEntityComposition"/>
	<xsl:template name="currency"/>
	<xsl:template name="clientRole"/>
	<xsl:template name="classification"/>
	<xsl:template name="custodianRole"/>
	<xsl:template name="externalBank"/>
	<xsl:template name="emailAddress"/>
	<xsl:template name="faxNumber"/>
	<xsl:template name="intermediaryRole"/>
	<xsl:template name="islamicCompliance"/>
	<xsl:template name="issuerRole"/>
	<xsl:template name="language"/>
	<xsl:template name="manager"/>
	<xsl:template name="phoneNumber"/>
	<xsl:template name="rating"/>
	<xsl:template name="residenceCountry"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="sector"/>
	<xsl:template name="taxationCountry"/>
	<xsl:template name="thirdPartyGroup"/>
	<xsl:template name="type"/>
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