<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSettleOptionBuy"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSettleOptionBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSettleOptionBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSettleOptionBuy" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:priSecAccGroup[@index='1']/b:priAccount"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:if test="b:tradeType = 'OPTION'">
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
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="b:costAccCcyGroup/b:costAccCcy"/>
		</account1NetAmount>
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
			<xsl:choose>
				<xsl:when test="b:tapRefId and b:tapRefId != '' and b:exchangeType = 'OTC'">
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="concat(b:tapOperCode, '_', b:id, $COMPANY_POSTFIX_SEPARATOR, b:companyMnemonicJoin)"/>
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
				<xsl:value-of select="'OPTION_BUY_CLOSE'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
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
	<xsl:if test="b:exchangeType != 'OTC'">
		<price>
			<xsl:value-of select="b:priPrice"/>
		</price>
	</xsl:if>
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
							<xsl:value-of select="concat(b:id, $COMPANY_POSTFIX_SEPARATOR, b:companyMnemonicJoin)"/>
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
			<xsl:with-param name="caller" select="'TransactionSettleOptionBuy'"/>
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
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
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