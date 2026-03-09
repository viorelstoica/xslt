<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch ns0" version="1.0">


	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:if test="../../../b:netAmount and ../../../b:netAmount != '0'"/>
		<account1CcyTradeCcyExchangeRate>
			<xsl:value-of select="format-number(../../../b:netAmtAccCur div ../../../b:netAmount,'#.#########','nan2zero')"/>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:choose>
				<xsl:when test="../../../../../c:PreviousEvent/b:TransactionEntitlement/b:netAmtAccCur and ../../../../../c:PreviousEvent/b:TransactionEntitlement/b:netAmtAccCur != ''">
					<xsl:value-of select="number(../../../b:netAmtAccCur) - number(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:netAmtAccCur)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:netAmtAccCur"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<accountingDate>
			<xsl:choose>
				<xsl:when test=". != ../../../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:intElectedDateSubGroup[@index = $intElectedDateSubGroupIndex]/b:intElectedDate">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="../../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="depositaryAccount">
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
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator">
		<xsl:param name="opStatus"/>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../../b:entitlementId,../../@index,'/',../../b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../../b:entitlementId,@index,'/',../../b:newSecuritySubGroup/@index,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../../../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCurrency"/>
	<xsl:template name="tradePrice">
		<tradePrice>
			<xsl:value-of select="../../../b:bookCostPercGroup/b:rate"/>
		</tradePrice>
	</xsl:template>
	<xsl:template name="tradeQuantity">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<tradeQuantity>
			<xsl:choose>
				<xsl:when test="../b:intElectedNom !='' and ../b:intElectedNom">
					<xsl:value-of select="../b:intElectedNom"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:optionNom"/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:param name="opStatus"/>
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
							<xsl:value-of select="concat(../../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../../b:entitlementId,$optionDescGroupIndex,'_',$intElectedDateSubGroupIndex,'_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:entitlementId,../@index,'_',$intElectedDateSubGroupIndex,'_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
							<xsl:value-of select="concat(../../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../../b:entitlementId,$optionDescGroupIndex,'_',$intElectedDateSubGroupIndex,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:entitlementId,$optionDescGroupIndex,'_',$intElectedDateSubGroupIndex,$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<transactionDate>
			<xsl:choose>
				<xsl:when test=". != ../../../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:intElectedDateSubGroup[@index = $intElectedDateSubGroupIndex]/b:intElectedDate">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:param name="fgnChargesAmt">
			<xsl:value-of select="format-number(../../../b:fgnChargesAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="fgnChargesAmtPrevious">
			<xsl:value-of select="format-number(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:fgnChargesAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="foreignChgesTax">
			<xsl:value-of select="format-number(../../../b:foreignChgesTax,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="foreignChgesTaxPrevious">
			<xsl:value-of select="format-number(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:foreignChgesTax,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="sourceTaxAmt">
			<xsl:value-of select="format-number(../../../b:sourceTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="sourceTaxAmtPrevious">
			<xsl:value-of select="format-number(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:sourceTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="localTaxAmtSum">
			<xsl:value-of select="format-number(sum(../../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="localTaxAmtSumPrevious">
			<xsl:value-of select="format-number(sum(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commissionAmt">
			<xsl:value-of select="format-number(../../../b:commissionAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commissionAmtPrevious">
			<xsl:value-of select="format-number(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:commissionAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commTaxAmt">
			<xsl:value-of select="format-number(../../../b:commTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commTaxAmtPrevious">
			<xsl:value-of select="format-number(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:commTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="manTaxAcySum">
			<xsl:value-of select="format-number(sum(../../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="manTaxAcySumPrevious">
			<xsl:value-of select="format-number(sum(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="scAmtAcySum">
			<xsl:value-of select="format-number(sum(../../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="scAmtAcySumPrevious">
			<xsl:value-of select="format-number(sum(../../../../../c:PreviousEvent/b:TransactionEntitlement/b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="($fgnChargesAmt + $foreignChgesTax) - ($fgnChargesAmtPrevious + $foreignChgesTaxPrevious)"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../../b:currency"/>
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
					<xsl:value-of select="../../../b:currency"/>
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
				<xsl:value-of select="($sourceTaxAmt + $localTaxAmtSum) - ($sourceTaxAmtPrevious + $localTaxAmtSumPrevious)"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../../b:currency"/>
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
					<xsl:value-of select="../../../b:currency"/>
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

				<xsl:value-of select="($commissionAmt + $commTaxAmt) - ($commissionAmtPrevious + $commTaxAmtPrevious)"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../../b:currency"/>
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
				<xsl:value-of select="($manTaxAcySum + $scAmtAcySum) - ($manTaxAcySumPrevious + $scAmtAcySumPrevious)"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../../b:currency"/>
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
					<xsl:value-of select="../../../b:currency"/>
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
					<xsl:value-of select="../../../b:currency"/>
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
					<xsl:value-of select="../../../b:currency"/>
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
					<xsl:value-of select="../../../b:currency"/>
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
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../../../b:valueDate"/>
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
					<xsl:value-of select="../../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
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
			<xsl:value-of select="../../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>




	<xsl:template name="account1_Lapse">
		<account1>
			<infra:code>
				<xsl:value-of select="../../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>

	<xsl:template name="account1CcyTradeCcyExchangeRate_Lapse"/>
	<xsl:template name="account1NetAmount_Lapse"/>
	<xsl:template name="accountingDate_Lapse">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<accountingDate>
			<xsl:choose>
				<xsl:when test=". != ../../../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:intElectedDateSubGroup[@index = $intElectedDateSubGroupIndex]/b:intElectedDate">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="coaReference_Lapse">
		<coaReference>
			<xsl:value-of select="../../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="depositaryAccount_Lapse">
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
	<xsl:template name="portfolio_Lapse">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark_Lapse"/>
	<xsl:template name="reversalIndicator_Lapse">
		<xsl:param name="opStatus"/>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../../b:entitlementId,@index,'/',../../b:newSecuritySubGroup/@index,'_lapse',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:entitlementId,@index,'/',../../b:newSecuritySubGroup/@index,'_lapse',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security_Lapse">
		<security>
			<infra:code>
				<xsl:value-of select="../../../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Lapse">
		<sourceSystemCode>
			<xsl:value-of select="../../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Lapse">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="tradeCurrency_Lapse"/>
	<xsl:template name="tradePrice_Lapse">
		<tradePrice>
			<xsl:value-of select="'0'"/>
		</tradePrice>
	</xsl:template>
	<xsl:template name="tradeQuantity_Lapse">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<tradeQuantity>
			<xsl:choose>
				<xsl:when test="../b:intElectedNom !='' and ../b:intElectedNom">
					<xsl:value-of select="../b:intElectedNom"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:optionNom"/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_Lapse">
		<xsl:param name="opStatus"/>
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
							<xsl:value-of select="concat(../../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../../b:entitlementId,$optionDescGroupIndex,'/',$intElectedDateSubGroupIndex,'_lapse_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:entitlementId,$optionDescGroupIndex,'/',$intElectedDateSubGroupIndex,'_lapse_R',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../../../b:tapOperCode and ../../../b:tapOperCode != ''">
							<xsl:value-of select="concat(../../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../../b:entitlementId,$optionDescGroupIndex,'/',$intElectedDateSubGroupIndex,'_lapse',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../../b:entitlementId,$optionDescGroupIndex,'/',$intElectedDateSubGroupIndex,'_lapse',$COMPANY_POSTFIX_SEPARATOR,../../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Lapse">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<transactionDate>
			<xsl:choose>
				<xsl:when test=". != ../../../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:intElectedDateSubGroup[@index = $intElectedDateSubGroupIndex]/b:intElectedDate">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../../b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Lapse"/>
	<xsl:template name="type_Lapse">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Lapse">
		<valueDate>
			<xsl:value-of select="../../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account2_Lapse"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_Lapse"/>
	<xsl:template name="account2NetAmount_Lapse"/>
	<xsl:template name="account3_Lapse"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_Lapse"/>
	<xsl:template name="account3NetAmount_Lapse"/>
	<xsl:template name="accountingCode_Lapse"/>
	<xsl:template name="accruedInterestAmount_Lapse"/>
	<xsl:template name="accruedInterestCounter_Lapse"/>
	<xsl:template name="cashPortfolio_Lapse"/>
	<xsl:template name="commonReference_Lapse"/>
	<xsl:template name="communication_Lapse"/>
	<xsl:template name="initiator_Lapse"/>
	<xsl:template name="notepad_Lapse"/>
	<xsl:template name="portfolioManager_Lapse"/>
	<xsl:template name="positionCriteria1_Lapse">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_Lapse"/>
	<xsl:template name="positionCriteria3_Lapse"/>
	<xsl:template name="reversedTransactionCode_Lapse"/>
	<xsl:template name="securityCcyNetAmount_Lapse"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_Lapse"/>
	<xsl:template name="subType_Lapse"/>
	<xsl:template name="supplementaryAmount_Lapse"/>
	<xsl:template name="tradeCcyGrossAmount_Lapse">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number((-1 * ../b:netAmtAccCur),$decimalformat,'nan2zero') + format-number(../b:refundAmtAccCcy,$decimalformat,'nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount_Lapse"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Lapse"/>
	<xsl:template name="typeInstrument_Lapse"/>
	<xsl:template name="userDefinedField_Lapse"/>
	<xsl:template name="mbFields_Lapse"/>
	<xsl:template name="exDate_Lapse">
		<exDate>
			<xsl:value-of select="../../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio_Lapse">
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