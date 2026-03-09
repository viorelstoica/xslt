<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">

	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat(b:id,'_IPO_UNLOCKCASHBC')"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:securityAccntGroup/b:custAccNo"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="lockingUnlocking">
		<lockingUnlocking>
			<xsl:value-of select="'2'"/>
		</lockingUnlocking>
	</xsl:template>
	<xsl:template name="transactionCurrency">
		<transactionCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</transactionCurrency>
	</xsl:template>
	<xsl:template name="lockingDate">
		<lockingDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</lockingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAccntGroup/b:securityAccnt"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:securityAccntGroup/b:cuSubscriptionAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:value-of select="'Unlock cash for IPO debit order during book closure'"/>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'IPO_LOCK'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="depositaryAccount"/>
	<xsl:template name="endDate"/>
	<xsl:template name="lockingTransactionCode"/>
	<xsl:template name="lockingType"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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