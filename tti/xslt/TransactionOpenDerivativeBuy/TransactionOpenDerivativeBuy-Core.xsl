<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionOpenDerivativeBuy"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionOpenDerivativeBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionOpenDerivativeBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionOpenDerivativeBuy" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

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
				<xsl:when test="b:tradeType = 'OPTION' and $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:tradeType = 'OPTION' and $boDefaultExch_Inverse_Flag != '0'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
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
			<xsl:choose>
				<xsl:when test="b:tradeType = 'OPTION'">
					<xsl:value-of select="b:costAccCcyGroup/b:costAccCcy"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:priTradeCost"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account3">
		<xsl:if test="b:tradeType = 'FUTURE' and (format-number(sum(b:priSecAccGroup/b:priCommTypSubGroup/b:priCommAmt) + sum(b:priSecAccGroup/b:taxAmtAcySubGroup/b:taxAmtTcy),$decimalformat,'nan2zero') != '0')">
			<account3>
				<infra:code>
					<xsl:value-of select="b:priSecAccGroup[@index='1']/b:priAccount"/>
				</infra:code>
			</account3>
		</xsl:if>
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
		<xsl:if test="b:tradeType = 'FUTURE'">
			<account3NetAmount>
				<xsl:variable name="sumPriCommAmt" select="sum(b:priSecAccGroup/b:priCommTypSubGroup/b:priCommAmt)"/>
				<xsl:variable name="sumTaxAmtTcy" select="sum(b:priSecAccGroup/b:priCommTypSubGroup/b:taxAmtTcy)"/>
				<xsl:value-of select="format-number(-1 * ($sumPriCommAmt + $sumTaxAmtTcy),$decimalformat,'nan2zero')"/>
			</account3NetAmount>
		</xsl:if>
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
	<xsl:template name="subType">
		<xsl:if test="substring(b:parentRef,1,5) = 'DXTRA'">
			<subType>
				<infra:code>
					<xsl:value-of select="concat(substring(b:tradeType,1,3),'_',substring(b:priBuySell,1,3),'_',substring(b:closeoutTypeJoinList/b:closeoutTypeJoin,1,3),'_',b:optionTypeJoin)"/>
				</infra:code>
			</subType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapRefId != '' and b:exchangeTypeJoin = 'OTC'">
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,'_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printDxOpenPositionFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionOpenDerivativeBuy'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<xsl:if test="b:tradeType = 'OPTION' or b:tradeType = 'FUTURE'">
			<type>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:tradeType = 'OPTION'">
							<xsl:value-of select="'OPTION_BUY_OPEN'"/>
						</xsl:when>
						<xsl:when test="b:tradeType = 'FUTURE'">
							<xsl:value-of select="'FUTURE_BUY_OPEN'"/>
						</xsl:when>
					</xsl:choose>
				</infra:code>
			</type>
		</xsl:if>
	</xsl:template>
	<xsl:template name="valueDate">
		<xsl:if test="b:valueDate != ''">
			<valueDate>
				<xsl:value-of select="b:valueDate"/>
			</valueDate>
		</xsl:if>
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
		<xsl:if test="b:tapRefId != '' and b:exchangeTypeJoin != 'OTC'">
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
		</xsl:if>
	</xsl:template>
	<xsl:template name="originalOrderCode">
		<xsl:if test="b:tapRefId and b:tapRefId != ''">
			<originalOrderCode>
				<xsl:value-of select="b:tapRefId"/>
			</originalOrderCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="price">
	<xsl:if test="b:exchangeType != 'OTC'">
		<price>
			<xsl:value-of select="b:priPrice"/>
		</price>
