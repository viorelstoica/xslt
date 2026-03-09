<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleeveAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:cuAccountNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="b:custNetAmt"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAcc"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:variable name="remark">
				<xsl:if test="b:upfrontSec = 'Y'">
					<xsl:value-of select="'Delivery of fund '"/>
					<xsl:value-of select="b:securityNo"/>
					<xsl:value-of select="' for mutual fund with upfront payment '"/>
				</xsl:if>
				<xsl:for-each select="b:custRemarksList/b:custRemarks">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="substring($remark,1,80)"/>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<xsl:choose>
			<xsl:when test="(b:tapRefId != '' and b:secHoldSettle = 'YES') or ((contains($sectPendTransNamesInSupportedTypes,b:transactionType)) and (not(b:autoCustSett) or b:autoCustSett = 'NO') and translate(b:valueDate,'-','') &gt; translate(b:eventCommon/ns0:today,'-',''))">
				<status>
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'EXECUTED'"/>
					</xsl:call-template>
				</status>
			</xsl:when>
			<xsl:otherwise>
				<status>
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
					</xsl:call-template>
				</status>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:choose>
			<xsl:when test="b:tapRefId != ''">
				<transactionCode>
					<xsl:value-of select="b:tapRefId"/>
				</transactionCode>
			</xsl:when>
			<xsl:otherwise>
				<transactionCode>
					<xsl:choose>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,'_','ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</transactionCode>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printTransferFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransferIn'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',b:transactionType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency">
		<xsl:if test="b:cuAccountCcy != '' or b:cuAccountCcy">
			<accountCurrency>
				<infra:code>
					<xsl:value-of select="b:cuAccountCcy"/>
				</infra:code>
			</accountCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="commonReference"/>
	<xsl:template name="accruedInterests">
		<accruedInterests>
			<xsl:choose>
				<xsl:when test="b:interestAmt">
					<xsl:value-of select="b:interestAmt"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</accruedInterests>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:choose>
			<xsl:when test="b:depository !='' and b:depository and b:subAccountTypeList/b:subAccountType[@index=1]=$subAccountNature">
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
			<xsl:otherwise>
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="b:depository"/>
					</infra:code>
				</depositaryAccount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="histOpExchRate">
		<xsl:if test="$TAKE_HIST_VALUES_INV = 'YES' and (not(b:peFund) or b:peFund = 'NO') and (not(b:upfrontSec) or b:upfrontSec != 'Y')">
			<xsl:if test="$boDefaultExch_Inverse_Flag = '1' and (b:grossAmtSecCcy and b:grossAmtSecCcy != '') and (b:cost and b:cost != '') and (b:cost and number(b:cost) != '0')">
				<histOpExchRate>
					<xsl:value-of select="format-number(b:grossAmtSecCcy div b:cost,$decimalformat,'nan2zero')"/>
				</histOpExchRate>
			</xsl:if>
			<xsl:if test="$boDefaultExch_Inverse_Flag = '0' and (b:cost and b:cost != '') and (b:grossAmtSecCcy and b:grossAmtSecCcy != '') and (b:grossAmtSecCcy and number(b:grossAmtSecCcy) != '0')">
				<histOpExchRate>
					<xsl:value-of select="format-number(b:cost div b:grossAmtSecCcy,$decimalformat,'nan2zero')"/>
				</histOpExchRate>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="histOpNetAmount"/>
	<xsl:template name="histQuote">
		<xsl:if test="$TAKE_HIST_VALUES_INV = 'YES' and (not(b:peFund) or b:peFund = 'NO') and (not(b:upfrontSec) or b:upfrontSec != 'Y')">
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
			<xsl:value-of select="b:tradeDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transferPrice">
		<xsl:if test="b:upfrontSec = 'Y' or (b:peFund = 'YES' and b:peType = 'ACTUAL PE SECURITY' and b:custRemarksList/b:custRemarks = 'Unit Allotment')">
			<transferPrice>
				<xsl:value-of select="b:price"/>
			</transferPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="positionCriteria1">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate">
		<xsl:variable name="cost">
			<xsl:choose>
				<xsl:when test="b:cost and b:cost != ''">
					<xsl:value-of select="b:cost"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="grossAmtSecCcy">
			<xsl:choose>
				<xsl:when test="b:grossAmtSecCcy and b:grossAmtSecCcy != ''">
					<xsl:value-of select="b:grossAmtSecCcy"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="netAmtSecCcy">
			<xsl:choose>
				<xsl:when test="b:netAmtSecCcy and b:netAmtSecCcy != ''">
					<xsl:value-of select="b:netAmtSecCcy"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="interestAmt">
			<xsl:choose>
				<xsl:when test="b:interestAmt and b:interestAmt != ''">
					<xsl:value-of select="b:interestAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="custNetAmt">
			<xsl:choose>
				<xsl:when test="b:custNetAmt and b:custNetAmt != ''">
					<xsl:value-of select="b:custNetAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="b:referenceCurrencyJoin = b:cuAccountCcy">
				<xsl:choose>
					<xsl:when test="(number($netAmtSecCcy) - number($interestAmt) - number($grossAmtSecCcy) = '0') or number($custNetAmt) = '0'"/>
					<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
						<transactionCcyPortfolioCcyExchangeRate>
							<xsl:value-of select="format-number(($netAmtSecCcy - $interestAmt - $grossAmtSecCcy) div $custNetAmt,$decimalformat,'nan2zero')"/>
						</transactionCcyPortfolioCcyExchangeRate>
					</xsl:when>
					<xsl:otherwise>
						<transactionCcyPortfolioCcyExchangeRate>
							<xsl:value-of select="format-number($custNetAmt div ($netAmtSecCcy - $interestAmt - $grossAmtSecCcy),$decimalformat,'nan2zero')"/>
						</transactionCcyPortfolioCcyExchangeRate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="number($cost) = '0' or number($grossAmtSecCcy) = '0'"/>
					<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
						<transactionCcyPortfolioCcyExchangeRate>
							<xsl:value-of select="format-number($cost div $grossAmtSecCcy,$decimalformat,'nan2zero')"/>
						</transactionCcyPortfolioCcyExchangeRate>
					</xsl:when>
					<xsl:otherwise>
						<transactionCcyPortfolioCcyExchangeRate>
							<xsl:value-of select="format-number($grossAmtSecCcy div $cost,$decimalformat,'nan2zero')"/>
						</transactionCcyPortfolioCcyExchangeRate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="paymentDate">
		<paymentDate>
			<xsl:value-of select="b:valueDate"/>
		</paymentDate>
	</xsl:template>
	<xsl:template name="paymentStatus"/>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:value-of select="b:valueDate"/>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus"/>
	<xsl:template name="boAccount">
		<boAccount>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:cuAccountNo"/>
				</xsl:if>
			</infra:code>
		</boAccount>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:securityAcc"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'1'"/>
					</xsl:otherwise>
				</xsl:choose>
		</splitPortfolio>
	</xsl:template>

	<!-- 
        Delivery of fund for upfront payment - part 1 - invest back cash fees
    -->
	<xsl:template name="account1_FundUpFrInvFees"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_FundUpFrInvFees"/>
	<xsl:template name="account1NetAmount_FundUpFrInvFees"/>
	<xsl:template name="account2_FundUpFrInvFees"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_FundUpFrInvFees"/>
	<xsl:template name="account2NetAmount_FundUpFrInvFees"/>
	<xsl:template name="account3_FundUpFrInvFees"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_FundUpFrInvFees"/>
	<xsl:template name="account3NetAmount_FundUpFrInvFees"/>
	<xsl:template name="accountingCode_FundUpFrInvFees"/>
	<xsl:template name="accountingDate_FundUpFrInvFees">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio_FundUpFrInvFees"/>
	<xsl:template name="commonReference_FundUpFrInvFees"/>
	<xsl:template name="ContractNumber_FundUpFrInvFees"/>
	<xsl:template name="notepad_FundUpFrInvFees"/>
	<xsl:template name="portfolioManager_FundUpFrInvFees"/>
	<xsl:template name="reversalIndicator_FundUpFrInvFees"/>
	<xsl:template name="reversedTransactionCode_FundUpFrInvFees"/>
	<xsl:template name="subType_FundUpFrInvFees"/>
	<xsl:template name="transactionCode_FundUpFrInvFees">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="concat(b:tapOperCode,'_','ST_I_UPFR_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_I_UPFR_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_FundUpFrInvFees"/>
	<xsl:template name="currentAccount_FundUpFrInvFees">
		<currentAccount>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt != ''">
						<xsl:value-of select="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:linkReferenceCustTransCodeGroup/b:linkReferenceCustAccNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="portfolio_FundUpFrInvFees">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt != ''">
						<xsl:choose>
							<xsl:when test="b:linkReferenceCuIncomeAccPtfGroup/b:linkReferenceCuIncomeAccPtfList/b:linkReferenceCuIncomeAccPtf and b:linkReferenceCuIncomeAccPtfGroup/b:linkReferenceCuIncomeAccPtfList/b:linkReferenceCuIncomeAccPtf != ''">
								<xsl:value-of select="b:linkReferenceCuIncomeAccPtfGroup/b:linkReferenceCuIncomeAccPtfList/b:linkReferenceCuIncomeAccPtf"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:linkReferenceCuIncomeAccSamHistIdList/b:linkReferenceCuIncomeAccSamHistId"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAcc"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity_FundUpFrInvFees">
		<quantity>
			<xsl:choose>
				<xsl:when test="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt != ''">
					<xsl:value-of select="- b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:linkReferenceCustTransCodeGroup/b:linkReferenceCuAmountDue -(round(b:linkReferenceCustTransCodeGroup/b:linkReferenceCuGrossAmTrd * (b:linkReferenceCustTransCodeGroup/b:linkReferenceCuAmountDue div b:linkReferenceCustTransCodeGroup/b:linkReferenceCuNetAmTrd) * 100) div 100), $decimalformat, 'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="remark_FundUpFrInvFees">
		<remark>
			<xsl:value-of select="'Correction: Re-invest fees paid with Upfront payment on '"/>
			<xsl:value-of select="b:securityNo"/>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode_FundUpFrInvFees">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_FundUpFrInvFees">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type_FundUpFrInvFees"/>
	<xsl:template name="valueDate_FundUpFrInvFees">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_FundUpFrInvFees"/>
	<xsl:template name="mbFields_FundUpFrInvFees"/>
	<xsl:template name="intermediary_FundUpFrInvFees"/>
	<xsl:template name="market_FundUpFrInvFees"/>
	<xsl:template name="transactionCcyGrossAmount_FundUpFrInvFees"/>
	<xsl:template name="transactionCcyNetAmount_FundUpFrInvFees"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate_FundUpFrInvFees"/>
	<xsl:template name="transactionCurrency_FundUpFrInvFees"/>
	<xsl:template name="transactionDate_FundUpFrInvFees"/>

	<!-- 
        Delivery of fund for upfront payment - part 2 - security buy trade with only fees mapped from the original upfront payment - so that the fees are allocated to the real position.
    -->

	<xsl:template name="account1_upfrontTradeFees">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt != ''">
						<xsl:value-of select="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:linkReferenceCustTransCodeGroup/b:linkReferenceCustAccNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_upfrontTradeFees"/>
	<xsl:template name="account1NetAmount_upfrontTradeFees">
		<account1NetAmount>
			<xsl:choose>
				<xsl:when test="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt != ''">
					<xsl:value-of select="- b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:linkReferenceCustTransCodeGroup/b:linkReferenceCuAmountDue -(round(b:linkReferenceCustTransCodeGroup/b:linkReferenceCuGrossAmTrd * (b:linkReferenceCustTransCodeGroup/b:linkReferenceCuAmountDue div b:linkReferenceCustTransCodeGroup/b:linkReferenceCuNetAmTrd) * 100) div 100), $decimalformat, 'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account2_upfrontTradeFees"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_upfrontTradeFees"/>
	<xsl:template name="account2NetAmount_upfrontTradeFees"/>
	<xsl:template name="account3_upfrontTradeFees"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_upfrontTradeFees"/>
	<xsl:template name="account3NetAmount_upfrontTradeFees"/>
	<xsl:template name="accountingCode_upfrontTradeFees"/>
	<xsl:template name="accountingDate_upfrontTradeFees">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio_upfrontTradeFees">
		<xsl:if test="b:linkReferenceCustTransCodeGroup/b:linkReferenceCuIncomeAmt != ''">
			<cashPortfolio>
				<portfolio>
					<infra:code>
						<xsl:choose>
							<xsl:when test="b:linkReferenceCuIncomeAccPtfGroup/b:linkReferenceCuIncomeAccPtfList/b:linkReferenceCuIncomeAccPtf">
								<xsl:value-of select="b:linkReferenceCuIncomeAccPtfGroup/b:linkReferenceCuIncomeAccPtfList/b:linkReferenceCuIncomeAccPtf"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:linkReferenceCuIncomeAccSamHistIdList/b:linkReferenceCuIncomeAccSamHistId"/>
							</xsl:otherwise>
						</xsl:choose>
					</infra:code>
				</portfolio>
			</cashPortfolio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="commonReference_upfrontTradeFees"/>
	<xsl:template name="ContractNumber_upfrontTradeFees"/>
	<xsl:template name="notepad_upfrontTradeFees"/>
	<xsl:template name="portfolio_upfrontTradeFees">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAcc"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_upfrontTradeFees"/>
	<xsl:template name="remark_upfrontTradeFees">
		<remark>
			<xsl:value-of select="'Fees paid with upfront transaction '"/>
			<xsl:value-of select="b:linkReference"/>
		</remark>
	</xsl:template>
	<xsl:template name="reversalIndicator_upfrontTradeFees"/>
	<xsl:template name="reversedTransactionCode_upfrontTradeFees"/>
	<xsl:template name="sourceSystemCode_upfrontTradeFees">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_upfrontTradeFees">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_upfrontTradeFees"/>
	<xsl:template name="transactionCode_upfrontTradeFees">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="concat(b:tapOperCode,'_','ST_I_UPFR_FEESFROMTRADE_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_I_UPFR_FEESFROMTRADE_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_upfrontTradeFees">
		<xsl:call-template name="printTradeFeesAndTaxesFromUpfrontTrade"/>
	</xsl:template>
	<xsl:template name="type_upfrontTradeFees">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',b:linkReferenceCustTransCodeGroup/b:linkReferenceCustTransCode)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_upfrontTradeFees">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_upfrontTradeFees"/>
	<xsl:template name="mbFields_upfrontTradeFees"/>
	<xsl:template name="accountCurrency_upfrontTradeFees"/>
	<xsl:template name="accruedInterests_upfrontTradeFees"/>
	<xsl:template name="accruedInterestCounter_upfrontTradeFees"/>
	<xsl:template name="broker_upfrontTradeFees"/>
	<xsl:template name="contactMethod_upfrontTradeFees"/>
	<xsl:template name="depositaryAccount_upfrontTradeFees">
		<depositaryAccount>
			<infra:code>
				<xsl:value-of select="b:depository"/>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
	<xsl:template name="exCoupon_upfrontTradeFees"/>
	<xsl:template name="executionSetCriteria_upfrontTradeFees"/>
	<xsl:template name="initiatedBy_upfrontTradeFees"/>
	<xsl:template name="initiator_upfrontTradeFees"/>
	<xsl:template name="limitPrice_upfrontTradeFees"/>
	<xsl:template name="orderType_upfrontTradeFees"/>
	<xsl:template name="orderValidityType_upfrontTradeFees"/>
	<xsl:template name="originalOrderCode_upfrontTradeFees"/>
	<xsl:template name="positionCriteria1_upfrontTradeFees"/>
	<xsl:template name="positionCriteria2_upfrontTradeFees"/>
	<xsl:template name="positionCriteria3_upfrontTradeFees"/>
	<xsl:template name="price_upfrontTradeFees"/>
	<xsl:template name="quantity_upfrontTradeFees">
		<quantity>0</quantity>
	</xsl:template>
	<xsl:template name="security_upfrontTradeFees">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="intermediary_upfrontTradeFees"/>
	<xsl:template name="market_upfrontTradeFees"/>
	<xsl:template name="securityCcyNetAmount_upfrontTradeFees"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_upfrontTradeFees"/>
	<xsl:template name="stockExchange_upfrontTradeFees"/>
	<xsl:template name="stopPrice_upfrontTradeFees"/>
	<xsl:template name="trader_upfrontTradeFees"/>
	<xsl:template name="tradeCurrency_upfrontTradeFees"/>
	<xsl:template name="tradeCcyGrossAmount_upfrontTradeFees"/>
	<xsl:template name="tradeCcyNetAmount_upfrontTradeFees"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_upfrontTradeFees"/>
	<xsl:template name="compundOrderCode_upfrontTradeFees"/>
	<xsl:template name="compoundOrderMaster_upfrontTradeFees"/>
	<xsl:template name="compoundOrderSlave_upfrontTradeFees"/>
	<xsl:template name="paymentOptionE_upfrontTradeFees"/>
	<xsl:template name="targetAmount_upfrontTradeFees"/>
	<xsl:template name="targetNature_upfrontTradeFees"/>
	<xsl:template name="targetObjective_upfrontTradeFees"/>
	<xsl:template name="tradeDate_upfrontTradeFees">
		<tradeDate>
			<xsl:value-of select="b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="validityDate_upfrontTradeFees"/>
</xsl:stylesheet>