<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/AutoUnblock" xmlns:b="http://www.temenos.com/T24/event/TTI/UnlockingTransaction" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchUnlockingTransaction"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">

	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat(b:autoUnblockRec/ns1:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:autoUnblockRec/ns1:idSecurityPosition,$COMPANY_POSTFIX_SEPARATOR,b:eventCommon/ns0:today,$COMPANY_POSTFIX_SEPARATOR,b:coCode)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<depositaryAccount>
			<infra:code>
				<xsl:value-of select="substring-before(substring-after(substring-after(b:autoUnblockRec/ns1:idSecurityPosition,'.'),'.'),'.')"/>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="substring-before(substring-after(b:autoUnblockRec/ns1:idSecurityPosition,'.'),'.')"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="lockingUnlocking">
		<lockingUnlocking>2</lockingUnlocking>
	</xsl:template>
	<xsl:template name="lockingDate">
		<lockingDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</lockingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="substring-before(b:autoUnblockRec/ns1:idSecurityPosition,'.')"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:autoUnblockRec/ns1:unBlockedNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="positionCriteria1">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="substring-after(b:autoUnblockRec/ns1:idSecurityPosition,'....')"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="endDate"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="lockingTransactionCode"/>
	<xsl:template name="lockingType"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="status"/>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCurrency"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'SC_UNBLOCK'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="validityDate"/>
	<xsl:template name="valueDate"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
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