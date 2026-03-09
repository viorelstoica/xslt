<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<!-- variables for evaluating the different cases -->
	<!--   Conversion into another security-->
	<xsl:template name="conversionIntoSecurityCriteria">
		<xsl:value-of select=" count(descendant::b:newSecuritySubGroup) &gt;= 1          and b:newSecuritySubGroup[@index=1]/b:newSecurity != ../b:securityNo          and b:newSecuritySubGroup[@index=1]/b:nominal"/>
	</xsl:template>
	<!--   Sell the position -->
	<xsl:template name="conversionSellCriteria">
		<xsl:value-of select=" ( not(b:newSecuritySubGroup)            or (     b:newSecuritySubGroup[@index=1]/b:newSecurity = ../b:securityNo                 and ../b:secNoGroup[@index=1]/b:secNo = ../b:securityNo          and ../b:secNoGroup[@index=1]/b:secNominal &lt; 0             )         )         and b:entitlementAmt &gt; 0           "/>
	</xsl:template>
	<!--   Lapse -->
	<xsl:template name="conversionLapseCriteria">
		<xsl:value-of select="(     not(b:newSecuritySubGroup)                       or (     b:newSecuritySubGroup[@index=1]/b:newSecurity = ../b:securityNo                 and ../b:secNoGroup[@index=1]/b:secNo = ../b:securityNo          and ../b:secNoGroup[@index=1]/b:secNominal &lt; 0            )          )         and ( b:entitlementAmt = 0 or not(b:entitlementAmt))"/>
	</xsl:template>
	<!--   OverSubscribe -->
	<xsl:template name="conversionOversubscribeCriteria">
		<xsl:value-of select=" (   count(descendant::b:newSecuritySubGroup) = 1                     and b:newSecuritySubGroup[@index=1]/b:newSecurity = ../b:securityNo        and b:newSecuritySubGroup[@index=1]/b:nominal        and b:newSecuritySubGroup[@index=1]/b:price        )        and b:entitlementAmt &lt; 0 "/>
	</xsl:template>
	<!--   Take no action -->
	<xsl:template name="conversionNoActionCriteria">
		<xsl:value-of select="'false'"/>
	</xsl:template>
	<!--   Custo Case 1 -->
	<xsl:template name="conversionCustoCriteria">
		<xsl:value-of select="'false'"/>
	</xsl:template>
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
	<xsl:param name="index" select="@index"/>
	<xsl:if test="not(../../b:accountCurr = ../../b:newSecCurrencyGroup[@index=$index]/b:newSecCurrencySubGroup/b:newSecCurrency) and ../../b:netAmount and number(../../b:netAmount) != '0'">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="depositaryAccount">
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
	<xsl:template name="portfolio">
	<xsl:if test="not(../b:tapRefId)">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../b:tapOperCode !=''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin,'_1')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin,'_1')"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<sourceSystemCode>
			<xsl:value-of select="$entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="tradeCcy">
	<tradeCcy>
		<infra:code>
			<xsl:value-of select="../../b:currency"/>
		</infra:code>
	</tradeCcy>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCurrency"/>
	<xsl:template name="tradeExchangeRate">
		<xsl:param name="netAmtAccCur">
			<xsl:value-of select="format-number(../../b:netAmtAccCur,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:if test="(../../b:accountCurr = ../../b:currency) and ../../b:netAmount and number(../../b:netAmount) != '0'">
			<tradeExchangeRate>
				<xsl:value-of select="$netAmtAccCur div ../../b:netAmount"/>
			</tradeExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradePrice">
	<tradePrice>
		<xsl:choose>
			<xsl:when test="(b:price and (b:price !='' or b:price != NULL))">
				<xsl:value-of select="b:price"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
		</xsl:choose>
	</tradePrice>
