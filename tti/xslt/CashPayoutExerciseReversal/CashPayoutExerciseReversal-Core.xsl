<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAssignExpiryOptionBuyCloseOutRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionBuyCloseOutRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAssignExpiryOptionBuyCloseOutRev"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionBuyCloseOutRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1_sale"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="account1NetAmount_sale"/>
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
	<xsl:template name="intermediary_sale"/>
	<xsl:template name="market_sale"/>
	<xsl:template name="notepad_sale"/>
	<xsl:template name="portfolio_sale">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity_sale">
		<quantity>
			<xsl:value-of select="b:tradeIdGroup/b:traBuyLots"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security_sale">
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
	<xsl:template name="transactionCode_sale">
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
	<xsl:template name="tradeDate_sale">
		<xsl:choose>
			<xsl:when test="b:exManualValueDateGroup/b:exManualValueDate and b:exManualValueDateGroup/b:exManualValueDate !=''">
				<tradeDate>
					<xsl:value-of select="b:exManualValueDateGroup/b:exManualValueDate"/>
				</tradeDate>
			</xsl:when>
			<xsl:otherwise>
				<tradeDate>
					<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
				</tradeDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="referenceNature_sale">
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
	<xsl:template name="referenceTransactionCode_sale">
		<xsl:variable name="index" select="@index"/>
		<referenceTransactionCode>

			<xsl:if test="(b:exchangeTypeJoinList/b:exchangeTypeJoin= 'OTC' and b:contractType= 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (b:exchangeTypeJoinList/b:exchangeTypeJoin= 'OTC' and b:contractType= 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23')">
				<xsl:value-of select="concat(b:tradeIdGroup/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="status_sale">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="sourceSystemCode_sale">
		<xsl:variable name="index" select="@index"/>
		<sourceSystemCode>
			<xsl:value-of select="concat(b:tradeIdGroup/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="valueDate_sale">
		<xsl:choose>
			<xsl:when test="b:exManualValueDateGroup/b:exManualValueDate and b:exManualValueDateGroup/b:exManualValueDate !=''">
				<valueDate>
					<xsl:value-of select="b:exManualValueDateGroup/b:exManualValueDate"/>
				</valueDate>
			</xsl:when>
			<xsl:otherwise>
				<valueDate>
					<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
				</valueDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversedTransactionCode_sale">
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
	<xsl:template name="reversalIndicator_sale">
		<reversalIndicator>
			<xsl:value-of select="'1'"/>
		</reversalIndicator>
	</xsl:template>


	<xsl:template name="portfolioManager_sale"/>
	<xsl:template name="remark_sale"/>
	<xsl:template name="subType_sale"/>
	<xsl:template name="transactionFeesTaxesCounter_sale"/>
	<xsl:template name="type_sale"/>
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
	<xsl:template name="depositaryAccount_sale"/>
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
	<xsl:template name="price_sale"/>
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
	<xsl:template name="tradeCcyGrossAmount_sale"/>
	<xsl:template name="tradeCcyNetAmount_sale"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_sale"/>
	<xsl:template name="validityDate_sale"/>
	<xsl:template name="orderTypeD_sale"/>
</xsl:stylesheet>