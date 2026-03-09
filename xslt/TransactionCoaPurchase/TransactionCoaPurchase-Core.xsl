<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:choose>
			<xsl:when test="not(../../b:reInvest = 'NO')">
				<xsl:if test="number(../../b:netAmount) != 0">
					<account1CcyTradeCcyExchangeRate>
						<xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,'#.#########','nan2zero')"/>
					</account1CcyTradeCcyExchangeRate>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(../../b:securityCurrency = ../../b:accountCurr) and number(../../b:netAmount) != 0">
					<account1CcyTradeCcyExchangeRate>
						<xsl:value-of select="format-number(-1 * (../b:entitlementAmt * ../../b:netAmtAccCur) div (b:price * b:nominal * ../../b:netAmount),'#.#########','nan2zero')"/>
					</account1CcyTradeCcyExchangeRate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<xsl:param name="nbNewSecuritySubGroup"/>
		<xsl:if test="$nbOptionDescGroupWithNewSecurity = 1 and $nbNewSecuritySubGroup = 1">
			<!-- only 1 secu bought -->
			<account1NetAmount>
				<xsl:value-of select="-1 * ../../b:netAmtAccCur"/>
			</account1NetAmount>
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
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<!-- Status -->
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
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../../b:entitlementId"/>
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
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:reInvest = 'NO'">
						<xsl:value-of select="../../b:securityCurrency"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../../b:currency"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradePrice">
		<xsl:if test="b:price">
			<tradePrice>
				<xsl:value-of select="b:price"/>
			</tradePrice>
		</xsl:if>
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
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:param name="currencyFT">
			<xsl:choose>
				<xsl:when test="../../b:reInvest = 'NO'">
					<xsl:value-of select="../../b:accountCurr"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:currency"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<!-- if reInvest 'NO', netAmtAccCur/netAmount -->
		<xsl:param name="multiCoeff">
			<xsl:choose>
				<xsl:when test="../../b:reInvest = 'NO'">
					<xsl:value-of select="format-number(../../b:netAmtAccCur div ../../b:netAmount,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="../@index = 1 and @index = 1">
				<!-- if reInvest 'NO',multiply the values with netAmtAccCur/netAmount(value of multiCoeff) -->
				<xsl:variable name="fgnChargesAmt" select="format-number(../../b:fgnChargesAmt * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="foreignChgesTax" select="format-number(../../b:foreignChgesTax * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="sourceTaxAmt" select="format-number(../../b:sourceTaxAmt * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumlocalTaxAmt" select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt) * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="commissionAmt" select="format-number(../../b:commissionAmt * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="commTaxAmt" select="format-number(../../b:commTaxAmt * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumManTaxAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy) * $multiCoeff,$decimalformat,'nan2zero')"/>
				<xsl:variable name="sumScAmtAcy" select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy) * $multiCoeff,$decimalformat,'nan2zero')"/>
				<!-- call the template to print the FT -->
				<xsl:call-template name="printEntitlementFeesAndTaxes_generic">
					<xsl:with-param name="sourceTax" select="$sourceTaxAmt"/>
					<xsl:with-param name="fgnCharges" select="$fgnChargesAmt"/>
					<xsl:with-param name="foreignChgesTax" select="$foreignChgesTax"/>
					<xsl:with-param name="sumlocalTaxAmt" select="$sumlocalTaxAmt"/>
					<xsl:with-param name="commission" select="$commissionAmt"/>
					<xsl:with-param name="commTax" select="$commTaxAmt"/>
					<xsl:with-param name="sumManTaxAcy" select="$sumManTaxAcy"/>
					<xsl:with-param name="sumScAmtAcy" select="$sumScAmtAcy"/>
					<xsl:with-param name="currencyFT" select="$currencyFT"/>
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
					<xsl:with-param name="currencyFT" select="$currencyFT"/>
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