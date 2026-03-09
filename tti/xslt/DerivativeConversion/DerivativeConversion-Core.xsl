<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DerivativeConversion" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
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
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="//b:ExDateDxDiaryJoinList/b:ExDateDxDiaryJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<xsl:param name="TradeIndex"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="//b:PriSecAccDxTradeJoinGroup/b:PriSecAccDxTradeJoinSubGroup[@index=$TradeIndex]/b:PriSecAccDxTradeJoinGroup/b:PriSecAccDxTradeJoin"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionCode">
		<xsl:param name="Index"/>
		<xsl:param name="SubIndex"/>
		<xsl:param name="legNumber"/>
		<transactionCode>
			<xsl:value-of select="concat(//b:dxDiaryIdGroup/b:entitlementList/b:entitlement[@index=$Index],$COMPANY_POSTFIX_SEPARATOR,//b:MnemonicCompanyJoin,'.',$Index,$SubIndex,$legNumber)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:param name="CurrentCaller"/>
		<xsl:call-template name="printDxCoFeesAndTaxes">
			<xsl:with-param name="caller" select="$CurrentCaller"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<xsl:param name="TradeIndex"/>
		<xsl:param name="BuySell"/>
		<type>
			<infra:code>
				<xsl:choose>
					<xsl:when test="//b:TradeTypeDxTradeJoinList/b:TradeTypeDxTradeJoin = 'OPTION' and $BuySell='BUY'">
						<xsl:value-of select="'OPTION_BUY_OPEN'"/>
					</xsl:when>
					<xsl:when test="//b:TradeTypeDxTradeJoinList/b:TradeTypeDxTradeJoin = 'OPTION' and $BuySell='SELL'">
						<xsl:value-of select="'OPTION_SEL_OPEN'"/>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="//b:ExDateDxDiaryJoinList/b:ExDateDxDiaryJoin"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="market">
		<xsl:param name="TradeIndex"/>
		<market>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,//b:ExcCodeDxTradeJoinList/b:ExcCodeDxTradeJoin[@index=$TradeIndex])"/>
			</infra:code>
		</market>
	</xsl:template>
	<xsl:template name="intermediary">
		<xsl:param name="TradeIndex"/>
		<intermediary>
			<infra:code>
				<xsl:value-of select="concat($CUSTOMER_PREFIX,//b:ExecBrokerDxTradeJoinList/b:ExecBrokerDxTradeJoin[@index=$TradeIndex])"/>
			</infra:code>
		</intermediary>
	</xsl:template>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="depositaryAccount">
		<xsl:param name="TradeIndex"/>
		<xsl:choose>
			<xsl:when test="$MapDepositDX = 'YES'">
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="//b:SecCustNoDxTradeJoinList/b:SecCustNoDxTradeJoin[@index=$TradeIndex]"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="quantity">
		<xsl:param name="BuySell"/>
		<xsl:param name="transfer"/>
		<quantity>
			<xsl:choose>
				<xsl:when test="$transfer = 'transferOut' and $BuySell = 'BUY'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:OldLotsDxEntitlementJoin"/>
				</xsl:when>
				<xsl:when test="$transfer = 'transferIn' and $BuySell = 'BUY'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:NewLotsDxEntitlementJoin"/>
				</xsl:when>
				<xsl:when test="$transfer = 'transferIn' and $BuySell = 'SELL'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:OldLotsDxEntitlementJoin"/>
				</xsl:when>
				<xsl:when test="$transfer = 'transferOut' and $BuySell = 'SELL'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:NewLotsDxEntitlementJoin"/>
				</xsl:when>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<xsl:param name="TradeIndex"/>
		<xsl:param name="Index"/>
		<xsl:param name="BuySell"/>
		<xsl:param name="transfer"/>
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$transfer = 'transferOut' and $BuySell = 'BUY'">
						<xsl:choose>
							<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC'">
								<xsl:choose>
									<xsl:when test="//b:tapRefIdList/b:tapRefId[@index=$Index] and //b:tapRefIdList/b:tapRefId[@index=$Index] != ''">
										<xsl:value-of select="//b:tapRefIdList/b:tapRefId[@index=$Index]"/>	
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat(//b:TradeIdDxTradeJoinGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoinSubGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoin,$COMPANY_POSTFIX_SEPARATOR,//b:MnemonicCompanyJoin)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="//b:ContractCodeDxEntitlementJoinList/b:ContractCodeDxEntitlementJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:TradeCcyDxTradeJoinList/b:TradeCcyDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:MatDateDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:OptionTypeDxTradeJoinList/b:OptionTypeDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:OldStrPriceDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:DlvCcyDxTradeJoinList/b:DlvCcyDxTradeJoin[@index=$TradeIndex]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="substring(//b:OptionStyleDxTradeJoinList/b:OptionStyleDxTradeJoin,'1','1')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$transfer = 'transferIn' and $BuySell = 'BUY'">
						<xsl:choose>
							<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC'">
								<xsl:choose>
									<xsl:when test="//b:tapRefIdList/b:tapRefId[@index=$Index] and //b:tapRefIdList/b:tapRefId[@index=$Index] != ''">
										<xsl:value-of select="//b:tapRefIdList/b:tapRefId[@index=$Index]"/>	
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat(//b:TradeIdDxTradeJoinGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoinSubGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoin,$COMPANY_POSTFIX_SEPARATOR,//b:MnemonicCompanyJoin)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="//b:ContractCodeDxEntitlementJoinList/b:ContractCodeDxEntitlementJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:TradeCcyDxTradeJoinList/b:TradeCcyDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:MatDateDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:OptionTypeDxTradeJoinList/b:OptionTypeDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:NewStrPriDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:DlvCcyDxTradeJoinList/b:DlvCcyDxTradeJoin[@index=$TradeIndex]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="substring(//b:OptionStyleDxTradeJoinList/b:OptionStyleDxTradeJoin,'1','1')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$transfer = 'transferIn' and $BuySell = 'SELL'">
						<xsl:choose>
							<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC'">
								<xsl:choose>
									<xsl:when test="//b:tapRefIdList/b:tapRefId[@index=$Index] and //b:tapRefIdList/b:tapRefId[@index=$Index] != ''">
										<xsl:value-of select="//b:tapRefIdList/b:tapRefId[@index=$Index]"/>	
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat(//b:TradeIdDxTradeJoinGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoinSubGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoin,$COMPANY_POSTFIX_SEPARATOR,//b:MnemonicCompanyJoin)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="//b:ContractCodeDxEntitlementJoinList/b:ContractCodeDxEntitlementJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:TradeCcyDxTradeJoinList/b:TradeCcyDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:MatDateDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:OptionTypeDxTradeJoinList/b:OptionTypeDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:OldStrPriceDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:DlvCcyDxTradeJoinList/b:DlvCcyDxTradeJoin[@index=$TradeIndex]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="substring(//b:OptionStyleDxTradeJoinList/b:OptionStyleDxTradeJoin,'1','1')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$transfer = 'transferOut' and $BuySell = 'SELL'">
						<xsl:choose>
							<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC'">
								<xsl:choose>
									<xsl:when test="//b:tapRefIdList/b:tapRefId[@index=$Index] and //b:tapRefIdList/b:tapRefId[@index=$Index] != ''">
										<xsl:value-of select="//b:tapRefIdList/b:tapRefId[@index=$Index]"/>	
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat(//b:TradeIdDxTradeJoinGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoinSubGroup[@index=$TradeIndex]/b:TradeIdDxTradeJoin,$COMPANY_POSTFIX_SEPARATOR,//b:MnemonicCompanyJoin)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="//b:ContractCodeDxEntitlementJoinList/b:ContractCodeDxEntitlementJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:TradeCcyDxTradeJoinList/b:TradeCcyDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:MatDateDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:OptionTypeDxTradeJoinList/b:OptionTypeDxTradeJoin[@index=$Index]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="b:NewStrPriDxEntitlementJoin"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="//b:DlvCcyDxTradeJoinList/b:DlvCcyDxTradeJoin[@index=$TradeIndex]"/>
								<xsl:value-of select="'/'"/>
								<xsl:value-of select="substring(//b:OptionStyleDxTradeJoinList/b:OptionStyleDxTradeJoin,'1','1')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="transactionCurrency">
		<xsl:param name="TradeIndex"/>
		<transactionCurrency>
			<infra:code>
				<xsl:value-of select="//b:TradeCcyDxTradeJoinList/b:TradeCcyDxTradeJoin[@index=$TradeIndex]"/>
			</infra:code>
		</transactionCurrency>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="//b:ExDateDxDiaryJoinList/b:ExDateDxDiaryJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transferPrice">
		<xsl:param name="BuySell"/>
		<xsl:param name="transfer"/>
		<transferPrice>
			<xsl:choose>
				<xsl:when test="$transfer = 'transferOut' and $BuySell = 'BUY'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:OldPriceDxEntitlementJoin"/>
				</xsl:when>
				<xsl:when test="$transfer = 'transferIn' and $BuySell = 'BUY'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:NewPriceDxEntitlementJoin"/>
				</xsl:when>
				<xsl:when test="$transfer = 'transferIn' and $BuySell = 'SELL'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:OldPriceDxEntitlementJoin"/>
				</xsl:when>
				<xsl:when test="$transfer = 'transferOut' and $BuySell = 'SELL'">
					<xsl:value-of select="b:TradesDxEntitlementJoinGroup/b:NewPriceDxEntitlementJoin"/>
				</xsl:when>
			</xsl:choose>
		</transferPrice>
	</xsl:template>
	<xsl:template name="referenceNature">
		<xsl:param name="TradeIndex"/>
		<xsl:param name="TradeId"/>
		<referenceNature>
			<xsl:choose>
				<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'NORMAL' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'NORMAL' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
			</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode">
		<xsl:param name="TradeIndex"/>
		<xsl:param name="TradeId"/>
		<referenceTransactionCode>
			<xsl:if test="(//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'NORMAL' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'NORMAL' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (//b:exchangeTypeJoinGroup/b:exchangeTypeJoinSubGroup[@index=$TradeIndex]/b:exchangeTypeJoin = 'OTC' and //b:contractTypeGroup/b:contractTypeSubGroup[@index=$TradeIndex]/b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat($TradeId,$COMPANY_POSTFIX_SEPARATOR,//b:MnemonicCompanyJoin)"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
   <xsl:template name="histOpExchRate"/>
   <xsl:template name="histOpNetAmount"/>
   <xsl:template name="histQuote"/>
</xsl:stylesheet>