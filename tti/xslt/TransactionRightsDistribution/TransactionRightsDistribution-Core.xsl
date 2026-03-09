<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
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
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyPositionCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="'0'"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate">
		<xsl:if test="../b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../b:optionDescGroup/b:tapRefId and (../b:optionDescGroup/b:tapRefId != '' or ../b:optionDescGroup/b:tapRefId != 'NULL')">
						<xsl:value-of select="../b:optionDescGroup/b:tapRefId"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../b:tapOperCode and ../b:tapOperCode !=''">
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_distrib/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../b:entitlementId,'_distrib/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
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
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<!-- secNoGroup index (never 0), followed by security index -->
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="../b:optionDescGroup/b:tapRefId and (../b:optionDescGroup/b:tapRefId != '' or ../b:optionDescGroup/b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(../b:optionDescGroup/b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_distrib/',@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat(../b:entitlementId,'_distrib/',@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../b:optionDescGroup/b:tapRefId and (../b:optionDescGroup/b:tapRefId != '' or ../b:optionDescGroup/b:tapRefId != 'NULL')">
							<xsl:value-of select="../b:optionDescGroup/b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_distrib/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat(../b:entitlementId,'_distrib/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printEntitlementFeesAndTaxes">
			<xsl:with-param name="sourceTax" select="'0'"/>
			<xsl:with-param name="fgnCharges" select="'0'"/>
			<xsl:with-param name="foreignChgesTax" select="'0'"/>
			<xsl:with-param name="sumlocalTaxAmt" select="'0'"/>
			<xsl:with-param name="commission" select="'0'"/>
			<xsl:with-param name="commTax" select="'0'"/>
			<xsl:with-param name="sumManTaxAcy" select="'0'"/>
			<xsl:with-param name="sumScAmtAcy" select="'0'"/>
			<xsl:with-param name="currencyFT" select="../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:EventTypeJoin)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="substring-before(../b:entitlementId,'.')"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="originalSecurityDepositaryAccount">
		<xsl:choose>
   		<xsl:when test="../b:depository != ''">
		<originalSecurityDepositaryAccount>
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
		</originalSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="originalSecurity">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:if test="../b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="rightDepositaryAccount">
		<xsl:choose>
			<xsl:when test="../b:depository != ''">
				<rightDepositaryAccount>
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
				</rightDepositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="rightQuantity">
		<rightQuantity>
			<xsl:value-of select="b:secNominal"/>
		</rightQuantity>
	</xsl:template>
	<xsl:template name="rightUnitaryCostPrice">
		<rightUnitaryCostPrice>
			<xsl:value-of select="'0'"/>
		</rightUnitaryCostPrice>
	</xsl:template>
	<xsl:template name="right">
		<right>
			<infra:code>
				<xsl:value-of select="b:secNo"/>
			</infra:code>
		</right>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="initiator"/>
	<xsl:template name="originalSecurityPositionCriteria1"/>
	<xsl:template name="originalSecurityPositionCriteria2"/>
	<xsl:template name="originalSecurityPositionCriteria3"/>
	<xsl:template name="originalSecurityPositionCurrency"/>
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
	<xsl:template name="positionCurrency"/>
	<xsl:template name="profitLossCounter"/>
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
	<xsl:template name="account1_TransferIn">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyPurchaseCcyExchangeRate_TransferIn">
		<account1CcyPurchaseCcyExchangeRate>
			<xsl:value-of select="../b:accExchRate"/>
		</account1CcyPurchaseCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount_TransferIn">
		<account1NetAmount>
			<xsl:value-of select="../b:netAmtAccCur * (-1)"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate_TransferIn">
		<xsl:if test="../b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionCode_TransferIn">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
					<xsl:value-of select="../b:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_BUY',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_BUY',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_TransferIn">
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
	<xsl:template name="coaReference_TransferIn">
		<coaReference>
			<xsl:value-of select="substring-before(../b:entitlementId,'.')"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_TransferIn">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecuritySubGroup[@index = 1]/b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="portfolio_TransferIn">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="conversionQuantity_TransferIn">
		<xsl:if test="b:newSecuritySubGroup/b:nominal != 0">
			<conversionQuantity>
				<xsl:value-of select="b:newSecuritySubGroup[@index = 1]/b:nominal"/>
			</conversionQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="purchasePrice_TransferIn">
		<xsl:if test="b:newSecuritySubGroup[@index = 1]/b:price != 0">
			<purchasePrice>
				<!-- Assume 1 new share by option -->
				<xsl:value-of select="b:newSecuritySubGroup[@index = 1]/b:price"/>
			</purchasePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="type_TransferIn">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:EventTypeJoin)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_TransferIn">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="status_TransferIn">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_TransferIn">
		<xsl:choose>
			<xsl:when test="b:newSecuritySubGroup/@index = 1">
				<xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumManTaxAcy" select="format-number(sum(../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumScAmtAcy" select="format-number(sum(../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
				<xsl:call-template name="printEntitlementFeesAndTaxes">
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
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="printEntitlementFeesAndTaxes">
					<xsl:with-param name="sourceTax" select="'0'"/>
					<xsl:with-param name="fgnCharges" select="'0'"/>
					<xsl:with-param name="foreignChgesTax" select="'0'"/>
					<xsl:with-param name="sumlocalTaxAmt" select="'0'"/>
					<xsl:with-param name="commission" select="'0'"/>
					<xsl:with-param name="commTax" select="'0'"/>
					<xsl:with-param name="sumManTaxAcy" select="'0'"/>
					<xsl:with-param name="sumScAmtAcy" select="'0'"/>
					<xsl:with-param name="currencyFT" select="../b:currency"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="purchaseDate_TransferIn">
		<xsl:if test="../b:PayDateJoin">
			<purchaseDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</purchaseDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_TransferIn">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="reversalIndicator_TransferIn">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
						<xsl:value-of select="b:tapRefId"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../b:tapOperCode and ../b:tapOperCode !=''">
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_distrib/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../b:entitlementId,'_distrib/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account2_TransferIn"/>
	<xsl:template name="account2CcyPurchaseCcyExchangeRate_TransferIn"/>
	<xsl:template name="account2NetAmount_TransferIn"/>
	<xsl:template name="account3_TransferIn"/>
	<xsl:template name="account3CcyPurchaseCcyExchangeRate_TransferIn"/>
	<xsl:template name="account3NetAmount_TransferIn"/>
	<xsl:template name="accountingCode_TransferIn"/>
	<xsl:template name="accruedInterests_TransferIn"/>
	<xsl:template name="accruedInterestCounter_TransferIn"/>
	<xsl:template name="cashPortfolio_TransferIn"/>
	<xsl:template name="commonReference_TransferIn"/>
	<xsl:template name="contractNumber_TransferIn"/>
	<xsl:template name="initiator_TransferIn"/>
	<xsl:template name="notepad_TransferIn"/>
	<xsl:template name="portfolioManager_TransferIn"/>
	<xsl:template name="positionCriteria1_TransferIn">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_TransferIn"/>
	<xsl:template name="positionCriteria3_TransferIn"/>
	<xsl:template name="purchaseCcyGrossAmount_TransferIn"/>
	<xsl:template name="purchaseCcyNetAmount_TransferIn"/>
	<xsl:template name="purchaseCcyPortfolioCcyExchangeRate_TransferIn"/>
	<xsl:template name="purchaseCurrency_TransferIn"/>
	<xsl:template name="remark_TransferIn"/>
	<xsl:template name="reversedTransactionCode_TransferIn"/>
	<xsl:template name="securityCcyNetAmount_TransferIn"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_TransferIn"/>
	<xsl:template name="subType_TransferIn"/>
	<xsl:template name="typeInstrument_TransferIn"/>
	<xsl:template name="userDefinedField_TransferIn"/>
	<xsl:template name="mbFields_TransferIn"/>
	<xsl:template name="exDate_TransferIn">
		<exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_TransferIn">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
	<xsl:template name="account1_TransferOut">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate_TransferOut">
		<xsl:if test="b:netAmount != 0">
			<account1CcyPositionCcyExchangeRate>
				<xsl:value-of select="format-number(b:netAmtAccCur div b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyPositionCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate_TransferOut">
		<xsl:if test="../b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio_TransferOut">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_TransferOut">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
						<xsl:value-of select="concat(b:tapRefId,'-A')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exch',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exch',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_TransferOut">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_TransferOut">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:tapRefId,'-A','_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOPerCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:tapRefId,'-A')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_TransferOut">
		<xsl:call-template name="printEntitlementFeesAndTaxes">
			<xsl:with-param name="sourceTax" select="'0'"/>
			<xsl:with-param name="fgnCharges" select="'0'"/>
			<xsl:with-param name="foreignChgesTax" select="'0'"/>
			<xsl:with-param name="sumlocalTaxAmt" select="'0'"/>
			<xsl:with-param name="commission" select="'0'"/>
			<xsl:with-param name="commTax" select="'0'"/>
			<xsl:with-param name="sumManTaxAcy" select="'0'"/>
			<xsl:with-param name="sumScAmtAcy" select="'0'"/>
			<xsl:with-param name="currencyFT" select="../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_TransferOut">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:EventTypeJoin)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_TransferOut">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="coaReference_TransferOut">
		<coaReference>
			<xsl:value-of select="substring-before(../b:entitlementId,'.')"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="newQuantity_TransferOut">
		<newQuantity>
			<xsl:value-of select="'0'"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurity_TransferOut">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:newSecurity"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount_TransferOut">
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
	<xsl:template name="oldQuantity_TransferOut">
		<xsl:param name="secuBought"/>
		<oldQuantity>
			<xsl:value-of select="b:optionNom * (-1)"/>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldSecurity_TransferOut">
		<xsl:param name="secuBought"/>
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="../b:secNoGroup[b:secNo != $secuBought and b:secNominal &lt; 0]/b:secNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount_TransferOut">
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
	<xsl:template name="transactionDate_TransferOut">
		<xsl:if test="../b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_TransferOut">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account1NetAmount_TransferOut"/>
	<xsl:template name="account2_TransferOut"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate_TransferOut"/>
	<xsl:template name="account2NetAmount_TransferOut"/>
	<xsl:template name="account3_TransferOut"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate_TransferOut"/>
	<xsl:template name="account3NetAmount_TransferOut"/>
	<xsl:template name="accountingCode_TransferOut"/>
	<xsl:template name="cashPortfolio_TransferOut"/>
	<xsl:template name="commonReference_TransferOut"/>
	<xsl:template name="contractNumber_TransferOut"/>
	<xsl:template name="notepad_TransferOut"/>
	<xsl:template name="portfolioManager_TransferOut"/>
	<xsl:template name="remark_TransferOut"/>
	<xsl:template name="reversedTransactionCode_TransferOut"/>
	<xsl:template name="subType_TransferOut"/>
	<xsl:template name="typeInstrument_TransferOut"/>
	<xsl:template name="userDefinedField_TransferOut"/>
	<xsl:template name="mbFields_TransferOut"/>
	<xsl:template name="initiator_TransferOut"/>
	<xsl:template name="newSecurityPositionCriteria1_TransferOut">
		<newSecurityPositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</newSecurityPositionCriteria1>
	</xsl:template>
	<xsl:template name="newSecurityPositionCriteria2_TransferOut"/>
	<xsl:template name="newSecurityPositionCriteria3_TransferOut"/>
	<xsl:template name="newSecurityPositionCurrency_TransferOut"/>
	<xsl:template name="oldSecurityPositionCriteria1_TransferOut"/>
	<xsl:template name="oldSecurityPositionCriteria2_TransferOut"/>
	<xsl:template name="oldSecurityPositionCriteria3_TransferOut"/>
	<xsl:template name="oldSecuritypositionCurrency_TransferOut"/>
	<xsl:template name="unitaryCostPrice_TransferOut"/>
	<xsl:template name="exDate_TransferOut">
		<exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_TransferOut">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
</xsl:stylesheet>