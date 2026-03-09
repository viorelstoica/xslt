<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<!-- variables for evaluating the different cases -->
	<!--   Exchange against another security-->
	<xsl:template name="repurchaseExchangeAgainstSecurityCriteria">
		<xsl:value-of select="b:newSecuritySubGroup and b:newSecuritySubGroup/b:newSecurity != ../b:securityNo and b:newSecuritySubGroup/b:nominal"/>
	</xsl:template>
	<!--   Sell the position -->
	<xsl:template name="repurchaseSellCriteria">
		<xsl:value-of select="not(b:newSecuritySubGroup) or (b:newSecuritySubGroup/b:newSecurity = ../b:securityNo and b:entitlementAmt != 0)"/>
	</xsl:template>
	<!--   Take no action -->
	<xsl:template name="repurchaseNoActionCriteria">
		<xsl:value-of select="b:newSecuritySubGroup and b:newSecuritySubGroup/b:newSecurity = ../b:securityNo and not(b:entitlementAmt)"/>
	</xsl:template>
	<!--   Custo Case 1 -->
	<xsl:template name="repurchaseCusto1Criteria">
		<xsl:value-of select="'false'"/>
	</xsl:template>
	<!-- elements -->
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount ,$decimalformat,'nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="../b:netAmtAccCur"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
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
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<!-- opStatus -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
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
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
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
	<xsl:template name="tradeCcyGrossAmount">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number(b:entitlementAmt,$decimalformat,'nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice">
		<xsl:variable name="qty" select="format-number(b:optionNom,$decimalformat,'nan2zero')"/>
		<xsl:variable name="cash" select="format-number(b:entitlementAmt,$decimalformat,'nan2zero')"/>
		<tradePrice>
			<xsl:choose>
				<xsl:when test="../b:PriceTypeSecurityNoJoin = 'BOND'">
					<xsl:value-of select="format-number(($cash div $qty) * 100,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number($cash div $qty,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</tradePrice>
	</xsl:template>
	<xsl:template name="tradeQuantity">
		<tradeQuantity>
			<xsl:value-of select="format-number(b:optionNom,$decimalformat,'nan2zero')"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode">
		<!-- opStatus -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
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
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat($entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
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
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accruedInterestAmount"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="communication"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="positionCriteria1">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="subType"/>
	<xsl:template name="supplementaryAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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
	<xsl:template name="account1_Adj">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyoldSecCcyExchangeRate_Adj">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyoldSecCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyoldSecCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate_Adj">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="accruedInterestAmount_Adj">
		<accruedInterestAmount>
			<xsl:value-of select="'0'"/>
		</accruedInterestAmount>
	</xsl:template>
	<xsl:template name="adjustmentNature_Adj">
		<adjustmentNature>
			<xsl:value-of select="'2'"/>
			<!-- 2 is PL -->
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="coaReference_Adj">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="newQuantity_Adj">
		<newQuantity>
			<xsl:value-of select="b:newSecuritySubGroup/b:nominal"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurity_Adj">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:newSecuritySubGroup/b:newSecurity"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount_Adj">
		<xsl:choose>
			<xsl:when test="../b:depository != ''">
				<newSecurityDepositaryAccount>
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
				</newSecurityDepositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="oldQuantity_Adj">
		<oldQuantity>
			<xsl:value-of select="format-number(b:optionNom * (-1),$decimalformat,'nan2zero')"/>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldSecurity_Adj">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount_Adj">
		<xsl:choose>
			<xsl:when test="../b:depository != ''">
				<oldSecurityDepositaryAccount>
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
				</oldSecurityDepositaryAccount>
			</xsl:when>
		</xsl:choose>	
	</xsl:template>
	<xsl:template name="portfolio_Adj">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_Adj">
		<!-- opStatus -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
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
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Adj">
		<!-- EntitlementId -->
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Adj">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_Adj">
		<!-- opStatus -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
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
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat($entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_',@index,'/',b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Adj">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Adj">
		<!-- Fees and taxes part -->
		<xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
		<xsl:variable name="sumManTaxAcy" select="format-number(sum(../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
		<xsl:variable name="sumScAmtAcy" select="format-number(sum(../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
		<!-- call the template to print the FT -->
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="$sumlocalTaxAmt"/>
			<xsl:with-param name="commission" select="../b:commissionAmt"/>
			<xsl:with-param name="commTax" select="../b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="$sumManTaxAcy"/>
			<xsl:with-param name="sumScAmtAcy" select="$sumScAmtAcy"/>
			<xsl:with-param name="currencyFT" select="../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_Adj">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Adj">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1NetAmount_Adj"/>
	<xsl:template name="account2_Adj"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate_Adj"/>
	<xsl:template name="account2NetAmount_Adj"/>
	<xsl:template name="account3_Adj"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate_Adj"/>
	<xsl:template name="account3NetAmount_Adj"/>
	<xsl:template name="accountingCode_Adj"/>
	<xsl:template name="accruedInterestCounter_Adj"/>
	<xsl:template name="adjustmentCounter_Adj"/>
	<xsl:template name="adjustmentPortfolio_Adj"/>
	<xsl:template name="cashPortfolio_Adj"/>
	<xsl:template name="commonReference_Adj"/>
	<xsl:template name="communication_Adj"/>
	<xsl:template name="initiator_Adj"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate_Adj"/>
	<xsl:template name="newSecurityNetAmount_Adj"/>
	<xsl:template name="newSecurityPositionCriteria1_Adj"/>
	<xsl:template name="newSecurityPositionCriteria2_Adj"/>
	<xsl:template name="newSecurityPositionCriteria3_Adj"/>
	<xsl:template name="newSecurityPositionCurrency_Adj"/>
	<xsl:template name="notepad_Adj"/>
	<xsl:template name="oldCcyGrossAmount_Adj"/>
	<xsl:template name="oldCcyNetAmount_Adj"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate_Adj"/>
	<xsl:template name="oldPrice_Adj">
		<xsl:variable name="qty" select="format-number(../b:secNoGroup[b:secNo = ../b:securityNo]/b:secNominal  * (-1),$decimalformat,'nan2zero')"/>
		<xsl:variable name="cash" select="format-number(b:entitlementAmt,$decimalformat,'nan2zero')"/>
		<oldPrice>
			<xsl:value-of select="format-number($cash div $qty,$decimalformat,'nan2zero')"/>
		</oldPrice>
	</xsl:template>
	<xsl:template name="oldSecurityPositionCriteria1_Adj">
		<oldSecurityPositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</oldSecurityPositionCriteria1>
	</xsl:template>
	<xsl:template name="oldSecurityPositionCriteria2_Adj"/>
	<xsl:template name="oldSecurityPositionCriteria3_Adj"/>
	<xsl:template name="oldSecurityPositionCurrency_Adj"/>
	<xsl:template name="portfolioManager_Adj"/>
	<xsl:template name="remark_Adj"/>
	<xsl:template name="reversedTransactionCode_Adj"/>
	<xsl:template name="subType_Adj"/>
	<xsl:template name="supplementaryAmount_Adj"/>
	<xsl:template name="typeInstrument_Adj"/>
	<xsl:template name="userDefinedField_Adj"/>
	<xsl:template name="mbFields_Adj"/>
	<xsl:template name="exDate_Adj">
		<exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_Adj">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
</xsl:stylesheet>