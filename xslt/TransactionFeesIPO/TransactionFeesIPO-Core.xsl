<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">


	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat(b:id,'_IPO_ORDER_FEES') "/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:securityAccountSegregChargeList/b:securityAccountSegregCharge = 'YES'">
						<xsl:value-of select="b:securityAccntGroup/b:cuIncomeAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAccntGroup/b:custAccNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="cashPortfolio">
		<xsl:if test="b:securityAccountSegregChargeList/b:securityAccountSegregCharge = 'YES'">
			<cashPortfolio>
				<portfolio>
					<infra:code>
						<xsl:choose>
							<xsl:when test="b:cuIncomeAccountPortfolioNoGroup/b:cuIncomeAccountPortfolioNoList/b:cuIncomeAccountPortfolioNo and b:cuIncomeAccountPortfolioNoGroup/b:cuIncomeAccountPortfolioNoList/b:cuIncomeAccountPortfolioNo != ''">
								<xsl:value-of select="b:cuIncomeAccountPortfolioNoGroup/b:cuIncomeAccountPortfolioNoList/b:cuIncomeAccountPortfolioNo"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:cuIncomeAccountSamHistIdList/b:cuIncomeAccountSamHistId"/>
							</xsl:otherwise>
						</xsl:choose>
					</infra:code>
				</portfolio>
			</cashPortfolio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="feesTaxesCurrency">
		<feesTaxesCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</feesTaxesCurrency>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAccntGroup/b:securityAccnt"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:value-of select="concat('IPO Order Fees for order',b:id)"/>
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
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:choose>
				<xsl:when test="b:eventCommon/ns0:application = 'SC.IPO.ORDER.ACCTG'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:orderDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionDate>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'IPO_ORDER_FEES'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:if test="b:securityAccntGroup/b:cuCommission != ''">
			<quantity>
				<xsl:value-of select="b:securityAccntGroup/b:cuCommission"/>
			</quantity>
		</xsl:if>
	</xsl:template>

	<xsl:template name="account1CcyFTCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyFTCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyFTCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:choose>
				<xsl:when test="b:eventCommon/ns0:application = 'SC.IPO.ORDER.ACCTG'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:orderDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="contractNumber"/>
	<xsl:template name="feesTaxesCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="feesTaxesCounter"/>
	<xsl:template name="feesTaxesAmount">
		<xsl:if test="b:securityAccntGroup/b:cuCommission != ''">
			<feesTaxesAmount>
				<xsl:value-of select="b:securityAccntGroup/b:cuCommission"/>
			</feesTaxesAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference"/>
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