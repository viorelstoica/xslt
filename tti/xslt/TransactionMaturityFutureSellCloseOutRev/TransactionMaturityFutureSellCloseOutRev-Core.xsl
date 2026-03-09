<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionMaturityFutureSellCloseOutRev" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionMaturityFutureSellCloseOutRev"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionMaturityFutureSellCloseOutRev" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionMaturityFutureSellCloseOutRev"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
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
	<xsl:template name="subType"/>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="b:id"/>
			<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
			<xsl:value-of select="b:mnemonicJoin"/>
			<xsl:value-of select="'-R'"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
		<xsl:if test="b:premValDateList/b:premValDate and b:premValDateList/b:premValDate != ''">
			<valueDate>
				<xsl:value-of select="b:premValDateList/b:premValDate"/>
			</valueDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="broker"/>
	<xsl:template name="depositaryAccount"/>
	<xsl:template name="executionSetCriteria"/>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="price"/>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="'0'"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
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
						<xsl:value-of select="b:contractCode"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="b:currency"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="b:maturityDate"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="b:optionType"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="b:strikePrice"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="b:deliveryCcy"/>
						<xsl:value-of select="'/'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="tradeCurrency"/>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="tradeDate">
		<xsl:if test="b:transDateList/b:transDate and b:transDateList/b:transDate != ''">
			<tradeDate>
				<xsl:value-of select="b:transDateList/b:transDate"/>
			</tradeDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="referenceNature">
		<referenceNature>
			<xsl:choose>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and b:contractTypeList/b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and b:contractTypeList/b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and b:contractTypeList/b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and b:contractTypeList/b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode">
		<referenceTransactionCode>
			<xsl:if test="(b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and b:contractTypeList/b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and b:contractTypeList/b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and b:contractTypeList/b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and b:contractTypeList/b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
			</xsl:if>
		</referenceTransactionCode>
	</xsl:template>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>
			<xsl:value-of select=" '1' "/>
		</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<reversedTransactionCode>
			<xsl:value-of select="b:id"/>
			<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
			<xsl:value-of select="b:mnemonicJoin"/>
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
		</sourceSystemCode>
	</xsl:template>
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
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="hedgeTrade"/>
	<xsl:template name="orderTypeD"/>
</xsl:stylesheet>