<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SafeCustodyFees" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b ns0"
                version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="b:chargesAcCcy"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="feesTaxesCounter">
		<feesTaxesCounter>
			<infra:code>PTF_SCUS_FEES</infra:code>
		</feesTaxesCounter>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:if test="b:chargesTaxAmt">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="b:chargesTaxAmt"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:accountCcy"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>PTF_TAX_ON_FEE</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat('PTFSCF_',b:id)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="feesTaxesCurrency">
		<feesTaxesCurrency>
			<infra:code>
				<xsl:value-of select="b:accountCcy"/>
			</infra:code>
		</feesTaxesCurrency>
	</xsl:template>
	<xsl:template name="feesTaxesAmount">
		<feesTaxesAmount>
			<xsl:variable name="chargesAcCcy" select="format-number(b:chargesAcCcy,$decimalformat,'nan2zero')"/>
			<xsl:variable name="chargesTaxAmt" select="format-number(b:chargesTaxAmt,$decimalformat,'nan2zero')"/>
			<xsl:value-of select="format-number(($chargesAcCcy - $chargesTaxAmt),'#.##','nan2zero')"/>
		</feesTaxesAmount>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="substring-before(b:id,'.')"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="status">
		<status>90</status>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'SCUS_FEE'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="account1CcyFTCcyExchangeRate"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyFTCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyFTCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="feesTaxesCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="quantity"/>
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