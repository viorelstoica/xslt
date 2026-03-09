<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferPtfToPtfWithdr"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferPtfToPtfWithdr" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferPtfToPtfWithdr" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferPtfToPtfWithdr" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../b:tapSlvPtfFrm != ''">
						<xsl:value-of select="../b:tapSlvPtfFrm"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../b:secAcctFrom"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:variable name="remark">
				<xsl:for-each select="../b:custNarrativeList/b:custNarrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="substring($remark,1,80)"/>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:value-of select="concat(../b:tapOperCode,'_','ST_O_',../b:id,'_',b:securityNo,'_',b:depository,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_O_',../b:id,'_',b:securityNo,'_',b:depository,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',../b:transTypeDr)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="accountCurrency">
		<accountCurrency>
			<infra:code>
				<xsl:value-of select="../b:localCurrency"/>
			</infra:code>
		</accountCurrency>
	</xsl:template>
	<xsl:template name="depositaryAccount">
	<xsl:variable name="index" select="@index"/>
		<xsl:choose>
					<xsl:when test="b:depository !=''">
					<depositaryAccount>
						<infra:code>
						<xsl:choose>
							<xsl:when test="../b:subAccountFromTypeList/b:subAccountFromType[@index=$index] !='' and ../b:subAccountFromTypeList/b:subAccountFromType[@index=$index] = $subAccountNature and b:subAccount">
								<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:depository"/>
							</xsl:otherwise>
						</xsl:choose>
						</infra:code>
						</depositaryAccount>
					</xsl:when>
				</xsl:choose>
	</xsl:template>
	<xsl:template name="histQuote">
		<xsl:if test="$TAKE_HIST_VALUES_WITH = 'YES'">
			<histQuote>
				<xsl:value-of select="b:price"/>
			</histQuote>
		</xsl:if>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:noNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="transactionCurrency">
		<transactionCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCcy"/>
			</infra:code>
		</transactionCurrency>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../b:tradeDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:chargeAcc"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount">
		<xsl:variable name="commissionamt" select="format-number(b:commission,$decimalformat,'nan2zero')"/>
		<xsl:variable name="taxamt" select="format-number(b:tax,$decimalformat,'nan2zero')"/>
		<xsl:variable name="xratePriBase" select="format-number(b:xratePriBase,$decimalformat,'nan2zero')"/>
		<xsl:choose>
			<xsl:when test="b:securityCcy = ../b:localCurrency">
				<account1NetAmount>
					<xsl:value-of select="$commissionamt + $taxamt "/>
				</account1NetAmount>
			</xsl:when>
			<xsl:otherwise>
				<account1NetAmount>
					<xsl:value-of select="($commissionamt + $taxamt) * $xratePriBase"/>
				</account1NetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printPositionTransferFeesAndTaxes">
			<xsl:with-param name="caller"/>
			<xsl:with-param name="commission" select="b:commission"/>
			<xsl:with-param name="tax" select="b:tax"/>
			<xsl:with-param name="securityCcy" select="b:securityCcy"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="transferPrice"/>
	<xsl:template name="histOpExchRate"/>
	<xsl:template name="histOpNetAmount"/>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="../b:tapSlvPtfFrm != ''">
					<xsl:value-of select="../b:secAcctFrom"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:choose>
				<xsl:when test="../b:tapSlvPtfFrm != '' or ../b:tapSlvPtfTo != ''">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</splitPortfolio>
	</xsl:template>
	<xsl:template name="paymentDate"/>
	<xsl:template name="paymentStatus"/>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:value-of select="../b:valueDate"/>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus"/>
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