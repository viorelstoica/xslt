<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionCoExerciseManual"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionCoExerciseManual" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionCoExerciseManual" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoExerciseManual" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="portfolio">
		<xsl:variable name="index" select="@index"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioList/b:portfolio[@index=$index]"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="index" select="@index"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="../../b:tapOperCode"/>
					<xsl:value-of select="'_'"/>
					<xsl:value-of select="."/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="../../b:companyMnemonicList/b:companyMnemonic[@index=$index]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="../../b:companyMnemonicList/b:companyMnemonic[@index=$index]"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select=" 'OPTION_EXERCISE' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<xsl:variable name="index" select="@index"/>
		<xsl:choose>
			<xsl:when test="../../b:settlementAmountGroup[@index=$index]/b:valueDate and ../../b:settlementAmountGroup[@index=$index]/b:valueDate !=''">
				<valueDate>
					<xsl:value-of select="../../b:settlementAmountGroup[@index=$index]/b:valueDate"/>
				</valueDate>
			</xsl:when>
			<xsl:otherwise>
				<valueDate>
					<xsl:value-of select="../../b:coDateGroup[@index=$index]/b:coDateSubGroup/b:coDate"/>
				</valueDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="intermediary">
		<xsl:variable name="index" select="@index"/>
		<intermediary>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !=''">
						<xsl:choose>
							<xsl:when test="../../b:executingBrokerList/b:executingBroker[@index=$index]!=''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,../../b:executingBrokerList/b:executingBroker[@index=$index])"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($CUSTOMER_PREFIX,../../b:secCustNoList/b:secCustNo[@index=$index])"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../../b:executingBrokerList/b:executingBroker[@index=$index]!=''">
								<xsl:value-of select="../../b:executingBrokerList/b:executingBroker[@index=$index]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../../b:secCustNoList/b:secCustNo[@index=$index]"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</intermediary>
	</xsl:template>
	<xsl:template name="quote">
		<quote>
			<xsl:value-of select="'0'"/>
		</quote>
	</xsl:template>
	<xsl:template name="referenceNature">
		<xsl:variable name="index" select="@index"/>
		<referenceNature>
			<xsl:choose>
				<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'NORMAL' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'NORMAL' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceOperationCode">
		<xsl:variable name="index" select="@index"/>
		<referenceOperationCode>
			<infra:code>
				<xsl:if test="(../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'NORMAL' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'NORMAL' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
					<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
				</xsl:if>
			</infra:code>
		</referenceOperationCode>
	</xsl:template>
	<xsl:template name="adjustmentNature">
		<adjustmentNature>
			<xsl:value-of select="'1'"/>
		</adjustmentNature>
	</xsl:template>

	<xsl:template name="depositaryAccount">
		<xsl:choose>
			<xsl:when test="$MapDepositDX = 'YES'">
				<xsl:variable name="index" select="@index"/>
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="../../b:secCustNoList/b:secCustNo[@index=$index]"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="newInstrumentQuantity">
		<newInstrumentQuantity>
			<xsl:value-of select="'0'"/>
		</newInstrumentQuantity>
	</xsl:template>
	<xsl:template name="originalDepositaryAccount">
		<xsl:choose>
			<xsl:when test="$MapDepositDX = 'YES'">
				<xsl:variable name="index" select="@index"/>
				<originalDepositaryAccount>
					<infra:code>
						<xsl:value-of select="../../b:secCustNoList/b:secCustNo[@index=$index]"/>
					</infra:code>
				</originalDepositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="originalInstrumentQuantity">
		<xsl:variable name="index" select="@index"/>
		<originalInstrumentQuantity>
			<xsl:value-of select="format-number(-1 *../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:traBuyLots,$decimalformat,'nan2zero')"/>
		</originalInstrumentQuantity>
	</xsl:template>
	<xsl:template name="originalSecurity">
		<xsl:variable name="index" select="@index"/>
		<originalSecurity>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index] = 'OTC'">
						<xsl:choose>
							<xsl:when test="../../b:tapRefIdList/b:tapRefId[@index=$index] and ../../b:tapRefIdList/b:tapRefId[@index=$index] != ''">
								<xsl:value-of select="../../b:tapRefIdList/b:tapRefId[@index=$index]"/>	
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index=$index]/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and       ((../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and       (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal)"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="positionCurrency">
		<xsl:variable name="index" select="@index"/>
		<positionCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currencyList/b:currency[@index=$index]"/>
			</infra:code>
		</positionCurrency>
	</xsl:template>
	<xsl:template name="security">
		<xsl:variable name="index" select="@index"/>
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index] = 'OTC'">
						<xsl:choose>
							<xsl:when test="../../b:tapRefIdList/b:tapRefId[@index=$index] and ../../b:tapRefIdList/b:tapRefId[@index=$index] != ''">
								<xsl:value-of select="../../b:tapRefIdList/b:tapRefId[@index=$index]"/>	
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index=$index]/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and       ((../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and       (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal)"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="supplementAmount">
	<supplementAmount>
	<xsl:value-of select="'0'"/>
	</supplementAmount>
	</xsl:template>

	<xsl:template name="transactionDate">
		<xsl:variable name="index" select="@index"/>
		<xsl:choose>
			<xsl:when test="../../b:settlementAmountGroup[@index=$index]/b:valueDate and ../../b:settlementAmountGroup[@index=$index]/b:valueDate !=''">
				<transactionDate>
					<xsl:value-of select="../../b:settlementAmountGroup[@index=$index]/b:valueDate"/>
				</transactionDate>
			</xsl:when>
			<xsl:otherwise>
				<transactionDate>
					<xsl:value-of select="../../b:coDateGroup[@index=$index]/b:coDateSubGroup/b:coDate"/>
				</transactionDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printDxExerciseExpireAssignFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionCoExerciseManual'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
		<xsl:variable name="index" select="@index"/>
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="coaReference"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="originalPositionCriteria1"/>
	<xsl:template name="originalPositionCriteria2"/>
	<xsl:template name="originalPositionCriteria3"/>
	<xsl:template name="originalSecurityPositionCurrency"/>
	<xsl:template name="PositionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="profitLossCounter"/>
	<xsl:template name="trader"/>



	<!--sale-->

	<xsl:template name="account1_sale">
		<xsl:variable name="index" select="@index"/>
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountList/b:account[@index=$index]"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="account1NetAmount_sale">
		<xsl:variable name="index" select="@index"/>
			<xsl:choose>
			<xsl:when test="(../../b:TradeCcyList/b:TradeCcy[@index=$index] != ../../b:priLotsGroup[@index=$index]/b:priLotsSubGroup[@index='1']/b:priAccCcy) or not(../../b:TradeCcyList/b:TradeCcy[@index=$index]) or not(../../b:priLotsGroup[@index=$index]/b:priLotsSubGroup[@index='1']/b:priAccCcy)">
			<account1NetAmount>
			<xsl:choose>
				<xsl:when test="../../b:settlementMethodList/b:settlementMethod[@index=$index] and ../../b:settlementMethodList/b:settlementMethod[@index=$index] ='CASH'">
					<xsl:value-of select="../../b:settlementAmountGroup[@index=$index]/b:settlementAmount"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:XoAccAmtGroup/b:XoAccAmtList/b:XoAccAmt"/>
				</xsl:otherwise>
			</xsl:choose>
			</account1NetAmount>
			</xsl:when>
			</xsl:choose>
	</xsl:template>
	<xsl:template name="account2_sale"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="account2NetAmount_sale"/>
	<xsl:template name="account3_sale"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="account3NetAmount_sale"/>
	<xsl:template name="accountingCode_sale"/>
	<xsl:template name="accountingDate_sale"/>
	<xsl:template name="cashPortfolio_sale"/>
	<xsl:template name="commonReference_sale"/>
	<xsl:template name="ContractNumber_sale"/>
	<xsl:template name="intermediary_sale">
		<xsl:variable name="index" select="@index"/>
		<intermediary>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX != ''">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,../../b:executingBrokerList/b:executingBroker[@index=$index])"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../../b:executingBrokerList/b:executingBroker[@index=$index]"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</intermediary>
	</xsl:template>
	<xsl:template name="market_sale"/>
	<xsl:template name="notepad_sale"/>
	<xsl:template name="portfolio_sale">
		<xsl:variable name="index" select="@index"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioList/b:portfolio[@index=$index]"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_sale"/>
	<xsl:template name="remark_sale"/>
	<xsl:template name="reversalIndicator_sale"/>
	<xsl:template name="reversedTransactionCode_sale"/>
	<xsl:template name="sourceSystemCode_sale">
		<xsl:variable name="index" select="@index"/>
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_sale">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_sale"/>
	<xsl:template name="transactionCode_sale">
		<xsl:variable name="index" select="@index"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="../../b:tapOperCode"/>
					<xsl:value-of select="'_'"/>
					<xsl:value-of select="."/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="../../b:companyMnemonicList/b:companyMnemonic[@index=$index]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="../../b:companyMnemonicList/b:companyMnemonic[@index=$index]"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_sale"/>
	<xsl:template name="type_sale">
		<type>
			<infra:code>
				<xsl:value-of select=" 'OPTION_EXERCISE' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_sale">
		<xsl:variable name="index" select="@index"/>
		<xsl:choose>
			<xsl:when test="../../b:settlementAmountGroup[@index=$index]/b:valueDate and ../../b:settlementAmountGroup[@index=$index]/b:valueDate !=''">
				<valueDate>
					<xsl:value-of select="../../b:settlementAmountGroup[@index=$index]/b:valueDate"/>
				</valueDate>
			</xsl:when>
			<xsl:otherwise>
				<valueDate>
					<xsl:value-of select="../../b:coDateGroup[@index=$index]/b:coDateSubGroup/b:coDate"/>
				</valueDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="userDefinedField-custo_sale"/>
	<xsl:template name="userDefinedField_sale"/>

	<xsl:template name="mbFields_sale"/>
	<xsl:template name="accountCurrency_sale"/>
	<xsl:template name="accuredInterest_sale"/>
	<xsl:template name="accuredInterestCounter_sale"/>
	<xsl:template name="boAccount_sale"/>
	<xsl:template name="boPortfolio_sale"/>
	<xsl:template name="broker_sale"/>
	<xsl:template name="compoundOrderCode_sale"/>
	<xsl:template name="compoundOrderMaster_sale"/>
	<xsl:template name="compoundOrderSlave_sale"/>
	<xsl:template name="contactMethod_sale"/>
	<xsl:template name="depositaryAccount_sale">
		<xsl:choose>
			<xsl:when test="$MapDepositDX = 'YES'">
				<xsl:variable name="index" select="@index"/>
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="../../b:secCustNoList/b:secCustNo[@index=$index]"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="exCoupon_sale"/>
	<xsl:template name="executionSetCriteria_sale"/>
	<xsl:template name="hierOperNature_sale"/>
	<xsl:template name="initiatedBy_sale"/>
	<xsl:template name="initiator_sale"/>
	<xsl:template name="limitPrice_sale"/>
	<xsl:template name="orderType_sale"/>
	<xsl:template name="orderValidityType_sale"/>
	<xsl:template name="originalOrderCode_sale"/>
	<xsl:template name="paymentDate_sale"/>
	<xsl:template name="paymentStatus_sale"/>
	<xsl:template name="paymentOptionE_sale"/>
	<xsl:template name="positionCriteria1_sale"/>
	<xsl:template name="positionCriteria2_sale"/>
	<xsl:template name="positionCriteria3_sale"/>
	<xsl:template name="quantity_sale">
		<xsl:variable name="index" select="@index"/>
		<quantity>
			<xsl:value-of select="../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:traBuyLots"/>
		</quantity>
	</xsl:template>

	<xsl:template name="positionCurrency_sale">
		<xsl:variable name="index" select="@index"/>
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currencyList/b:currency[@index=$index]"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="profitLossCounter_sale"/>
	<xsl:template name="price_sale">
		<price>
			<xsl:value-of select="'0'"/>
		</price>
	</xsl:template>
	<xsl:template name="referenceNature_sale">
		<xsl:variable name="index" select="@index"/>
		<referenceNature>
			<xsl:choose>
				<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode_sale">
		<xsl:variable name="index" select="@index"/>
		<referenceTransactionCode>

			<xsl:if test="(../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="security_sale">
		<xsl:variable name="index" select="@index"/>
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index] = 'OTC'">
						<xsl:choose>
							<xsl:when test="../../b:tapRefIdList/b:tapRefId[@index=$index] and ../../b:tapRefIdList/b:tapRefId[@index=$index] != ''">
								<xsl:value-of select="../../b:tapRefIdList/b:tapRefId[@index=$index]"/>	
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index=$index]/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and       ((../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and       (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal)"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType,'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:TradeCcyList/b:TradeCcy[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:DlvCcyList/b:DlvCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>

	<xsl:template name="tradeDate_sale">
		<xsl:variable name="index" select="@index"/>
		<xsl:choose>
			<xsl:when test="../../b:settlementAmountGroup[@index=$index]/b:valueDate and ../../b:settlementAmountGroup[@index=$index]/b:valueDate !=''">
				<tradeDate>
					<xsl:value-of select="../../b:settlementAmountGroup[@index=$index]/b:valueDate"/>
				</tradeDate>
			</xsl:when>
			<xsl:otherwise>
				<tradeDate>
					<xsl:value-of select="../../b:coDateGroup[@index=$index]/b:coDateSubGroup/b:coDate"/>
				</tradeDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="tradeCcyGrossAmount_sale">
			<xsl:variable name="index" select="@index"/>
			<xsl:variable name="priAccCcy" select="../../b:priLotsGroup[@index=$index]/b:priLotsSubGroup[@index='1']/b:priAccCcy"/>
			<xsl:choose>
				<xsl:when test="../../b:TradeCcyList/b:TradeCcy[@index=$index]=$priAccCcy">
					<tradeCcyGrossAmount>
					<xsl:choose>
						<xsl:when test="../../b:settlementMethodList/b:settlementMethod[@index=$index] and ../../b:settlementMethodList/b:settlementMethod[@index=$index] ='CASH'">
					<xsl:value-of select="../../b:settlementAmountGroup[@index=$index]/b:settlementAmount"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:XoAccAmtGroup/b:XoAccAmtList/b:XoAccAmt"/>
				</xsl:otherwise>
			</xsl:choose>
			</tradeCcyGrossAmount>
			</xsl:when>
			</xsl:choose>
	</xsl:template>

	<xsl:template name="securityCcyNetAmount_sale"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_sale"/>
	<xsl:template name="settlementDate_sale"/>
	<xsl:template name="settlementStatus_sale"/>
	<xsl:template name="splitPortfolio_sale"/>
	<xsl:template name="stockExchange_sale"/>
	<xsl:template name="stopPrice_sale"/>
	<xsl:template name="targetAmount_sale"/>
	<xsl:template name="targetNature_sale"/>
	<xsl:template name="targetObjective_sale"/>
	<xsl:template name="trader_sale"/>
	<xsl:template name="tradeCurrency_sale"/>

	<xsl:template name="tradeCcyNetAmount_sale"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_sale"/>

	<xsl:template name="validityDate_sale"/>
	<xsl:template name="orderTypeD_sale"/>
</xsl:stylesheet>
