<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPaymentOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrder"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PaymentOrder">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:choose>
				<xsl:when test="b:debitAccountPortfolioNoList/b:debitAccountPortfolioNo and b:debitAccountPortfolioNoList/b:debitAccountPortfolioNo != ''">
					<xsl:call-template name="checkPortfolioCondition">
						<xsl:with-param name="xsltName" select="'TransactionPaymentOrderDebitRev'"/>
						<xsl:with-param name="memoAccount" select="b:debitMemoAccountList/b:debitMemoAccount"/>
						<xsl:with-param name="dealerBook" select="b:debitDealerBookList/b:debitDealerBook"/>
						<xsl:with-param name="customerType" select="b:debitAccountCustomerTypeJoinGroup/b:debitAccountCustomerTypeJoinList/b:debitAccountCustomerTypeJoin"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="checkPortfolioCondition">
						<xsl:with-param name="xsltName" select="'TransactionPaymentOrderDebitRev'"/>
						<xsl:with-param name="memoAccount" select="b:debitMemoAccountHistJoin"/>
						<xsl:with-param name="dealerBook" select="b:debitDealerBookHistJoin"/>
						<xsl:with-param name="customerType" select="b:debitCustomerTypeHistJoinList/b:debitCustomerTypeHistJoin"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PaymentOrder[$checkPortfolioConditionVar = 'true' and b:tapRefId and b:tapRefId != '']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PaymentOrder" mode="filter1">
		<xsl:apply-templates select="self::b:PaymentOrder[b:recordStatus = 'REVE']" mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:PaymentOrder" mode="filter-custo">
		<xsl:apply-templates select="self::b:PaymentOrder" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PaymentOrder" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>