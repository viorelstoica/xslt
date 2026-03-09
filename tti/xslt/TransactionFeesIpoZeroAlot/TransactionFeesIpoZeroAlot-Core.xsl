<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FullPartialExecution" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">


	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat(b:orderNumber,'_IPO_ORDER_FEES_ZA') "/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:securityAccountSegregChargeList/b:securityAccountSegregCharge = 'YES'">
                        <xsl:value-of select="b:secOpenOrderNoNominalGroup/b:orderCuIncomeAcc"/>
					</xsl:when>
					<xsl:otherwise>
                        <xsl:value-of select="b:secOpenOrderNoNominalGroup/b:CustAccNoSecOpenOrder"/>
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
							<xsl:when test="b:orderCuIncomeAccPortfolioNoGroup/b:orderCuIncomeAccPortfolioNoList/b:orderCuIncomeAccPortfolioNo">
								<xsl:value-of select="b:orderCuIncomeAccPortfolioNoGroup/b:orderCuIncomeAccPortfolioNoList/b:orderCuIncomeAccPortfolioNo"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:orderCuIncomeAccSamHistIdList/b:orderCuIncomeAccSamHistId"/>
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
				<xsl:value-of select="b:securityAcctGroup/b:securityAcct"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:value-of select="concat('IPO Order Fees due to zero allotment for order ',b:orderNumber)"/>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:orderNumber"/>
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
			<xsl:value-of select="b:eventCommon/ns0:today"/>
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
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="quantity">
			<quantity>
				<xsl:value-of select="b:secOpenOrderNoNominalGroup/b:orderCuCommission"/>
			</quantity>
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
	<xsl:template name="accountingDate"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="feesTaxesCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="feesTaxesCounter"/>
	<xsl:template name="feesTaxesAmount">
	   <feesTaxesAmount>  
	       <xsl:value-of select="b:secOpenOrderNoNominalGroup/b:orderCuCommission"/>
	   </feesTaxesAmount>
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