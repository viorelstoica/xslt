<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:param name="list_EventType">
		<xsl:call-template name="diaryTypeTranslation">
			<xsl:with-param name="diaryType" select="'EXCHANGE.OFFER'"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:template name="account1_Sell">
		<account1>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Sell">
		<xsl:if test="b:netAmount != 0">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number(b:netAmtAccCur div b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Sell">
		<account1NetAmount>
			<xsl:value-of select="b:netAmtAccCur"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate_Sell">
		<xsl:if test="b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coaReference_Sell">
		<coaReference>
			<xsl:value-of select="b:diaryId"/>
		</coaReference>
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
	<xsl:template name="portfolio_Sell">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolioNo"/>
			</infra:code>
		</portfolio>
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
					<xsl:when test="b:optionDescGroup/b:tapRefId and (b:optionDescGroup/b:tapRefId != '' or b:optionDescGroup/b:tapRefId != 'NULL')">
						<xsl:value-of select="b:optionDescGroup/b:tapRefId"/>
					</xsl:when>
					<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
						<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/S',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:entitlementId,'_0/S',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security_Sell">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
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
	<xsl:template name="tradeCurrency_Sell">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice_Sell">
	<tradePrice>
        <xsl:choose>
            <xsl:when test="b:PriceTypeSecurityNoJoin = 'BOND' or b:PriceTypeSecurityNoJoin = 'DBOND' ">
               <xsl:value-of select="format-number((b:optionDescGroup[@index=1]/b:entitlementAmt div b:secNoGroup/b:secNominal) * -100,'#.########','nan2zero')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="format-number((b:optionDescGroup[@index=1]/b:entitlementAmt div b:secNoGroup/b:secNominal) * -1,'#.########','nan2zero')"/>
            </xsl:otherwise>
         </xsl:choose> 
    </tradePrice>
	</xsl:template>
	<xsl:template name="tradeQuantity_Sell">
		<tradeQuantity>
			<xsl:value-of select="format-number(b:secNoGroup[b:secNo = ../b:securityNo]/b:secNominal * (-1),$decimalformat,'nan2zero')"/>
		</tradeQuantity>
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
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:optionDescGroup/b:tapRefId and (b:optionDescGroup/b:tapRefId != '' or b:optionDescGroup/b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:optionDescGroup/b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/S','_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:entitlementId,'_0/S','_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:optionDescGroup/b:tapRefId and (b:optionDescGroup/b:tapRefId != '' or b:optionDescGroup/b:tapRefId != 'NULL')">
							<xsl:value-of select="b:optionDescGroup/b:tapRefId"/>
						</xsl:when>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/S',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:entitlementId,'_0/S',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Sell">
		<transactionDate>
			<xsl:value-of select="b:PayDateJoin"/>
		</transactionDate>
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
	<xsl:template name="tradeCcyGrossAmount_Sell"/>
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
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyoldSecCcyExchangeRate">
		<xsl:if test="b:netAmount != 0">
			<account1CcyoldSecCcyExchangeRate>
				<xsl:value-of select="format-number(b:netAmtAccCur div b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyoldSecCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate">
		<xsl:if test="b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="adjustmentNature">
		<adjustmentNature>
			<xsl:value-of select="'1'"/>
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="newQuantity">
		<newQuantity>
			<xsl:value-of select="'0'"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurity">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount">
		 <xsl:choose>
   		<xsl:when test="b:depository != ''">
		<newSecurityDepositaryAccount>
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
		</newSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="oldQuantity">
		<xsl:param name="sumEntitlementAmt"/>
		<oldQuantity>
			<xsl:value-of select="$sumEntitlementAmt"/>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldSecurity">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</oldSecurity>
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
					<xsl:when test="b:optionDescGroup/b:tapRefId and (b:optionDescGroup/b:tapRefId != '' or b:optionDescGroup/b:tapRefId != 'NULL')">
						<xsl:value-of select="b:optionDescGroup/b:tapRefId"/>
					</xsl:when>
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
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:entitlementId"/>
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
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:optionDescGroup/b:tapRefId and (b:optionDescGroup/b:tapRefId != '' or b:optionDescGroup/b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:optionDescGroup/b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:entitlementId,'_0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:optionDescGroup/b:tapRefId and (b:optionDescGroup/b:tapRefId != '' or b:optionDescGroup/b:tapRefId != 'NULL')">
							<xsl:value-of select="b:optionDescGroup/b:tapRefId"/>
						</xsl:when>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_0/',@index,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:entitlementId,'_0/',@index,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:if test="b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="b:commissionAmt"/>
			<xsl:with-param name="commTax" select="b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(/b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
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
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accruedInterestAmount"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="adjustmentCounter"/>
	<xsl:template name="adjustmentPortfolio"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="communication"/>
	<xsl:template name="initiator"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate"/>
	<xsl:template name="newSecurityNetAmount"/>
	<xsl:template name="newSecurityPositionCriteria1"/>
	<xsl:template name="newSecurityPositionCriteria2"/>
	<xsl:template name="newSecurityPositionCriteria3"/>
	<xsl:template name="newSecurityPositionCurrency"/>
	<xsl:template name="notepad"/>
	<xsl:template name="oldCcyGrossAmount"/>
	<xsl:template name="oldCcyNetAmount"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="oldPrice"/>
	<xsl:template name="oldSecurityDepositaryAccount"/>
	<xsl:template name="oldSecurityPositionCriteria1">
		<oldSecurityPositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</oldSecurityPositionCriteria1>
	</xsl:template>
	<xsl:template name="oldSecurityPositionCriteria2"/>
	<xsl:template name="oldSecurityPositionCriteria3"/>
	<xsl:template name="oldSecurityPositionCurrency"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="supplementaryAmount"/>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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
	<xsl:template name="account1_Adj">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyoldSecCcyExchangeRate_Adj">
		<xsl:param name="sumEntitlementAmt"/>
		<xsl:param name="nbNewSecuritySubGroup"/>
		<xsl:if test="$nbNewSecuritySubGroup = 1 and $sumEntitlementAmt = 0 and ../../b:netAmount != 0">
			<!-- exchange 1-1 with fees, for 1-N see template cashPartOfExchange -->
			<account1CcyoldSecCcyExchangeRate>
				<xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyoldSecCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Adj">
		<xsl:param name="sumEntitlementAmt"/>
		<xsl:param name="nbNewSecuritySubGroup"/>
		<xsl:if test="$nbNewSecuritySubGroup = 1 and $sumEntitlementAmt = 0 and ../../b:netAmtAccCur != 0">
			<!-- exchange 1-1 no cash, for 1-N see template cashPartOfExchange -->
			<account1NetAmount>
				<xsl:value-of select="format-number(../../b:netAmtAccCur * (-1) ,'#.####','nan2zero')"/>
			</account1NetAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate_Adj">
		<accountingDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="adjustmentNature_Adj">
		<adjustmentNature>
			<xsl:value-of select="'2'"/>
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="coaReference_Adj">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="newQuantity_Adj">
		<newQuantity>
			<xsl:value-of select="b:nominal"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurity_Adj">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount_Adj">
		 <xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<newSecurityDepositaryAccount>
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
		</newSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="oldQuantity_Adj">
		<xsl:param name="nbNewSecuritySubGroupInOptionGroup"/>
		<xsl:param name="optionDescGroupQtyToDeal"/>
		<xsl:param name="lastRatioQty"/>
		<xsl:param name="ratioProportion"/>
		<xsl:param name="lastPriceQty"/>
		<xsl:param name="totalSubGroupPrice"/>
		<oldQuantity>
			<!-- Removing old quantity in correct proportion to split original cost prince on new elements -->
			<xsl:choose>
				<!-- only 1 new security in group -->
				<xsl:when test="$nbNewSecuritySubGroupInOptionGroup = 1 ">
					<xsl:value-of select="format-number((-1) * $optionDescGroupQtyToDeal,'#.########','nan2zero')"/>
				</xsl:when>
				<!-- multiple security in group -->
				<!-- if last, amount to deal is $qtyLastOptionDescGroupWithSecu -->
				<!-- if not last, amount to deal is ../../b:eventNominal * $optionDescGroupProportion -->
				<xsl:otherwise>
					<!--If a ratio exists (we assume it exists on all newSecuritySubGroup of ths optionDescGroup) -->
					<xsl:choose>
						<xsl:when test="b:ratio">
							<!-- ratio is qtyNew:qtyOld -->
							<xsl:choose>
								<xsl:when test="@index = $nbNewSecuritySubGroupInOptionGroup">
									<xsl:value-of select="format-number( (-1) * $lastRatioQty,'#.########','nan2zero')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="format-number( (-1) * $optionDescGroupQtyToDeal * $ratioProportion ,'#.########','nan2zero')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- else use price proportion -->
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="@index = $nbNewSecuritySubGroupInOptionGroup">
									<xsl:value-of select="format-number( (-1) * $lastPriceQty,'#.########','nan2zero')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="format-number( (-1) * ($optionDescGroupQtyToDeal * b:price) div $totalSubGroupPrice  ,'#.########','nan2zero')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldSecurity_Adj">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount_Adj">
		 <xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<oldSecurityDepositaryAccount>
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
		</oldSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="portfolio_Adj">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_Adj">
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
		</xsl:if>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../b:tapRefId and (../b:tapRefId != '' or ../b:tapRefId != 'NULL')">
						<xsl:value-of select="../b:tapRefId"/>
					</xsl:when>
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
	<xsl:template name="sourceSystemCode_Adj">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:entitlementId,'_X')"/>
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
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="../b:tapRefId and (../b:tapRefId != '' or ../b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(../b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../b:tapRefId and (../b:tapRefId != '' or ../b:tapRefId != 'NULL')">
							<xsl:value-of select="../b:tapRefId"/>
						</xsl:when>
						<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Adj">
		<xsl:if test="../../b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="../../b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Adj">
		<xsl:param name="sumEntitlementAmt"/>
		<xsl:param name="nbNewSecuritySubGroup"/>
		<xsl:param name="ratioProportion"/>
		<xsl:param name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
		<xsl:param name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
		<xsl:param name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
		<xsl:param name="multiCoeff">
			<xsl:choose>
				<!-- if cashPartOfExchange is present,fees are calculated only on cashPartOfExchange -->
				<xsl:when test="$sumEntitlementAmt != '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$nbNewSecuritySubGroup = '1'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$ratioProportion"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<!-- call the template to print the FT -->
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="../../b:sourceTaxAmt*$multiCoeff"/>
			<xsl:with-param name="fgnCharges" select="../../b:fgnChargesAmt*$multiCoeff"/>
			<xsl:with-param name="foreignChgesTax" select="../../b:foreignChgesTax*$multiCoeff"/>
			<xsl:with-param name="sumlocalTaxAmt" select="$sumlocalTaxAmt*$multiCoeff"/>
			<xsl:with-param name="commission" select="../../b:commissionAmt*$multiCoeff"/>
			<xsl:with-param name="commTax" select="../../b:commTaxAmt*$multiCoeff"/>
			<xsl:with-param name="sumManTaxAcy" select="$sumManTaxAcy*$multiCoeff"/>
			<xsl:with-param name="sumScAmtAcy" select="$sumScAmtAcy*$multiCoeff"/>
			<xsl:with-param name="currencyFT" select="../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_Adj">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Adj">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_Adj"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate_Adj"/>
	<xsl:template name="account2NetAmount_Adj"/>
	<xsl:template name="account3_Adj"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate_Adj"/>
	<xsl:template name="account3NetAmount_Adj"/>
	<xsl:template name="accountingCode_Adj"/>
	<xsl:template name="accruedInterestAmount_Adj"/>
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
	<xsl:template name="oldPrice_Adj"/>
	<xsl:template name="oldSecurityPositionCriteria1_Adj">
		<oldSecurityPositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../b:extCustodian"/>
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
		<xsl:if test="b:diaryExDate and b:diaryExDate != ''">
			<exDate>
				<xsl:value-of select="b:diaryExDate"/>
			</exDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="splitPortfolio_Adj">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
	<xsl:template name="account1_Status"/>
	<xsl:template name="account1CcyoldSecCcyExchangeRate_Status"/>
	<xsl:template name="account1NetAmount_Status"/>
	<xsl:template name="account2_Status"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate_Status"/>
	<xsl:template name="account2NetAmount_Status"/>
	<xsl:template name="account3_Status"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate_Status"/>
	<xsl:template name="account3NetAmount_Status"/>
	<xsl:template name="accountingCode_Status"/>
	<xsl:template name="accountingDate_Status"/>
	<xsl:template name="accruedInterestAmount_Status"/>
	<xsl:template name="accruedInterestCounter_Status"/>
	<xsl:template name="adjustmentCounter_Status"/>
	<xsl:template name="adjustmentNature_Status"/>
	<xsl:template name="adjustmentPortfolio_Status"/>
	<xsl:template name="cashPortfolio_Status"/>
	<xsl:template name="coaReference_Status"/>
	<xsl:template name="commonReference_Status"/>
	<xsl:template name="communication_Status"/>
	<xsl:template name="initiator_Status"/>
	<xsl:template name="newQuantity_Status"/>
	<xsl:template name="newSecurity_Status"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate_Status"/>
	<xsl:template name="newSecurityDepositaryAccount_Status"/>
	<xsl:template name="newSecurityNetAmount_Status"/>
	<xsl:template name="newSecurityPositionCriteria1_Status"/>
	<xsl:template name="newSecurityPositionCriteria2_Status"/>
	<xsl:template name="newSecurityPositionCriteria3_Status"/>
	<xsl:template name="newSecurityPositionCurrency_Status"/>
	<xsl:template name="notepad_Status"/>
	<xsl:template name="oldCcyGrossAmount_Status"/>
	<xsl:template name="oldCcyNetAmount_Status"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate_Status"/>
	<xsl:template name="oldPrice_Status"/>
	<xsl:template name="oldQuantity_Status"/>
	<xsl:template name="oldSecurity_Status"/>
	<xsl:template name="oldSecurityDepositaryAccount_Status"/>
	<xsl:template name="oldSecurityPositionCriteria1_Status"/>
	<xsl:template name="oldSecurityPositionCriteria2_Status"/>
	<xsl:template name="oldSecurityPositionCriteria3_Status"/>
	<xsl:template name="oldSecurityPositionCurrency_Status"/>
	<xsl:template name="portfolio_Status"/>
	<xsl:template name="portfolioManager_Status"/>
	<xsl:template name="remark_Status"/>
	<xsl:template name="reversalIndicator_Status"/>
	<xsl:template name="reversedTransactionCode_Status"/>
	<xsl:template name="sourceSystemCode_Status"/>
	<xsl:template name="status_Status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_Status"/>
	<xsl:template name="supplementaryAmount_Status"/>
	<xsl:template name="transactionCode_Status">
		<transactionCode>
			<xsl:value-of select="../b:tapRefId"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Status"/>
	<xsl:template name="transactionFeesTaxesCounter_Status"/>
	<xsl:template name="type_Status"/>
	<xsl:template name="typeInstrument_Status"/>
	<xsl:template name="valueDate_Status"/>
	<xsl:template name="userDefinedField_Status"/>
	<xsl:template name="mbFields_Status"/>
	<xsl:template name="splitPortfolio_Status">
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