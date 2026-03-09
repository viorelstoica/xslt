<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionCoAssignManual"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionCoAssignManual" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionCoAssignManual" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoAssignManual" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

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
				<xsl:value-of select=" 'OPTION_ASSIGNMENT' "/>
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
			<xsl:value-of select="../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:traSellLots"/>
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
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and ((../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
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
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and ((../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
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
			<xsl:with-param name="caller" select="'TransactionCoAssignManual'"/>
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




	<!-- PURCHASE  -->
	<xsl:template name="portfolio_purchase">
		<xsl:variable name="index" select="@index"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioList/b:portfolio[@index=$index]"/>
			</infra:code>
		</portfolio>
	</xsl:template>

	<xsl:template name="status_purchase">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>

	<xsl:template name="transactionCode_purchase">
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

	<xsl:template name="userDefinedField_purchase"/>



	<xsl:template name="type_purchase">
		<type>
			<infra:code>
				<xsl:value-of select=" 'OPTION_ASSIGNMENT' "/>
			</infra:code>
		</type>
	</xsl:template>

	<xsl:template name="valueDate_purchase">
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

	<xsl:template name="price_purchase">
		<price>
			<xsl:value-of select="'0'"/>
		</price>
	</xsl:template>

	<xsl:template name="referenceNature_purchase">
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

	<xsl:template name="depositaryAccount_purchase">
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

	<xsl:template name="quantity_purchase">
		<xsl:variable name="index" select="@index"/>
		<quantity>
			<xsl:value-of select="../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:traSellLots"/>
		</quantity>
	</xsl:template>

	<xsl:template name="tradeCurrency_purchase">
		<xsl:variable name="index" select="@index"/>
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currencyList/b:currency[@index=$index]"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>

	<xsl:template name="security_purchase">
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
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and ((../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1),'/',(../../b:ExoticTypeGroup[@index=$index]/b:ExoticTypeSubGroup[@index='1']/b:ExoticType))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat((../../b:contractCodeList/b:contractCode[@index=$index]),'/',(../../b:TradeCcyList/b:TradeCcy[@index=$index]),'/',(../../b:maturityDateList/b:maturityDate[@index=$index]),'/',(../../b:optionTypeList/b:optionType[@index=$index]),'/',(../../b:strikePriceList/b:strikePrice[@index=$index]),'/',(../../b:DlvCcyList/b:DlvCcy[@index=$index]),'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>

	<xsl:template name="tradeDate_purchase">
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

	<xsl:template name="account1_purchase">
		<xsl:variable name="index" select="@index"/>
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountList/b:account[@index=$index]"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account1NetAmount_purchase">
			<xsl:variable name="index" select="@index"/>
			<xsl:choose>
				<xsl:when test="(../../b:TradeCcyList/b:TradeCcy[@index=$index] != ../../b:priLotsGroup[@index=$index]/b:priLotsSubGroup[@index='1']/b:priAccCcy) or not(../../b:TradeCcyList/b:TradeCcy[@index=$index]) or not(../../b:priLotsGroup[@index=$index]/b:priLotsSubGroup[@index='1']/b:priAccCcy)">
					<account1NetAmount>
					<xsl:choose>
						<xsl:when test="../../b:settlementMethodList/b:settlementMethod[@index=$index] and ../../b:settlementMethodList/b:settlementMethod[@index=$index] ='CASH'">
							<xsl:value-of select="format-number(-1*../../b:settlementAmountGroup[@index=$index]/b:settlementAmount,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(-1*../../b:XoAccAmtGroup[@index=$index]/b:XoAccAmtList/b:XoAccAmt,$decimalformat,'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
					</account1NetAmount>
				</xsl:when>
			</xsl:choose>
	</xsl:template>
	<xsl:template name="account2_purchase"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account2NetAmount_purchase"/>
	<xsl:template name="account3_purchase"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account3NetAmount_purchase"/>
	<xsl:template name="accountingCode_purchase"/>
	<xsl:template name="accountingDate_purchase"/>
	<xsl:template name="cashPortfolio_purchase"/>
	<xsl:template name="ContractNumber_purchase"/>
	<xsl:template name="market_purchase"/>
	<xsl:template name="notepad_purchase"/>
	<xsl:template name="portfolioManager_purchase"/>
	<xsl:template name="remark_purchase"/>
	<xsl:template name="reversalIndicator_purchase"/>
	<xsl:template name="reversedTransactionCode_purchase"/>
	<xsl:template name="sourceSystemCode_purchase">
		<xsl:variable name="index" select="@index"/>
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="intermediary_purchase">
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

	<xsl:template name="referenceTransactionCode_purchase">
		<xsl:variable name="index" select="@index"/>
		<referenceTransactionCode>

			<xsl:if test="(../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23')">
				<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>

	<xsl:template name="tradeCcyGrossAmount_purchase">
			<xsl:variable name="index" select="@index"/>
			<xsl:variable name="priAccCcy" select="../../b:priLotsGroup[@index=$index]/b:priLotsSubGroup[@index='1']/b:priAccCcy"/>
			<xsl:choose>
				<xsl:when test="../../b:TradeCcyList/b:TradeCcy[@index=$index]=$priAccCcy">
					<tradeCcyGrossAmount>
					<xsl:choose>
						<xsl:when test="../../b:settlementMethodList/b:settlementMethod[@index=$index] and ../../b:settlementMethodList/b:settlementMethod[@index=$index] ='CASH'">
							<xsl:value-of select="format-number(-1*../../b:settlementAmountGroup[@index=$index]/b:settlementAmount,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(-1*../../b:XoAccAmtGroup[@index=$index]/b:XoAccAmtList/b:XoAccAmt,$decimalformat,'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
					</tradeCcyGrossAmount>
				</xsl:when>
			</xsl:choose>
	</xsl:template>

	<xsl:template name="mbFields_purchase"/>
	<xsl:template name="accountCurrency_purchase"/>
	<xsl:template name="accuredInterest_purchase"/>
	<xsl:template name="accuredInterestCounter_purchase"/>
	<xsl:template name="boAccount_purchase"/>
	<xsl:template name="boPortfolio_purchase"/>
	<xsl:template name="broker_purchase"/>
	<xsl:template name="compoundOrderCode_purchase"/>
	<xsl:template name="compoundOrderMaster_purchase"/>
	<xsl:template name="compoundOrderSlave_purchase"/>
	<xsl:template name="contactMethod_purchase"/>
	<xsl:template name="commonReference_purchase"/>
	<xsl:template name="exCoupon_purchase"/>
	<xsl:template name="subType_purchase"/>
	<xsl:template name="executionSetCriteria_purchase"/>
	<xsl:template name="hierOperNature_purchase"/>
	<xsl:template name="userDefinedField-custo_purchase"/>
	<xsl:template name="transactionFeesTaxesCounter_purchase"/>
	<xsl:template name="initiatedBy_purchase"/>
	<xsl:template name="initiator_purchase"/>
	<xsl:template name="limitPrice_purchase"/>
	<xsl:template name="orderType_purchase"/>
	<xsl:template name="orderValidityType_purchase"/>
	<xsl:template name="originalOrderCode_purchase"/>
	<xsl:template name="paymentDate_purchase"/>
	<xsl:template name="paymentStatus_purchase"/>
	<xsl:template name="paymentOptionE_purchase"/>
	<xsl:template name="positionCriteria1_purchase"/>
	<xsl:template name="positionCriteria2_purchase"/>
	<xsl:template name="positionCriteria3_purchase"/>
	<xsl:template name="securityCcyNetAmount_purchase"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_purchase"/>
	<xsl:template name="settlementDate_purchase"/>
	<xsl:template name="settlementStatus_purchase"/>
	<xsl:template name="splitPortfolio_purchase"/>
	<xsl:template name="stockExchange_purchase"/>
	<xsl:template name="stopPrice_purchase"/>
	<xsl:template name="targetAmount_purchase"/>
	<xsl:template name="targetNature_purchase"/>
	<xsl:template name="targetObjective_purchase"/>
	<xsl:template name="trader_purchase"/>
	<xsl:template name="tradeCcyNetAmount_purchase"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_purchase"/>
	<xsl:template name="validityDate_purchase"/>
	<xsl:template name="orderTypeD_purchase"/>
</xsl:stylesheet>
