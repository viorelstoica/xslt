<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecurityBookValueAdjust"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecurityBookValueAdjust" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecurityBookValueAdjust" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecurityBookValueAdjust" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAccount"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:value-of select="b:narrative"/>
		</remark>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
						<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:id"/>
						<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
						<xsl:value-of select="b:companyMnemonic"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<!-- Reversal -->
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- not a reversal -->
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="adjustmentNature">
		<adjustmentNature>
			<xsl:value-of select="'1'"/>
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:choose>
   		<xsl:when test="b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
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
	<xsl:template name="newInstrumentQuantity">
		<newInstrumentQuantity>
			<xsl:value-of select="'0'"/>
		</newInstrumentQuantity>
	</xsl:template>
	<xsl:template name="originalDepositaryAccount">
		<xsl:choose>
   		<xsl:when test="b:depository != ''">
		<originalDepositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
					<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</originalDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="originalSecurity">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="b:securityNumber"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="positionCurrency">
		<positionCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</positionCurrency>
	</xsl:template>
	<xsl:template name="profitLossCounter">
		<xsl:variable name="list_TransactionCodeDecrease">
			<xsl:call-template name="scBookCostTransactionCodeTranslation">
				<xsl:with-param name="transactionCode" select="'COST_DECREASE'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="list_TransactionCodeIncrease">
			<xsl:call-template name="scBookCostTransactionCodeTranslation">
				<xsl:with-param name="transactionCode" select="'COST_INCREASE'"/>
			</xsl:call-template>
		</xsl:variable>
		<profitLossCounter>
			<infra:code>
				<xsl:choose>
					<xsl:when test="contains(concat(' ',$list_TransactionCodeIncrease,' '),concat(' ',b:transaction,' '))">
						<xsl:value-of select="'CAPITAL_LOSS'"/>
					</xsl:when>
					<xsl:when test="contains(concat(' ',$list_TransactionCodeDecrease,' '),concat(' ',b:transaction,' '))">
						<xsl:value-of select="'CAPITAL_PROFIT'"/>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</profitLossCounter>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNumber"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="supplementAmount">
		<xsl:variable name="list_TransactionCodeDecrease">
			<xsl:call-template name="scBookCostTransactionCodeTranslation">
				<xsl:with-param name="transactionCode" select="'COST_DECREASE'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="list_TransactionCodeIncrease">
			<xsl:call-template name="scBookCostTransactionCodeTranslation">
				<xsl:with-param name="transactionCode" select="'COST_INCREASE'"/>
			</xsl:call-template>
		</xsl:variable>
		<supplementAmount>
			<xsl:choose>
				<xsl:when test="contains(concat(' ',$list_TransactionCodeIncrease,' '),concat(' ',b:transaction,' '))">
					<xsl:value-of select="b:bookCostSecCcy"/>
				</xsl:when>
				<xsl:when test="contains(concat(' ',$list_TransactionCodeDecrease,' '),concat(' ',b:transaction,' '))">
					<xsl:value-of select="format-number(-1 * b:bookCostSecCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
			</xsl:choose>
		</supplementAmount>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="b:tradeDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="PositionCriteria1">
		<PositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="b:subAccount"/>
				</xsl:with-param>
			</xsl:call-template>
		</PositionCriteria1>
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
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="coaReference"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="originalInstrumentQuantity"/>
	<xsl:template name="originalPositionCriteria1"/>
	<xsl:template name="originalPositionCriteria2"/>
	<xsl:template name="originalPositionCriteria3"/>
	<xsl:template name="originalSecurityPositionCurrency"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="quote"/>
	<xsl:template name="referenceOperationCode"/>
	<xsl:template name="trader"/>
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