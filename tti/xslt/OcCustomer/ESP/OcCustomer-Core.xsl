<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OcCustomer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOcCustomer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOcCustomer" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOcCustomer"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:if test="b:id != ''">
				<xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
			</xsl:if>
		</code>
	</xsl:template>
	<xsl:template name="active">
		<active>1</active>
	</xsl:template>
	<!-- BEG - Synonym Template -->
	<xsl:template name="synonym">
		<!-- BEG - Third Party Synonym (LEI) -->
		<xsl:if test="b:legalEntityId and b:legalEntityId != ''">
			<synonym>
				<xsl:call-template name="active_LEI"/>
				<xsl:call-template name="beginDate_LEI"/>
				<code>
					<xsl:value-of select="b:legalEntityId"/>
				</code>
				<codification>
					<xsl:value-of select="$THIRDPARTY_LEI_CODIFICATION"/>
				</codification>
				<xsl:call-template name="endDate_LEI"/>
				<xsl:call-template name="status_LEI"/>
				<xsl:call-template name="mbFields_LEI"/>
			</synonym>
		</xsl:if>
		<!-- END - Third Party Synonym (LEI) -->
	</xsl:template>

	<xsl:template name="active_LEI">
		<xsl:choose>
			<xsl:when test="b:entityStatusLeDirectoryJoin = 'ACTIVE'">
				<active>
					<xsl:value-of select="'1'"/>
				</active>
			</xsl:when>
			<xsl:when test="b:entityStatusLeDirectoryJoin = 'INACTIVE'">
				<active>
					<xsl:value-of select="'0'"/>
				</active>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="beginDate_LEI">
		<xsl:if test="b:assignedDateLeDirectoryJoin and b:assignedDateLeDirectoryJoin != ''">
			<beginDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:assignedDateLeDirectoryJoin"/>
				</xsl:call-template>
			</beginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate_LEI">
		<xsl:if test="b:nextRenewalDateLeDirectoryJoin and b:nextRenewalDateLeDirectoryJoin != ''">
			<endDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:nextRenewalDateLeDirectoryJoin"/>
				</xsl:call-template>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_LEI">
		<xsl:if test="b:registrationStatusLeDirectoryJoin and b:registrationStatusLeDirectoryJoin != ''">
			<status>
				<xsl:call-template name="leDirectoryRegistrationStatusTranslation">
					<xsl:with-param name="registrationStatus" select="translate(b:registrationStatusLeDirectoryJoin,$lowercase,$uppercase)"/>
				</xsl:call-template>
			</status>
		</xsl:if>
	</xsl:template>
	<xsl:template name="mbFields_LEI"/>

		<!-- END - Synonym Template -->

	<xsl:template name="shortName"/>
	<xsl:template name="longName"/>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad-custo"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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

	<!-- Third Party third relation -->

	<xsl:template name="relationship">
		<xsl:if test="b:umbrellaEntity and b:umbrellaEntity != ''">
			<relationship>
				<xsl:value-of select="'34'"/>
			</relationship>
		</xsl:if>
	</xsl:template>
	<xsl:template name="relThirdEntity">
		<xsl:if test="b:id != ''">
			<relThirdEntity>
				<code>
					<xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
				</code>
			</relThirdEntity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="thirdEntity">
		<thirdEntity>
			<code>
				<xsl:value-of select="b:umbrellaEntity"/>
			</code>
		</thirdEntity>
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