</xsl:if>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:if test="b:priSecAccGroup/b:priLots != ''">
			<quantity>
				<xsl:value-of select="b:priSecAccGroup/b:priLots"/>
			</quantity>
		</xsl:if>
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
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldValSubGroup[1]/b:usrFldVal and b:exoticTypeGroup/b:usrFldValSubGroup[2]/b:usrFldVal)">
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:exoticTypeGroup/b:exoticType,'/',b:exoticTypeGroup/b:usrFldValSubGroup[@index='1']/b:usrFldVal,'/',b:exoticTypeGroup/b:usrFldValSubGroup[@index='2']/b:usrFldVal)"/>
						</xsl:when>
						<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldValSubGroup[1]/b:usrFldVal)">
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:exoticTypeGroup/b:exoticType,'/',b:exoticTypeGroup/b:usrFldValSubGroup[@index='1']/b:usrFldVal)"/>
						</xsl:when>
						<xsl:when test="b:exoticTypeGroup/b:exoticType">
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:exoticTypeGroup/b:exoticType)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1))"/>
						</xsl:otherwise>
					</xsl:choose>																									
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate">
		<securityCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType = 'OPTION' and $boDefaultExch_Inverse_Flag = '0' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType = 'OPTION' and $boDefaultExch_Inverse_Flag != '0' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType != 'OPTION' and $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType != 'OPTION' and $boDefaultExch_Inverse_Flag != '0'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0' and b:tradeType = 'OPTION' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costSamCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag != '0' and b:tradeType = 'OPTION' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costSamCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0' and b:tradeType != 'OPTION'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costSamCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag != '0' and b:tradeType != 'OPTION'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costSamCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
			</xsl:choose>
		</securityCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$DXSTOCKEXCH_PREFIX !='' ">
						<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:exchangeCode)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:exchangeCode"/>
					</xsl:otherwise>
				</xsl:choose>
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
		<xsl:if test="b:priTradeCost and b:priTradeCost != ''">
			<tradeCcyGrossAmount>
				<xsl:value-of select="b:priTradeCost"/>
			</tradeCcyGrossAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount">
		<xsl:if test="b:priSecAccGroup/b:priNetCost and b:priSecAccGroup/b:priNetCost != ''">
			<tradeCcyNetAmount>
				<xsl:value-of select="b:priSecAccGroup/b:priNetCost"/>
			</tradeCcyNetAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate">
		<tradeCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType = 'OPTION' and $boDefaultExch_Inverse_Flag = '0' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType = 'OPTION' and $boDefaultExch_Inverse_Flag != '0'and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType != 'OPTION' and $boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costAccCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:priSecAccGroup/b:priAccCcy = b:refrenceCurrencyList/b:referenceCurrency and b:tradeType != 'OPTION' and $boDefaultExch_Inverse_Flag != '0'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costAccCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0' and b:tradeType = 'OPTION' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costSamCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag != '0' and b:tradeType = 'OPTION' and b:priSecAccGroup/b:priNetCost &gt; 0">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costSamCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0' and b:tradeType != 'OPTION'">
					<xsl:value-of select="format-number(b:costAccCcyGroup/b:costSamCcy div b:priSecAccGroup/b:priNetCost,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="$boDefaultExch_Inverse_Flag != '0' and b:tradeType != 'OPTION'">
					<xsl:value-of select="format-number(b:priSecAccGroup/b:priNetCost div b:costAccCcyGroup/b:costSamCcy,$decimalformat,'nan2zero')"/>
				</xsl:when>
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
				<xsl:when test="b:exchangeType = 'NORMAL' and b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeType = 'NORMAL' and b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeType = 'OTC' and b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeType = 'OTC' and b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode">
		<referenceTransactionCode>
			<xsl:if test="(b:exchangeType = 'NORMAL' and b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (b:exchangeType = 'NORMAL' and b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (b:exchangeType = 'OTC' and b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (b:exchangeType = 'OTC' and b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="intermediary">
		<intermediary>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX != ''">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,b:executingBroker)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:executingBroker"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</intermediary>
	</xsl:template>
	<xsl:template name="market">
		<market>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:executingBroker)"/>
			</infra:code>
		</market>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="hedgeTrade">
		<xsl:if test="b:priSecAccGroup/b:priHedgeTrade = 'HEDGE'">
			<hedgeTrade>
				<xsl:value-of select="'1'"/>
			</hedgeTrade>
		</xsl:if>
	</xsl:template>
	<xsl:template name="orderTypeD">
		<xsl:if test="b:priSecAccGroup/b:priStrategy and b:priSecAccGroup/b:priStrategy !=''">
			<orderTypeD>
				<infra:code>
					<xsl:call-template name="orderTypeTranslation">
						<xsl:with-param name="orderType" select="b:priSecAccGroup/b:priStrategy"/>
					</xsl:call-template>
				</infra:code>
			</orderTypeD>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
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
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="paymentOptionE"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="securityCcyNetAmount">
		<xsl:if test="b:priSecAccGroup/b:priNetCost and b:priSecAccGroup/b:priNetCost != ''">
			<securityCcyNetAmount>
				<xsl:value-of select="b:priSecAccGroup/b:priNetCost"/>
			</securityCcyNetAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="premiumCurrency">
		<xsl:if test="b:exchangeType = 'OTC'">
			<premiumCurrency>
				<infra:code>
					<xsl:value-of select="b:priSecAccGroup/b:priPremiumCcy"/>
				</infra:code>
			</premiumCurrency>
		</xsl:if>
	</xsl:template>

	<xsl:template name="premiumAmount">
		<xsl:if test="b:exchangeType = 'OTC'">
			<premiumAmount>
				<xsl:value-of select="b:priSecAccGroup/b:priTotalPremAmt"/>
			</premiumAmount>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>