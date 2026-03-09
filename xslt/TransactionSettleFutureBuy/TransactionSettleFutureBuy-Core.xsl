<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSettleFutureBuy"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSettleFutureBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSettleFutureBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSettleFutureBuy" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:priSecAccGroup[@index='1']/b:priAccount"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<account1CcyTradeCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="b:priTradeCost"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account3">
		<account3>
			<infra:code>
				<xsl:value-of select="b:priSecAccGroup[@index='1']/b:priAccount"/>
			</infra:code>
		</account3>
	</xsl:template>
	<xsl:template name="account3CcyTradeCcyExchangeRate">
		<xsl:if test="b:tradeType = 'FUTURE'">
			<account3CcyTradeCcyExchangeRate>
				<xsl:choose>
					<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
						<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</account3CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account3NetAmount">
		<account3NetAmount>
			<xsl:variable name="sumPriCommAmt" select="sum(b:priSecAccGroup/b:priCommTypSubGroup/b:priCommAmt)"/>
			<xsl:variable name="sumTaxAmtTcy" select="sum(b:priSecAccGroup/b:priCommTypSubGroup/b:taxAmtTcy)"/>
			<xsl:choose>
				<xsl:when test="b:tradeType = 'FUTURE' and format-number($sumPriCommAmt + $sumTaxAmtTcy,'0.##','nan2zero') != '0'">
					<xsl:value-of select="format-number(-1 * ($sumPriCommAmt + $sumTaxAmtTcy),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</account3NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:priSecAccGroup/b:priSecAcc"/>
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
		<transactionCode>
			<xsl:variable name="check_tradeDate">
				<xsl:choose>
					<xsl:when test="string-length(b:tradeDate) ='8'">
						<xsl:value-of select="b:tradeDate"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring(translate(b:tradeDate,'-',''),1,8)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="check_toDay">
				<xsl:choose>
					<xsl:when test="string-length(b:eventCommon/ns0:today) = '8'">
						<xsl:value-of select="translate(b:eventCommon/ns0:today,'-','')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring(translate(b:eventCommon/ns0:today,'-',''),1,8)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="b:tapRefId and b:tapRefId != '' and b:exchangeTypeJoin = 'OTC'">
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:when test="$check_tradeDate &lt; $check_toDay">
					<xsl:value-of select="concat( 'VX_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:companyMnemonicJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'FUTURE_BUY_CLOSE'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:tradeDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="broker">
		<broker>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !=''">
						<xsl:choose>
							<xsl:when test="b:executingBroker!=''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:executingBroker)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:secCustNo)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="b:executingBroker!=''">
								<xsl:value-of select="b:executingBroker"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:secCustNo"/>
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
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="b:secCustNo"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="executionSetCriteria">
		<xsl:if test="b:tapRefId and b:tapRefId !=''">
			<executionSetCriteria>
			     <xsl:choose>
			         <xsl:when test="starts-with(b:tapRefId, 'D')">
                        <xsl:value-of select="b:tapExSetCrit"/>			         
			         </xsl:when>
			         <xsl:otherwise>
                        <xsl:value-of select="concat(b:tradeDate,'/',b:tapRefId)"/>			         
			         </xsl:otherwise>
			     </xsl:choose>
			</executionSetCriteria>
			<originalOrderCode>
				<xsl:value-of select="b:tapRefId"/>
			</originalOrderCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="price">
		<price>
			<xsl:value-of select="b:priPrice"/>
		</price>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:priSecAccGroup/b:priLots"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:exchangeTypeJoin = 'OTC'">
						<xsl:choose>
							<xsl:when test="b:tapRefId and b:tapRefId != ''">
								<xsl:value-of select="b:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,'1','1'))"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate">
		<securityCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test=" b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test=" b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and $boDefaultExch_Inverse_Flag != '0'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test=" $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costSamCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costSamCcy,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</securityCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:exchangeCode)"/>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount">
		<tradeCcyGrossAmount>
			<xsl:value-of select="b:priTradeCost"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount">
		<tradeCcyNetAmount>
			<xsl:value-of select="b:priSecAccGroup/b:priNetCost"/>
		</tradeCcyNetAmount>
	</xsl:template>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate">
		<tradeCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test=" b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test=" b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and $boDefaultExch_Inverse_Flag != '0'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test=" $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costSamCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costSamCcy,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="tradeDate">
		<tradeDate>
			<xsl:value-of select="b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="referenceNature">
		<referenceNature>
			<xsl:choose>
				<xsl:when test="b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoin = 'OTC' and b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoin = 'OTC' and b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode">
		<referenceTransactionCode>
			<xsl:if test="(b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (b:exchangeTypeJoin = 'OTC' and b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (b:exchangeTypeJoin = 'OTC' and b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(b:closeoutTradeGroup/b:closeoutTrade,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printDxCloseOutFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionSettleFutureBuy'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="exCoupon"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="trader"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="compoundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="contactMethod"/>
	<xsl:template name="paymentOptionE"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="hedgeTrade"/>
	<xsl:template name="orderTypeD"/>
</xsl:stylesheet>