<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c d e f g ns0 batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS"
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
    xmlns:b="http://www.temenos.com/T24/event/TTI/TPHServiceFlow"
	xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTPHServiceFlow"
	xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTPHServiceFlow"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTPHServiceFlow"	
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:d="http://www.temenos.com/T24/PaymentsEventsService/PorTransactionFull" 
	xmlns:e="http://www.temenos.com/T24/PaymentsEventsService/PorTransactionFullAdditional" 
	xmlns:f="http://www.temenos.com/T24/PaymentsEventsService/PorPostingAndConfirmation" 
	xmlns:g="http://www.temenos.com/T24/PaymentsEventsService/AccountDetails"
	xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TPHServiceFlow">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:if test="b:accountdetails/g:debitPortfolioId and b:accountdetails/g:debitPortfolioId != ''">
				<xsl:call-template name="checkPortfolioCondition">
					<xsl:with-param name="xsltName" select="'TransactionPaymentOutgoingRevTPH'"/>
					<xsl:with-param name="memoAccount" select="b:accountdetails/g:debitMemoAccount"/>
					<xsl:with-param name="dealerBook" select="b:accountdetails/g:debitDealerBook"/>
					<xsl:with-param name="customerType" select="b:accountdetails/g:debitCustomerType"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TPHServiceFlow[(not(b:tapRefId) or b:tapRefId = '') and b:portransactionrec/d:statusCode = '993' and $checkPortfolioConditionVar = 'true']"
		                     mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:TPHServiceFlow" mode="filter-custo">
		<xsl:apply-templates select="self::b:TPHServiceFlow" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TPHServiceFlow" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>