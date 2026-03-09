<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1_OddLotSale">
      <account1>
         <infra:code>
            <xsl:value-of select="../b:accountNo"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcysaleCcyExchangeRate_OddLotSale">
      <xsl:if test="../b:netAmount != 0">
         <account1CcysaleCcyExchangeRate>
            <xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
         </account1CcysaleCcyExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="account1NetAmount_OddLotSale">
      <account1NetAmount>
         <xsl:value-of select="../b:netAmtAccCur"/>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="accountingDate_OddLotSale">
      <xsl:if test="../b:PayDateJoin">
         <accountingDate>
            <xsl:value-of select="../b:PayDateJoin"/>
         </accountingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="coaReference_OddLotSale">
      <coaReference>
         <xsl:value-of select="../b:diaryId"/>
      </coaReference>
   </xsl:template>
   <xsl:template name="depositaryAccount_OddLotSale">
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
   <xsl:template name="portfolio_OddLotSale">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator_OddLotSale">
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
				<xsl:when test="../b:tapOperCode !=''">
					<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
         </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="salePrice_OddLotSale">
      <salePrice>
         <xsl:value-of select="format-number((../b:netAmtAccCur + ../b:sourceTaxAmt + ../b:fgnChargesAmt + ../b:localTaxAmtList/b:localTaxAmt + ../b:commissionAmt + ../b:commTaxAmt ) div ../b:eventNominal ,$decimalformat,'nan2zero')"/>
      </salePrice>
   </xsl:template>
   <xsl:template name="security_OddLotSale">
      <security>
         <infra:code>
            <xsl:value-of select="../b:securityNo"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="status_OddLotSale">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode_OddLotSale">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="../b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode><!-- 0_ to be first in fusion, followed by entitlementAmtGroup index -->
         <xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode !=''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:entitlementId,'0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="saleDate_OddLotSale">
      <saleDate>
         <xsl:value-of select="../b:PayDateJoin"/>
      </saleDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter_OddLotSale">
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
   <xsl:template name="type_OddLotSale">
      <type>
         <infra:code>
            <xsl:value-of select="concat('ENT_',../b:eventType)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate_OddLotSale">
      <valueDate>
         <xsl:value-of select="../b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="oddLotQuantity_OddLotSale">
      <oddLotQuantity>
         <xsl:value-of select="format-number(../b:secNoGroup/b:secNominal * (-1),$decimalformat,'nan2zero')"/>
      </oddLotQuantity>
   </xsl:template>
   <xsl:template name="sourceSystemCode_OddLotSale">
      <sourceSystemCode>
         <xsl:value-of select="../b:entitlementId"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="account2_OddLotSale"/>
   <xsl:template name="account2CcysaleCcyExchangeRate_OddLotSale"/>
   <xsl:template name="account2NetAmount_OddLotSale"/>
   <xsl:template name="account3_OddLotSale"/>
   <xsl:template name="account3CcysaleCcyExchangeRate_OddLotSale"/>
   <xsl:template name="account3NetAmount_OddLotSale"/>
   <xsl:template name="accountingCode_OddLotSale"/>
   <xsl:template name="accruedInterestCounter_OddLotSale"/>
   <xsl:template name="accruedInterests_OddLotSale"/>
   <xsl:template name="commonReference_OddLotSale"/>
   <xsl:template name="cashPortfolio_OddLotSale"/>
   <xsl:template name="contractNumber_OddLotSale"/>
   <xsl:template name="initiator_OddLotSale"/>
   <xsl:template name="notepad_OddLotSale"/>
   <xsl:template name="portfolioManager_OddLotSale"/>
   <xsl:template name="remark_OddLotSale"/>
   <xsl:template name="reversedTransactionCode_OddLotSale"/>
   <xsl:template name="saleCcyGrossAmount_OddLotSale"/>
   <xsl:template name="saleCcyNetAmount_OddLotSale"/>
   <xsl:template name="saleCcyPortfolioCcyExchangeRate_OddLotSale"/>
   <xsl:template name="saleCurrency_OddLotSale"/>
   <xsl:template name="securityCcyNetAmount_OddLotSale"/>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate_OddLotSale"/>
   <xsl:template name="subType_OddLotSale"/>
   <xsl:template name="positionCriteria1_OddLotSale">
   	<positionCriteria1>
		<xsl:call-template name="extCustodianTranslation">
			<xsl:with-param name="boExtCustodian">
				<xsl:value-of select="../b:extCustodian"/>
			</xsl:with-param>
		</xsl:call-template>
	</positionCriteria1>
   </xsl:template>
   <xsl:template name="positionCriteria2_OddLotSale"/>
   <xsl:template name="positionCriteria3_OddLotSale"/>
   <xsl:template name="typeInstrument_OddLotSale"/>
   <xsl:template name="userDefinedField_OddLotSale"/>
   <xsl:template name="mbFields_OddLotSale"/>
   <xsl:template name="exDate_OddLotSale">
	    <exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_OddLotSale">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
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
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode !=''">
					<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
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
         <xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode !=''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../b:entitlementId,'0/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:entitlementId,'0/',@index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
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
            <xsl:value-of select="concat('ENT_',../b:eventType)"/>
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
         <xsl:value-of select="../b:diaryId"/>
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
   <xsl:template name="cashAmount">
      <xsl:if test="../b:secNoGroup/b:secNominal">
         <cashAmount>
            <xsl:value-of select="b:entitlementAmt"/>
         </cashAmount>
      </xsl:if>
   </xsl:template>
   <xsl:template name="currentAccount">
      <currentAccount>
         <infra:code>
            <xsl:value-of select="../b:accountNo"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="concat(../b:entitlementId,'_X')"/>
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
				<xsl:value-of select="../b:extCustodian"/>
			</xsl:with-param>
		</xsl:call-template>
	</positionCriteria1>
   </xsl:template>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="positionCurrency"/>
   <xsl:template name="profitLossCounter"/>
   
   <xsl:template name="account1_OldSecurity">
      <account1>
         <infra:code>
            <xsl:value-of select="../../b:accountNo"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyPositionCcyExchangeRate_OldSecurity">
      <xsl:if test="../../b:netAmount != 0">
         <account1CcyPositionCcyExchangeRate>
            <xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,'#.#########','nan2zero')"/>
         </account1CcyPositionCcyExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="accountingDate_OldSecurity">
      <xsl:if test="../../b:PayDateJoin">
         <accountingDate>
            <xsl:value-of select="../../b:PayDateJoin"/>
         </accountingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="portfolio_OldSecurity">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../../b:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator_OldSecurity">
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
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode !=''">
					<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:entitlementId,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
         </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="status_OldSecurity">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode_OldSecurity">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
         <xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode !=''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter_OldSecurity">
      <xsl:choose>
         <xsl:when test="@index = 1">
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
               <xsl:with-param name="currencyFT" select="../../b:currency"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="type_OldSecurity">
      <type>
         <infra:code>
            <xsl:value-of select="concat('ENT_',../../b:eventType)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate_OldSecurity">
      <valueDate>
         <xsl:value-of select="../../b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="coaReference_OldSecurity">
      <coaReference>
         <xsl:value-of select="../../b:diaryId"/>
      </coaReference>
   </xsl:template>
   <xsl:template name="newQuantity_OldSecurity">
      <newQuantity>
         <xsl:value-of select="b:nominal"/>
      </newQuantity>
   </xsl:template>
   <xsl:template name="newSecurity_OldSecurity">
      <newSecurity>
         <infra:code>
            <xsl:value-of select="b:newSecurity"/>
         </infra:code>
      </newSecurity>
   </xsl:template>
   <xsl:template name="newSecurityDepositaryAccount_OldSecurity">
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
   <xsl:template name="oldQuantity_OldSecurity">
      <oldQuantity>
         <xsl:value-of select="../../b:secNoGroup[@index = 1][b:secNo = ../b:securityNo]/b:secNominal"/>
      </oldQuantity>
   </xsl:template>
   <xsl:template name="oldSecurity_OldSecurity">
      <oldSecurity>
         <infra:code>
            <xsl:value-of select="../../b:securityNo"/>
         </infra:code>
      </oldSecurity>
   </xsl:template>
   <xsl:template name="oldSecurityDepositaryAccount_OldSecurity">
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
   <xsl:template name="transactionDate_OldSecurity">
      <xsl:if test="../../b:PayDateJoin">
         <transactionDate>
            <xsl:value-of select="../../b:PayDateJoin"/>
         </transactionDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="sourceSystemCode_OldSecurity">
      <sourceSystemCode>
         <xsl:value-of select="../../b:entitlementId"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="account1NetAmount_OldSecurity"/>
   <xsl:template name="account2_OldSecurity"/>
   <xsl:template name="account2CcyPositionCcyExchangeRate_OldSecurity"/>
   <xsl:template name="account2NetAmount_OldSecurity"/>
   <xsl:template name="account3_OldSecurity"/>
   <xsl:template name="account3CcyPositionCcyExchangeRate_OldSecurity"/>
   <xsl:template name="account3NetAmount_OldSecurity"/>
   <xsl:template name="accountingCode_OldSecurity"/>
   <xsl:template name="cashPortfolio_OldSecurity"/>
   <xsl:template name="commonReference_OldSecurity"/>
   <xsl:template name="contractNumber_OldSecurity"/>
   <xsl:template name="notepad_OldSecurity"/>
   <xsl:template name="portfolioManager_OldSecurity"/>
   <xsl:template name="remark_OldSecurity"/>
   <xsl:template name="reversedTransactionCode_OldSecurity"/>
   <xsl:template name="subType_OldSecurity"/>
   <xsl:template name="typeInstrument_OldSecurity"/>
   <xsl:template name="userDefinedField_OldSecurity"/>
   <xsl:template name="mbFields_OldSecurity"/>
   <xsl:template name="initiator_OldSecurity"/>
   <xsl:template name="newSecurityPositionCriteria1_OldSecurity"/>
   <xsl:template name="newSecurityPositionCriteria2_OldSecurity"/>
   <xsl:template name="newSecurityPositionCriteria3_OldSecurity"/>
   <xsl:template name="newSecurityPositionCurrency_OldSecurity"/>
   <xsl:template name="oldSecurityPositionCriteria1_OldSecurity">
	<oldSecurityPositionCriteria1>
		<xsl:call-template name="extCustodianTranslation">
			<xsl:with-param name="boExtCustodian">
				<xsl:value-of select="../../b:extCustodian"/>
			</xsl:with-param>
		</xsl:call-template>
	</oldSecurityPositionCriteria1>
   </xsl:template>
   <xsl:template name="oldSecurityPositionCriteria2_OldSecurity"/>
   <xsl:template name="oldSecurityPositionCriteria3_OldSecurity"/>
   <xsl:template name="oldSecuritypositionCurrency_OldSecurity"/>
   <xsl:template name="unitaryCostPrice_OldSecurity"/>
   <xsl:template name="exDate_OldSecurity">
	    <exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_OldSecurity">
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