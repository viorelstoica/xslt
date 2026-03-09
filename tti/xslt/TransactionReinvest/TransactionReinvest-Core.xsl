<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="../b:accountNo"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyIncomeCcyExchangeRate">
      <xsl:if test="../b:netAmount != 0">
         <account1CcyIncomeCcyExchangeRate>
            <xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
         </account1CcyIncomeCcyExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="account1NetAmount"/>
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
   <xsl:template name="income">
      <income>
         <xsl:choose>
            <xsl:when test="../b:bookCostPercGroup[@index]/b:percentAge = 'Y'">
               <xsl:value-of select="format-number((../b:bookCostPercGroup[@index]/b:rate div 100),'#.#########','nan2zero')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="../b:bookCostPercGroup[@index]/b:rate"/>
            </xsl:otherwise>
         </xsl:choose>
      </income>
   </xsl:template>
   <xsl:template name="incomeCcyGrossAmount"/>
   <xsl:template name="incomeCurrency">
      <incomeCurrency>
         <infra:code>
            <xsl:value-of select="../b:currency"/>
         </infra:code>
      </incomeCurrency>
   </xsl:template>
   <xsl:template name="nominalOrUnit">
      <nominalOrUnit>
         <xsl:value-of select="../b:qualifyHolding"/>
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
					<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
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
	               		<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/I','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
	            	</xsl:when>
	            	<xsl:otherwise>
	               		<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
	            	</xsl:otherwise>
	         	</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
	        	<xsl:choose>
	            	<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
	               		<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/I','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
	            	</xsl:when>
	            	<xsl:otherwise>
	               		<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/I',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
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
      <xsl:param name="nbNewSecuSubGroup"/>
      <xsl:choose>
         <xsl:when test="$nbNewSecuSubGroup = 0">
            <xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
            <xsl:variable name="sumManTaxAcy" select="format-number(sum(../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
            <xsl:variable name="sumScAmtAcy" select="format-number(sum(../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
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
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="printEntitlementFeesAndTaxes_generic">
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
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyIncomeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyIncomeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="communication"/>
   <xsl:template name="incomeCcyNetAmount"/>
   <xsl:template name="incomeCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="incomeCounter"/>
   <xsl:template name="initiator"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="securityCcyNetAmount"/>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="subType"/>
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
   <xsl:template name="account1_Buy">
      <account1>
         <infra:code>
            <xsl:value-of select="../b:accountNo"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate_Buy">
      <xsl:if test="../b:netAmount != 0">
         <account1CcyTradeCcyExchangeRate>
            <xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
         </account1CcyTradeCcyExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="accountingDate_Buy">
      <accountingDate>
         <xsl:value-of select="../b:PayDateJoin"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="coaReference_Buy">
      <coaReference>
         <xsl:value-of select="../b:diaryId"/>
      </coaReference>
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
   <xsl:template name="portfolio_Buy">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="remark_Buy">
      <remark>
         <xsl:value-of select="b:optionDesc"/>
      </remark>
   </xsl:template>
   <xsl:template name="reversalIndicator_Buy">
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
					<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
         </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="security_Buy">
      <security>
         <infra:code>
            <xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:newSecurity"/>
         </infra:code>
      </security>
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
   <xsl:template name="tradeCcyGrossAmount_Buy"/>
   <xsl:template name="tradeCurrency_Buy">
      <tradeCurrency>
         <infra:code>
            <xsl:value-of select="../b:currency"/>
         </infra:code>
      </tradeCurrency>
   </xsl:template>
   <xsl:template name="tradePrice_Buy">
      <tradePrice>
         <xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:price"/>
      </tradePrice>
   </xsl:template>
   <xsl:template name="tradeQuantity_Buy">
      <tradeQuantity>
         <xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:nominal"/>
      </tradeQuantity>
   </xsl:template>
   <xsl:template name="transactionCode_Buy">
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
               			<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/1','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
            		</xsl:when>
            		<xsl:otherwise>
               			<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../b:entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
            		</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
         		<xsl:choose>
            		<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               			<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/1','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
            		</xsl:when>
            		<xsl:otherwise>
               			<xsl:value-of select="concat(../b:entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
            		</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate_Buy">
      <transactionDate>
         <xsl:value-of select="../b:PayDateJoin"/>
      </transactionDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter_Buy">
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
   <xsl:template name="account1NetAmount_Buy"/>
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
   <xsl:template name="positionCriteria1_Buy">
	<positionCriteria1>
		<xsl:call-template name="extCustodianTranslation">
			<xsl:with-param name="boExtCustodian">
				<xsl:value-of select="../b:extCustodian"/>
			</xsl:with-param>
		</xsl:call-template>
	</positionCriteria1>
   </xsl:template>
   <xsl:template name="positionCriteria2_Buy"/>
   <xsl:template name="positionCriteria3_Buy"/>
   <xsl:template name="reversedTransactionCode_Buy"/>
   <xsl:template name="securityCcyNetAmount_Buy"/>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate_Buy"/>
   <xsl:template name="subType_Buy"/>
   <xsl:template name="supplementaryAmount_Buy"/>
   <xsl:template name="tradeCcyNetAmount_Buy"/>
   <xsl:template name="tradeCcyPortfolioCcyExchangeRate_Buy"/>
   <xsl:template name="typeInstrument_Buy"/>
   <xsl:template name="userDefinedField_Buy"/>
   <xsl:template name="mbFields_Buy"/>
   <xsl:template name="exDate_Buy">
	<exDate>
		<xsl:value-of select="../b:diaryExDate"/>
	</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Buy">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
</xsl:stylesheet>