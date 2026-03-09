<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionMaturityFutureSell"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionMaturityFutureSell" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionMaturityFutureSell" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionMaturityFutureSell" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1">
		<xsl:variable name="index" select="@index"/>
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountList/b:account[@index=$index]"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:variable name="index" select="@index"/>
		<account1CcyTradeCcyExchangeRate>
			<xsl:value-of select="../../b:priLotsGroup/b:priLotsSubGroup[@index=$index]/b:priExRateRef"/>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<xsl:variable name="index" select="@index"/>
		<account1NetAmount>
			<xsl:value-of select="../../b:buyValueList/b:buyValue[@index=$index]"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account2">
		<xsl:variable name="index" select="@index"/>
		<account2>
			<infra:code>
				<xsl:value-of select="../../b:accountList/b:account[@index=$index]"/>
			</infra:code>
		</account2>
	</xsl:template>
	<xsl:template name="account2CcyTradeCcyExchangeRate">
		<xsl:variable name="index" select="@index"/>
		<account2CcyTradeCcyExchangeRate>
			<xsl:value-of select="../../b:priLotsGroup/b:priLotsSubGroup[@index=$index]/b:priExRateRef"/>
		</account2CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account2NetAmount">
		<xsl:variable name="index" select="@index"/>
		<account2NetAmount>
			<xsl:value-of select="format-number(sum(../../b:taxAmtTcyGroup[@index=$index]/b:taxAmtTcySubGroup/b:taxAmtTcy),$decimalformat,'nan2zero')"/>
		</account2NetAmount>
	</xsl:template>
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
			<xsl:value-of select="."/>
			<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
			<xsl:value-of select="../../b:companyMnemonicList/b:companyMnemonic[@index=$index]"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>FUTURE_MATURITY</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<xsl:variable name="index" select="@index"/>
		<valueDate>
			<xsl:value-of select="../../b:premValDateList/b:premValDate[@index=$index]"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="broker">
		<xsl:variable name="index" select="@index"/>
		<broker>
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
		</broker>
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
	<xsl:template name="price">
		<xsl:variable name="index" select="@index"/>
		<price>
			<xsl:value-of select="../../b:maturityPriceList/b:maturityPrice[@index=$index]"/>
		</price>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:variable name="index" select="@index"/>
		<quantity>
			<xsl:value-of select="format-number(sum(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup/b:traSellLots),$decimalformat,'nan2zero')"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<xsl:variable name="index" select="@index"/>
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC'">
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
						<xsl:value-of select="concat(../../b:contractCodeList/b:contractCode[@index=$index],'/',../../b:currencyList/b:currency[@index=$index],'/',../../b:maturityDateList/b:maturityDate[@index=$index],'/',../../b:optionTypeList/b:optionType[@index=$index],'/',../../b:strikePriceList/b:strikePrice[@index=$index],'/',../../b:deliveryCcyList/b:deliveryCcy[@index=$index],'/',substring(../../b:optionStyleList/b:optionStyle[@index=$index],1,1))"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="tradeCurrency">
		<xsl:variable name="index" select="@index"/>
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currencyList/b:currency[@index=$index]"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeDate">
		<xsl:variable name="index" select="@index"/>
		<tradeDate>
			<xsl:value-of select="../../b:transDateList/b:transDate[@index=$index]"/>
		</tradeDate>
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
	<xsl:template name="referenceTransactionCode">
		<xsl:variable name="index" select="@index"/>
		<referenceTransactionCode>
			<xsl:if test="(../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'NORMAL' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'NORMAL' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (../../b:exchangeTypeJoinList/b:exchangeTypeJoin[@index=$index]= 'OTC' and ../../b:contractTypeList/b:contractType[@index=$index]= 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(../../b:tradeIdGroup[@index=$index]/b:tradeIdSubGroup[@index='1']/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printDxMaturityFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionMaturityFutureSell'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
		<xsl:variable name="index" select="@index"/>
		<sourceSystemCode>
			<xsl:value-of select="concat(.,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicList/b:companyMnemonic[@index=$index])"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="compundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="contactMethod"/>
	<xsl:template name="exCoupon"/>
	<xsl:template name="executionSetCriteria"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="paymentOptionE"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="hedgeTrade"/>
	<xsl:template name="orderTypeD"/>
</xsl:stylesheet>