</xsl:template>
	<xsl:template name="tradeQuantity">
		<tradeQuantity>
			<xsl:value-of select="b:nominal"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapRefId and ../b:tapRefId != ''">
					<xsl:value-of select="concat(../b:tapRefId, '-A')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode !=''">
							<xsl:choose>
								<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin,'_1')"/>
								</xsl:when>
								<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin,'_1')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat($entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin,'_1')"/>
								</xsl:when>
								<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin,'_1')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>					
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:param name="idxFirstOptDescGroupWithSecu"/>
		<xsl:choose>
			<xsl:when test="../@index = $idxFirstOptDescGroupWithSecu and @index = 1">
				<xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
				<!-- call the template to print the FT -->
				<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
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
				<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
					<xsl:with-param name="sourceTax" select="'0'"/>
					<xsl:with-param name="fgnCharges" select="'0'"/>
					<xsl:with-param name="foreignChgesTax" select="0"/>
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
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1NetAmount"/>
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
					<xsl:value-of select="../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="remark"/>
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
		<xsl:value-of select="../../b:diaryExDate"/>
	</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<xsl:template name="account1_Sell">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_Sell">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount ,$decimalformat,'nan2zero')"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount_Sell">
		<xsl:if test="count(../b:optionDescGroup[b:optionNom != 0]) = 1">
			<!-- only this option, all old securities are sold -->
			<account1NetAmount>
				<xsl:value-of select="format-number(../b:netAmtAccCur,'#.####','nan2zero')"/>
			</account1NetAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate_Sell">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="coaReference_Sell">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
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
	<xsl:template name="portfolio_Sell">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_Sell">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
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
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($entitlementId,'_',@index,'/S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>								
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security_Sell">
		<security>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Sell">
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<sourceSystemCode>
			<xsl:value-of select="$entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Sell">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Sell">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number(b:entitlementAmt,'#.####','nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCurrency_Sell">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice_Sell">
		<tradePrice>
			<xsl:value-of select="format-number(b:entitlementAmt div b:optionNom,'#.####','nan2zero')"/>
		</tradePrice>
	</xsl:template>
	<xsl:template name="tradeQuantity_Sell">
		<tradeQuantity>
			<xsl:value-of select="b:optionNom"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_Sell">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/S_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/S_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/S',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Sell">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Sell">
		<xsl:choose>
			<xsl:when test="count(../b:optionDescGroup[b:optionNom != 0]) = 1">
				<!-- only this option ie the sell, takes all the FT -->
				<!-- Fees and taxes part -->
				<xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumManTaxAcy" select="format-number(sum(../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumScAmtAcy" select="format-number(sum(../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
				<!-- call the template to print the FT -->
				<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
					<xsl:with-param name="sourceTax" select="../b:sourceTaxAmt"/>
					<xsl:with-param name="fgnCharges" select="../b:fgnChargesAmt"/>
					<xsl:with-param name="sumlocalTaxAmt" select="$sumlocalTaxAmt"/>
					<xsl:with-param name="commission" select="../b:commissionAmt"/>
					<xsl:with-param name="commTax" select="../b:commTaxAmt"/>
					<xsl:with-param name="sumManTaxAcy" select="$sumManTaxAcy"/>
					<xsl:with-param name="sumScAmtAcy" select="$sumScAmtAcy"/>
					<xsl:with-param name="currencyFT" select="../b:currency"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- F&T will be put on the securities -->
				<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
					<xsl:with-param name="sourceTax" select="'0'"/>
					<xsl:with-param name="fgnCharges" select="'0'"/>
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
					<xsl:value-of select="../b:extCustodian"/>
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
	<xsl:template name="tradeCcyNetAmount_Sell"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Sell"/>
	<xsl:template name="typeInstrument_Sell"/>
	<xsl:template name="userDefinedField_Sell"/>
	<xsl:template name="mbFields_Sell"/>
	<xsl:template name="exDate_Sell">
	<exDate>
		<xsl:value-of select="../b:diaryExDate"/>
	</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Sell">
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
	<xsl:template name="reversalIndicator_Buy">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
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
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/B',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($entitlementId,'_',@index,'/B',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
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
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<sourceSystemCode>
			<xsl:value-of select="$entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Buy">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_Buy">
		<tradeCcyGrossAmount>
			<xsl:value-of select="format-number(b:entitlementAmt * (-1),'#.####','nan2zero')"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCurrency_Buy">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice_Buy">
		<xsl:if test="b:newSecuritySubGroup[@index=1]/b:price">
			<tradePrice>
				<xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:price"/>
			</tradePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeQuantity_Buy">
		<tradeQuantity>
			<xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:nominal"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_Buy">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/B_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/B_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/B',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/B',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
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
	<xsl:template name="remark_Buy"/>
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
	<xsl:template name="account1_Adj">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyoldSecCcyExchangeRate_Adj">
		<xsl:if test="../b:netAmount != 0">
			<account1CcyoldSecCcyExchangeRate>
				<xsl:value-of select="format-number(../b:netAmtAccCur div ../b:netAmount,'#.#########','nan2zero')"/>
			</account1CcyoldSecCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate_Adj">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="adjustmentNature_Adj">
		<adjustmentNature>
			<xsl:value-of select="'2'"/>
			<!-- 2 is PL -->
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="coaReference_Adj">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="newQuantity_Adj">
		<newQuantity>
			<xsl:value-of select="'0'"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurity_Adj">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:newSecuritySubGroup[@index=1]/b:newSecurity"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount_Adj">
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
	<xsl:template name="oldQuantity_Adj">
		<oldQuantity>
			<xsl:value-of select="format-number(b:optionNom * (-1),'#.####','nan2zero')"/>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldSecurity_Adj">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount_Adj">
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
	<xsl:template name="portfolio_Adj">
	<xsl:if test="not(b:tapRefId)">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversalIndicator_Adj">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
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
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin,'_2')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin,'_2')"/>
							</xsl:otherwise>
						</xsl:choose>								
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Adj">
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<sourceSystemCode>
			<xsl:value-of select="$entitlementId"/>
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
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/1_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin,'_2')"/>
								</xsl:when>
								<xsl:otherwise>
							<xsl:value-of select="concat($entitlementId,'_',@index,'/1_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin,'_2')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/1',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin,'_2')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/1_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin,'_2')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Adj">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_Adj">
		<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
			<xsl:with-param name="sourceTax" select="'0'"/>
			<xsl:with-param name="fgnCharges" select="'0'"/>
			<xsl:with-param name="sumlocalTaxAmt" select="'0'"/>
			<xsl:with-param name="commission" select="'0'"/>
			<xsl:with-param name="commTax" select="'0'"/>
			<xsl:with-param name="sumManTaxAcy" select="'0'"/>
			<xsl:with-param name="sumScAmtAcy" select="'0'"/>
			<xsl:with-param name="currencyFT" select="../b:currency"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_Adj">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_Adj">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1NetAmount_Adj"/>
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
	<xsl:template name="newSecurityPositionCriteria1_Adj">
		<newSecurityPositionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</newSecurityPositionCriteria1>
	</xsl:template>
	<xsl:template name="newSecurityPositionCriteria2_Adj"/>
	<xsl:template name="newSecurityPositionCriteria3_Adj"/>
	<xsl:template name="newSecurityPositionCurrency_Adj"/>
	<xsl:template name="notepad_Adj"/>
	<xsl:template name="oldCcyGrossAmount_Adj"/>
	<xsl:template name="oldCcyNetAmount_Adj"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate_Adj"/>
	<xsl:template name="oldPrice_Adj"/>
	<xsl:template name="oldSecurityPositionCriteria1_Adj"/>
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
	<exDate>
		<xsl:value-of select="../b:diaryExDate"/>
	</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Adj">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
	<xsl:template name="account1_Inv">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="accountingDate_Inv">
		<accountingDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="coaReference_Inv">
		<coaReference>
			<xsl:value-of select="../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="depositaryAccount_Inv">
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
	<xsl:template name="portfolio_Inv">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator_Inv">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
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
							<xsl:when test="../b:tapOperCode !=''">
								<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/L',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($entitlementId,'_',@index,'/L',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="security_Inv">
		<security>
			<infra:code>
				<xsl:value-of select="../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode_Inv">
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<sourceSystemCode>
			<xsl:value-of select="$entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_Inv">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="tradeCurrency_Inv">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeQuantity_Inv">
		<tradeQuantity>
			<xsl:value-of select="format-number(b:optionNom * (-1),$decimalformat,'nan2zero')"/>
		</tradeQuantity>
	</xsl:template>
	<xsl:template name="transactionCode_Inv">
		<!-- Status -->
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- EntitlementId -->
		<xsl:variable name="entitlementId">
			<xsl:choose>
				<xsl:when test="contains(../b:entitlementId,';')">
					<xsl:value-of select="substring-before(../b:entitlementId,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:entitlementId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="concat(b:tapRefId,'_R')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/L','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/L','_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId and (b:tapRefId != '' or b:tapRefId != 'NULL')">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
									<xsl:value-of select="concat(../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,$entitlementId,'_',@index,'/L',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat($entitlementId,'_',@index,'/L',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_Inv">
		<transactionDate>
			<xsl:value-of select="../b:PayDateJoin"/>
		</transactionDate>
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
	<xsl:template name="account1CcyTradeCcyExchangeRate_Inv"/>
	<xsl:template name="account1NetAmount_Inv"/>
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
	<xsl:template name="positionCriteria1_Inv">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2_Inv"/>
	<xsl:template name="positionCriteria3_Inv"/>
	<xsl:template name="remark_Inv"/>
	<xsl:template name="reversedTransactionCode_Inv"/>
	<xsl:template name="subType_Inv"/>
	<xsl:template name="supplementaryAmount_Inv"/>
	<xsl:template name="tradeCcyGrossAmount_Inv"/>
	<xsl:template name="tradeCcyNetAmount_Inv"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_Inv"/>
	<xsl:template name="tradePrice_Inv"/>
	<xsl:template name="transactionFeesTaxesCounter_Inv"/>
	<xsl:template name="typeInstrument_Inv"/>
	<xsl:template name="userDefinedField_Inv"/>
	<xsl:template name="mbFields_Inv"/>
	<xsl:template name="exDate_Inv">
	<exDate>
		<xsl:value-of select="../b:diaryExDate"/>
	</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio_Inv">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\..\..\Gwpack\gwpack\XML Schema\GenericCOA.xsd" destSchemaRoot="GenericCOA" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="conversionIntoSecurityCriteria"></template>
			<template name="depositaryAccount"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->