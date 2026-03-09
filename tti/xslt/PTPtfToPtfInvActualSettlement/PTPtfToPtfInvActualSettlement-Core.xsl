<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferScSettlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferScSettlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferScSettlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="IdVar" select="substring-before(../b:id,'.')"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:value-of select="concat(../b:tapOperCode,'_','ST_I_',$IdVar,'_',b:securityNo,'_',b:depository,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_I_',$IdVar,'_',b:securityNo,'_',b:depository,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount">
	<xsl:variable name="index" select="@index"/>
		<depositaryAccount>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../b:depositoryTo and ../b:depositoryTo != ''">
						<xsl:choose>
							<xsl:when test="../b:subAccountToTypeList/b:subAccountToType[@index=$index] !='' and ../b:subAccountToTypeList/b:subAccountToType[@index=$index] = $subAccountNature and b:subAccountGroup[@index=$index]/b:subAccTo">
								<xsl:value-of select="concat(../b:depositoryTo,'_',b:subAccountGroup[@index=$index]/b:subAccTo)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../b:depositoryTo"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../b:subAccountToTypeList/b:subAccountToType[@index=$index] !='' and ../b:subAccountToTypeList/b:subAccountToType[@index=$index] = $subAccountNature and b:subAccountGroup[@index=$index]/b:subAccTo">
								<xsl:value-of select="concat(b:depository,'_',b:subAccountGroup[@index=$index]/b:subAccTo)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:depository"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
	<xsl:template name="histQuote">
		<xsl:if test="$TAKE_HIST_VALUES_INV = 'YES'">
			<histQuote>
				<xsl:value-of select="b:price"/>
			</histQuote>
		</xsl:if>
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
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:secAcctTo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:noNominal"/>
		</quantity>
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
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',../b:transTypeCr)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="paymentDate"/>
	<xsl:template name="paymentStatus"/>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:choose>
				<xsl:when test="../b:secHoldSettle = 'YES'">
					<xsl:value-of select="../b:brNomOutstandGroup/b:brNomValDate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:valueDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus">
		<xsl:if test="../b:secHoldSettle = 'YES'">
			<settlementStatus>
				<xsl:choose>
					<xsl:when test="number(../b:brNomOutstandGroup/b:brNomOutstand) = '0'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'3'"/>
					</xsl:otherwise>
				</xsl:choose>
			</settlementStatus>
		</xsl:if>
	</xsl:template>
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
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="histOpExchRate"/>
	<xsl:template name="histOpNetAmount"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="transferPrice"/>
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