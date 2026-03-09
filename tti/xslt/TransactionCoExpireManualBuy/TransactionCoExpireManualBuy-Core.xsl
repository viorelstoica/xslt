<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionCoExpireManualBuy"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionCoExpireManualBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionCoExpireManualBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionCoExpireManualBuy" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

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
				<xsl:when test="../../b:tapOperCodeList/b:tapOperCode[@index=$index] and ../../b:tapOperCodeList/b:tapOperCode[@index=$index] != ''">
					<xsl:value-of select="../../b:tapOperCodeList/b:tapOperCode[@index=$index]"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
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
				<xsl:value-of select=" 'OPTION_EXPIRY' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<xsl:variable name="index" select="@index"/>
		<valueDate>
			<xsl:value-of select="../../b:coDateGroup[@index=$index]/b:coDateSubGroup/b:coDate"/>
		</valueDate>
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
		<xsl:variable name="index" select="@index"/>
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
			<xsl:value-of select="format-number( -1* sum(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup/b:traBuyLots),$decimalformat,'nan2zero')"/>
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
		<transactionDate>
			<xsl:value-of select="../../b:coDateGroup[@index=$index]/b:coDateSubGroup/b:coDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printDxExerciseExpireAssignFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionCoExpireManualBuy'"/>
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
</xsl:stylesheet>