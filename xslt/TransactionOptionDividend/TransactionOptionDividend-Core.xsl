<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyDividendCcyExchangeRate">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyDividendCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyDividendCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashDividend">
		<xsl:if test="b:optionNom and b:optionNom != ''">
			<xsl:variable name="entitlementAmtVar" select="format-number(b:entitlementAmt,'#.#########','nan2zero')"/>
			<xsl:variable name="taxCreditVar" select="format-number(../b:taxCredit,'#.#########','nan2zero')"/>
			<cashDividend>
				<xsl:value-of select="format-number(($entitlementAmtVar + $taxCreditVar) div b:optionNom,'#.#########','nan2zero')"/>
			</cashDividend>
		</xsl:if>
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
	<xsl:template name="dividendCcyGrossAmount">
		<dividendCcyGrossAmount>
			<xsl:value-of select="b:entitlementAmt"/>
		</dividendCcyGrossAmount>
	</xsl:template>
	<xsl:template name="dividendCcyNetAmount">
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<xsl:choose>
			<xsl:when test="$nbOptionDescGroupWithNewSecurity = 0">
				<!-- no new security -->
				<dividendCcyNetAmount>
					<xsl:value-of select="../b:netAmount"/>
				</dividendCcyNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<dividendCcyNetAmount>
					<xsl:value-of select="b:entitlementAmt"/>
					<!-- F&T with security part -->
				</dividendCcyNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="nominalOrUnit">
		<nominalOrUnit>
			<xsl:value-of select="b:optionNom"/>
		</nominalOrUnit>
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
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/0',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/0',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
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
	<xsl:template name="transactionCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/0','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/0',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/0','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/0',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
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
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<xsl:choose>
			<xsl:when test="$nbOptionDescGroupWithNewSecurity = 0">
				<!-- no new security -->
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
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyDividendCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyDividendCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="dividendCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="dividendCurrency"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="subType"/>
	<xsl:template name="typeInstrument"/>
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
	<xsl:template name="account1_Security">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate_Security">
		<xsl:if test="../../b:netAmount != 0">
			<account1CcyPositionCcyExchangeRate>
				<xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyPositionCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate_Security">
		<accountingDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio_Security">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_Security">
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
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Security">
		<sourceSystemCode>
			<xsl:value-of select="../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Security">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_Security">
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
	<xsl:template name="transactionFeesTaxesCounter_Security">
		<xsl:param name="idxFirstOptDescGroupWithNewSecu"/>
		<xsl:if test="format-number(../@index,'#.##','nan2zero') = format-number($idxFirstOptDescGroupWithNewSecu,'#.##','nan2zero') ">
			<!-- need format-number to compare correctly -->
			<xsl:if test="(@index = 1)">
				<xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
				<xsl:call-template name="printEntitlementFeesAndTaxes">
					<xsl:with-param name="sourceTax" select="../../b:sourceTaxAmt"/>
					<xsl:with-param name="fgnCharges" select="../../b:fgnChargesAmt"/>
					<xsl:with-param name="foreignChgesTax" select="../../b:foreignChgesTax"/>
					<xsl:with-param name="sumlocalTaxAmt" select="$sumlocalTaxAmt"/>
					<xsl:with-param name="commission" select="../../b:commissionAmt"/>
					<xsl:with-param name="commTax" select="../../b:commTaxAmt"/>
					<xsl:with-param name="sumManTaxAcy" select="$sumManTaxAcy"/>
					<xsl:with-param name="sumScAmtAcy" select="$sumScAmtAcy"/>
					<xsl:with-param name="currencyFT" select="../../b:currency"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="type_Security">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Security">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="coaReference_Security">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="originalSecurityDepositaryAccount_Security">
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
	<xsl:template name="originalSecurity_Security">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="transactionDate_Security">
		<transactionDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="depositaryAccount_Security">
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
	<xsl:template name="security_Security">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="stockDividendQuantity_Security">
		<stockDividendQuantity>
			<xsl:value-of select="b:nominal"/>
		</stockDividendQuantity>
	</xsl:template>
	<xsl:template name="account1NetAmount_Security"/>
	<xsl:template name="account2_Security"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate_Security"/>
	<xsl:template name="account2NetAmount_Security"/>
	<xsl:template name="account3_Security"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate_Security"/>
	<xsl:template name="account3NetAmount_Security"/>
	<xsl:template name="accountingCode_Security"/>
	<xsl:template name="cashPortfolio_Security"/>
	<xsl:template name="commonReference_Security"/>
	<xsl:template name="contractNumber_Security"/>
	<xsl:template name="notepad_Security"/>
	<xsl:template name="portfolioManager_Security"/>
	<xsl:template name="remark_Security"/>
	<xsl:template name="reversedTransactionCode_Security"/>
	<xsl:template name="subType_Security"/>
	<xsl:template name="typeInstrument_Security"/>
	<xsl:template name="userDefinedField_Security"/>
	<xsl:template name="mbFields_Security"/>
	<xsl:template name="initiator_Security"/>
	<xsl:template name="originalSecurityPositionCriteria1_Security"/>
	<xsl:template name="originalSecurityPositionCriteria2_Security"/>
	<xsl:template name="originalSecurityPositionCriteria3_Security"/>
	<xsl:template name="originalSecurityPositionCurrency_Security"/>
	<xsl:template name="positionCriteria1_Security">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_Security"/>
	<xsl:template name="positionCriteria3_Security"/>
	<xsl:template name="positionCurrency_Security"/>
	<xsl:template name="profitLossCounter_Security"/>
	<xsl:template name="exDate_Security">
		<exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_Security">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
	
	<!-- =============================================  cash fraction for security part ======================================== -->
    <xsl:template name="account1_securityCash">
        <account1>
            <infra:code>
                <xsl:value-of select="../../b:accountNo"/>
            </infra:code>
        </account1>
    </xsl:template>
    <xsl:template name="account1CcyDividendCcyExchangeRate_securityCash">
        <xsl:if test="../../b:netAmount != 0">
            <account1CcyDividendCcyExchangeRate>
                <xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,'#.#########','nan2zero')"/>
            </account1CcyDividendCcyExchangeRate>
        </xsl:if>
    </xsl:template>
    <xsl:template name="accountingDate_securityCash">
        <accountingDate>
            <xsl:value-of select="../../b:PayDateJoin"/>
        </accountingDate>
    </xsl:template>
    <xsl:template name="cashDividend_securityCash">
        <cashDividend>
            <xsl:value-of select="1"/>
        </cashDividend>
    </xsl:template>
    <xsl:template name="coaReference_securityCash">
        <coaReference>
            <xsl:value-of select="../../b:diaryId"/>
        </coaReference>
    </xsl:template>
    <xsl:template name="depositaryAccount_securityCash">
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
    <xsl:template name="dividendCcyGrossAmount_securityCash"/>
    <xsl:template name="dividendCcyNetAmount_securityCash"/>
    <xsl:template name="nominalOrUnit_securityCash">
        <nominalOrUnit>
            <xsl:value-of select="b:cashFraction"/>
        </nominalOrUnit>
    </xsl:template>
    <xsl:template name="portfolio_securityCash">
        <portfolio>
            <infra:code>
                <xsl:value-of select="../../b:portfolioNo"/>
            </infra:code>
        </portfolio>
    </xsl:template>
    <xsl:template name="reversalIndicator_securityCash">
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
                        <xsl:value-of select="concat(concat(../../b:tapOperCode, '_CS') ,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(concat(../../b:entitlementId, '_CS'), '_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </reversedTransactionCode>
        </xsl:if>
    </xsl:template>
    <xsl:template name="security_securityCash">
        <security>
            <infra:code>
                <xsl:value-of select="../../b:securityNo"/>
            </infra:code>
        </security>
    </xsl:template>
    <xsl:template name="sourceSystemCode_securityCash">
        <sourceSystemCode>
            <xsl:value-of select="../../b:entitlementId"/>
        </sourceSystemCode>
    </xsl:template>
    <xsl:template name="status_securityCash">
        <status>
            <xsl:call-template name="statusTranslation">
                <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
            </xsl:call-template>
        </status>
    </xsl:template>
    <xsl:template name="transactionCode_securityCash">
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
                            <xsl:value-of select="concat(concat(../../b:tapOperCode, '_CS'),$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(concat(../../b:tapOperCode, '_CS'),$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
                            <xsl:value-of select="concat(concat(../../b:entitlementId, '_CS'),'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(concat(../../b:entitlementId, '_CS'),'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </transactionCode>
    </xsl:template>
    <xsl:template name="transactionDate_securityCash">
        <transactionDate>
            <xsl:value-of select="../../b:PayDateJoin"/>
        </transactionDate>
    </xsl:template>
    <xsl:template name="transactionFeesTaxesCounter_securityCash">
        <xsl:call-template name="printEntitlementFeesAndTaxes">
            <xsl:with-param name="sourceTax" select="0"/>
            <xsl:with-param name="fgnCharges" select="0"/>
            <xsl:with-param name="foreignChgesTax" select="0"/>
            <xsl:with-param name="sumlocalTaxAmt" select="0"/>
            <xsl:with-param name="commission" select="0"/>
            <xsl:with-param name="commTax" select="0"/>
            <xsl:with-param name="sumManTaxAcy" select="0"/>
            <xsl:with-param name="sumScAmtAcy" select="0"/>
            <xsl:with-param name="currencyFT" select="../../b:currency"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="type_securityCash">
        <type>
            <infra:code>
                <xsl:value-of select="concat('ENT_',../../b:eventType)"/>
            </infra:code>
        </type>
    </xsl:template>
    <xsl:template name="valueDate_securityCash">
        <valueDate>
            <xsl:value-of select="../../b:valueDate"/>
        </valueDate>
    </xsl:template>
    <xsl:template name="account1NetAmount_securityCash"/>
    <xsl:template name="account2_securityCash"/>
    <xsl:template name="account2CcyDividendCcyExchangeRate_securityCash"/>
    <xsl:template name="account2NetAmount_securityCash"/>
    <xsl:template name="account3_securityCash"/>
    <xsl:template name="account3CcyDividendCcyExchangeRate_securityCash"/>
    <xsl:template name="account3NetAmount_securityCash"/>
    <xsl:template name="accountingCode_securityCash"/>
    <xsl:template name="cashPortfolio_securityCash"/>
    <xsl:template name="commonReference_securityCash"/>
    <xsl:template name="contractNumber_securityCash"/>
    <xsl:template name="dividendCcyPortfolioCcyExchangeRate_securityCash"/>
    <xsl:template name="dividendCurrency_securityCash"/>
    <xsl:template name="initiator_securityCash"/>
    <xsl:template name="notepad_securityCash"/>
    <xsl:template name="remark_securityCash"/>
    <xsl:template name="reversedTransactionCode_securityCash"/>
    <xsl:template name="portfolioManager_securityCash"/>
    <xsl:template name="securityCcyNetAmount_securityCash"/>
    <xsl:template name="securityCcyPortfolioCcyExchangeRate_securityCash"/>
    <xsl:template name="subType_securityCash"/>
    <xsl:template name="typeInstrument_securityCash"/>
    <xsl:template name="userDefinedField_securityCash"/>
    <xsl:template name="positionCriteria1_securityCash">
        <positionCriteria1>
            <xsl:call-template name="extCustodianTranslation">
                <xsl:with-param name="boExtCustodian">
                    <xsl:value-of select="../../b:extCustodian"/>
                </xsl:with-param>
            </xsl:call-template>
        </positionCriteria1>
    </xsl:template>
    <xsl:template name="mbFields_securityCash"/>
    <xsl:template name="exDate_securityCash">
        <exDate>
            <xsl:value-of select="../../b:diaryExDate"/>
        </exDate>
    </xsl:template>
    <xsl:template name="splitPortfolio_securityCash">
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