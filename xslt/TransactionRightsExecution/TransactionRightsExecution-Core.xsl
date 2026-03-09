<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- BEG Templates for checking Adjustment, upfront payment, buy, upfront payment returned and lapse Criterias -->
	<xsl:template name="CheckAdjustmentPLCriteria">
		<xsl:choose>
			<xsl:when test="b:optionNom and number(b:optionNom) != '0' and b:optionInd = 'EXER' and ../b:optStatus = 'COMPLETED' and count(descendant::b:newSecuritySubGroup) &gt;= 1 and b:newSecuritySubGroup[@index='1']/b:newSecurity != ../b:securityNo and b:newSecuritySubGroup[@index='1']/b:nominal">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CheckUpfrontPaymentCriteria">
		<xsl:choose>
			<xsl:when test="../b:upfrontPaymentDiaryJoin = 'YES' and ../b:optStatus = 'PAID' and b:optionInd = 'EXER' and ../b:netAmtAccCur and number(../b:netAmtAccCur) != '0' and b:entitlementAmt and number(b:entitlementAmt) != '0'">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CheckBuyCriteria">
		<xsl:choose>
			<xsl:when test="b:optionInd = 'EXER' and b:optionNom and number(b:optionNom) != '0' and ../b:optStatus = 'COMPLETED' and count(descendant::b:newSecuritySubGroup) &gt;= 1 and b:newSecuritySubGroup[@index='1']/b:newSecurity != ../b:securityNo and b:newSecuritySubGroup[@index='1']/b:nominal">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CheckUpfrontPaymentReturnedCriteria">
		<xsl:choose>
			<xsl:when test="../b:upfrontPaymentDiaryJoin = 'YES' and ../b:optStatus = 'COMPLETED' and b:optionInd = 'EXER' and ../b:netAmtAccCur and number(../b:netAmtAccCur) != 0 and b:entitlementAmt and number(b:entitlementAmt) != '0'">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CheckSellorLapseCriteria">
		<xsl:choose>
			<xsl:when test="b:optionInd = 'LAPS' and ../b:optStatus = 'COMPLETED' and b:optionNom and number(b:optionNom != 0) and number(b:entitlementAmt) &gt;= '0'">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- END Templates for checking Adjustment, upfront payment, buy, upfront payment returned and lapse Criterias -->

	<!-- BEG - Adjustment PL -->
	<xsl:template name="accountingDate_adj">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount_adj">
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
	<xsl:template name="newSecurity_adj">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:newSecuritySubGroup/b:newSecurity"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newQuantity_adj">
		<newQuantity>
			<xsl:value-of select="'0'"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurityPositionCriteria1_adj">
		<newSecurityPositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</newSecurityPositionCriteria1>
	</xsl:template>
	<xsl:template name="adjustmentNature_adj">
		<adjustmentNature>
			<xsl:value-of select="'2'"/>
			<!-- 2 is PL -->
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="transactionCode_adj">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'-A','_R')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'-A')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount_adj">
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
	<xsl:template name="coaReference_adj">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="oldSecurity_adj">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="transactionDate_adj">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="portfolio_adj">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_adj">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_adj">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
						<xsl:value-of select="concat(b:tapRefId,'-A')"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_',../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_exchadj',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_adj">
		<sourceSystemCode>
			<xsl:value-of select="concat(../b:entitlementId,'_A')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_adj">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type_adj">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_adj">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="oldQuantity_adj">
		<oldQuantity>
			<xsl:value-of select="format-number((-1) * b:optionNom,$decimalformat,'nan2zero')"/>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldPrice_adj">
		<oldPrice>
			<xsl:value-of select="'0'"/>
		</oldPrice>
	</xsl:template>
	<xsl:template name="account1_adj"/>
	<xsl:template name="account1CcyoldSecCcyExchangeRate_adj"/>
	<xsl:template name="account1NetAmount_adj"/>
	<xsl:template name="account2_adj"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate_adj"/>
	<xsl:template name="account2NetAmount_adj"/>
	<xsl:template name="account3_adj"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate_adj"/>
	<xsl:template name="account3NetAmount_adj"/>
	<xsl:template name="accountingCode_adj"/>
	<xsl:template name="accruedInterestAmount_adj"/>
	<xsl:template name="accruedInterestCounter_adj"/>
	<xsl:template name="adjustmentCounter_adj"/>
	<xsl:template name="adjustmentPortfolio_adj"/>
	<xsl:template name="cashPortfolio_adj"/>
	<xsl:template name="commonReference_adj"/>
	<xsl:template name="communication_adj"/>
	<xsl:template name="initiator_adj"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate_adj"/>
	<xsl:template name="newSecurityNetAmount_adj"/>
	<xsl:template name="newSecurityPositionCriteria2_adj"/>
	<xsl:template name="newSecurityPositionCriteria3_adj"/>
	<xsl:template name="newSecurityPositionCurrency_adj"/>
	<xsl:template name="notepad_adj"/>
	<xsl:template name="oldCcyGrossAmount_adj"/>
	<xsl:template name="oldCcyNetAmount_adj"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate_adj"/>
	<xsl:template name="oldSecurityPositionCriteria1_adj"/>
	<xsl:template name="oldSecurityPositionCriteria2_adj"/>
	<xsl:template name="oldSecurityPositionCriteria3_adj"/>
	<xsl:template name="oldSecurityPositionCurrency_adj"/>
	<xsl:template name="portfolioManager_adj"/>
	<xsl:template name="remark_adj"/>
	<xsl:template name="subType_adj"/>
	<xsl:template name="supplementaryAmount_adj"/>
	<xsl:template name="transactionFeesTaxesCounter_adj"/>
	<xsl:template name="typeInstrument_adj"/>
	<xsl:template name="userDefinedField_adj"/>
	<xsl:template name="mbFields_adj"/>
	<!-- END - Adjustment PL -->

	<!-- BEG - UpfrontPayment -->
	<xsl:template name="accountingDate_Wd">
		<accountingDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode_Wd">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'-A','_R')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_',../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_W_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_W_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'-A')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_',../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_W',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_W',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="coaReference_Wd">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Wd">
		<security>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_Wd">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:accountCurr"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_Wd">
		<transactionDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Wd">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number(../b:netAmtAccCur * (-1),$decimalformat,'nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="portfolio_Wd">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_Wd">
		<tradeQuantity>
			<xsl:value-of select="format-number(../b:netAmtAccCur * (-1),$decimalformat,'nan2zero')"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="reversalIndicator_Wd">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_Wd">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
						<xsl:value-of select="concat(b:tapRefId,'-A')"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_',../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_W',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_W',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Wd">
		<sourceSystemCode>
			<xsl:value-of select="concat(../b:entitlementId,'_W')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Wd">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="positionCriteria1_Wd">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="type_Wd">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Wd">
		<valueDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1_Wd"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Wd"/>
	<xsl:template name="account1NetAmount_Wd"/>
	<xsl:template name="depositaryAccount_Wd"/>
	<xsl:template name="account2_Wd"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Wd"/>
	<xsl:template name="account2NetAmount_Wd"/>
	<xsl:template name="account3_Wd"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Wd"/>
	<xsl:template name="account3NetAmount_Wd"/>
	<xsl:template name="accountingCode_Wd"/>
	<xsl:template name="accruedInterestAmount_Wd"/>
	<xsl:template name="accruedInterestCounter_Wd"/>
	<xsl:template name="cashPortfolio_Wd"/>
	<xsl:template name="commonReference_Wd"/>
	<xsl:template name="communication_Wd"/>
	<xsl:template name="initiator_Wd"/>
	<xsl:template name="notepad_Wd"/>
	<xsl:template name="portfolioManager_Wd"/>
	<xsl:template name="positionCriteria2_Wd"/>
	<xsl:template name="positionCriteria3_Wd"/>
	<xsl:template name="remark_Wd"/>
	<xsl:template name="subType_Wd"/>
	<xsl:template name="supplementaryAmount_Wd"/>
	<xsl:template name="tradeCcyNetAmount_Wd"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Wd"/>
	<xsl:template name="tradePrice_Wd"/>
	<xsl:template name="transactionFeesTaxesCounter_Wd"/>
	<xsl:template name="typeInstrument_Wd"/>
	<xsl:template name="userDefinedField_Wd"/>
	<xsl:template name="mbFields_Wd"/>
	<!-- END - UpfrontPayment -->

	<!-- BEG - Buy -->
	<xsl:template name="account1_Buy">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Buy">
		<xsl:param name="index" select="@index"/>
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:if test="not(../b:accountCurr = ../b:newSecCurrencyGroup[@index=$index]/b:newSecCurrencySubGroup/b:newSecCurrency) and ../b:netAmount and number(../b:netAmount) != '0'">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="$netAmtAccCur div ../b:netAmount"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Buy">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="entitlementAmt">
			<xsl:value-of select="format-number(../b:optionDescGroup[b:optionInd = 'LAPS']/b:entitlementAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="netAmount">
			<xsl:value-of select="format-number(../b:netAmount,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<account1NetAmount>
			<xsl:choose>
				<xsl:when test="b:optionNom = ../b:eventNominal">
					<xsl:value-of select="format-number($netAmtAccCur * (-1),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number($netAmtAccCur * (-1) + $entitlementAmt * ($netAmtAccCur div $netAmount),$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate_Buy">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Buy">
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$fgnChargesAmt + $foreignChgesTax"/>
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
	<xsl:template name="transactionCode_Buy">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:tapOperCode,'_',../b:entitlementId,'_','/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,'_',../b:entitlementId,'_','/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:entitlementId,'_','/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,'_','/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_Buy">
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
	<xsl:template name="coaReference_Buy">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Buy">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecuritySubGroup/b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_Buy"/>
	<xsl:template name="tradeCcy_Buy">
		<tradeCcy>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</tradeCcy>
	</xsl:template>
	<xsl:template name="tradeExchangeRate_Buy">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:if test="(../b:accountCurr = ../b:currency) and ../b:netAmount and number(../b:netAmount) != '0'">
			<tradeExchangeRate>
				<xsl:value-of select="$netAmtAccCur div ../b:netAmount"/>
			</tradeExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionDate_Buy">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Buy"/>
	<xsl:template name="portfolio_Buy">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_Buy">
		<tradeQuantity>
			<xsl:value-of select="b:newSecuritySubGroup/b:nominal"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="tradePrice_Buy">
		<xsl:if test="b:newSecuritySubGroup/b:price">
			<tradePrice>
				<xsl:value-of select="b:newSecuritySubGroup/b:price"/>
			</tradePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversalIndicator_Buy">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_Buy">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,'_','/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:entitlementId,'_','/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Buy">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Buy">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="positionCriteria1_Buy">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="type_Buy">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Buy">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_Buy"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Buy"/>
	<xsl:template name="account2NetAmount_Buy"/>
	<xsl:template name="account3_Buy"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Buy"/>
	<xsl:template name="account3NetAmount_Buy"/>
	<xsl:template name="accountingCode_Buy"/>
	<xsl:template name="accruedInterestAmount_Buy"/>
	<xsl:template name="accruedInterestCounter_Buy"/>
	<xsl:template name="cashPortfolio_Buy"/>
	<xsl:template name="commonReference_Buy"/>
	<xsl:template name="communication_Buy"/>
	<xsl:template name="initiator_Buy"/>
	<xsl:template name="notepad_Buy"/>
	<xsl:template name="portfolioManager_Buy"/>
	<xsl:template name="positionCriteria2_Buy"/>
	<xsl:template name="positionCriteria3_Buy"/>
	<xsl:template name="remark_Buy"/>
	<xsl:template name="securityCcyNetAmount_Buy"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_Buy"/>
	<xsl:template name="subType_Buy"/>
	<xsl:template name="supplementaryAmount_Buy"/>
	<xsl:template name="tradeCcyNetAmount_Buy"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Buy"/>
	<xsl:template name="typeInstrument_Buy"/>
	<xsl:template name="userDefinedField_Buy"/>
	<xsl:template name="mbFields_Buy"/>
	<!-- END - Buy -->


	<!-- BEG - UpfrontPaymentReturned -->
	<xsl:template name="accountingDate_Inv">
		<xsl:if test="../b:PayDateJoin">
			<accountingDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</accountingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionCode_Inv">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'-A','_R')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_I_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_I_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'-A')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="coaReference_Inv">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Inv">
		<security>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_Inv">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:accountCurr"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_Inv">
		<xsl:if test="../b:PayDateJoin">
			<transactionDate>
				<xsl:value-of select="../b:PayDateJoin"/>
			</transactionDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Inv">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="refundAmtAccCcy">
			<xsl:value-of select="format-number(../b:refundAmtAccCcy,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<tradeCcyGrossAmount>
			<xsl:value-of select=" ((-1) * $netAmtAccCur) + $refundAmtAccCcy"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="portfolio_Inv">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_Inv">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="refundAmtAccCcy">
			<xsl:value-of select="format-number(../b:refundAmtAccCcy,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<tradeQuantity>
			<xsl:value-of select=" ((-1) * $netAmtAccCur) + $refundAmtAccCcy"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="reversalIndicator_Inv">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_Inv">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
						<xsl:value-of select="concat(b:tapRefId,'-A')"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:entitlementId,@index,'/',b:newSecuritySubGroup/@index,'_I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Inv">
		<sourceSystemCode>
			<xsl:value-of select="concat(../b:entitlementId,'_I')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Inv">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="positionCriteria1_Inv">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="type_Inv">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Inv">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1_Inv"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Inv"/>
	<xsl:template name="account1NetAmount_Inv"/>
	<xsl:template name="depositaryAccount_Inv"/>
	<xsl:template name="remark_Inv"/>
	<xsl:template name="tradePrice_Inv"/>
	<xsl:template name="transactionFeesTaxesCounter_Inv"/>
	<xsl:template name="account2_Inv"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Inv"/>
	<xsl:template name="account2NetAmount_Inv"/>
	<xsl:template name="account3_Inv"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Inv"/>
	<xsl:template name="account3NetAmount_Inv"/>
	<xsl:template name="accountingCode_Inv"/>
	<xsl:template name="accruedInterestAmount_Inv"/>
	<xsl:template name="accruedInterestCounter_Inv"/>
	<xsl:template name="cashPortfolio_Inv"/>
	<xsl:template name="commonReference_Inv"/>
	<xsl:template name="communication_Inv"/>
	<xsl:template name="initiator_Inv"/>
	<xsl:template name="notepad_Inv"/>
	<xsl:template name="portfolioManager_Inv"/>
	<xsl:template name="positionCriteria2_Inv"/>
	<xsl:template name="positionCriteria3_Inv"/>
	<xsl:template name="subType_Inv"/>
	<xsl:template name="supplementaryAmount_Inv"/>
	<xsl:template name="tradeCcyNetAmount_Inv"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Inv"/>
	<xsl:template name="typeInstrument_Inv"/>
	<xsl:template name="userDefinedField_Inv"/>
	<xsl:template name="mbFields_Inv"/>
	<!-- END - UpfrontPaymentReturned -->

	<!-- BEG - SellorLapse -->
	<xsl:template name="account1_Sell">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Sell">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:if test="../b:netAmount and number(../b:netAmount) != '0'">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="$netAmtAccCur div ../b:netAmount"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Sell">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="entitlementAmt">
			<xsl:value-of select="format-number(b:entitlementAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="netAmount">
			<xsl:value-of select="format-number(../b:netAmount,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<account1NetAmount>
			<xsl:choose>
				<xsl:when test="b:optionNom = ../b:eventNominal">
					<xsl:value-of select="format-number($netAmtAccCur,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number($entitlementAmt * ($netAmtAccCur div $netAmount),$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate_Sell">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode_Sell">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="concat(b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,'_',@index,'_S_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,'_',@index,'_S_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
							<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,'_',@index,'_S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,'_',@index,'_S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_Sell">
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
	<xsl:template name="coaReference_Sell">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Sell">
		<security>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_Sell">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_Sell">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Sell">
		<tradeCcyGrossAmount>
			<xsl:value-of select="b:entitlementAmt"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="portfolio_Sell">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_Sell">
		<tradeQuantity>
			<xsl:value-of select="b:optionNom"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="tradePrice_Sell">
		<tradePrice>
			<xsl:value-of select="format-number(b:entitlementAmt div b:optionNom,$decimalformat,'nan2zero')"/>
		</tradePrice>
	</xsl:template>
	<xsl:template name="reversalIndicator_Sell">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_Sell">
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId and b:tapRefId != '' and b:tapRefId != 'NULL'">
						<xsl:value-of select="b:tapRefId"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,'_',@index,'_S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:entitlementId,'_',@index,'_S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Sell">
		<sourceSystemCode>
			<xsl:value-of select="../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Sell">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="positionCriteria1_Sell">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="type_Sell">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Sell">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Sell"/>
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
	<xsl:template name="positionCriteria2_Sell"/>
	<xsl:template name="positionCriteria3_Sell"/>
	<xsl:template name="remark_Sell"/>
	<xsl:template name="securityCcyNetAmount_Sell"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_Sell"/>
	<xsl:template name="subType_Sell"/>
	<xsl:template name="supplementaryAmount_Sell"/>
	<xsl:template name="tradeCcyNetAmount_Sell"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Sell"/>
	<xsl:template name="typeInstrument_Sell"/>
	<xsl:template name="userDefinedField_Sell"/>
	<xsl:template name="mbFields_Sell"/>
	<!-- END - SellorLapse -->
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