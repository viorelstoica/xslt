<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAssignExpiryOptionSellCloseOutRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionSellCloseOutRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAssignExpiryOptionSellCloseOutRev"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionSellCloseOutRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1_purchase"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account1NetAmount_purchase"/>
	<xsl:template name="account2_purchase"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account2NetAmount_purchase"/>
	<xsl:template name="account3_purchase"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account3NetAmount_purchase"/>
	<xsl:template name="accountingCode_purchase"/>
	<xsl:template name="accountingDate_purchase"/>
	<xsl:template name="cashPortfolio_purchase"/>
	<xsl:template name="commonReference_purchase"/>
	<xsl:template name="ContractNumber_purchase"/>
	<xsl:template name="intermediary_purchase"/>
	<xsl:template name="market_purchase"/>
	<xsl:template name="notepad_purchase"/>
	<xsl:template name="portfolio_purchase">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity_purchase">
		<quantity>
			<xsl:value-of select="format-number(-1*b:tradeIdGroup/b:traSellLots,$decimalformat,'nan2zero')"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security_purchase">
		<xsl:variable name="index" select="@index"/>
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC'">
						<xsl:choose>
							<xsl:when test="b:tapRefIdList/b:tapRefId and b:tapRefIdList/b:tapRefId != ''">
								<xsl:value-of select="b:tapRefIdList/b:tapRefId"/>	
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(b:tradeIdGroup/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and ((b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal) and (b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))">
								<xsl:value-of select="concat((b:contractCode),'/',(b:TradeCcyList/b:TradeCcy),'/',(b:maturityDate),'/',(b:optionType),'/',(b:strikePrice),'/',(b:deliveryCcy),'/',substring(b:optionStyleJoinList/b:optionStyleJoin,1,1),'/',(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal),'/',(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='2']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:ExoticType) and (b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal)">
								<xsl:value-of select="concat((b:contractCode),'/',(b:TradeCcyList/b:TradeCcy),'/',(b:maturityDate),'/',(b:optionType),'/',(b:strikePrice),'/',(b:deliveryCcy),'/',substring(b:optionStyleList/b:optionStyle,1,1),'/',(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:ExoticType),'/',(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:UsrFldValGroup[@index='1']/b:UsrFldVal))"/>
							</xsl:when>
							<xsl:when test="(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:ExoticType)">
								<xsl:value-of select="concat((b:contractCode),'/',(b:TradeCcyList/b:TradeCcy),'/',(b:maturityDate),'/',(b:optionType),'/',(b:strikePrice),'/',(b:deliveryCcy),'/',substring(b:optionStyleList/b:optionStyle,1,1),'/',(b:ExoticTypeGroup/b:ExoticTypeSubGroup[@index='1']/b:ExoticType))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat((b:contractCode),'/',(b:TradeCcyList/b:TradeCcy),'/',(b:maturityDate),'/',(b:optionType),'/',(b:strikePrice),'/',(b:deliveryCcy),'/',substring(b:optionStyleList/b:optionStyle,1,1))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="transactionCode_purchase">
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="contains(b:id,';')">
					<xsl:value-of select="substring-before(b:id,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="b:tapOperCode"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
					<xsl:value-of select="'-R'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
					<xsl:value-of select="'-R'"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="tradeDate_purchase">
		<xsl:choose>
			<xsl:when test="b:asManualValueDateGroup/b:asManualValueDate and b:asManualValueDateGroup/b:asManualValueDate !=''">
				<tradeDate>
					<xsl:value-of select="b:asManualValueDateGroup/b:asManualValueDate"/>
				</tradeDate>
			</xsl:when>
			<xsl:otherwise>
				<tradeDate>
					<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
				</tradeDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="referenceNature_purchase">
		<referenceNature>
			<xsl:choose>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin= 'OTC' and b:contractType= 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin= 'OTC' and b:contractType= 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode_purchase">
		<xsl:variable name="index" select="@index"/>
		<referenceTransactionCode>

			<xsl:if test="(b:exchangeTypeJoinList/b:exchangeTypeJoin= 'OTC' and b:contractType= 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (b:exchangeTypeJoinList/b:exchangeTypeJoin= 'OTC' and b:contractType= 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23')">
				<xsl:value-of select="concat(b:tradeIdGroup/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="status_purchase">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="sourceSystemCode_purchase">
		<xsl:variable name="index" select="@index"/>
		<sourceSystemCode>
			<xsl:value-of select="concat(b:tradeIdGroup/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="valueDate_purchase">
		<xsl:choose>
			<xsl:when test="b:asManualValueDateGroup/b:asManualValueDate and b:asManualValueDateGroup/b:asManualValueDate !=''">
				<valueDate>
					<xsl:value-of select="b:asManualValueDateGroup/b:asManualValueDate"/>
				</valueDate>
			</xsl:when>
			<xsl:otherwise>
				<valueDate>
					<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
				</valueDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_purchase">
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="contains(b:id,';')">
					<xsl:value-of select="substring-before(b:id,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="b:tapOperCode"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="reversalIndicator_purchase">
		<reversalIndicator>
			<xsl:value-of select="'1'"/>
		</reversalIndicator>
	</xsl:template>


	<xsl:template name="portfolioManager_purchase"/>
	<xsl:template name="remark_purchase"/>
	<xsl:template name="subType_purchase"/>
	<xsl:template name="transactionFeesTaxesCounter_purchase"/>
	<xsl:template name="type_purchase"/>
	<xsl:template name="userDefinedField-custo_purchase"/>
	<xsl:template name="userDefinedField_purchase"/>
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
	<xsl:template name="depositaryAccount_purchase"/>
	<xsl:template name="exCoupon_purchase"/>
	<xsl:template name="executionSetCriteria_purchase"/>
	<xsl:template name="hierOperNature_purchase"/>
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
	<xsl:template name="price_purchase"/>
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
	<xsl:template name="tradeCurrency_purchase"/>
	<xsl:template name="tradeCcyGrossAmount_purchase"/>
	<xsl:template name="tradeCcyNetAmount_purchase"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_purchase"/>
	<xsl:template name="validityDate_purchase"/>
	<xsl:template name="orderTypeD_purchase"/>
</xsl:stylesheet>