<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">

	<xsl:template name="account1_Purchase">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>

	<xsl:template name="account1CcyTradeCcyExchangeRate_Purchase">
		<xsl:if test="../../b:netAmount != ''">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number((../../b:netAmtAccCur) div (../../b:netAmount),$decimalformat,'nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Purchase">
		<account1NetAmount>
			<xsl:value-of select="format-number(../../b:netAmtAccCur * (-1),'#.##','nan2zero')"/>
		</account1NetAmount>
	</xsl:template>

	<xsl:template name="accountingDate_Purchase">
		<accountingDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Purchase">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="../../b:sourceTaxAmt"/>
			<xsl:with-param name="fgnCharges" select="../../b:fgnChargesAmt"/>
			<xsl:with-param name="foreignChgesTax" select="../../b:foreignChgesTax"/>
			<xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="commission" select="../../b:commissionAmt"/>
			<xsl:with-param name="commTax" select="../../b:commTaxAmt"/>
			<xsl:with-param name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
			<xsl:with-param name="currencyFT" select="../../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="transactionCode_Purchase">
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
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount_Purchase">
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
	<xsl:template name="coaReference_Purchase">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security_Purchase">
		<security>
			<infra:code>
				<xsl:value-of select="../b:newSecuritySubGroup/b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency_Purchase">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="transactionDate_Purchase">
		<transactionDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Purchase">
		<tradeCcyGrossAmount>
			<xsl:value-of select="../../b:finalSubscrAmt"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="portfolio_Purchase">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="tradeQuantity_Purchase">
		<tradeQuantity>
			<xsl:value-of select="../../b:finalSubscrQty"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="tradePrice_Purchase">
		<xsl:choose>
			<xsl:when test="b:pricetypeSecurityjoinGroup/b:pricetypeSecurityjoinSubGroup/b:pricetypeSecurityjoin = 'BOND' or b:pricetypeSecurityjoinGroup/b:pricetypeSecurityjoinSubGroup/b:pricetypeSecurityjoin = 'DBOND'">
				<tradePrice>
					<xsl:value-of select="format-number((../../b:finalSubscrAmt) div (../../b:finalSubscrQty),$decimalformat,'nan2zero')*100"/>
				</tradePrice>
			</xsl:when>
			<xsl:otherwise>
				<tradePrice>
					<xsl:value-of select="format-number((../../b:finalSubscrAmt) div (../../b:finalSubscrQty),$decimalformat,'nan2zero')"/>
				</tradePrice>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversalIndicator_Purchase">
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
					<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
            			<xsl:value-of select="concat(../../b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Purchase">
		<sourceSystemCode>
			<xsl:value-of select="../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Purchase">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type_Purchase">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Purchase">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_Purchase"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Purchase"/>
	<xsl:template name="account2NetAmount_Purchase"/>
	<xsl:template name="account3_Purchase"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Purchase"/>
	<xsl:template name="account3NetAmount_Purchase"/>
	<xsl:template name="accountingCode_Purchase"/>
	<xsl:template name="accruedInterestAmount_Purchase"/>
	<xsl:template name="accruedInterestCounter_Purchase"/>
	<xsl:template name="cashPortfolio_Purchase"/>
	<xsl:template name="commonReference_Purchase"/>
	<xsl:template name="communication_Purchase"/>
	<xsl:template name="initiator_Purchase"/>
	<xsl:template name="notepad_Purchase"/>
	<xsl:template name="portfolioManager_Purchase"/>
	<xsl:template name="positionCriteria1_Purchase"/>
	<xsl:template name="positionCriteria2_Purchase"/>
	<xsl:template name="positionCriteria3_Purchase"/>
	<xsl:template name="remark_Purchase"/>
	<xsl:template name="reversedTransactionCode_Purchase"/>
	<xsl:template name="securityCcyNetAmount_Purchase"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_Purchase"/>
	<xsl:template name="subType_Purchase"/>
	<xsl:template name="supplementaryAmount_Purchase"/>
	<xsl:template name="tradeCcyNetAmount_Purchase"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Purchase"/>
	<xsl:template name="typeInstrument_Purchase"/>
	<xsl:template name="userDefinedField_Purchase"/>
	<xsl:template name="mbFields_Purchase"/>
	<xsl:template name="exDate_Purchase">
	    <exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Purchase">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<!-- END OF Purchase -->
	<!-- start of withdrwal-->
	<xsl:template name="account1_withdrawal"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_withdrawal"/>
	<xsl:template name="account1NetAmount_withdrawal"/>
	<xsl:template name="account2_withdrawal"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_withdrawal"/>
	<xsl:template name="account2NetAmount_withdrawal"/>
	<xsl:template name="account3_withdrawal"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_withdrawal"/>
	<xsl:template name="account3NetAmount_withdrawal"/>
	<xsl:template name="accountingCode_withdrawal"/>
	<xsl:template name="accountingDate_withdrawal">
		<accountingDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="accruedInterestAmount_withdrawal"/>
	<xsl:template name="accruedInterestCounter_withdrawal"/>
	<xsl:template name="cashPortfolio_withdrawal"/>
	<xsl:template name="coaReference_withdrawal">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="commonReference_withdrawal"/>
	<xsl:template name="communication_withdrawal"/>
	<xsl:template name="depositaryAccount_withdrawal"/>
	<xsl:template name="initiator_withdrawal"/>
	<xsl:template name="notepad_withdrawal"/>
	<xsl:template name="portfolio_withdrawal">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_withdrawal"/>
	<xsl:template name="positionCriteria1_withdrawal"/>
	<xsl:template name="positionCriteria2_withdrawal"/>
	<xsl:template name="positionCriteria3_withdrawal"/>
	<xsl:template name="remark_withdrawal"/>
	<xsl:template name="reversalIndicator_withdrawal"/>
	<xsl:template name="reversedTransactionCode_withdrawal">
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
					<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_W',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
            			<xsl:value-of select="concat(../../b:entitlementId,'_W',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security_withdrawal">
		<security>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode_withdrawal">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:entitlementId,'_W')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_withdrawal">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_withdrawal"/>
	<xsl:template name="supplementaryAmount_withdrawal"/>
	<xsl:template name="tradeCcyGrossAmount_withdrawal">
		<tradeCcyGrossAmount>
			<xsl:value-of select="../../b:netAmtAccCur * (-1)"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount_withdrawal"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_withdrawal"/>
	<xsl:template name="tradeCurrency_withdrawal">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:accountCurr"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice_withdrawal"/>
	<xsl:template name="tradeQuantity_withdrawal">
		<tradeQuantity>
			<xsl:value-of select="../../b:netAmtAccCur * (-1)"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_withdrawal">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:value-of select="concat(../../b:entitlementId,'_W','_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:entitlementId,'_W',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_W','_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_W',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,'_W','_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,'_W',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_withdrawal">
		<transactionDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_withdrawal"/>
	<xsl:template name="type_withdrawal">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="typeInstrument_withdrawal"/>
	<xsl:template name="valueDate_withdrawal">
		<valueDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_withdrawal"/>
	<xsl:template name="mbFields_withdrawal"/>
	<xsl:template name="exDate_withdrawal">
	    <exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_withdrawal">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<!-- end of withdrawl -->
	<!-- start of investment -->
	<xsl:template name="account1_Investment"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Investment"/>
	<xsl:template name="account1NetAmount_Investment"/>
	<xsl:template name="account2_Investment"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Investment"/>
	<xsl:template name="account2NetAmount_Investment"/>
	<xsl:template name="account3_Investment"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Investment"/>
	<xsl:template name="account3NetAmount_Investment"/>
	<xsl:template name="accountingCode_Investment"/>
	<xsl:template name="accountingDate_Investment">
		<accountingDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="accruedInterestAmount_Investment"/>
	<xsl:template name="accruedInterestCounter_Investment"/>
	<xsl:template name="cashPortfolio_Investment"/>
	<xsl:template name="coaReference_Investment">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="commonReference_Investment"/>
	<xsl:template name="communication_Investment"/>
	<xsl:template name="depositaryAccount_Investment"/>
	<xsl:template name="initiator_Investment"/>
	<xsl:template name="notepad_Investment"/>
	<xsl:template name="portfolio_Investment">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_Investment"/>
	<xsl:template name="positionCriteria1_Investment"/>
	<xsl:template name="positionCriteria2_Investment"/>
	<xsl:template name="positionCriteria3_Investment"/>
	<xsl:template name="remark_Investment"/>
	<xsl:template name="reversalIndicator_Investment"/>
	<xsl:template name="reversedTransactionCode_Investment">
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
					<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_I',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
            			<xsl:value-of select="concat(../../b:entitlementId,'_I',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security_Investment">
		<security>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Investment">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:entitlementId,'_I')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Investment">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_Investment"/>
	<xsl:template name="supplementaryAmount_Investment"/>
	<xsl:template name="tradeCcyGrossAmount_Investment">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number((-1 * ../../b:netAmtAccCur),$decimalformat,'nan2zero') + format-number(../../b:refundAmtAccCcy,$decimalformat,'nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount_Investment"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Investment"/>
	<xsl:template name="tradeCurrency_Investment">
		<tradeCurrency>
			<infra:code>
			<xsl:value-of select="../../b:accountCurr"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice_Investment"/>
	<xsl:template name="tradeQuantity_Investment">
		<tradeQuantity>
			<xsl:value-of select="format-number((-1 * ../../b:netAmtAccCur),$decimalformat,'nan2zero') + format-number(../../b:refundAmtAccCcy,$decimalformat,'nan2zero')"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_Investment">
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
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_I','_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_I',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,'_I','_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,'_I',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Investment">
		<transactionDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Investment"/>
	<xsl:template name="type_Investment">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="typeInstrument_Investment"/>
	<xsl:template name="valueDate_Investment">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_Investment"/>
	<xsl:template name="mbFields_Investment"/>
	<xsl:template name="exDate_Investment">
	    <exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Investment">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<!-- end of investment-->
</xsl:stylesheet>