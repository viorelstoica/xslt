<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<!-- BEG Templates for checking SinkingRedemption(Partial) and SinkingRedemption(Final) Criterias -->
	<xsl:template name="CheckSinkingRedemptionPartial">
		<xsl:choose>
			<xsl:when test="b:optionNom and number(b:optionNom) != '0' and ../b:bookCostPercGroup/b:newFactorDiaryJoin and number(../b:bookCostPercGroup/b:newFactorDiaryJoin) != '0'">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CheckSinkingRedemptionFinal">
		<xsl:choose>
			<xsl:when test="b:entitlementAmt and number(b:entitlementAmt) != '0' and number(../b:bookCostPercGroup/b:newFactorDiaryJoin) = '0'">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- END Templates for checking SinkingRedemption(Partial) and SinkingRedemption(Final) Criterias -->

	<!-- BEG - SinkingRedemption(Partial) -->
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyPositionCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,$decimalformat,'nan2zero')"/>
			</account1CcyPositionCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="format-number(../b:netAmtAccCur * (-1),$decimalformat,'nan2zero')"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator">
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
				<reversalIndicator>
					<xsl:value-of select=" '1' "/>
				</reversalIndicator>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
				<reversedTransactionCode>
					<xsl:choose>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_P',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_P',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</reversedTransactionCode>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionCode">
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_P',$COMPANY_POSTFIX_SEPARATOR,'R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_P',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat($entitlementId,'_P',$COMPANY_POSTFIX_SEPARATOR,'R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_P',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printEntitlementFeesAndTaxes">
			<xsl:with-param name="sourceTax" select="../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="../b:commissionAmt"/>
			<xsl:with-param name="commTax" select="../b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="currencyFT" select="../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="positionCriteria1">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="mbFields"/>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="initiator"/>
	<xsl:template name="redemptionAmount">
		<redemptionAmount>
			<xsl:value-of select="format-number(b:entitlementAmt * (-1),$decimalformat,'nan2zero')"/>
		</redemptionAmount>
	</xsl:template>
	<xsl:template name="redemptionNetAmount">
		<redemptionNetAmount>
			<xsl:value-of select="format-number(../b:netAmtAccCur * (-1),$decimalformat,'nan2zero')"/>
		</redemptionNetAmount>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:choose>
   		<xsl:when test="../b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../b:subAccount != ''">
					<xsl:value-of select="concat(../b:depository,'_',../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="exDate">
	    <exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<!-- END - SinkingRedemption(Partial) -->

	<!-- BEG - SinkingRedemption(Final) -->
	<xsl:template name="account1_Final">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyRedemptionCcyExchangeRate_Final">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyRedemptionCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,$decimalformat,'nan2zero')"/>
			</account1CcyRedemptionCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Final">
		<account1NetAmount>
			<xsl:value-of select="../b:netAmtAccCur"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate_Final">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode_Final">
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_F',$COMPANY_POSTFIX_SEPARATOR,'R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_F',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat($entitlementId,'_F',$COMPANY_POSTFIX_SEPARATOR,'R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_F',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_Final">
		<xsl:choose>
   		<xsl:when test="../b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../b:subAccount != ''">
					<xsl:value-of select="concat(../b:depository,'_',../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="coaReference_Final">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Final">
		<security>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="redemptionCurrency_Final">
		<redemptionCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</redemptionCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_Final">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="redemptionCcyGrossAmount_Final">
		<redemptionCcyGrossAmount>
			<xsl:value-of select="b:entitlementAmt"/>
		</redemptionCcyGrossAmount>
	</xsl:template>
	<xsl:template name="redemptionCcyNetAmount_Final">
		<redemptionCcyNetAmount>
			<xsl:value-of select="../b:netAmtAccCur"/>
		</redemptionCcyNetAmount>
	</xsl:template>
	<xsl:template name="portfolio_Final">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="redemptionQuantity_Final">
		<redemptionQuantity>
			<xsl:value-of select="../b:qualifyHolding"/>
		</redemptionQuantity>
	</xsl:template>
	<xsl:template name="redemptionPrice_Final">
		<redemptionPrice>
			<xsl:value-of select="../b:bookCostPercGroup/b:rate"/>
		</redemptionPrice>
	</xsl:template>
	<xsl:template name="reversalIndicator_Final">
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
				<reversalIndicator>
					<xsl:value-of select=" '1' "/>
				</reversalIndicator>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_Final">
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
				<reversedTransactionCode>
					<xsl:choose>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_F',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_F',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</reversedTransactionCode>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Final">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Final">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="positionCriteria1_Final">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="type_Final">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Final">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_Final"/>
	<xsl:template name="account2CcyRedemptionCcyExchangeRate_Final"/>
	<xsl:template name="account2NetAmount_Final"/>
	<xsl:template name="account3_Final"/>
	<xsl:template name="account3CcyRedemptionCcyExchangeRate_Final"/>
	<xsl:template name="account3NetAmount_Final"/>
	<xsl:template name="accountingCode_Final"/>
	<xsl:template name="accruedInterests_Final"/>
	<xsl:template name="cashPortfolio_Final"/>
	<xsl:template name="commonReference_Final"/>
	<xsl:template name="contractNumber_Final"/>
	<xsl:template name="initiator_Final"/>
	<xsl:template name="notepad_Final"/>
	<xsl:template name="portfolioManager_Final"/>
	<xsl:template name="positionCriteria2_Final"/>
	<xsl:template name="positionCriteria3_Final"/>
	<xsl:template name="redemptionCcyPortfolioCcyExchangeRate_Final"/>
	<xsl:template name="remark_Final"/>
	<xsl:template name="securityCcyNetAmount_Final"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_Final"/>
	<xsl:template name="subType_Final"/>
	<xsl:template name="typeInstrument_Final"/>
	<xsl:template name="userDefinedField_Final"/>
	<xsl:template name="mbFields_Final"/>
	<xsl:template name="transactionFeesTaxesCounter_Final">
		<xsl:param name="fgnChargesAmt">
			<xsl:value-of select="format-number(../b:fgnChargesAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="foreignChgesTax">
			<xsl:value-of select="format-number(../b:foreignChgesTax,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="sourceTaxAmt">
			<xsl:value-of select="format-number(../b:sourceTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="localTaxAmtSum">
			<xsl:value-of select="format-number(sum(../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commissionAmt">
			<xsl:value-of select="format-number(../b:commissionAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commTaxAmt">
			<xsl:value-of select="format-number(../b:commTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="manTaxAcySum">
			<xsl:value-of select="format-number(sum(../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="scAmtAcySum">
			<xsl:value-of select="format-number(sum(../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="taxCredit">
			<xsl:value-of select="format-number(../b:taxCredit,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$sourceTaxAmt + $fgnChargesAmt"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP1'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP10'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$sourceTaxAmt + $localTaxAmtSum"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP2'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP3'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$commissionAmt + $commTaxAmt"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP4'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$manTaxAcySum + $scAmtAcySum"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP5'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP6'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$taxCredit"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP7'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP8'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP9'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="exDate_Final">
	    <exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Final">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<!-- END - SinkingRedemption(Final) -->
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