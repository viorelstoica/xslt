<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate">
		<xsl:if test="b:netAmount != 0">
			<account1CcyPositionCcyExchangeRate>
				<xsl:value-of select="format-number(b:netAmtAccCur div b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyPositionCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate">
		<xsl:if test="b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolioNo"/>
			</infra:code>
		</portfolio>
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
						<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/',@index,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:entitlementId,'_0/',@index,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
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
			<!-- _0 to be first in fusion, followed by index -->
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/',@index,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(b:entitlementId,'_0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:entitlementId,'_0/',@index,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
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
			<xsl:with-param name="taxCredit" select="'0'"/>
			<xsl:with-param name="taxRefund" select="'0'"/>
			<xsl:with-param name="currencyFT" select="b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="originalSecurityDepositaryAccount">
		<xsl:choose>
   		<xsl:when test="b:depository != ''">
		<originalSecurityDepositaryAccount>
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
		</originalSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="originalSecurity">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:if test="b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cashAmount">
		<cashAmount>
			<xsl:value-of select="format-number(b:optionDescGroup/b:entitlementAmt,$decimalformat,'nan2zero')"/>
		</cashAmount>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account1NetAmount"/>
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
					<xsl:value-of select="b:extCustodian"/>
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
			<xsl:value-of select="b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
	<xsl:template name="account1_NewSecurity">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="accountingDate_NewSecurity">
		<xsl:if test="../../b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="../../b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio_NewSecurity">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_NewSecurity">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_NewSecurity">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_NewSecurity">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_NewSecurity">
		<xsl:param name="commission">
			<xsl:choose>
				<xsl:when test="./@index = '1'">
					<xsl:value-of select="../../b:commissionAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="commTax">
			<xsl:choose>
				<xsl:when test="./@index = '1'">
					<xsl:value-of select="../../b:commTaxAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:call-template name="printEntitlementFeesAndTaxes">
			<xsl:with-param name="sourceTax" select="../../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="$commission"/>
			<xsl:with-param name="commTax" select="$commTax"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="taxCredit" select="'0'"/>
			<xsl:with-param name="taxRefund" select="'0'"/>
			<xsl:with-param name="currencyFT" select="../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_NewSecurity">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_NewSecurity">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="coaReference_NewSecurity">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="originalSecurityDepositaryAccount_NewSecurity">
		<xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<originalSecurityDepositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
					<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</originalSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="originalSecurity_NewSecurity">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="transactionDate_NewSecurity">
		<xsl:if test="../../b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="../../b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="depositaryAccount_NewSecurity">
		<xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
					<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="securityQuantity_NewSecurity">
		<securityQuantity>
			<xsl:value-of select="b:nominal"/>
		</securityQuantity>
	</xsl:template>
	<xsl:template name="security_NewSecurity">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityUnitaryCostPrice_NewSecurity">
		<xsl:choose>
			<xsl:when test="b:bookCost and b:bookCost != '' and number(b:bookCost) != '0'">
				<securityUnitaryCostPrice>
					<xsl:value-of select="b:bookCost"/>
				</securityUnitaryCostPrice>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:price and b:price != '' and number(b:price) != '0'">
					<securityUnitaryCostPrice>
						<xsl:value-of select="b:price"/>
					</securityUnitaryCostPrice>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="sourceSystemCode_NewSecurity">
		<sourceSystemCode>
			<xsl:value-of select="../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate_NewSecurity"/>
	<xsl:template name="account1NetAmount_NewSecurity"/>
	<xsl:template name="account2_NewSecurity"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate_NewSecurity"/>
	<xsl:template name="account2NetAmount_NewSecurity"/>
	<xsl:template name="account3_NewSecurity"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate_NewSecurity"/>
	<xsl:template name="account3NetAmount_NewSecurity"/>
	<xsl:template name="accountingCode_NewSecurity"/>
	<xsl:template name="cashPortfolio_NewSecurity"/>
	<xsl:template name="commonReference_NewSecurity"/>
	<xsl:template name="contractNumber_NewSecurity"/>
	<xsl:template name="notepad_NewSecurity"/>
	<xsl:template name="portfolioManager_NewSecurity"/>
	<xsl:template name="remark_NewSecurity"/>
	<xsl:template name="reversedTransactionCode_NewSecurity"/>
	<xsl:template name="subType_NewSecurity"/>
	<xsl:template name="typeInstrument_NewSecurity"/>
	<xsl:template name="userDefinedField_NewSecurity"/>
	<xsl:template name="mbFields_NewSecurity"/>
	<xsl:template name="initiator_NewSecurity"/>
	<xsl:template name="originalSecurityPositionCriteria1_NewSecurity"/>
	<xsl:template name="originalSecurityPositionCriteria2_NewSecurity"/>
	<xsl:template name="originalSecurityPositionCriteria3_NewSecurity"/>
	<xsl:template name="originalSecurityPositionCurrency_NewSecurity"/>
	<xsl:template name="positionCriteria1_NewSecurity">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_NewSecurity"/>
	<xsl:template name="positionCriteria3_NewSecurity"/>
	<xsl:template name="positionCurrency_NewSecurity"/>
	<xsl:template name="profitLossCounter_NewSecurity"/>
	<xsl:template name="exDate_NewSecurity">
		<exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_NewSecurity">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>


	<xsl:template name="account1_NewSecurityProp">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="accountingDate_NewSecurityProp">
		<xsl:if test="../../b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="../../b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio_NewSecurityProp">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_NewSecurityProp">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_NewSecurityProp">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_NewSecurityProp">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_NewSecurityProp">
		<xsl:param name="commission">
			<xsl:choose>
				<xsl:when test="./@index = '1'">
					<xsl:value-of select="../../b:commissionAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="commTax">
			<xsl:choose>
				<xsl:when test="./@index = '1'">
					<xsl:value-of select="../../b:commTaxAmt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:call-template name="printEntitlementFeesAndTaxes">
			<xsl:with-param name="sourceTax" select="../../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="$commission"/>
			<xsl:with-param name="commTax" select="$commTax"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="taxCredit" select="'0'"/>
			<xsl:with-param name="taxRefund" select="'0'"/>
			<xsl:with-param name="currencyFT" select="../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_NewSecurityProp">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_NewSecurityProp">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="coaReference_NewSecurityProp">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="originalDepositaryAccount_NewSecurityProp">
		<xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<originalDepositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
					<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</originalDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="originalSecurity_NewSecurityProp">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="transactionDate_NewSecurityProp">
		<xsl:if test="../../b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="../../b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="depositaryAccount_NewSecurityProp">
		<xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
					<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="securityQuantity_NewSecurityProp">
		<securityQuantity>
			<xsl:value-of select="b:nominal"/>
		</securityQuantity>
	</xsl:template>
	<xsl:template name="security_NewSecurityProp">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="costProportion_NewSecurityProp">
		<xsl:variable name="index" select="./@index"/>
		<xsl:choose>
			<xsl:when test="$index= 1">
				<costProportion>
					<xsl:value-of select="b:bookCost"/>
				</costProportion>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="currentBookCost" select="b:bookCost"/>
				<xsl:variable name="prevBookCost" select="format-number(sum(../b:newSecuritySubGroup[@index &lt; $index]/b:bookCost),$decimalformat,'nan2zero')"/>
				<costProportion>
					<xsl:value-of select="format-number($currentBookCost div (1 - ($prevBookCost div 100)),'#.##','nan2zero')"/>
				</costProportion>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="sourceSystemCode_NewSecurityProp">
		<sourceSystemCode>
			<xsl:value-of select="../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate_NewSecurityProp"/>
	<xsl:template name="account1NetAmount_NewSecurityProp"/>
	<xsl:template name="account2_NewSecurityProp"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate_NewSecurityProp"/>
	<xsl:template name="account2NetAmount_NewSecurityProp"/>
	<xsl:template name="account3_NewSecurityProp"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate_NewSecurityProp"/>
	<xsl:template name="account3NetAmount_NewSecurityProp"/>
	<xsl:template name="accountingCode_NewSecurityProp"/>
	<xsl:template name="cashPortfolio_NewSecurityProp"/>
	<xsl:template name="commonReference_NewSecurityProp"/>
	<xsl:template name="contractNumber_NewSecurityProp"/>
	<xsl:template name="notepad_NewSecurityProp"/>
	<xsl:template name="portfolioManager_NewSecurityProp"/>
	<xsl:template name="remark_NewSecurityProp"/>
	<xsl:template name="reversedTransactionCode_NewSecurityProp"/>
	<xsl:template name="subType_NewSecurityProp"/>
	<xsl:template name="typeInstrument_NewSecurityProp"/>
	<xsl:template name="userDefinedField_NewSecurityProp"/>
	<xsl:template name="mbFields_NewSecurityProp"/>
	<xsl:template name="initiator_NewSecurityProp"/>
	<xsl:template name="originalSecurityPositionCriteria1_NewSecurityProp"/>
	<xsl:template name="originalSecurityPositionCriteria2_NewSecurityProp"/>
	<xsl:template name="originalSecurityPositionCriteria3_NewSecurityProp"/>
	<xsl:template name="originalSecurityPositionCurrency_NewSecurityProp"/>
	<xsl:template name="positionCriteria1_NewSecurityProp">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_NewSecurityProp"/>
	<xsl:template name="positionCriteria3_NewSecurityProp"/>
	<xsl:template name="positionCurrency_NewSecurityProp"/>
	<xsl:template name="profitLossCounter_NewSecurityProp"/>
	<xsl:template name="exDate_NewSecurityProp">
		<exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_NewSecurityProp">
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