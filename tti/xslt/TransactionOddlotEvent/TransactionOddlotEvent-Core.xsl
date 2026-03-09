<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">

	<xsl:template name="account1_COAPurchase">
		<account1>
			<infra:code>
				<xsl:value-of select="../../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>

	<xsl:template name="account1CcyTradeCcyExchangeRate_COAPurchase">
		<xsl:if test="../../../b:netAmount != ''">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number((../../../b:netAmtAccCur) div (../../../b:netAmount),$decimalformat,'nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_COAPurchase">
		<account1NetAmount>
			<xsl:value-of select="format-number(../../../b:netAmtAccCur * (-1),'#.##','nan2zero')"/>
		</account1NetAmount>
	</xsl:template>

	<xsl:template name="accountingDate_COAPurchase">
		<accountingDate>
			<xsl:value-of select="../../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>

	<xsl:template name="transactionFeesTaxesCounter_COAPurchase">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="../../../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../../../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../../../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(../../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="../../../b:commissionAmt"/>
			<xsl:with-param name="commTax" select="../../../b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(../../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(../../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="currencyFT" select="../../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="transactionCode_COAPurchase">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../../b:tapOperCode, '_', ../../../b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:tapOperCode, '_', ../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../../b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_COAPurchase">
		<xsl:choose>
   		<xsl:when test="../../../b:depository != ''">
		<depositaryAccount>
         <infra:code>
			<xsl:choose>
				<xsl:when test="../../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../../b:subAccount != ''">
					<xsl:value-of select="concat(../../../b:depository,'_',../../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
         </infra:code>
      </depositaryAccount>
	  </xsl:when>
	 </xsl:choose>
	</xsl:template>
	<xsl:template name="coaReference_COAPurchase">
		<coaReference>
			<xsl:value-of select="../../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_COAPurchase">
		<security>
			<infra:code>
				<xsl:value-of select="."/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_COAPurchase">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_COAPurchase">
		<transactionDate>
			<xsl:value-of select="../../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_COAPurchase">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number(../../b:entitlementAmt * (-1),'#.####','nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="portfolio_COAPurchase">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_COAPurchase">
		<tradeQuantity>
			<xsl:value-of select="../b:nominal"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="tradePrice_COAPurchase">
	<xsl:variable name="index">
		<xsl:value-of select="../../@index"/>
	</xsl:variable>
		<xsl:choose>
			<xsl:when test="../../../b:PriceTypeSecurityNoJoin = 'BOND' or ../../../b:PriceTypeSecurityNoJoin = 'DBOND'">
				<tradePrice>
					<xsl:value-of select="format-number((../../../b:optionDescGroup[@index=$index]/b:entitlementAmt) div (../../../b:secNoGroup/b:secNominal),$decimalformat,'nan2zero')* -100"/>
				</tradePrice>
			</xsl:when>
			<xsl:otherwise>
				<tradePrice>
					<xsl:value-of select="format-number((../../../b:optionDescGroup[@index=$index]/b:entitlementAmt) div (../../../b:secNoGroup/b:secNominal),$decimalformat,'nan2zero')* -1"/>
				</tradePrice>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversalIndicator_COAPurchase">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../../b:tapOperCode, '_', ../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_COAPurchase">
		<sourceSystemCode>
			<xsl:value-of select="../../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_COAPurchase">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type_COAPurchase">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_COAPurchase">
		<valueDate>
			<xsl:value-of select="../../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_COAPurchase"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_COAPurchase"/>
	<xsl:template name="account2NetAmount_COAPurchase"/>
	<xsl:template name="account3_COAPurchase"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_COAPurchase"/>
	<xsl:template name="account3NetAmount_COAPurchase"/>
	<xsl:template name="accountingCode_COAPurchase"/>
	<xsl:template name="accruedInterestAmount_COAPurchase"/>
	<xsl:template name="accruedInterestCounter_COAPurchase"/>
	<xsl:template name="cashPortfolio_COAPurchase"/>
	<xsl:template name="commonReference_COAPurchase"/>
	<xsl:template name="communication_COAPurchase"/>
	<xsl:template name="initiator_COAPurchase"/>
	<xsl:template name="notepad_COAPurchase"/>
	<xsl:template name="portfolioManager_COAPurchase"/>
	<xsl:template name="positionCriteria1_COAPurchase">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_COAPurchase"/>
	<xsl:template name="positionCriteria3_COAPurchase"/>
	<xsl:template name="remark_COAPurchase"/>
	<xsl:template name="reversedTransactionCode_COAPurchase"/>
	<xsl:template name="securityCcyNetAmount_COAPurchase"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_COAPurchase"/>
	<xsl:template name="subType_COAPurchase"/>
	<xsl:template name="supplementaryAmount_COAPurchase"/>
	<xsl:template name="tradeCcyNetAmount_COAPurchase"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_COAPurchase"/>
	<xsl:template name="typeInstrument_COAPurchase"/>
	<xsl:template name="userDefinedField_COAPurchase"/>
	<xsl:template name="mbFields_COAPurchase"/>
	 <xsl:template name="exDate_COAPurchase">
	    <exDate>
			<xsl:value-of select="../../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_COAPurchase">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<!-- end of buy -->

	<!-- start of sell -->

	<xsl:template name="account1_COASale">
		<account1>
			<infra:code>
				<xsl:value-of select="../../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_COASale">
		<xsl:if test="../../../b:netAmount != ''">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number((../../../b:netAmtAccCur) div (../../../b:netAmount),$decimalformat,'nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_COASale">
		<account1NetAmount>
			<xsl:value-of select="../../../b:netAmtAccCur"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account2_COASale"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_COASale"/>
	<xsl:template name="account2NetAmount_COASale"/>
	<xsl:template name="account3_COASale"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_COASale"/>
	<xsl:template name="account3NetAmount_COASale"/>
	<xsl:template name="accountingCode_COASale"/>
	<xsl:template name="accountingDate_COASale">
		<accountingDate>
			<xsl:value-of select="../../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="accruedInterestAmount_COASale"/>
	<xsl:template name="accruedInterestCounter_COASale"/>
	<xsl:template name="cashPortfolio_COASale"/>
	<xsl:template name="coaReference_COASale">
		<coaReference>
			<xsl:value-of select="../../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="commonReference_COASale"/>
	<xsl:template name="communication_COASale"/>
	<xsl:template name="depositaryAccount_COASale">
		<xsl:choose>
   		<xsl:when test="../../../b:depository != ''">
		<depositaryAccount>
         <infra:code>
			<xsl:choose>
				<xsl:when test="../../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../../b:subAccount != ''">
					<xsl:value-of select="concat(../../../b:depository,'_',../../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
         </infra:code>
      </depositaryAccount>
	  </xsl:when>
	 </xsl:choose>
	</xsl:template>
	<xsl:template name="initiator_COASale"/>
	<xsl:template name="notepad_COASale"/>
	<xsl:template name="portfolio_COASale">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_COASale"/>
	<xsl:template name="positionCriteria1_COASale">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_COASale"/>
	<xsl:template name="positionCriteria3_COASale"/>
	<xsl:template name="remark_COASale"/>
	<xsl:template name="reversalIndicator_COASale">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../../b:tapOperCode, '_', ../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_COASale"/>
	<xsl:template name="security_COASale">
		<security>
			<infra:code>
				<xsl:value-of select="."/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyNetAmount_COASale"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_COASale"/>
	<xsl:template name="sourceSystemCode_COASale">
		<sourceSystemCode>
			<xsl:value-of select="../../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_COASale">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_COASale"/>
	<xsl:template name="supplementaryAmount_COASale"/>
	<xsl:template name="tradeCcyGrossAmount_COASale">
		<tradeCcyGrossAmount>
			<xsl:value-of select="../../b:entitlementAmt"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount_COASale"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_COASale"/>
	<xsl:template name="tradeCurrency_COASale">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice_COASale">
		<xsl:variable name="index">
		<xsl:value-of select="../../@index"/>
	</xsl:variable>
		<xsl:choose>
			<xsl:when test="b:PriceTypeSecurityNoJoin = 'BOND' or b:PriceTypeSecurityNoJoin = 'DBOND'">
				<tradePrice>
					<xsl:value-of select="format-number((../../../b:optionDescGroup[@index=$index]/b:entitlementAmt) div (../../../b:secNoGroup/b:secNominal),$decimalformat,'nan2zero')* -100"/>
				</tradePrice>
			</xsl:when>
			<xsl:otherwise>
				<tradePrice>
					<xsl:value-of select="format-number((../../../b:optionDescGroup[@index=$index]/b:entitlementAmt) div (../../../b:secNoGroup/b:secNominal),$decimalformat,'nan2zero')* -1"/>
				</tradePrice>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="tradeQuantity_COASale">
		<tradeQuantity>
			<xsl:value-of select="../b:nominal"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_COASale">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../../b:tapOperCode, '_', ../../../b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:tapOperCode, '_', ../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../../b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_COASale">
		<transactionDate>
			<xsl:value-of select="../../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_COASale">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="../../../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../../../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../../../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(../../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="../../../b:commissionAmt"/>
			<xsl:with-param name="commTax" select="../../../b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(../../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(../../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="currencyFT" select="../../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_COASale">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="typeInstrument_COASale"/>
	<xsl:template name="valueDate_COASale">
		<valueDate>
			<xsl:value-of select="../../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_COASale"/>
	<xsl:template name="mbFields_COASale"/>
	<xsl:template name="exDate_COASale">
	    <exDate>
			<xsl:value-of select="../../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_COASale">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
</xsl:stylesheet>