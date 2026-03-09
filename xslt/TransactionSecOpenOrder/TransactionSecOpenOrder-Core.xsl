<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecOpenOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- security buy -->
	<xsl:template name="account1">
		<xsl:choose>
			<xsl:when test="b:tapSleevePtf !=''">
				<account1>
					<infra:code>
						<xsl:value-of select="b:tapSleeveAcc"/>
					</infra:code>
				</account1>
			</xsl:when>
			<xsl:otherwise>
				<account1>
					<infra:code>
						<xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
					</infra:code>
				</account1>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<account1CcyTradeCcyExchangeRate>
			<xsl:value-of select="b:custNumberGroup/b:cuExRateAcc"/>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
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
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:choose>
				<xsl:when test="($g_filterBySubAssetType='Y' and (contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin))) or (b:subAssetTypeTapInstrType and contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))">
					<xsl:value-of select="'40'"/>
				</xsl:when>
				<xsl:when test="($g_filterBySubAssetType='Y' and (not(contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin)))) or (b:subAssetTypeTapInstrType and (not(contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))))">
					<xsl:value-of select="'35'"/>
				</xsl:when>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionCode"/>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printSecOpenOrderFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionSecOpenOrder'"/>
			<xsl:with-param name="cuEbvFees" select="b:custNumberGroup/b:cuEbvFees"/>
			<xsl:with-param name="cuForeignFee" select="b:custNumberGroup/b:cuForeignFee"/>
			<xsl:with-param name="cuBrkrComm" select="b:custNumberGroup/b:cuBrkrComm"/>
			<xsl:with-param name="cuCommission" select="b:custNumberGroup/b:cuCommission"/>
			<xsl:with-param name="cuCommTax" select="b:custNumberGroup/b:cuCommTax"/>
			<xsl:with-param name="cuStampTax" select="b:custNumberGroup/b:cuStampTax"/>
			<xsl:with-param name="cuChargeTaxAmt" select="b:custNumberGroup/b:cuChargeTaxTypeSubGroup/b:cuChargeTaxAmt"/>
			<xsl:with-param name="cuChargeTaxType" select="b:custNumberGroup/b:cuChargeTaxTypeSubGroup/b:cuChargeTaxType"/>
			<xsl:with-param name="cuFeesMisc" select="b:custNumberGroup/b:cuFeesMisc"/>
			<xsl:with-param name="cuDiscAmt" select="b:custNumberGroup/b:cuDiscAmt"/>
			<xsl:with-param name="cuWhtTax" select="b:custNumberGroup/b:cuWhtTaxList/b:cuWhtTax"/>
			<xsl:with-param name="tradeCcy" select="b:tradeCcy"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',b:transactionCode)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate"/>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'order_fee_e'"/>
			</infra:name>
			<infra:value>
				<xsl:if test="b:custNumberGroup/b:calcChrgs ='YES'">
					<xsl:value-of select="'0'"/>
				</xsl:if>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'stp_order_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="($g_filterBySubAssetType='Y' and (contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin))) or (b:subAssetTypeTapInstrType and contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="($g_filterBySubAssetType='Y' and (not(contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin)))) or (b:subAssetTypeTapInstrType and (not(contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))))">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'remark_1_c'"/>
			</infra:name>
			<infra:value>
				<xsl:for-each select="b:custNumberGroup/b:narrativeList/b:narrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'remark_2_c'"/>
			</infra:name>
			<infra:value>
				<xsl:for-each select="b:acctNarrativeList/b:acctNarrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'remark_3_c'"/>
			</infra:name>
			<infra:value>
				<xsl:for-each select="b:dealNarrativeList/b:dealNarrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'order_type'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'PCK_TCIB_BO_CORP_ACT'"/>
			</infra:value>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="boAccount">
		<boAccount>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
				</xsl:if>
			</infra:code>
		</boAccount>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="broker"/>
	<xsl:template name="compoundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="contactMethod"/>
	<xsl:template name="depositaryAccount">
		<depositaryAccount>
			<infra:code>
				<xsl:value-of select="b:depository"/>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
	<xsl:template name="exCoupon"/>
	<xsl:template name="executionSetCriteria"/>
	<xsl:template name="hierOperNature"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice">
		<xsl:if test="(b:orderType = 'LIMIT') or (b:orderType = 'STOP.LIMIT')">
			<limitPrice>
				<xsl:value-of select="b:limitPrice"/>
			</limitPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="orderType">
		<xsl:if test="(b:orderType = 'MARKET') or (b:orderType = 'LIMIT') or (b:orderType = 'PRICE') or (b:orderType = 'STOP') or (b:orderType = 'STOP.LIMIT')">
		<orderType>
			<xsl:choose>
				<xsl:when test="b:orderType = 'MARKET'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="(b:orderType = 'LIMIT') or (b:orderType = 'PRICE')">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:orderType = 'STOP'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="b:orderType = 'STOP.LIMIT'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
			</xsl:choose>
		</orderType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="orderValidityType">
		<xsl:if test="b:limitType = 'GTC'">
			<orderValidityType>
				<xsl:value-of select="'2'"/>
			</orderValidityType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="paymentDate"/>
	<xsl:template name="paymentStatus"/>
	<xsl:template name="paymentOptionE">
		<paymentOptionE>
			<xsl:choose>
				<xsl:when test="b:investOptionType = 'CASH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:investOptionType = 'REINVEST'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentOptionE>
	</xsl:template>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="price">
		<price>
			<xsl:choose>
				<xsl:when test="b:orderType= 'MARKET'">
					<xsl:value-of select="b:marketPrice"/>
				</xsl:when>
				<xsl:when test="b:orderType= 'CASH'">
					<xsl:value-of select="b:custNumberGroup/b:currPrice"/>
				</xsl:when>
			</xsl:choose>
		</price>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:custNumberGroup/b:noNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="settlementDate"/>
	<xsl:template name="settlementStatus"/>
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$STOCKEXCH_PREFIX != ''">
						<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:stockExchange"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="stopPrice">
		<xsl:if test="b:custNumberGroup/b:currPrice and (b:orderType = 'STOP' or b:orderType = 'STOP.LIMIT')">
		<stopPrice>
				<xsl:value-of select="b:custNumberGroup/b:currPrice"/>
		</stopPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="targetAmount">
		<targetAmount>
			<xsl:if test="b:orderType = 'CASH'">
				<xsl:value-of select="b:custNumberGroup/b:cuCashAmount"/>
			</xsl:if>
		</targetAmount>
	</xsl:template>
	<xsl:template name="targetNature">
		<targetNature>
			<xsl:choose>
				<xsl:when test="b:custNumberGroup/b:cashChrgs = 'GROSS'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:custNumberGroup/b:cashChrgs = 'NET'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
			</xsl:choose>
		</targetNature>
	</xsl:template>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="tradeDate"/>
	<xsl:template name="validityDate">
		<xsl:if test="b:limitExpDate and b:limitExpDate != ''">
			<validityDate>
				<xsl:value-of select="b:limitExpDate"/>
			</validityDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelEndDate"/>
	<xsl:template name="referenceNature"/>
	<xsl:template name="boRoutingBusinessEntityId">
		<boRoutingBusinessEntityId>
			<xsl:value-of select="b:coCode"/>
		</boRoutingBusinessEntityId>
	</xsl:template>

	<!-- security sell -->
	<xsl:template name="account1_sale">
		<xsl:choose>
			<xsl:when test="b:tapSleevePtf !=''">
				<account1>
					<infra:code>
						<xsl:value-of select="b:tapSleeveAcc"/>
					</infra:code>
				</account1>
			</xsl:when>
			<xsl:otherwise>
				<account1>
					<infra:code>
						<xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
					</infra:code>
				</account1>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_sale">
		<account1CcyTradeCcyExchangeRate>
			<xsl:value-of select="b:custNumberGroup/b:cuExRateAcc"/>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
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
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_sale"/>
	<xsl:template name="remark_sale"/>
	<xsl:template name="reversalIndicator_sale"/>
	<xsl:template name="reversedTransactionCode_sale"/>
	<xsl:template name="sourceSystemCode_sale">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_sale">
		<status>
			<xsl:choose>
				<xsl:when test="($g_filterBySubAssetType='Y' and (contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin))) or (b:subAssetTypeTapInstrType and contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))">
					<xsl:value-of select="'40'"/>
				</xsl:when>
				<xsl:when test="($g_filterBySubAssetType='Y' and (not(contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin)))) or (b:subAssetTypeTapInstrType and (not(contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))))">
					<xsl:value-of select="'35'"/>
				</xsl:when>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="subType_sale"/>
	<xsl:template name="transactionCode_sale"/>
	<xsl:template name="transactionFeesTaxesCounter_sale">
		<xsl:call-template name="printSecOpenOrderFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionSecOpenOrder'"/>
			<xsl:with-param name="cuEbvFees" select="b:custNumberGroup/b:cuEbvFees"/>
			<xsl:with-param name="cuForeignFee" select="b:custNumberGroup/b:cuForeignFee"/>
			<xsl:with-param name="cuBrkrComm" select="b:custNumberGroup/b:cuBrkrComm"/>
			<xsl:with-param name="cuCommission" select="b:custNumberGroup/b:cuCommission"/>
			<xsl:with-param name="cuCommTax" select="b:custNumberGroup/b:cuCommTax"/>
			<xsl:with-param name="cuStampTax" select="b:custNumberGroup/b:cuStampTax"/>
			<xsl:with-param name="cuChargeTaxAmt" select="b:custNumberGroup/b:cuChargeTaxTypeSubGroup/b:cuChargeTaxAmt"/>
			<xsl:with-param name="cuChargeTaxType" select="b:custNumberGroup/b:cuChargeTaxTypeSubGroup/b:cuChargeTaxType"/>
			<xsl:with-param name="cuFeesMisc" select="b:custNumberGroup/b:cuFeesMisc"/>
			<xsl:with-param name="cuDiscAmt" select="b:custNumberGroup/b:cuDiscAmt"/>
			<xsl:with-param name="cuWhtTax" select="b:custNumberGroup/b:cuWhtTaxList/b:cuWhtTax"/>
			<xsl:with-param name="tradeCcy" select="b:tradeCcy"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type_sale">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',b:transactionCode)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_sale"/>
	<xsl:template name="userDefinedField_sale">
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'order_fee_e'"/>
			</infra:name>
			<infra:value>
				<xsl:if test="b:custNumberGroup/b:calcChrgs ='YES'">
					<xsl:value-of select="'0'"/>
				</xsl:if>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'stp_order_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
                    <xsl:when test="($g_filterBySubAssetType='Y' and (contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin))) or (b:subAssetTypeTapInstrType and contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))">
						<xsl:value-of select="'0'"/>
					</xsl:when>
                    <xsl:when test="($g_filterBySubAssetType='Y' and (not(contains($list_SubAssetType_NDMAforSOO,b:subAssetTypeSecurityMasterJoin)))) or (b:subAssetTypeTapInstrType and (not(contains($list_TapInstrType_NDMAforSOO,b:subAssetTypeTapInstrType))))">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'remark_1_c'"/>
			</infra:name>
			<infra:value>
				<xsl:for-each select="b:custNumberGroup/b:narrativeList/b:narrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'remark_2_c'"/>
			</infra:name>
			<infra:value>
				<xsl:for-each select="b:acctNarrativeList/b:acctNarrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'remark_3_c'"/>
			</infra:name>
			<infra:value>
				<xsl:for-each select="b:dealNarrativeList/b:dealNarrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</infra:value>
		</userDefinedField>
		<userDefinedField>
			<infra:name>
				<xsl:value-of select="'order_type'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'PCK_TCIB_BO_CORP_ACT'"/>
			</infra:value>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="mbFields_sale"/>
	<xsl:template name="accountCurrency_sale"/>
	<xsl:template name="accruedInterests_sale"/>
	<xsl:template name="accruedInterestCounter_sale"/>
	<xsl:template name="boAccount_sale">
		<boAccount>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
				</xsl:if>
			</infra:code>
		</boAccount>
	</xsl:template>
	<xsl:template name="boPortfolio_sale">
		<boPortfolio>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="broker_sale"/>
	<xsl:template name="compoundOrderCode_sale"/>
	<xsl:template name="compoundOrderMaster_sale"/>
	<xsl:template name="compoundOrderSlave_sale"/>
	<xsl:template name="contactMethod_sale"/>
	<xsl:template name="depositaryAccount_sale">
		<depositaryAccount>
			<infra:code>
				<xsl:value-of select="b:depository"/>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
	<xsl:template name="exCoupon_sale"/>
	<xsl:template name="executionSetCriteria_sale"/>
	<xsl:template name="hierOperNature_sale"/>
	<xsl:template name="initiatedBy_sale"/>
	<xsl:template name="initiator_sale"/>
	<xsl:template name="limitPrice_sale">
		<xsl:if test="(b:orderType = 'LIMIT') or (b:orderType = 'STOP.LIMIT')">
			<limitPrice>
				<xsl:value-of select="b:limitPrice"/>
			</limitPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="orderType_sale">
		<orderType>
			<xsl:choose>
				<xsl:when test="b:orderType = 'MARKET'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="(b:orderType = 'LIMIT') or (b:orderType = 'PRICE')">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:orderType = 'STOP'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="b:orderType = 'STOP.LIMIT'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
			</xsl:choose>
		</orderType>
	</xsl:template>
	<xsl:template name="orderValidityType_sale">
		<xsl:if test="b:limitType = 'GTC'">
			<orderValidityType>
				<xsl:value-of select="'2'"/>
			</orderValidityType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="originalOrderCode_sale"/>
	<xsl:template name="paymentDate_sale"/>
	<xsl:template name="paymentStatus_sale"/>
	<xsl:template name="paymentOptionE_sale">
		<paymentOptionE>
			<xsl:choose>
				<xsl:when test="b:investOptionType = 'CASH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:investOptionType = 'REINVEST'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentOptionE>
	</xsl:template>
	<xsl:template name="positionCriteria1_sale"/>
	<xsl:template name="positionCriteria2_sale"/>
	<xsl:template name="positionCriteria3_sale"/>
	<xsl:template name="price_sale">
		<price>
			<xsl:choose>
				<xsl:when test="b:orderType= 'MARKET'">
					<xsl:value-of select="b:marketPrice"/>
				</xsl:when>
				<xsl:when test="b:orderType= 'CASH'">
					<xsl:value-of select="b:custNumberGroup/b:currPrice"/>
				</xsl:when>
			</xsl:choose>
		</price>
	</xsl:template>
	<xsl:template name="quantity_sale">
		<quantity>
			<xsl:value-of select="b:custNumberGroup/b:noNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security_sale">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyNetAmount_sale"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_sale"/>
	<xsl:template name="settlementDate_sale"/>
	<xsl:template name="settlementStatus_sale"/>
	<xsl:template name="stockExchange_sale">
		<stockExchange>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$STOCKEXCH_PREFIX != ''">
						<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:stockExchange"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="stopPrice_sale">
		<stopPrice>
			<xsl:if test="b:custNumberGroup/b:currPrice and (b:orderType = 'STOP' or b:orderType = 'STOP.LIMIT')">
				<xsl:value-of select="b:custNumberGroup/b:currPrice"/>
			</xsl:if>
		</stopPrice>
	</xsl:template>
	<xsl:template name="targetAmount_sale">
		<targetAmount>
			<xsl:if test="b:orderType = 'CASH'">
				<xsl:value-of select="b:custNumberGroup/b:cuCashAmount"/>
			</xsl:if>
		</targetAmount>
	</xsl:template>
	<xsl:template name="targetNature_sale">
		<targetNature>
			<xsl:choose>
				<xsl:when test="b:custNumberGroup/b:cashChrgs = 'GROSS'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:custNumberGroup/b:cashChrgs = 'NET'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
			</xsl:choose>
		</targetNature>
	</xsl:template>
	<xsl:template name="targetObjective_sale"/>
	<xsl:template name="trader_sale"/>
	<xsl:template name="tradeCurrency_sale">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_sale"/>
	<xsl:template name="tradeCcyNetAmount_sale"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_sale"/>
	<xsl:template name="tradeDate_sale"/>
	<xsl:template name="validityDate_sale">
		<xsl:if test="b:limitExpDate and b:limitExpDate != ''">
			<validityDate>
				<xsl:value-of select="b:limitExpDate"/>
			</validityDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelEndDate_sale"/>
	<xsl:template name="referenceNature_sale"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->