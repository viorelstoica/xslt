<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchIRSNotionalPrinChange"
                xmlns:ns1="http://www.temenos.com/T24/SwapDetailsService/SwBalancesDetails" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSNotionalPrinChange" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b batch ns0 ns1" version="1.0">

	<xsl:template name="account1"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:swapbalancesrecord/ns1:SwapBalancesList[ns1:scheduleType = 'PIN']/ns1:processDate"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="counterparty"/>
	<xsl:template name="expirationDate"/>
	<xsl:template name="fixedInterestRate"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="concat(b:swapbalancesrecord/ns1:customer,'-',b:swapbalancesrecord/ns1:portfolioNumber)"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="principalAmount">
		<principalAmount>
			<xsl:value-of select="b:swapbalancesrecord/ns1:SwapBalancesList[ns1:scheduleType='PIN']/ns1:currencyAmount"/>
		</principalAmount>
	</xsl:template>
	<xsl:template name="remark"/>
	<xsl:template name="referenceNature">
			<referenceNature>
				<xsl:value-of select="'23'"/>
			</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode">
			<referenceTransactionCode>
				<xsl:value-of select="concat(b:swapbalancesrecord/ns1:swapId,$COMPANY_POSTFIX_SEPARATOR,b:swapbalancesrecord/ns1:coMnemonic)"/>
			</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:swapbalancesrecord/ns1:swapId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="spotExchangeRate"/>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="swap">
		<swap>
			<infra:code>
				<xsl:value-of select="concat(b:swapbalancesrecord/ns1:swapId,$COMPANY_POSTFIX_SEPARATOR,b:swapbalancesrecord/ns1:coMnemonic)"/>
			</infra:code>
		</swap>
	</xsl:template>
	<xsl:template name="swapCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="swapCurrency"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat('IRS_PIN',$COMPANY_POSTFIX_SEPARATOR, b:swapbalancesrecord/ns1:swapId,$COMPANY_POSTFIX_SEPARATOR,b:swapbalancesrecord/ns1:SwapBalancesList[ns1:scheduleType = 'PIN']/ns1:processDate,$COMPANY_POSTFIX_SEPARATOR,b:swapbalancesrecord/ns1:coMnemonic)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:swapbalancesrecord/ns1:SwapBalancesList[ns1:scheduleType = 'PIN']/ns1:processDate"/>
			</xsl:call-template>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'IRS_PIN'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:swapbalancesrecord/ns1:SwapBalancesList[ns1:scheduleType = 'PIN']/ns1:processDate"/>
			</xsl:call-template>
		</valueDate>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="account1"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->