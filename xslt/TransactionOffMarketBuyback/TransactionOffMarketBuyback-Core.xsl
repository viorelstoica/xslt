<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1_Sell">
		<account1>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>

	<xsl:template name="account1CcyTradeCcyExchangeRate_Sell">
		<xsl:if test="b:netAmount != ''">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number((b:netAmtAccCur) div (b:netAmount),$decimalformat,'nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Sell">
		<account1NetAmount>
			<xsl:value-of select="b:netAmtAccCur"/>
		</account1NetAmount>
	</xsl:template>

	<xsl:template name="accountingDate_Sell">
		<accountingDate>
			<xsl:value-of select="b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>

	<xsl:template name="transactionFeesTaxesCounter_Sell">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="b:commissionAmt"/>
			<xsl:with-param name="commTax" select="b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="currencyFT" select="b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="transactionCode_Sell">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(b:tapOperCode, '_', b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:tapOperCode, '_', b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_Sell">
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
	<xsl:template name="coaReference_Sell">
		<coaReference>
			<xsl:value-of select="b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Sell">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_Sell">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_Sell">
		<transactionDate>
			<xsl:value-of select="b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Sell">
		<xsl:if test="b:optionDescGroup/b:optionDesc = 'ACCEPTED.TENDER'">
			<tradeCcyGrossAmount>
				<xsl:value-of select="b:optionDescGroup[b:optionDesc = 'ACCEPTED.TENDER']/b:entitlementAmt"/>
			</tradeCcyGrossAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio_Sell">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_Sell">
		<tradeQuantity>
			<xsl:value-of select="b:finalDebitQty"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="tradePrice_Sell">
		<tradePrice>
			<xsl:value-of select="b:buybckPriceJoin"/>
		</tradePrice>
	</xsl:template>
	<xsl:template name="reversalIndicator_Sell">
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
						<xsl:value-of select="concat(b:tapOperCode, '_', b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Sell">
		<sourceSystemCode>
			<xsl:value-of select="b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Sell">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type_Sell">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Sell">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_Sell"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Sell"/>
	<xsl:template name="account2NetAmount_Sell"/>
	<xsl:template name="account3_Sell"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Sell"/>
	<xsl:template name="account3NetAmount_Sell"/>
	<xsl:template name="accountingCode_Sell"/>
	<xsl:template name="accruedInterestAmount_Sell"/>
	<xsl:template name="accruedInterestCounter_Sell"/>
	<xsl:template name="cashPortfolio_Sell"/>
	<xsl:template name="commonReference_Sell"/>
	<xsl:template name="communication_Sell"/>
	<xsl:template name="initiator_Sell"/>
	<xsl:template name="notepad_Sell"/>
	<xsl:template name="portfolioManager_Sell"/>
	<xsl:template name="positionCriteria1_Sell">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_Sell"/>
	<xsl:template name="positionCriteria3_Sell"/>
	<xsl:template name="remark_Sell"/>
	<xsl:template name="reversedTransactionCode_Sell"/>
	<xsl:template name="securityCcyNetAmount_Sell"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_Sell"/>
	<xsl:template name="subType_Sell"/>
	<xsl:template name="supplementaryAmount_Sell"/>
	<xsl:template name="tradeCcyNetAmount_Sell"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Sell"/>
	<xsl:template name="typeInstrument_Sell"/>
	<xsl:template name="userDefinedField_Sell"/>
	<xsl:template name="mbFields_Sell"/>
	<xsl:template name="exDate_Sell">
		<exDate>
			<xsl:value-of select="b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_Sell">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
	<!-- END OF SELL -->
</xsl:stylesheet>